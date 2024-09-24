Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class AdminRegisterUser
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SetDropdownList()
        End If
    End Sub

    Protected Sub BtnRegisterLandlord(ByVal sender As Object, ByVal e As EventArgs)
        If IsEmailexists(landlordEmail.Text.Trim) = "True" Then
            Response.Write("<div class='alertError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Email arlready EXISTS</div></div>")
        Else
            RegisterLandlord()
            ClearLandlordForm()
        End If
    End Sub

    Protected Sub BtnRegisterTenant(ByVal sender As Object, ByVal e As EventArgs)
        If IsEmailexists(tenantEmail.Text.Trim) = "True" Then
            Response.Write("<div class='alertError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Email arlready EXISTS</div></div>")
        Else
            RegisterTenant()
            ClearTenantForm()
        End If
    End Sub

    Public Sub ClearLandlordForm()
        landlordEmail.Text = ""
        landlordPassword.Text = ""
        landlordFirstName.Text = ""
        landlordLastName.Text = ""
    End Sub

    Public Sub ClearTenantForm()
        FullDescrp.SelectedValue = 0
        tenantEmail.Text = ""
        tenantPassword.Text = ""
        tenantPassword.Text = ""
    End Sub

    Private Function GetTenantName(ByVal userID As Integer) As String()
        Dim firstName As String = ""
        Dim lastName As String = ""

        conn.Open()
        Dim query As New SqlCommand("SELECT FirstName, LastName 
                                     FROM EliteTenantImport 
                                     WHERE EliteTenantImportID ='" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            firstName = CStr(reader("FirstName"))
            lastName = CStr(reader("LastName"))
        End While
        conn.Close()

        Return New String() {firstName, lastName}
    End Function

    Public Function IsEmailexists(ByVal email As String) As Boolean
        Dim isExists As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT UserID 
                                     FROM Users 
                                     WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        If reader.HasRows Then
            isExists = True
        Else
            isExists = False
        End If
        conn.Close()

        Return isExists
    End Function

    Public Sub RegisterLandlord()
        'Const LANDLORD_ROLE_ID As Integer = 3
        'Const IS_EMAIL_VERIFIED As Boolean = 1
        'Const IS_SECURITY_QUESTIONS_COMPLETED As Boolean = 0

        Dim email As String = landlordEmail.Text.Trim
        Dim password As String = landlordPassword.Text.Trim
        Dim firstName As String = StrConv(landlordFirstName.Text.Trim, VbStrConv.ProperCase)
        Dim lastName As String = StrConv(landlordLastName.Text.Trim, VbStrConv.ProperCase)
        Dim dateRegistered As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        'Dim code As String = ""

        Dim query As String = String.Empty
        query &= "INSERT INTO User (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID)"
        query &= "VALUES (@FirstName, @LastName, @Email, @Password, @IsEmailVerified, @IsSecurityQuestionsCompleted, @DateRegistered, @LastLogin, @RoleID);"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
                .Parameters.AddWithValue("@FirstName", firstName)
                .Parameters.AddWithValue("@LastName", lastName)
                .Parameters.AddWithValue("@Email", email)
                .Parameters.AddWithValue("@Password", password)
                .Parameters.AddWithValue("@IsEmailVerified", ApplicationConstants.Constants.IsEmailVerified)
                .Parameters.AddWithValue("@IsSecurityQuestionsCompleted", ApplicationConstants.Constants.IsSecurityQuestionsCompeleted)
                .Parameters.AddWithValue("@DateRegistered", dateRegistered)
                .Parameters.AddWithValue("@LastLogin", lastLogin)
                .Parameters.AddWithValue("@RoleID", ApplicationConstants.Constants.LandlordRole)
            End With

            conn.Open()
            comm.ExecuteNonQuery()
            conn.Close()
        End Using
    End Sub

    Public Sub RegisterTenant()
        Const TENANT_ROLE_ID As Integer = 2
        Const IS_EMAIL_VERIFIED As Boolean = 1
        Const IS_SECURITY_QUESTIONS_COMPLETED As Boolean = 0

        Dim userID As Integer = FullDescrp.SelectedValue
        Dim email As String = tenantEmail.Text
        Dim password As String = tenantPassword.Text
        Dim fullNameList As String() = GetTenantName(userID)
        Dim firstName As String = fullNameList(0)
        Dim lastName As String = fullNameList(1)
        Dim dateRegistered As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")

        Dim query As String = String.Empty
        query &= "INSERT INTO User (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID)"
        query &= "VALUES (@FirstName, @LastName, @Email, @Password, @IsEmailVerified, @IsSecurityQuestionsCompleted, @DateRegistered, @LastLogin, @RoleID);"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
                .Parameters.AddWithValue("@FirstName", firstName)
                .Parameters.AddWithValue("@LastName", lastName)
                .Parameters.AddWithValue("@Email", email)
                .Parameters.AddWithValue("@Password", password)
                .Parameters.AddWithValue("@IsEmailVerified", IS_EMAIL_VERIFIED)
                .Parameters.AddWithValue("@IsSecurityQuestionsCompleted", IS_SECURITY_QUESTIONS_COMPLETED)
                .Parameters.AddWithValue("@DateRegistered", dateRegistered)
                .Parameters.AddWithValue("@LastLogin", lastLogin)
                .Parameters.AddWithValue("@RoleID", TENANT_ROLE_ID)
            End With

            conn.Open()
            comm.ExecuteNonQuery()
            conn.Close()
        End Using
    End Sub

    Public Sub SetDropdownList()
        FullDescrp.AppendDataBoundItems = True
        FullDescrp.Items.Insert(0, New ListItem("User *", "0"))
    End Sub
End Class