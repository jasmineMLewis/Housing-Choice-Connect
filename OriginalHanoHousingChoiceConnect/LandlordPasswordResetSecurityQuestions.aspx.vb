Imports System.Data.SqlClient

Public Class LandlordpasswordResetSecurityQuestios
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmitClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim email As String
        If email = Nothing Then
            email = Request.QueryString("Email")
        End If

        Dim userID As Integer = getUserIdFromEmail(email)

        Dim securityQuestionOneID As Integer = Request.Form("questionOneID")
        securityQuestionOneID = securityQuestionOneID + 1
        Dim _securityQuestionAnswerOne As String = securityQuestionAnswerOne.Text

        Dim securityQuestionTwoID As Integer = Request.Form("questionTwoID")
        securityQuestionTwoID = securityQuestionTwoID + 1
        Dim _securityQuestionAnswerTwo As String = securityQuestionAnswerTwo.Text

        Dim isQuestOneReponseMatch As Boolean = isSecurityQuestionResponseMatch(userID, securityQuestionOneID, _securityQuestionAnswerOne)
        Dim isQuestTwoReponseMatch As Boolean = isSecurityQuestionResponseMatch(userID, securityQuestionTwoID, _securityQuestionAnswerTwo)

        If (isQuestOneReponseMatch = True) And (isQuestTwoReponseMatch = True) Then
            Response.Redirect("LandlordSecurityQuestionsPasswordReset.aspx?Email=" & email & "")
        Else
            ' Response.Write("<div id='alertSecurityQuestionsError'><div class='alert alert-warning col-xs-12' role='alert'>Security Responses DON'T match!</div></div>")
            lblMsg.Text = "Oh No! Security Responses DON'T match!"
        End If
    End Sub

    Public Function getUserIdFromEmail(ByVal email As String) As Integer
        Dim userID As Integer
        conn.Open()
        Dim query As New SqlCommand("SELECT UserID FROM Users WHERE Email='" & email & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            userID = reader(CStr("UserID"))
        End While
        conn.Close()
        Return userID
    End Function

    Public Function isSecurityQuestionResponseMatch(ByVal userID As Integer, ByVal securityQuestionID As Integer, ByVal userResponse As String) As Boolean
        Dim dbResponse As String
        conn.Open()
        Dim query As New SqlCommand("SELECT Response FROM UserSecurityQuestion WHERE fk_SecurityQuestionID ='" & securityQuestionID & "' AND fk_UserID ='" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            dbResponse = reader(CStr("Response"))
        End While
        conn.Close()
        If dbResponse = userResponse Then
            Return True
        Else
            Return False
        End If
    End Function
End Class