Imports System.Net.Mail
Imports System.Drawing
Imports System.Data.SqlClient
Imports System.Net
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security


Public Class SendEmailVerification
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnEmailNewVerificationCode(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim code As String = UniqueKey.KeyGenerator.GetUniqueKey(8)
            Dim userID As Integer = getEmailUserID(email.Text)
            updateCode(userID, code)

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

            If (Not (String.IsNullOrEmpty(email.Text))) Then
                msg.To.Add(New MailAddress(email.Text))
            End If

            msg.Subject = "Email Verification Code from HANO Housing Choice Connect  "
            msg.IsBodyHtml = True
            msg.Body = "<!DOCTYPE HTML><html><head></head><body><h1>Housing Choice Connect </h1> <br />" + _
                                "<b>Email: </b> <font color=#336699>" + email.Text + "</font> <br />" + _
                               "<b>Date of submition:  </b> <font color=#336699>" + Now.ToShortDateString + "</font> <br /><br />" + _
                               "<b>Email Code Verification: </b> <font color=#336699>" + code + "</font> <br /></body></html>"

            Try
                httpCallForFailCertificate()
                client.Send(msg)
                Web.HttpContext.Current.Session("Email") = email.Text
                lblMsg.ForeColor = Color.Black
                lblMsg.Text = "Your message has been successfully sent. You will receive an email confirming your information within the next 10 minutes. Click <a href='EmailVerification.aspx'>here</a>"
            Catch ex As Exception
                lblMsg.ForeColor = Color.Red
                lblMsg.Text = "Error occured while sending your message." + ex.Message
            End Try

        Catch ex2 As Exception
            lblMsg.Text = "Error occured while sending your message." + ex2.Message
        End Try
    End Sub

    Private Shared Function customCertValidation(ByVal sender As Object, ByVal cert As X509Certificate, ByVal chain As X509Chain, ByVal errors As SslPolicyErrors) As Boolean
        Return True
    End Function

    Public Sub httpCallForFailCertificate()
        'CALL THIS BEFORE ANY HTTPS CALLS THAT WILL FAIL WITH CERT ERROR
        ServicePointManager.ServerCertificateValidationCallback = New System.Net.Security.RemoteCertificateValidationCallback(AddressOf customCertValidation)
    End Sub

    Public Function getEmailUserID(ByVal email As String) As Integer
        Dim userID As Integer
        conn.Open()

        Dim userIDquery As New SqlCommand("SELECT UserID FROM Users WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = userIDquery.ExecuteReader()
        While reader.Read
            userID = CStr(reader("UserID"))
        End While
        conn.Close()
        Return userID
    End Function

    Public Sub updateCode(ByVal userID As Integer, ByVal code As String)
        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET Code = '" & code & "' WHERE UserID ='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class