Imports System.Web
Imports System.Data.SqlClient

Public Class AdminDeleteTenant
    Implements System.Web.IHttpHandler
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim tenantUserID As Integer = Integer.Parse(context.Request.QueryString("TenantUserID"))
        deleteUser(tenantUserID)
        context.Response.Redirect(context.Request.UrlReferrer.ToString())
    End Sub

    Private Sub deleteUser(ByVal userID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE FROM Users WHERE UserID = '" & userID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
End Class