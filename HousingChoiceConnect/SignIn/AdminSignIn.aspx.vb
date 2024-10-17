Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class AdminSignIn
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session.Contents.RemoveAll()
    End Sub

    Protected Sub BtnAdminSignIn(ByVal sender As Object, ByVal e As EventArgs)
        Dim formEmail As String = email.Text.Trim
        Dim formPassword As String = password.Text.Trim
        Dim isExists As Boolean
        Dim isActive As Boolean
        Dim isEmailPasswordCorrect As Boolean
        Dim sessionUserID As Integer
        Dim userRoleID As Integer

        isExists = IsUserExists(formEmail)
        If isExists Then
            isActive = IsUserActive(formEmail)

            If isActive Then
                isEmailPasswordCorrect = IsUserEmailPasswordCorrect(formEmail, formPassword)

                If isEmailPasswordCorrect Then
                    sessionUserID = GetUserIdFromEmail(formEmail)
                    userRoleID = GetUserRoleId(sessionUserID)

                    Dim tenantSignIn As String = "TenantSignIn.aspx"
                    Dim landlordSignIn As String = "LandlordSignIn.aspx"
                    Dim adminDashboard As String = "/Admins/AdminDashboard.aspx?SessionUserID=" & sessionUserID & ""

                    If userRoleID = ApplicationGeneralConstants.GeneralConstants.TenantRole Then
                        Response.Redirect(tenantSignIn)
                    ElseIf userRoleID = ApplicationGeneralConstants.GeneralConstants.LandlordRole Then
                        Response.Redirect(landlordSignIn)
                    ElseIf ApplicationGeneralConstants.GeneralConstants.AdminRole Then
                        Session("SessionUserID") = sessionUserID

                        UpdateActivitySignIn(sessionUserID)
                        UpdateLastLoginDate(sessionUserID)

                        Response.Redirect(adminDashboard)
                    Else
                        lblMsg.Text = "Oh No! Problem with locating Information. Contact Admin."
                    End If
                Else
                    lblMsg.Text = "Oh No! Incorrect Email/Password Combination."
                End If
            Else
                lblMsg.Text = "Oh No! Account Is Not ACTIVE"
            End If
        Else
            lblMsg.Text = "Oh No! Account does NOT EXISTS."
        End If
    End Sub

    Public Function GetUserIdFromEmail(ByVal email As String) As Integer
        Dim userID As Integer
        conn.Open()
        Dim query As New SqlCommand("SELECT UserID
                                     FROM [Security].[User]
                                     WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            While reader.Read
                userID = CStr(reader("UserID"))
            End While
            conn.Close()
        End If

        Return userID
    End Function

    Public Function GetUserRoleId(ByVal userID As Integer) As Integer
        Dim userRoleID As Integer
        conn.Open()
        Dim query As New SqlCommand("SELECT RoleID
                                     FROM [Security].[UserRole]
                                     WHERE UserID='" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            While reader.Read
                userRoleID = CStr(reader("RoleID"))
            End While
            conn.Close()
        End If

        Return userRoleID
    End Function

    Public Function IsUserActive(ByVal email As String) As Boolean
        Dim isActive As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT IsActive
                                     FROM [Security].[User]
                                     WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            While reader.Read
                isActive = CStr(reader("IsActive"))
            End While
            conn.Close()
        End If

        If isActive Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function IsUserExists(ByVal email As String) As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT UserID
                                     FROM [Security].[User]
                                     WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            conn.Close()
            Return True
        Else
            Return False
        End If

        Return True
    End Function

    Public Function IsUserEmailPasswordCorrect(ByVal email As String, ByVal password As String) As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT UserID
                                     FROM [Security].[User]
                                     WHERE Email='" & email & "' AND Password= '" & password & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            conn.Close()
            Return True
        Else
            Return False
        End If

        Return True
    End Function

    Public Sub UpdateActivitySignIn(ByVal userID As Integer)
        Dim activityDate As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim activityDescription As String = "Admin Sign In"

        Dim query As String = String.Empty
        query &= "INSERT INTO [Security].[UserActivityLog] (UserID, ActivityTypeID, ActivityDate, Description)"
        query &= "VALUES                                   (@UserID, @ActivityTypeID, @ActivityDate, @Description);"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
                .Parameters.AddWithValue("@UserID", userID)
                .Parameters.AddWithValue("@ActivityTypeID", ApplicationActivityConstants.ActivityConstants.ActivitySignInID)
                .Parameters.AddWithValue("@ActivityDate", activityDate)
                .Parameters.AddWithValue("@Description", activityDescription)
            End With

            conn.Open()
            comm.ExecuteNonQuery()
            conn.Close()
        End Using
    End Sub

    Public Sub UpdateLastLoginDate(ByVal userID As Integer)
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        conn.Open()
        Dim query As New SqlCommand("UPDATE [Security].[User] 
                                     SET LastLogin ='" & lastLogin & "' 
                                     WHERE UserID='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class