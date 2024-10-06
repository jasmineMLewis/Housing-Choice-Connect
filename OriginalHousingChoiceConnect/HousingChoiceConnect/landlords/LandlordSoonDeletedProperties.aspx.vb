Public Class LandlordProximityProperties
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        DisplayActiveProperties(GetUserID())
    End Sub

    Public Sub DisplayActiveProperties(ByVal userID As Integer)
        Dim sql As String = "SELECT LandlordPropertyID, RTRIM([AddressProperty] + ' ' + [Apt_Suite]) As Address, ZipCode, " & _
                            "       BedroomNumber AS Bed, BathroomNumber As Bath, Rent, NumberOfTenantViews " & _
                            "FROM LandlordProperty " & _
                            "INNER JOIN Neighborhood ON LandlordProperty.fk_NeighborhoodID = Neighborhood.NeighborhoodID " & _
                            "WHERE [fk_UserID] = '" & userID & "' AND [DateLastUpdated] < DATEADD(day, -90, GETDATE()) " & _
                            "ORDER BY AddressProperty ASC "
        sqlProperties.SelectCommand = sql
        sqlProperties.DataBind()
        GridViewProperties.DataBind()
    End Sub

    Protected Function DisplayActivateLink(ByVal landlordPropertyID As Integer) As String
        Return "<a href=/landlords/SetPropertyState.aspx?LandlordPropertyID=" & landlordPropertyID & "&PropertyStateID=1><i class='fa fa-toggle-on'></i></a>"
    End Function

    Protected Function DisplayDeleteLink(ByVal landlordPropertyID As Integer) As String
        Return "<a href=/landlords/SetPropertyState.aspx?LandlordPropertyID=" & landlordPropertyID & "&PropertyStateID=2><i class='fa fa-trash'></i></a>"
    End Function

    Protected Function DisplayEditLink(ByVal landlordPropertyID As Integer) As String
        Return "<a href=/landlords/LandlordEditProperty.aspx?LandlordPropertyID=" & landlordPropertyID & "><i class='fa fa-pencil'></i></a>"
    End Function

    Public Function DisplayViewLink(ByVal landlordPropertyID As Integer, ByVal address As String) As String
        Dim link As String = ""
        link = "<a href=/landlords/ViewProperty.aspx?LandlordPropertyID=" & landlordPropertyID & " target='_blank'>" & address & "</a>"
        Return link
    End Function

    Public Function GetUserID() As Integer
        Dim userID As String
        If Not Request.QueryString("LandlordUserID") Is Nothing Then
            userID = Request.QueryString("LandlordUserID")
        Else
            If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
                userID = Web.HttpContext.Current.Session("UserID").ToString()
            End If

            If userID = Nothing Then
                userID = Request.QueryString("UserID")
                Web.HttpContext.Current.Session("UserID") = userID
            End If
        End If
        Return Convert.ToInt32(userID)
    End Function
End Class