Public Class Tenants
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            setDropdownList()
        End If
    End Sub

    Protected Sub btnSearchTenant(ByVal sender As Object, ByVal e As EventArgs)
        Dim sql As String = "SELECT UserID, FirstName + ' ' + LastName AS Name, Email, DateRegistered, LastLogin FROM Users WHERE fk_RoleID = 4"
        Dim userID As Integer = FullName.SelectedValue
        Dim emailToSearch As String = Email.SelectedValue

        If (userID > 0) Then
            sql += "AND UserID = " + userID.ToString()
        End If

        If Not String.IsNullOrEmpty(emailToSearch) Then
            sql += " AND Email = '" + emailToSearch.ToString() + "'"
        End If

        sqlGridView.SelectCommand = sql
        sqlGridView.DataBind()
        GridView1.DataBind()
    End Sub

    Public Function DisplayDeleteLink(ByVal tenantUserID As Integer, ByVal sessionUserID As Integer) As String
        Return "<a href=AdminDeleteTenant.ashx?TenantUserID=" & tenantUserID & "&UserID=" & sessionUserID & "><i class='fa fa-trash'></i></a>"
    End Function

    Public Function DisplayEditLink(ByVal tenantUserID As Integer, ByVal sessionUserID As Integer) As String
        Return "<a href=AdminEditTenant.aspx?TenantUserID=" & tenantUserID & "&UserID=" & sessionUserID & "><i class='fa fa-pencil'></i></a>"
    End Function

    Public Sub setDropdownList()
        FullName.AppendDataBoundItems = True
        FullName.Items.Insert(0, New ListItem("Name", "0"))

        Email.AppendDataBoundItems = True
        Email.Items.Insert(0, New ListItem("Email", ""))
    End Sub
End Class