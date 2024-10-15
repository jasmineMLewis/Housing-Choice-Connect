Imports System.Data.SqlClient

Public Class Landlords
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            setDropdownList()
        End If
    End Sub

    Protected Sub btnSearchLandlord(ByVal sender As Object, ByVal e As EventArgs)
        Dim sql As String = "SELECT UserID, FirstName + ' ' + LastName AS FullName, Email, IsEmailVerified, DateRegistered, LastLogin, (SELECT COUNT(LandlordPropertyID) AS Expr1 FROM LandlordProperty WHERE (fk_UserID = Users.UserID) AND (IsActive = '1')) AS CountActive, (SELECT COUNT(LandlordPropertyID) AS Expr1 FROM LandlordProperty AS LandlordProperty_2 WHERE (fk_UserID = Users.UserID) AND (IsActive = '0')) AS CountInactive, (SELECT COUNT(LandlordPropertyID) AS countSoonToBeDeleted FROM LandlordProperty AS LandlordProperty_1 WHERE (fk_UserID = Users.UserID) AND (DateLastUpdated < DATEADD(day, - 90, GETDATE()))) AS CountSoonToBeDeleted FROM Users WHERE (fk_RoleID = '5')"
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

    Public Function DisplayDeleteLink(ByVal landlordUserID As Integer, ByVal sessionUserID As Integer) As String
        Return "<a href=AdminDeleteLandlord.ashx?LandlordUserID=" & landlordUserID & "&UserID=" & sessionUserID & "><i class='fa fa-trash'></i></a>"
    End Function

    Public Function DisplayEditLink(ByVal landlordUserID As Integer, ByVal sessionUserID As Integer) As String
        Return "<a href=AdminEditLandlord.aspx?LandlordUserID=" & landlordUserID & "&UserID=" & sessionUserID & "><i class='fa fa-pencil'></i></a>"
    End Function

    Public Function DisplayNameLink(ByVal landlordUserID As Integer, ByVal name As String, ByVal sessionUserID As Integer) As String
        Return "<a href=AdminViewLandlord.aspx?LandlordUserID=" & landlordUserID & "&UserID=" & sessionUserID & ">" & name & "</a>"
    End Function

    Public Sub setDropdownList()
        FullName.AppendDataBoundItems = True
        FullName.Items.Insert(0, New ListItem("Name", "0"))

        Email.AppendDataBoundItems = True
        Email.Items.Insert(0, New ListItem("Email", ""))
    End Sub
End Class