Imports System.Data.SqlClient

Public Class EmailVerification
    Inherits System.Web.UI.Page

    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmitClick(ByVal sender As Object, ByVal e As EventArgs)
        Const LANDLORD As Integer = 5
        Const TENANT As Integer = 4

        Dim email As String = Web.HttpContext.Current.Session("Email").ToString()
        Dim userID As Integer = getEmailUserID(email)
        Dim dbCode As String = getVerificationCode(userID)
        Dim roleID As Integer = getRoleID(userID)
        Dim _verificationCode As String = verificationCode.Text.Trim

        If (_verificationCode = dbCode) Then
            updateEmailVerification(userID)
            If roleID = TENANT Then
                Web.HttpContext.Current.Session("UserID") = userID
                Response.Redirect("Tenants/TenantDashboard.aspx")
            ElseIf roleID = LANDLORD Then
                Web.HttpContext.Current.Session("UserID") = userID
                Response.Redirect("Landlords/LandlordSecurityQuestions.aspx?UserID=" & userID & "&SecurityQuestionsState=0")
            End If
        Else
            lblMsg.Text = "Oh No! EWrong Verification Code. Try again or get a new one."
        End If
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

    Public Function getRoleID(ByVal userID As Integer) As Integer
        Dim roleID As Integer
        conn.Open()

        Dim roleIDquery As New SqlCommand("SELECT fk_RoleID FROM Users WHERE UserID='" & userID & "'", conn)
        Dim reader As SqlDataReader = roleIDquery.ExecuteReader()
        While reader.Read
            roleID = CStr(reader("fk_RoleID"))
        End While
        conn.Close()
        Return roleID
    End Function

    Public Function getVerificationCode(ByVal userID As Integer) As String
        Dim code As String
        conn.Open()

        Dim codequery As New SqlCommand("SELECT Code FROM Users WHERE UserID = '" & userID & "'", conn)
        Dim readerCode As SqlDataReader = codequery.ExecuteReader()
        While readerCode.Read
            code = CStr(readerCode("Code"))
        End While
        conn.Close()

        If Not IsDBNull(code) Then
            Return code
        Else
            Return "ERROR"
        End If
    End Function

    Sub updateEmailVerification(ByVal userID As Integer)
        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET IsEmailVerified = 1 WHERE UserID ='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class