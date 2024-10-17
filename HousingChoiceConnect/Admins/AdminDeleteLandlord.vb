Imports System.Data.SqlClient
Imports System.Web.Configuration
Public Class AdminDeleteLandlord
    Implements IHttpHandler

    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

    ''' <summary>
    '''  You will need to configure this handler in the Web.config file of your 
    '''  web and register it with IIS before being able to use it. For more information
    '''  see the following link: https://go.microsoft.com/?linkid=8101007
    ''' </summary>
#Region "IHttpHandler Members"

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim landlordUserID As Integer = Integer.Parse(context.Request.QueryString("LandlordUserID"))

        'Get Landlord Property IDs
        Dim landlordPropertyIDs As ArrayList = GetLandlordPropertyIDs(landlordUserID)

        'For each property delete their Amenities, Handicap Accessibility, Pictures
        DeleteLandlordPropertiesAmenities(landlordPropertyIDs)
        DeleteLandlordPropertiesHandicapAccessibility(landlordPropertyIDs)
        DeleteLandlordPropertiesPictures(landlordPropertyIDs)

        'Delete each actual property
        DeleteLandlordProperties(landlordPropertyIDs)

        'Delete the users' security questions
        DeleteUserSecurityQuestions(landlordUserID)

        'Delete the user
        DeleteUserRole(landlordUserID)
        DeleteUser(landlordUserID)

        context.Response.Redirect(context.Request.UrlReferrer.ToString())
    End Sub

    Private Sub DeleteLandlordProperties(ByVal landlordPropertyIDs As ArrayList)
        Dim i As Integer
        For Each i In landlordPropertyIDs
            DeleteLandlordProperty(i)
        Next i
    End Sub

    Private Sub DeleteLandlordPropertiesAmenities(ByVal landlordPropertyIDs As ArrayList)
        Dim i As Integer
        For Each i In landlordPropertyIDs
            DeleteLandlordPropertyAmenities(i)
        Next i
    End Sub

    Private Sub DeleteLandlordPropertiesHandicapAccessibility(ByVal landlordPropertyIDs As ArrayList)
        Dim i As Integer
        For Each i In landlordPropertyIDs
            DeleteLandlordPropertyHandicapAccessibility(i)
        Next i
    End Sub

    Private Sub DeleteLandlordPropertiesPictures(ByVal landlordPropertyIDs As ArrayList)
        Dim i As Integer
        For Each i In landlordPropertyIDs
            DeleteLandlordPropertyPictures(i)
        Next i
    End Sub

    Private Sub DeleteLandlordProperty(ByVal landlordPropertyID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE 
                                     FROM [Landlord].[Property] 
                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub DeleteLandlordPropertyAmenities(ByVal landlordPropertyID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE 
                                     FROM [Landlord].[PropertyAmentity]
                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub DeleteLandlordPropertyHandicapAccessibility(ByVal landlordPropertyID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE 
                                     FROM [Landlord].[PropertyHandicapAccessibility]
                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub DeleteLandlordPropertyPictures(ByVal landlordPropertyID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE 
                                     FROM [Landlord].[PropertyPicture] 
                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub DeleteUser(ByVal userID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE 
                                     FROM [Security].[User] 
                                     WHERE UserID = '" & userID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub DeleteUserRole(ByVal userID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE 
                                     FROM [Security].[UserRole] 
                                     WHERE UserID = '" & userID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Sub DeleteUserSecurityQuestions(ByVal userID As Integer)
        conn.Open()
        Dim query As New SqlCommand("DELETE 
                                     FROM [Security].[UserQuestion]
                                     WHERE UserID = '" & userID & "'", conn)
        query.ExecuteReader()
        conn.Close()
    End Sub

    Private Function GetLandlordPropertyIDs(ByVal landlordUserID As Integer) As ArrayList
        Dim propertyIDs As New ArrayList()
        conn.Open()
        Dim query As New SqlCommand("SELECT LandlordPropertyID 
                                     FROM [Landlord].[Property]
                                     WHERE UserID = '" & landlordUserID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            propertyIDs.Add(reader("LandlordPropertyID"))
        End While
        conn.Close()

        Return propertyIDs
    End Function

    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return True
        End Get
    End Property
#End Region

End Class
