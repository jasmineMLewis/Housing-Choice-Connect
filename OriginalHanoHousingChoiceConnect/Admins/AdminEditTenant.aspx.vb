Imports System.Data.SqlClient

Public Class AdminEditTenant
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnUpdateTenant(ByVal sender As Object, ByVal e As EventArgs)
        Dim tenantUserID As Integer = Integer.Parse(Context.Request.QueryString("TenantUserID"))
        updateTenantProfile(tenantUserID)
    End Sub

    Private Sub updateTenantProfile(ByVal userID As Integer)
        Dim firstName As String = Request.Form("firstName")
        Dim lastName As String = Request.Form("lastName")
        Dim password As String = Request.Form("password")
        Dim email As String = Request.Form("email")

        conn.Open()
        Dim query As New SqlCommand("UPDATE Users SET FirstName = '" & firstName & "', LastName =  '" & lastName & "', Password = '" & password & "', Email = '" & email & "' WHERE UserID='" & userID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class