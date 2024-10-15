Imports System.Data.SqlClient

Public Class LandlordProfileUpdate
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnUpdateProfile(ByVal sender As Object, ByVal e As EventArgs)
        Dim userID As String = getSessionUserID()
        updateProfile(userID)
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

    Private Sub updateProfile(ByVal userID As Integer)
        Dim firstName As String = Request.Form("firstName")
        Dim lastName As String = Request.Form("lastName")
        Dim password As String = Request.Form("newPassword")
        Dim email As String = Request.Form("email")

        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET FirstName = '" & firstName & "', LastName =  '" & lastName & "', Password = '" & password & "', Email = '" & email & "' WHERE UserID='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class