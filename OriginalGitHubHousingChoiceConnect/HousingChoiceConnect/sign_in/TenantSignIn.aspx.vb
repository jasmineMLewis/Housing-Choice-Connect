Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class TenantLogin
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmitClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim email As String = Request.Form("email").Trim
        Dim password As String = Request.Form("password").Trim
        Dim dbPassword As String
        Dim roleID As Integer
        Dim userID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT UserID, fk_RoleID, Password FROM Users WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        If reader.HasRows Then
            While reader.Read
                dbPassword = CStr(reader("Password"))
                roleID = CStr(reader("fk_RoleID"))
                userID = CStr(reader("UserID"))
            End While
            conn.Close()

            If (password = dbPassword) Then
                Web.HttpContext.Current.Session("UserID") = userID
                updateLastLoginDate(userID)
                If roleID = 2 Then
                    Response.Redirect("../tenants/TenantDashboard.aspx")
                ElseIf roleID = 3 Then
                    Response.Redirect("LandlordSignIn.aspx")
                End If
            Else
                lblMsg.Text = "Oh No! Incorrect Email/Password Combination."
            End If
        Else
            conn.Close()
            lblMsg.Text = "Oh No! Email does NOT exist."
        End If
    End Sub

    Public Sub updateLastLoginDate(ByVal userID As Integer)
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET LastLogin ='" & lastLogin & "' WHERE UserID='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class