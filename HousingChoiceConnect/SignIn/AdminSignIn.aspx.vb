Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports Microsoft.VisualBasic.ApplicationServices

Public Class AdminSignIn
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
    'Public Const ADMIN_ROLE_ID As Integer = 1
    'Public Const TENANT_ROLE_ID As Integer = 2
    'Public Const LANDLORD_ROLE_ID As Integer = 3

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub BtnAdminSignIn(ByVal sender As Object, ByVal e As EventArgs)
        Dim formEmail As String = email.Text.Trim
        Dim formPassword As String = password.Text.Trim
        'Dim sessionUserID As Integer
        'Dim sessionRoleID As Integer
        'Dim isActive As Boolean
        Dim isExists As Boolean

        'If User Exists
        'If Active
        'If Email/Password Correct

        'Dim dbPassword As String
        'Dim roleID As Integer
        Dim userID As Integer = 1

        isExists = IsUserExists(formEmail)
        'Console.WriteLine("After IsExits")
        If isExists Then
            'Console.WriteLine("Account does EXISTS")
            'Response.Write("<div id='alertUserExistsError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Account does EXISTS.</div></div>")

            Web.HttpContext.Current.Session("UserID") = userID
            Session("UserID") = userID

            '            UpdateLastLoginDate(userID)
            Response.Redirect("/Admins/AdminDashboard.aspx?UserID=" & userID)
        Else
            'Dont Exists
            Console.WriteLine("Account does NOT EXISTS")
            Response.Write("<div id='alertUserExistsError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Account does NOT EXISTS.</div></div>")
        End If

        'conn.Open()
        'Dim query As New SqlCommand("SELECT UserID, IsActive 
        '                             FROM [Security].[UserRole]
        '                             WHERE Email='" & formEmail & "' AND Password= '" & formPassword & "'", conn)
        'Dim reader As SqlDataReader = query.ExecuteReader()


        ''If reader.HasRows Then
        ''    While reader.Read
        ''        userID = CStr(reader("UserID"))
        ''        dbPassword = CStr(reader("Password"))
        ''    End While
        ''    conn.Close()

        ''    roleID = GetUserRole(userID)

        ''    If roleID = ApplicationConstants.Constants.TenantRole Then
        ''        Response.Redirect("TenantSignIn.aspx")
        ''    ElseIf roleID = ApplicationConstants.Constants.LandlordRole Then
        ''        Response.Redirect("LandlordSignIn.aspx")
        ''    ElseIf ApplicationConstants.Constants.AdminRole Then
        ''        If (_password = dbPassword) Then
        ''            Web.HttpContext.Current.Session("UserID") = userID
        ''            Session("UserID") = userID

        ''            UpdateLastLoginDate(userID)
        ''            Response.Redirect("/Admins/AdminDashboard.aspx?UserID=" & userID)
        ''        Else
        ''            Response.Write("<div id='alertEmailPassowrdError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Incorrect Email/Password Combination.</div></div>")
        ''        End If
        ''    End If
        ''Else
        ''    Response.Write("<div id='alertEmailExistsError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Email does NOT exist.</div></div>")
        ''End If

        'If reader.HasRows Then
        '    While reader.Read
        '        sessionUserID = CStr(reader("UserID"))
        '        isActive = CStr(reader("IsActive"))
        '    End While
        '    conn.Close()

        '    If isActive Then
        '        '    Dim adminDashboard As String = "./RoleDashboard/AdminDashboard.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & ""
        '        '    Dim projectSpecialistDashboard As String = "./RoleDashboard/ProjectSpecialistDashboard.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & ""
        '        '    Dim housingSpecialistDashboard As String = "./RoleDashboard/HousingSpecialistDashboard.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & ""
        '        '    Dim fileRoomClerkDashboard As String = "./RoleDashboard/FileRoomClerkDashboard.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & ""

        '        '    Session("SessionUserID") = sessionUserID
        '        '    Session("SessionRoleID") = sessionRoleID

        '        '    If sessionRoleID = ADMIN Then
        '        '        Response.Redirect(adminDashboard)
        '        '    ElseIf sessionRoleID = PROJECT_SPECIALIST Then
        '        '        Response.Redirect(projectSpecialistDashboard)
        '        '    ElseIf sessionRoleID = HOUSING_SPECIALIST Then
        '        '        Response.Redirect(housingSpecialistDashboard)
        '        '    ElseIf sessionRoleID = FILE_ROOM_CLERK Then
        '        '        Response.Redirect(fileRoomClerkDashboard)
        '        '    Else
        '        '        lblMsg.Text = "Unable to Identity your User Role."
        '        '    End If

        '    Else
        '        ' lblMsg.Text = "Account is Disabled."
        '    End If
        'Else
        '    'Response.Write("<div id='alertEmailPassowrdError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Incorrect Email/Password Combination.</div></div>")
        'End If
    End Sub

    Public Function GetUserRole(ByVal userID As Integer) As Integer
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

    Public Function IsUserExists(ByVal email As String) As Boolean
        Console.WriteLine("In IsExits")
        Dim userID As Integer

        conn.Open()
        'Dim query As New SqlCommand("SELECT UserID
        '                             FROM [Security].[User]
        '                             WHERE Email='" & email & "'", conn)
        Dim query As New SqlCommand("SELECT UserID
                                     FROM [dbo].[UserTest]
                                     WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            While reader.Read
                userID = CStr(reader("UserID"))
            End While
            conn.Close()
            Console.WriteLine("Before True In If")
            Return True
        Else
            Console.WriteLine("Before False")
            Return False
        End If

        Console.WriteLine("Before True in func")
        Return True
    End Function

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