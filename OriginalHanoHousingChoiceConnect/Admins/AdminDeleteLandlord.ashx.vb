Imports System.Web
Imports System.Data.SqlClient

Public Class DeleteUser1
    Implements System.Web.IHttpHandler
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Public Sub processRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim landlordUserID As Integer = Integer.Parse(context.Request.QueryString("LandlordUserID"))

        'Get Landlord Property IDs
        Dim landlordPropertyIDs As ArrayList = getLandlordPropertyIDs(landlordUserID)

        'For each property delete their Amenities, Handicap Accessibility, Pictures
        deleteLandlordPropertiesAmenities(landlordPropertyIDs)
        deleteLandlordPropertiesHandicapAccessibility(landlordPropertyIDs)
        deleteLandlordPropertiesPictrues(landlordPropertyIDs)

        'Delete each actual property
        deleteLandlordProperties(landlordPropertyIDs)

        'Delete the users' security questions
        deleteUserSecurityQuestions(landlordUserID)

        'Delete the user
        deleteUser(landlordUserID)

        context.Response.Redirect(context.Request.UrlReferrer.ToString())
    End Sub

    Private Sub deleteLandlordProperties(ByVal landlordPropertyIDs As ArrayList)
        Dim i As Integer
        For Each i In landlordPropertyIDs
            deleteLandlordProperty(i)
        Next i
    End Sub

    Private Sub deleteLandlordPropertiesAmenities(ByVal landlordPropertyIDs As ArrayList)
        Dim i As Integer
        For Each i In landlordPropertyIDs
            deleteLandlordPropertyAmenities(i)
        Next i
    End Sub

    Private Sub deleteLandlordPropertiesHandicapAccessibility(ByVal landlordPropertyIDs As ArrayList)
        Dim i As Integer
        For Each i In landlordPropertyIDs
            deleteLandlordPropertyHandicapAccessibility(i)
        Next i
    End Sub

    Private Sub deleteLandlordPropertiesPictrues(ByVal landlordPropertyIDs As ArrayList)
        Dim i As Integer
        For Each i In landlordPropertyIDs
            deleteLandlordPropertyPictures(i)
        Next i
    End Sub

    Private Sub deleteLandlordProperty(ByVal landlordPropertyID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE FROM LandlordProperty WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub deleteLandlordPropertyAmenities(ByVal landlordPropertyID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE FROM LandlordPropertyAmentity WHERE fk_LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub deleteLandlordPropertyHandicapAccessibility(ByVal landlordPropertyID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE FROM LandlordPropertyHandicapAccessibility WHERE fk_LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub deleteLandlordPropertyPictures(ByVal landlordPropertyID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE FROM LandlordPropertyPictures WHERE fk_LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub deleteUser(ByVal userID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE FROM Users WHERE UserID = '" & userID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub deleteUserSecurityQuestions(ByVal userID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE FROM UserSecurityQuestion WHERE fk_UserID = '" & userID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Function getLandlordPropertyIDs(ByVal landlordUserID As Integer) As ArrayList
        Dim propertyIDs As New ArrayList()
        conn.Open()
        Dim query As New SqlCommand("SELECT LandlordPropertyID FROM LandlordProperty WHERE fk_UserID = '" & landlordUserID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            propertyIDs.Add(reader("LandlordPropertyID"))
        End While
        conn.Close()
        Return propertyIDs
    End Function

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
End Class