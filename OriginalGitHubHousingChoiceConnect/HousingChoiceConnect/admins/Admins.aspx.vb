Public Class Admins
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            setDropdownList()
        End If
    End Sub

    Protected Sub btnSearchAdmin(ByVal sender As Object, ByVal e As EventArgs)
        Dim sql As String = "SELECT UserID, FirstName + ' ' + LastName AS Name, Email, DateRegistered, LastLogin FROM Users WHERE fk_RoleID = 1"
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

    Public Sub setDropdownList()
        FullName.AppendDataBoundItems = True
        FullName.Items.Insert(0, New ListItem("Name", "0"))

        Email.AppendDataBoundItems = True
        Email.Items.Insert(0, New ListItem("Email", ""))
    End Sub
End Class