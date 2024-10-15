Imports System.Data.SqlClient
Imports System.Net
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security
Imports System.Net.Mail

Public Class LandlordVerifyEmail
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnEmailAdrdressToVerify(ByVal sender As Object, ByVal e As EventArgs)
        Dim _emailAdrdressToVerify As String = emailAdrdressToVerify.Text.Trim
        Dim _uniqueCode As String = generateCode()
        hdCode.Value = _uniqueCode

        If (_emailAdrdressToVerify = "") Then
            Response.Write("<div id='alertEmailExistsError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong>Enter an Email Address</div></div>")
        ElseIf Not isEmailexists(_emailAdrdressToVerify) Then
            Response.Write("<div id='alertEmailExistsError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Email does NOT EXIST</div></div>")
        Else
            Try
                updateLandlord(_emailAdrdressToVerify, _uniqueCode)
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

                If (Not (String.IsNullOrEmpty(emailAdrdressToVerify.Text))) Then
                    msg.To.Add(New MailAddress(emailAdrdressToVerify.Text))
                End If

                msg.Subject = "Welcome to HANO Choice Connect  "
                msg.IsBodyHtml = True

                msg.Body = "<!DOCTYPE HTML><html><head></head><body><h1>Housing Choice Connect </h1> <br />" + _
                                    "<b>Email: </b> <font color=#336699>" + emailAdrdressToVerify.Text + "</font> <br />" + _
                                 "<b>Verification Code: </b> <font color=#336699>" + hdCode.Value + "</font> <br /></body></html>"

                Try
                    httpCallForFailCertificate()
                    client.Send(msg)
                    Web.HttpContext.Current.Session("Email") = _emailAdrdressToVerify
                    Response.Redirect("EmailVerification.aspx")
                Catch ex As Exception

                End Try
            Catch ex2 As Exception
            End Try
        End If
    End Sub

    Private Shared Function customCertValidation(ByVal sender As Object, ByVal cert As X509Certificate, ByVal chain As X509Chain, ByVal errors As SslPolicyErrors) As Boolean
        Return True
    End Function

    Public Sub httpCallForFailCertificate()
        'CALL THIS BEFORE ANY HTTPS CALLS THAT WILL FAIL WITH CERT ERROR
        ServicePointManager.ServerCertificateValidationCallback = New System.Net.Security.RemoteCertificateValidationCallback(AddressOf customCertValidation)
    End Sub

    Private Function generateCode() As String
        Return UniqueKey.KeyGenerator.GetUniqueKey(8)
    End Function

    Public Function isEmailexists(ByVal email As String) As Boolean
        Dim isExists As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT * FROM Users WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        If reader.HasRows Then
            isExists = True
        Else
            isExists = False
        End If
        conn.Close()
        Return isExists
    End Function

    Private Sub updateLandlord(ByVal email As String, ByVal uniqueCode As String)
        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET Code = '" & uniqueCode & "' WHERE Email='" & email & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub

End Class