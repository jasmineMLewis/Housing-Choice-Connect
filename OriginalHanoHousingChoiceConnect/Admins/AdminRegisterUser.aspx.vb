Imports System.Data.SqlClient

Public Class AdminRegisterUser
    Inherits System.Web.UI.Page
    Dim connectionString As String = "Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01"
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            setDropdownList()
        End If
    End Sub

    Protected Sub btnRegisterLandlord(ByVal sender As Object, ByVal e As EventArgs)
        If isEmailexists(landlordEmail.Text) = "True" Then
            Response.Write("<div class='alertError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Email arlready EXISTS</div></div>")
        Else
            registerLandlord()
            clearLandlordForm()
        End If
    End Sub

    Protected Sub btnRegisterTenant(ByVal sender As Object, ByVal e As EventArgs)
        If isEmailexists(tenantEmail.Text) = "True" Then
            Response.Write("<div class='alertError'><div class='alert alert-danger col-xs-12' role='alert'><strong>Oh No!</strong> Email arlready EXISTS</div></div>")
        Else
            registerTenant()
            clearTenantForm()
        End If
    End Sub

    Public Sub clearLandlordForm()
        landlordEmail.Text = ""
        landlordPassword.Text = ""
        landlordFirstName.Text = ""
        landlordLastName.Text = ""
    End Sub

    Public Sub clearTenantForm()
        FullDescrp.SelectedValue = 0
        tenantEmail.Text = ""
        tenantPassword.Text = ""
        tenantPassword.Text = ""
    End Sub

    Private Function getTenantName(ByVal userID As Integer) As String()
        Dim firstName As String = ""
        Dim lastName As String = ""

        conn.Open()
        Dim query As New SqlCommand("SELECT FirstName, LastName FROM EliteTenantImport WHERE ID ='" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            firstName = CStr(reader("FirstName"))
            lastName = CStr(reader("LastName"))
        End While
        conn.Close()

        Return New String() {firstName, lastName}
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

    Public Sub registerLandlord()
        Const ROLE As Integer = 5
        Dim email As String = landlordEmail.Text
        Dim password As String = landlordPassword.Text
        Dim firstName As String = landlordFirstName.Text
        Dim lastName As String = landlordLastName.Text
        Dim isEmailVerified As Boolean = 1
        Dim isSecurityQuestionsCompleted As Boolean = 0
        Dim dateRegistered As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim code As String = ""

        Dim query As String = String.Empty
        query &= "INSERT INTO Users (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, fk_RoleID, Code)"
        query &= "VALUES (@FirstName, @LastName, @Email, @Password, @IsEmailVerified, @IsSecurityQuestionsCompleted, @DateRegistered, @LastLogin, @fk_RoleID, @Code);"

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@FirstName", firstName)
                    .Parameters.AddWithValue("@LastName", lastName)
                    .Parameters.AddWithValue("@Email", email)
                    .Parameters.AddWithValue("@Password", password)
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

    Public Sub registerTenant()
        Const ROLE As Integer = 4
        Dim userID As Integer = FullDescrp.SelectedValue
        Dim email As String = tenantEmail.Text
        Dim password As String = tenantPassword.Text
        Dim fullNameList As String() = getTenantName(userID)
        Dim firstName As String = fullNameList(0)
        Dim lastName As String = fullNameList(1)
        Dim isEmailVerified As Boolean = 1
        Dim isSecurityQuestionsCompleted As Boolean = 0
        Dim dateRegistered As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim code As String = ""

        Dim query As String = String.Empty
        query &= "INSERT INTO Users (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, fk_RoleID, Code)"
        query &= "VALUES (@FirstName, @LastName, @Email, @Password, @IsEmailVerified, @IsSecurityQuestionsCompleted, @DateRegistered, @LastLogin, @fk_RoleID, @Code);"

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@FirstName", firstName)
                    .Parameters.AddWithValue("@LastName", lastName)
                    .Parameters.AddWithValue("@Email", email)
                    .Parameters.AddWithValue("@Password", password)
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

    Public Sub setDropdownList()
        FullDescrp.AppendDataBoundItems = True
        FullDescrp.Items.Insert(0, New ListItem("User *", "0"))
    End Sub
End Class