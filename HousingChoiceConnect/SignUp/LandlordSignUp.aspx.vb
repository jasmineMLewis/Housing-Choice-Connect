Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class LandlordSignUp
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub

    Protected Sub BtnLandlordSignUp(ByVal sender As Object, ByVal e As EventArgs)
        Dim _email As String = email.Text.Trim
        Dim _confEmail As String = confEmail.Text.Trim
        Dim _password As String = password.Text.Trim
        Dim _firstName As String = StrConv(firstName.Text.Trim, VbStrConv.ProperCase)
        Dim _lastName As String = StrConv(lastName.Text.Trim, VbStrConv.ProperCase)

        If (_email = "") Or (_confEmail = "") Or (_password = "") Or (_firstName = "") Or (_lastName = "") Then
            lblMsg.Text = "Oh No! All Fields are REQUIRED"
        ElseIf Not (_email.Equals(_confEmail)) Then
            lblMsg.Text = "Oh No! Email does NOT match."
        ElseIf IsEmailexists(_email) = "True" Then
            lblMsg.Text = "Oh No! Email arlready EXISTS"
        Else
            Try
                Dim userID As Integer = RegisterLandlord()
                Session("UserID") = userID

                Response.Redirect("../landlords/LandlordDashboard.aspx?UserID=" & userID)
            Catch ex2 As Exception
                lblMsg.Text = "Error occured while sending your message." + ex2.Message
            End Try
        End If
    End Sub

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

    Public Function RegisterLandlord() As Integer
        Const LANDLORD_ROLE_ID As Integer = 3
        Const IS_EMAIL_VERIFIED As Boolean = 1
        Const IS_SECURITY_QUESTIONS_COMPLETED As Boolean = 0

        Dim userID As Integer
        Dim _email As String = email.Text.Trim
        Dim _password As String = password.Text.Trim
        Dim _firstName As String = StrConv(firstName.Text.Trim, VbStrConv.ProperCase)
        Dim _lastName As String = StrConv(lastName.Text.Trim, VbStrConv.ProperCase)
        Dim dateRegistered As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim lastLogin As DateTime = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
        Dim code As String = UniqueKey.KeyGenerator.GetUniqueKey(8)
        hdCode.Value = code

        Dim query As String = String.Empty
        query &= "INSERT INTO Users (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID, Code)"
        query &= "VALUES (@FirstName, @LastName, @Email, @Password, @IsEmailVerified, @IsSecurityQuestionsCompleted, @DateRegistered, @LastLogin, @RoleID, @Code);"
        query &= "SELECT @@IDENTITY FROM Users"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
                .Parameters.AddWithValue("@FirstName", _firstName)
                .Parameters.AddWithValue("@LastName", _lastName)
                .Parameters.AddWithValue("@Email", _email)
                .Parameters.AddWithValue("@Password", _password)
                .Parameters.AddWithValue("@IsEmailVerified", IS_EMAIL_VERIFIED)
                .Parameters.AddWithValue("@IsSecurityQuestionsCompleted", IS_SECURITY_QUESTIONS_COMPLETED)
                .Parameters.AddWithValue("@DateRegistered", dateRegistered)
                .Parameters.AddWithValue("@LastLogin", lastLogin)
                .Parameters.AddWithValue("@RoleID", LANDLORD_ROLE_ID)
                .Parameters.AddWithValue("@Code", code)
            End With

            conn.Open()
            userID = comm.ExecuteScalar()
            conn.Close()
        End Using

        Return userID
    End Function
End Class