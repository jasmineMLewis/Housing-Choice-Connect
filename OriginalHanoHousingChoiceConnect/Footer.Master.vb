Imports System.Net.Mail
Imports System.Drawing
Imports System.Configuration

Public Class startPage
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmitClick(sender As Object, e As EventArgs)
        Try
            Dim client As SmtpClient = New SmtpClient()

            System.Net.ServicePointManager.ServerCertificateValidationCallback = Function() True

            client.DeliveryMethod = SmtpDeliveryMethod.Network
            client.EnableSsl = True
            client.Host = ConfigurationManager.AppSettings("MailServer").ToString()
            client.Port = Convert.ToInt32(ConfigurationManager.AppSettings("MailServerPort").ToString())

            'setup Smtp authentication
            Dim credentials As System.Net.NetworkCredential = New System.Net.NetworkCredential(ConfigurationManager.AppSettings("CredentialMail").ToString(), ConfigurationManager.AppSettings("CredentialPassword").ToString())
            client.UseDefaultCredentials = True
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

            If (Not (String.IsNullOrEmpty(contactUsModalEmail.Text))) Then
                msg.To.Add(New MailAddress(contactUsModalEmail.Text))
            End If

            msg.Subject = "Your Inquiry sent to HANO Choice Connect  " + contactUsModalName.Text
            msg.IsBodyHtml = True

            msg.Body = "<!DOCTYPE HTML><html><head></head><body><h1>Housing Choice Connect - Contact Us </h1> <br />" + _
                               "<b>Name: </b> <font color=#336699>" + contactUsModalName.Text + "</font> <br />" + _
                               "<b>Phone Number: </b> <font color=#336699>" + contactUsModalPhoneNumber.Text + "</font> <br />" + _
                               "<b>Date of submission:  </b> <font color=#336699>" + Now.ToShortDateString + "</font> <br /><br />" + _
                               "<b>Comment:  </b><font color=#336699>" + contactUsModalComment.Text + "</font> <br /></body></html>"

            Try
                client.Send(msg)
                lblMsg.ForeColor = Color.Black
                lblMsg.Text = "Your message has been successfully sent. You will receive an email confirmination."
            Catch ex As Exception
                lblMsg.ForeColor = Color.Red
                lblMsg.Text = "Error occured while sending your message." + ex.Message
            End Try
        Catch ex2 As Exception
            lblMsg.Text = "Error occured while sending your message." + ex2.Message
        End Try
    End Sub
End Class