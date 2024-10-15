Imports System.Data
Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Drawing
Imports System.Configuration
Imports System.Net
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security

Public Class TenantSignUp
    Inherits System.Web.UI.Page
    Dim connectionString As String = "Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01"
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmitClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim _email As String = email.Text
        Dim _confEmail As String = confEmail.Text
        Dim _password As String = password.Text
        Dim _firstName As String = firstName.Text
        Dim _lastName As String = lastName.Text
        Dim _tenantEntityID As String = tenantEntityID.Text
        Dim _lastFourSSN As String = lastFourSSN.Text

        If (_email = "") Or (_confEmail = "") Or (_password = "") Or (_firstName = "") Or (_lastName = "") Or (_tenantEntityID = "") Or (_lastFourSSN = "") Then
            lblMsg.Text = "Oh No! All Fields are REQUIRED"
        ElseIf Not (_email.Equals(_confEmail)) Then
            lblMsg.Text = "Oh No! Email does NOT match"
        ElseIf isEmailexists(_email) Then
            lblMsg.Text = "Email arlready EXISTS"
        ElseIf isEntityIDExists(_tenantEntityID) = "False" Then
            lblMsg.Text = "Oh No! Entity ID does NOT EXISTS"
        ElseIf (isEntityIdSsnMatch(_tenantEntityID, _lastFourSSN)) = "False" Then
            lblMsg.Text = "Oh No!  Entity ID & SSN does NOT match our records"
        Else
            Try
                registerTenant()
                Dim client As SmtpClient = New SmtpClient()

                client.DeliveryMethod = SmtpDeliveryMethod.Network
                client.EnableSsl = True
                client.Host = ConfigurationManager.AppSettings("MailServer").ToString()
                client.Port = Convert.ToInt32(ConfigurationManager.AppSettings("MailServerPort").ToString())

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

                msg.Subject = "Welcome to HANO Choice Connect  " + firstName.Text + " " + lastName.Text
                msg.IsBodyHtml = True
                msg.Body = "<!DOCTYPE HTML><html><head></head><body><h1>Housing Choice Connect </h1> <br />" + _
                                   "<b>Tenant Name: </b> <font color=#336699>" + firstName.Text + " " + lastName.Text + "</font> <br />" + _
                                    "<b>Email: </b> <font color=#336699>" + email.Text + "</font> <br />" + _
                                    "<b>Password: </b> <font color=#336699>" + password.Text + "</font> <br />" + _
                                   "<b>Date of submission:  </b> <font color=#336699>" + Now.ToShortDateString + "</font> <br /><br />" + _
                                   "<b>Email Code Verification: </b> <font color=#336699>" + hdCode.Value + "</font> <br /></body></html>"

                Try
                    httpCallForFailCertificate()
                    client.Send(msg)
                    Web.HttpContext.Current.Session("Email") = _email
                    Response.Redirect("EmailVerification.aspx")
                Catch ex As Exception
                    lblMsg.ForeColor = Color.Red
                    lblMsg.Text = "Error occured while sending your message." + ex.Message
                End Try

            Catch ex2 As Exception
                lblMsg.Text = "Error occured while sending your message." + ex2.Message
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

    Public Function isEmailexists(ByVal email As String) As Boolean
        Dim isExists As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT  * FROM Users WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        If reader.HasRows Then
            isExists = True
        Else
            isExists = False
        End If
        conn.Close()
        Return isExists
    End Function

    Public Function isEntityIDExists(ByVal entityID As String) As Boolean
        Dim isExists As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT * FROM EliteTenantImport WHERE EntityID = '" & entityID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            isExists = True
        Else
            isExists = False
        End If
        conn.Close()
        Return isExists
    End Function

    Public Function isEntityIdSsnMatch(ByVal entityID As String, ByVal lastFourSSN As String) As Boolean
        Dim isMatch As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT DisguisedTaxID FROM EliteTenantImport WHERE EntityID = '" & entityID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        Dim dbDisguisedTaxID As String
        While reader.Read
            dbDisguisedTaxID = CStr(reader("DisguisedTaxID"))
        End While

        Dim cleanDbDisguisedTaxID As String
        cleanDbDisguisedTaxID = dbDisguisedTaxID.Replace("XXX-XX-", "")

        If cleanDbDisguisedTaxID = lastFourSSN Then
            isMatch = True
        Else
            isMatch = False
        End If
        conn.Close()
        Return isMatch
    End Function

    Public Sub registerTenant()
        Const ROLE As Integer = 4
        Dim _email As String = email.Text
        Dim _password As String = password.Text
        Dim _firstName As String = firstName.Text
        Dim _lastName As String = lastName.Text
        Dim isEmailVerified As Boolean = 0
        Dim isSecurityQuestionsCompleted As Boolean = 0
        Dim dateRegistered As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim code As String = UniqueKey.KeyGenerator.GetUniqueKey(8)
        hdCode.Value = code

        Dim query As String = String.Empty
        query &= "INSERT INTO Users (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, fk_RoleID, Code)"
        query &= "VALUES (@FirstName, @LastName, @Email, @Password, @IsEmailVerified, @IsSecurityQuestionsCompleted, @DateRegistered, @LastLogin, @fk_RoleID, @Code);"

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@FirstName", _firstName)
                    .Parameters.AddWithValue("@LastName", _lastName)
                    .Parameters.AddWithValue("@Email", _email)
                    .Parameters.AddWithValue("@Password", _password)
                    .Parameters.AddWithValue("@IsEmailVerified", isEmailVerified)
                    .Parameters.AddWithValue("@IsSecurityQuestionsCompleted", isSecurityQuestionsCompleted)
                    .Parameters.AddWithValue("@DateRegistered", dateRegistered)
                    .Parameters.AddWithValue("@LastLogin", lastLogin)
                    .Parameters.AddWithValue("@fk_RoleID", ROLE)
                    .Parameters.AddWithValue("@Code", code)
                End With

                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End Using
    End Sub
End Class