Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Drawing

Public Class LandlordSecurityQuestionsPasswordReset
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmitClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim email As String
        If email = Nothing Then
            email = Request.QueryString("Email")
        End If

        Dim userID As Integer = getUserIdFromEmail(email)
        Dim newPassword As String = password.Text

        Try
            updatePassword(userID, newPassword)
            Dim client As SmtpClient = New SmtpClient()

            client.DeliveryMethod = SmtpDeliveryMethod.Network
            client.EnableSsl = True
            client.Host = ConfigurationManager.AppSettings("MailServer").ToString()
            client.Port = Convert.ToInt32(ConfigurationManager.AppSettings("MailServerPort").ToString())

            'setup Smtp authentication
            Dim credentials As System.Net.NetworkCredential = New System.Net.NetworkCredential(ConfigurationManager.AppSettings("CredentialMail").ToString(), ConfigurationManager.AppSettings("CredentialPassword").ToString())
            client.UseDefaultCredentials = False
            client.Credentials = credentials

            Dim msg As MailMessage = New MailMessage()
            msg.From = New MailAddress(ConfigurationManager.AppSettings("CredentialMail").ToString())
            msg.To.Add(New MailAddress(ConfigurationManager.AppSettings("ToMail").ToString()))

            Dim CC() As String = ConfigurationManager.AppSettings("CCMail").ToString().Split(",")
            Dim BCC() As String = ConfigurationManager.AppSettings("BCCMail").ToString().Split(",")

            For Each cc_copy As String In CC
                If (Not String.IsNullOrEmpty(cc_copy)) Then
                    msg.CC.Add(New MailAddress(cc_copy))
                End If
            Next

            For Each bcc_copy As String In BCC
                If (Not String.IsNullOrEmpty(bcc_copy)) Then
                    msg.Bcc.Add(New MailAddress(bcc_copy))
                End If
            Next

            If (Not (String.IsNullOrEmpty(email))) Then
                msg.To.Add(New MailAddress(email))
            End If

            msg.Subject = "HANO Housing Choice Connect - Updated Password  " + email
            msg.IsBodyHtml = True
            msg.Body = "<!DOCTYPE HTML><html><head></head><body><h1>Housing Choice Connect </h1> <br />" + _
                                "<b>Email: </b> <font color=#336699>" + email + "</font> <br />" + _
                                "<b>New Password: </b> <font color=#336699>" + newPassword + "</font> <br />" + _
                               "<b>Date of Password Change:  </b> <font color=#336699>" + Now.ToShortDateString + "</font> <br /><br /></body></html>"

            Try
                client.Send(msg)
                lblMsg.Text = "Password Updated. Please <a href='LandlordSignIn.aspx'>Sign In</a> with you new password"
            Catch ex As Exception
                lblMsg.ForeColor = Color.Red
                lblMsg.Text = "Error occured while sending your message." + ex.Message
            End Try

        Catch ex2 As Exception
            lblMsg.Text = "Error occured while sending your message." + ex2.Message
        End Try

    End Sub

    Public Function getUserIdFromEmail(ByVal email As String) As Integer
        Dim userID As Integer
        conn.Open()
        Dim query As New SqlCommand("SELECT UserID FROM Users WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            userID = reader(CStr("UserID"))
        End While
        conn.Close()
        Return userID
    End Function

    Sub updatePassword(ByVal userID As Integer, ByVal newPassword As String)
        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET Password = '" & newPassword & "' WHERE UserID ='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class