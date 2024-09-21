Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class TenantLogin
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub BtnTenantSignIn(ByVal sender As Object, ByVal e As EventArgs)
        Const TENANT_ROLE As Integer = 2
        Const LANDLORD_ROLE As Integer = 3

        Dim _email As String = email.Text.Trim
        Dim _password As String = password.Text.Trim
        Dim dbPassword As String
        Dim roleID As Integer
        Dim userID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT UserID, RoleID, Password 
                                     FROM Users 
                                     WHERE Email='" & _email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        If reader.HasRows Then
            While reader.Read
                dbPassword = CStr(reader("Password"))
                roleID = CStr(reader("RoleID"))
                userID = CStr(reader("UserID"))
            End While
            conn.Close()

            If (_password = dbPassword) Then
                Web.HttpContext.Current.Session("UserID") = userID
                Session("UserID") = userID

                updateLastLoginDate(userID)
                If roleID = TENANT_ROLE Then
                    Response.Redirect("../Tenants/TenantDashboard.aspx")
                ElseIf roleID = LANDLORD_ROLE Then
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
        Dim query As New SqlCommand("UPDATE Users 
                                    SET LastLogin ='" & lastLogin & "' 
                                    WHERE UserID='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class