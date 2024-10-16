﻿Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class TenantSignUp
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

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
                Dim userID As Integer = registerTenant()
                Response.Redirect("../tenants/TenantDashboard.aspx?UserID=" & userID)
            Catch ex2 As Exception
                lblMsg.Text = "Error occured while sending your message." + ex2.Message
            End Try
        End If
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
    Public Function registerTenant() As Integer
        Const ROLE As Integer = 2
        Dim userID As Integer
        Dim _email As String = email.Text
        Dim _password As String = password.Text
        Dim _firstName As String = firstName.Text
        Dim _lastName As String = lastName.Text
        Dim isEmailVerified As Boolean = 1
        Dim isSecurityQuestionsCompleted As Boolean = 0
        Dim dateRegistered As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim code As String = UniqueKey.KeyGenerator.GetUniqueKey(8)
        hdCode.Value = code

        Dim query As String = String.Empty
        query &= "INSERT INTO Users (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, fk_RoleID, Code)"
        query &= "VALUES (@FirstName, @LastName, @Email, @Password, @IsEmailVerified, @IsSecurityQuestionsCompleted, @DateRegistered, @LastLogin, @fk_RoleID, @Code);"
        query &= "SELECT @@IDENTITY from Users"

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
            userID = comm.ExecuteScalar()
            conn.Close()
        End Using

        Return userID
    End Function
End Class