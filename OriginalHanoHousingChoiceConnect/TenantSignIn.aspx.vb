Imports System.Data.SqlClient

Public Class TenantLogin
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

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
                If roleID = 4 Then
                    Response.Redirect("Tenants/TenantDashboard.aspx")
                ElseIf roleID = 5 Then
                    Response.Redirect("LandlordSignIn.aspx")
                End If
            Else
                'Response.Write("<div id='alertEmailPassowrdError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Incorrect Email/Password Combination.</div></div>")
                lblMsg.Text = "Oh No! Incorrect Email/Password Combination."
            End If
        Else
            conn.Close()
            'Response.Write("<div id='alertEmailExistsError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Email does NOT exist.</div></div>")
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