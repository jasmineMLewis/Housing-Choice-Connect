Public Class Admins
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SetDropdownList()
        End If
    End Sub

    Protected Sub BtnSearchAdmin(ByVal sender As Object, ByVal e As EventArgs)
        Dim sql As String = "SELECT Users.UserID, (FirstName + ' ' + LastName) AS FullName, 
                                    Email, DateRegistered, LastLogin 
                             FROM [Security].[User] AS Users
                             INNER JOIN [Security].[UserRole] As UserRoles ON Users.UserID = UserRoles.UserID
                             WHERE RoleID = 1"
        Dim userID As Integer = FullName.SelectedValue.Trim
        Dim emailToSearch As String = Email.SelectedValue.Trim

        If (userID > 0) Then
            sql += "AND Users.UserID = " + userID.ToString()
        End If

        If Not String.IsNullOrEmpty(emailToSearch) Then
            sql += " AND Email = '" + emailToSearch.ToString() + "'"
        End If

        sqlGridView.SelectCommand = sql
        sqlGridView.DataBind()
        GridViewAdmins.DataBind()
    End Sub

    Public Sub SetDropdownList()
        FullName.AppendDataBoundItems = True
        FullName.Items.Insert(0, New ListItem("Full Name", "0"))

        Email.AppendDataBoundItems = True
        Email.Items.Insert(0, New ListItem("Email", ""))
    End Sub
End Class