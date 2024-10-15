Imports System.Data.SqlClient

Public Class AdminSignIn
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")
    Public Const ADMIN_ROLE_ID As Integer = 1
    Public Const LANDLORD_ROLE_ID As Integer = 5
    Public Const TENANT_ROLE_ID As Integer = 4

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnAdminSignIn(ByVal sender As Object, ByVal e As EventArgs)
        Dim email As String = Request.Form("email").Trim
        Dim password As String = Request.Form("password").Trim
        Dim dbPassword As String
        Dim roleID As Integer
        Dim userID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT UserID, Password, fk_RoleID FROM Users WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            While reader.Read
                dbPassword = CStr(reader("Password"))
                roleID = CStr(reader("fk_RoleID"))
                userID = CStr(reader("UserID"))
            End While
            conn.Close()

            If roleID = TENANT_ROLE_ID Then
                Response.Redirect("TenantSignIn.aspx")
            ElseIf roleID = LANDLORD_ROLE_ID Then
                Response.Redirect("LandlordSignIn.aspx")
            ElseIf roleID = ADMIN_ROLE_ID Then
                If (password = dbPassword) Then
                    Web.HttpContext.Current.Session("UserID") = userID
                    updateLastLoginDate(userID)
                    Response.Redirect("Admins/AdminDashboard.aspx?UserID=" & userID)
                Else
                    Response.Write("<div id='alertEmailPassowrdError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Incorrect Email/Password Combination.</div></div>")
                End If
            End If
        Else
            Response.Write("<div id='alertEmailExistsError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Email does NOT exist.</div></div>")
        End If
    End Sub

    Sub updateLastLoginDate(ByVal userID As Integer)
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET LastLogin ='" & lastLogin & "' WHERE UserID='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class