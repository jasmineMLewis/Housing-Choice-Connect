Imports System.Data.SqlClient

Public Class AdminEditLandlord
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnUpdateLandlord(ByVal sender As Object, ByVal e As EventArgs)
        Dim landlordUserID As Integer = Integer.Parse(Context.Request.QueryString("LandlordUserID"))
        updateLandlordProfile(landlordUserID)
        updateSecurityQuestions(landlordUserID)
    End Sub

    Private Sub updateLandlordProfile(ByVal userID As Integer)
        Dim firstName As String = Request.Form("firstName")
        Dim lastName As String = Request.Form("lastName")
        Dim password As String = Request.Form("password")
        Dim email As String = Request.Form("email")

        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET FirstName = '" & firstName & "', LastName =  '" & lastName & "', Password = '" & password & "', Email = '" & email & "' WHERE UserID='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub

    Private Sub updateSecurityQuestions(ByVal userID As Integer)
        Dim securityQuestionAnswerOne = Request.Form("securityQuestionAnswerOne").Trim
        Dim securityQuestionAnswerTwo = Request.Form("securityQuestionAnswerTwo").Trim
        Dim securityQuestionAnswerThree = Request.Form("securityQuestionAnswerThree").Trim
        Dim securityQuestionAnswerFour = Request.Form("securityQuestionAnswerFour").Trim
        Dim securityQuestionAnswerFive = Request.Form("securityQuestionAnswerFive").Trim
        Dim securityQuestionAnswerSix = Request.Form("securityQuestionAnswerSix").Trim

        conn.Open()
        Dim query1 As New SqlCommand("UPDATE UserSecurityQuestion SET Response = '" & securityQuestionAnswerOne & "' WHERE fk_UserID ='" & userID & "' AND fk_SecurityQuestionID = 1", conn)
        query1.ExecuteNonQuery()
        conn.Close()

        conn.Open()
        Dim query2 As New SqlCommand("UPDATE UserSecurityQuestion SET Response = '" & securityQuestionAnswerTwo & "' WHERE fk_UserID ='" & userID & "' AND fk_SecurityQuestionID = 2", conn)
        query2.ExecuteNonQuery()
        conn.Close()

        conn.Open()
        Dim query3 As New SqlCommand("UPDATE UserSecurityQuestion SET Response = '" & securityQuestionAnswerThree & "' WHERE fk_UserID ='" & userID & "' AND fk_SecurityQuestionID = 3", conn)
        query3.ExecuteNonQuery()
        conn.Close()

        conn.Open()
        Dim query4 As New SqlCommand("UPDATE UserSecurityQuestion SET Response = '" & securityQuestionAnswerFour & "' WHERE fk_UserID ='" & userID & "' AND fk_SecurityQuestionID = 4", conn)
        query4.ExecuteNonQuery()
        conn.Close()

        conn.Open()
        Dim query5 As New SqlCommand("UPDATE UserSecurityQuestion SET Response = '" & securityQuestionAnswerFive & "' WHERE fk_UserID ='" & userID & "' AND fk_SecurityQuestionID = 5", conn)
        query5.ExecuteNonQuery()
        conn.Close()

        conn.Open()
        Dim query6 As New SqlCommand("UPDATE UserSecurityQuestion SET Response = '" & securityQuestionAnswerSix & "' WHERE fk_UserID='" & userID & "' AND fk_SecurityQuestionID = 6", conn)
        query6.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class