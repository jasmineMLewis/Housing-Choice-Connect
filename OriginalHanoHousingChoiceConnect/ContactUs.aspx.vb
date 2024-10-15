Imports System.Net.Mail
Imports System.Drawing
Imports System.Configuration
Imports System.Net
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security
Imports System.Data.SqlClient

Public Class ContactUs
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim userID As String = getSessionUserID()
     
        If Not IsPostBack Then
            setContactFormInfo(userID)
        End If
    End Sub

    Private Shared Function customCertValidation(ByVal sender As Object, ByVal cert As X509Certificate, ByVal chain As X509Chain, ByVal errors As SslPolicyErrors) As Boolean
        Return True
    End Function

    Public Sub CertificationCheck()
        ServicePointManager.ServerCertificateValidationCallback = New System.Net.Security.RemoteCertificateValidationCallback(AddressOf customCertValidation)
    End Sub

    Protected Sub btnSubmitClick(sender As Object, e As EventArgs)
        Try
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

            msg.Subject = "HANO Choice Connect Contact Us"
            msg.IsBodyHtml = True

            msg.Body = "<!DOCTYPE HTML><html><head></head><body><h1>Housing Choice Connect </h1> <br />" + _
                               "<b>Name: </b> <font color=#336699>" + name.Text + " </font> <br />" + _
                               "<b>Address: </b> <font color=#336699>" + phone.Text + "</font> <br />" + _
                               "<b>Comment: </b> <font color=#336699>" + comment.Text + "</font> <br />" + _
                               "<b>Date of submition:  </b> <font color=#336699>" + Now.ToShortDateString + "</font> <br /><br /></body></html>"


            Try
                CertificationCheck()
                client.Send(msg)
                lblMsg.ForeColor = Color.Black
                lblMsg.Text = "Your message has been successfully sent. You will receive an email confirming your information within the next 10 minutes. To ensure that your emails from HANO are always delivered to your inbox, please add us to your safe sender's list."
            Catch ex As Exception
                lblMsg.ForeColor = Color.Red
                lblMsg.Text = "Error occured while sending your message." + ex.Message
            End Try

        Catch ex2 As Exception
            lblMsg.Text = "Error occured while sending your message." + ex2.Message
        End Try

        lblMsg.Text = "Your message has been successfully sent. You will receive an email confirming your information within the next 10 minutes. To ensure that your emails from HANO are always delivered to your inbox, please add us to your safe sender's list."
    End Sub

    Public Function getSessionUserID() As String
        Dim userID As String
        If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
            userID = Web.HttpContext.Current.Session("UserID").ToString()
        End If

        If userID = Nothing Then
            userID = Request.QueryString("UserID")
            Web.HttpContext.Current.Session("UserID") = userID
        End If

        Return userID
    End Function

    Public Sub setContactFormInfo(ByVal userID As Integer)
        Dim dbName As String = ""
        Dim dbEmail As String = ""

        conn.Open()
        Dim query As New SqlCommand("SELECT FirstName + ' ' + LastName As Name, Email FROM Users WHERE UserID='" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            dbName = CStr(reader("Name"))
            dbEmail = CStr(reader("Email"))
        End While
        conn.Close()

        name.Text = dbName
        email.Text = dbEmail
    End Sub
End Class