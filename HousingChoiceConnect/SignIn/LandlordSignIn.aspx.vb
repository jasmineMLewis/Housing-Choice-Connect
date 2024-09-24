Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class LandlordSignIn
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub BtnLandlordSignIn(ByVal sender As Object, ByVal e As EventArgs)
        'Const LANDLORD_ROLE_ID As Integer = 3
        Dim _email As String = email.Text.Trim
        Dim _password As String = password.Text.Trim
        Dim dbPassword As String
        Dim roleID As Integer
        Dim userID As Integer
        Dim isEmailVerified As Boolean
        Dim isSecurityQuestionsCompleted As Boolean

        conn.Open()
        Dim query As New SqlCommand("SELECT UserID, Password, RoleID, IsEmailVerified, 
                                            IsSecurityQuestionsCompleted 
                                     FROM User
                                     WHERE Email='" & _email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            While reader.Read
                dbPassword = CStr(reader("Password"))
                roleID = CStr(reader("RoleID"))
                userID = CStr(reader("UserID"))
                isEmailVerified = CStr(reader("IsEmailVerified"))
                isSecurityQuestionsCompleted = CStr(reader("IsSecurityQuestionsCompleted"))
            End While
            conn.Close()

            If (_password = dbPassword) Then
                If (isEmailVerified = 1) Or (isEmailVerified = "True") Then
                    If roleID = ApplicationConstants.Constants.LandlordRole Then
                        If (isSecurityQuestionsCompleted = 1) Or (isSecurityQuestionsCompleted = "True") Then
                            Web.HttpContext.Current.Session("UserID") = userID
                            Session("UserID") = userID

                            updateLastLoginDate(userID)
                            Response.Redirect("../Landlords/LandlordDashboard.aspx?UserID=" & userID)
                        Else
                            Web.HttpContext.Current.Session("UserID") = userID
                            Session("UserID") = userID

                            Response.Redirect("../Landlords/LandlordSecurityQuestions.aspx?UserID=" & userID & "&SecurityQuestionsState=0")
                        End If
                    Else
                        Response.Redirect("/SignIn/TenantSignIn.aspx")
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

    Public Sub updateLastLoginDate(ByVal userID As Integer)
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        conn.Open()
        Dim query As New SqlCommand("UPDATE User
                                     SET LastLogin ='" & lastLogin & "' 
                                     WHERE UserID='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class