Imports System.Data.SqlClient

Public Class LandlordSignIn
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmitClick(ByVal sender As Object, ByVal e As EventArgs)
        Const LANDLORD_ROLE_ID As Integer = 5
        Dim email As String = Request.Form("email")
        Dim password As String = Request.Form("password")
        Dim dbPassword As String
        Dim roleID As Integer
        Dim userID As Integer
        Dim isEmailVerified As Boolean
        Dim isSecurityQuestionsCompleted As Boolean

        conn.Open()
        Dim query As New SqlCommand("SELECT UserID, Password, fk_RoleID, IsEmailVerified, IsSecurityQuestionsCompleted FROM Users WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            While reader.Read
                dbPassword = CStr(reader("Password"))
                roleID = CStr(reader("fk_RoleID"))
                userID = CStr(reader("UserID"))
                isEmailVerified = CStr(reader("IsEmailVerified"))
                isSecurityQuestionsCompleted = CStr(reader("IsSecurityQuestionsCompleted"))
            End While
            conn.Close()

            If (password = dbPassword) Then
                If (isEmailVerified = 1) Or (isEmailVerified = "True") Then
                    If roleID = LANDLORD_ROLE_ID Then
                        If (isSecurityQuestionsCompleted = 1) Or (isSecurityQuestionsCompleted = "True") Then
                            Web.HttpContext.Current.Session("UserID") = userID
                            updateLastLoginDate(userID)
                            Response.Redirect("Landlords/LandlordDashboard.aspx?UserID=" & userID)
                        Else
                            Web.HttpContext.Current.Session("UserID") = userID
                            Response.Redirect("Landlords/LandlordSecurityQuestions.aspx?UserID=" & userID & "&SecurityQuestionsState=0")
                        End If
                    Else
                        Response.Redirect("TenantSignIn.aspx")
                    End If
                Else
                    lblMsg.Text = "Oh No! You MUST <a href='LandlordVerifyEmail.aspx'>verify your email.</a>"
                End If
            Else
                lblMsg.Text = "Oh No! Incorrect Email/Password Combination."
            End If
        Else
            conn.Close()
            lblMsg.Text = "Oh No! Email does NOT exist."
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