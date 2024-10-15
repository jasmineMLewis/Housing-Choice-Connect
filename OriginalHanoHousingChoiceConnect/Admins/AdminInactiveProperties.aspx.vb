Imports System.Data.SqlClient
Imports System.IO

Public Class AdminInactiveProperties
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SetDropdownList()
        End If
    End Sub

    Private Sub BindGridWithFilters()
        Dim sql As String = "SELECT LandlordProperty.LandlordPropertyID, " & _
                            "       RTRIM(LandlordProperty.AddressProperty + ' ' + LandlordProperty.Apt_Suite) As ""Address"", Rent, " & _
                            "       BedroomNumber AS Bed, BathroomNumber As Bath, Neighborhood.ZipCode, PersonOfContact As Landlord, " & _
                            "       CONVERT (varchar(MAX), CAST(LandlordProperty.DateOfPostage AS date), 101) AS DateOfPostage, " & _
                            "       CONVERT (varchar(MAX), CAST(LandlordProperty.DateLastUpdated AS date), 101) AS DateLastUpdated, " & _
                            "       PersonToContactPhoneNumber As LandlordNumber " & _
                            "FROM LandlordProperty " & _
                            "INNER JOIN Neighborhood ON LandlordProperty.fk_NeighborhoodID = Neighborhood.NeighborhoodID " & _
                            "WHERE IsActive = 0"
        Dim streetAddressID As Integer = PropertyAddress.SelectedValue
        Dim zip As Integer = ZipCode.SelectedValue
        Dim beds As Integer = Bedroom.SelectedValue
        Dim baths As Double = Bathroom.SelectedValue
        Dim rent As String = rentText.Text

        If (streetAddressID > 0) Then
            sql += "AND LandlordProperty.LandlordPropertyID = " + streetAddressID.ToString()
        End If

        If (zip > 0) Then
            sql += " AND Neighborhood.ZipCode = " + zip.ToString()
        End If

        If (beds >= 0) Then
            sql += " AND LandlordProperty.BedroomNumber = " + beds.ToString()
        End If

        If (baths > 0) Then
            sql += " AND LandlordProperty.BathroomNumber = " + baths.ToString()
        End If

        If Not String.IsNullOrEmpty(rent) Then
            sql += " AND LandlordProperty.Rent <=" + rent.ToString()
        End If

        sql += " ORDER BY ZipCode, Bed ASC"

        sqlProperties.SelectCommand = sql
        sqlProperties.DataBind()
        GridViewProperties.DataBind()
    End Sub

    Protected Sub BtnFilterProperties(ByVal sender As Object, ByVal e As EventArgs)
        Me.BindGridWithFilters()
    End Sub

    Protected Sub BtnExportToExcel(ByVal sender As Object, ByVal e As EventArgs)
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment;filename=HANOPropertyList.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"
        Using writeContent As New StringWriter()
            GridViewProperties.AllowPaging = False
            Dim writeHtmlContent As New HtmlTextWriter(writeContent)
            Me.BindGridWithFilters()
            GridViewProperties.RenderControl(writeHtmlContent)
            Response.Output.Write(writeContent.ToString())
            Response.Flush()
            Response.[End]()
        End Using
    End Sub

    Public Function DisplayActivateLink(ByVal landlordPropertyID As Integer) As String
        Return "<a href=../SetPropertyState.aspx?LandlordPropertyID=" & landlordPropertyID & "&PropertyStateID=1><i class='fa fa-toggle-on'></i></a>"
    End Function

    Public Function DisplayDeleteLink(ByVal landlordPropertyID As Integer) As String
        Return "<a href=../SetPropertyState.aspx?LandlordPropertyID=" & landlordPropertyID & "&PropertyStateID=2><i class='fa fa-trash'></i></a>"
    End Function

    Public Function DisplayEditLink(ByVal landlordPropertyID As Integer) As String
        Return "<a href=AdminEditProperty.aspx?LandlordPropertyID=" & landlordPropertyID & "><i class='fa fa-pencil'></i></a>"
    End Function

    Public Function DisplayViewLink(ByVal landlordPropertyID As Integer, ByVal address As String) As String
        Dim link As String = ""
        link = "<a href=AdminViewProperty.aspx?LandlordPropertyID=" & landlordPropertyID & ">" & address & "</a>"
        Return link
    End Function

    Public Sub SetDropdownList()
        PropertyAddress.AppendDataBoundItems = True
        PropertyAddress.Items.Insert(0, New ListItem("Street Address", "0"))

        ZipCode.AppendDataBoundItems = True
        ZipCode.Items.Insert(0, New ListItem("Zip Code", "0"))
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        ' Confirms that an HtmlForm control is rendered for the specified ASP.NET
        '     server control at run time. 
    End Sub
End Class