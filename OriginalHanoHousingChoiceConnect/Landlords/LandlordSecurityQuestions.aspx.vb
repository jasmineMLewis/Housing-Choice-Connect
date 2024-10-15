Imports System.Data.SqlClient

Public Class LandlordSecurityQuestions
    Inherits System.Web.UI.Page
    Dim connectionString As String = "Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01"
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")
    Private Const QUESTION_ONE As Integer = 1
    Private Const QUESTION_TWO As Integer = 2
    Private Const QUESTION_THREE As Integer = 3
    Private Const QUESTION_FOUR As Integer = 4
    Private Const QUESTION_FIVE As Integer = 5
    Private Const QUESTION_SIX As Integer = 6

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Sub answerSecurityQuestions(ByVal userID As Integer)
        Dim securityQuestionAnswerOne = Request.Form("securityQuestionAnswerOne").Trim
        Dim securityQuestionAnswerTwo = Request.Form("securityQuestionAnswerTwo").Trim
        Dim securityQuestionAnswerThree = Request.Form("securityQuestionAnswerThree").Trim
        Dim securityQuestionAnswerFour = Request.Form("securityQuestionAnswerFour").Trim
        Dim securityQuestionAnswerFive = Request.Form("securityQuestionAnswerFive").Trim
        Dim securityQuestionAnswerSix = Request.Form("securityQuestionAnswerSix").Trim

        Dim query As String = String.Empty
        query &= "INSERT INTO UserSecurityQuestion (Response, fk_SecurityQuestionID, fk_UserID)"
        query &= "VALUES (@Response, @fk_SecurityQuestionID, @fk_UserID)"

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@Response", securityQuestionAnswerOne)
                    .Parameters.AddWithValue("@fk_SecurityQuestionID", QUESTION_ONE)
                    .Parameters.AddWithValue("@fk_UserID", userID)
                End With

                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End Using

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@Response", securityQuestionAnswerTwo)
                    .Parameters.AddWithValue("@fk_SecurityQuestionID", QUESTION_TWO)
                    .Parameters.AddWithValue("@fk_UserID", userID)
                End With

                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End Using

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@Response", securityQuestionAnswerThree)
                    .Parameters.AddWithValue("@fk_SecurityQuestionID", QUESTION_THREE)
                    .Parameters.AddWithValue("@fk_UserID", userID)
                End With

                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End Using

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@Response", securityQuestionAnswerFour)
                    .Parameters.AddWithValue("@fk_SecurityQuestionID", QUESTION_FOUR)
                    .Parameters.AddWithValue("@fk_UserID", userID)
                End With

                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End Using

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@Response", securityQuestionAnswerFive)
                    .Parameters.AddWithValue("@fk_SecurityQuestionID", QUESTION_FIVE)
                    .Parameters.AddWithValue("@fk_UserID", userID)
                End With

                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End Using

        Using conn As New SqlConnection(connectionString)
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@Response", securityQuestionAnswerSix)
                    .Parameters.AddWithValue("@fk_SecurityQuestionID", QUESTION_SIX)
                    .Parameters.AddWithValue("@fk_UserID", userID)
                End With

                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End Using

    End Sub

    Protected Sub btnAnswerSecurityQuestions(ByVal sender As Object, ByVal e As EventArgs)
        Dim userID As String = getSessionUserID()
        answerSecurityQuestions(userID)
        setSecurityQuestionsCompletion(userID)
        Response.Redirect("LandlordDashboard.aspx?UserID=" & userID)
    End Sub

    Protected Sub btnUpdateSecurityQuestions(ByVal sender As Object, ByVal e As EventArgs)
        Dim userID As String = getSessionUserID()
        updateSecurityQuestions(userID)
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

    Public Sub setSecurityQuestionsCompletion(ByVal userID As Integer)
        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET IsSecurityQuestionsCompleted = 1 WHERE UserID='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub

    Public Sub updateSecurityQuestions(ByVal userID As Integer)
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