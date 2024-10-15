<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Hosting" %>

    <%
        Dim userID As String
        If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
            userID = Web.HttpContext.Current.Session("UserID").ToString()
        End If
    
        If userID = Nothing Then
            userID = Request.QueryString("UserID")
            Web.HttpContext.Current.Session("UserID") = userID
        End If
        
        Dim landlordPropertyID As String
        If landlordPropertyID = Nothing Then
            landlordPropertyID = Request.QueryString("LandlordPropertyID")
        End If
     
        Dim propertyStateID As String
        If propertyStateID = Nothing Then
            propertyStateID = Request.QueryString("PropertyStateID")
        End If
  
        Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")
        Select Case propertyStateID
            Case 0
                conn.Open()
                Dim query As New SqlCommand("UPDATE LandlordProperty SET IsActive = 0, DateOfInactivation = '" & Date.Today & "' WHERE LandlordPropertyID ='" & landlordPropertyID & "'", conn)
                query.ExecuteNonQuery()
                conn.Close()
                Response.Redirect(Request.UrlReferrer.ToString())
            Case 1
                conn.Open()
                Dim query As New SqlCommand("UPDATE LandlordProperty SET IsActive = 1, DateLastUpdated = '" & Date.Today & "' WHERE LandlordPropertyID ='" & landlordPropertyID & "'", conn)
                query.ExecuteNonQuery()
                conn.Close()
                Response.Redirect(Request.UrlReferrer.ToString())
            Case 2
                'Delete records from amentity
                conn.Open()
                Dim queryAmentity As New SqlCommand("DELETE FROM LandlordPropertyAmentity WHERE fk_LandlordPropertyID ='" & landlordPropertyID & "'", conn)
                queryAmentity.ExecuteNonQuery()
                conn.Close()
             
                'Delete record from handicap accessibility
                conn.Open()
                Dim queryHandicapAccessibility As New SqlCommand("DELETE FROM LandlordPropertyHandicapAccessibility WHERE fk_LandlordPropertyID ='" & landlordPropertyID & "'", conn)
                queryHandicapAccessibility.ExecuteNonQuery()
                conn.Close()
             
                'Delete records from property
                conn.Open()
                Dim queryProperty As New SqlCommand("DELETE FROM LandlordProperty WHERE LandlordPropertyID ='" & landlordPropertyID & "'", conn)
                queryProperty.ExecuteNonQuery()
                conn.Close()
             
                'Delete records from propertyPictures
                conn.Open()
                Dim queryPictrues As New SqlCommand("DELETE FROM LandlordPropertyPictures WHERE fk_LandlordPropertyID ='" & landlordPropertyID & "'", conn)
                queryPictrues.ExecuteNonQuery()
                conn.Close()
             
                'Redirect to current Page
                Response.Redirect(Request.UrlReferrer.ToString())
        End Select
    %>

