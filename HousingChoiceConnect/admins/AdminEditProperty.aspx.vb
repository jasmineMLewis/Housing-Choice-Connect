Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Configuration

Public Class AdminEditPropertyaspx
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Sub BtnEditProperty(ByVal sender As Object, ByVal e As EventArgs)
        Dim landlordPropertyID As String = GetLandlordPropertyID()
        UpdatePropertyInfo(landlordPropertyID)

        Dim isHandicapAccessible As Boolean = UpdateHandicapAccessibilites(landlordPropertyID)
        Dim isAmentitiesIncluded As Boolean = UpdateAmentities(landlordPropertyID)

        UpdatePropertyAmentityHandicap(landlordPropertyID, isAmentitiesIncluded, isHandicapAccessible)
        UploadMultiplePictures(landlordPropertyID)

        Response.Redirect("AdminViewProperty.aspx?LandlordPropertyID=" & landlordPropertyID)
    End Sub

    Public Function GetSessionUserID() As String
        Dim userID As String = Session("UserID")
        If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
            userID = Web.HttpContext.Current.Session("UserID").ToString()
        End If

        If userID = Nothing Then
            userID = Request.QueryString("UserID")
            Web.HttpContext.Current.Session("UserID") = userID
        End If
        Return userID
    End Function

    Public Function GetLandlordPropertyID() As String
        Dim landlordPropertyID As String
        If landlordPropertyID = Nothing Then
            landlordPropertyID = Request.QueryString("LandlordPropertyID")
        End If
        Return landlordPropertyID
    End Function

    Public Sub PopulateDropdwonList(ByVal landlordPropertyID As Integer)
        Dim neighborhoodID As Integer
        Dim bedroomNumber As Integer
        Dim bathroomNumber As Double
        Dim propertyTypeID As Integer
        Dim unitTypeID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT NeighborhoodID, BedroomNumber, BathroomNumber, 
                                            PropertyID, UnitID 
                                    FROM LandlordProperty 
                                    WHERE LandlordPropertyID='" & landlordPropertyID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            neighborhoodID = CStr(reader("NeighborhoodID"))
            bedroomNumber = CStr(reader("BedroomNumber"))
            bathroomNumber = CStr(reader("BathroomNumber"))
            propertyTypeID = CStr(reader("PropertyID"))
            unitTypeID = CStr(reader("UnitID"))
        End While
        conn.Close()

        If neighborhoodID <> 0 Then
            Neighborhood.DataBind()
            Neighborhood.Items.Insert(0, New ListItem("Neighborhood *", "0"))
            Neighborhood.Items.FindByValue(neighborhoodID).Selected = True
        Else
            Neighborhood.AppendDataBoundItems = True
            Neighborhood.Items.Insert(0, New ListItem("Neighborhood *", "0"))
        End If

        If bedroomNumber <> -1 Then
            Bedroom.DataBind()
            Bedroom.Items.FindByValue(bedroomNumber).Selected = True
        Else
            Bedroom.DataBind()
            Bedroom.Items.FindByValue(-1).Selected = True
        End If

        If bathroomNumber <> 0 Then
            Bathroom.DataBind()
            Bathroom.Items.FindByValue(bathroomNumber).Selected = True
        Else
            Bathroom.DataBind()
            Bathroom.Items.FindByValue(0).Selected = True
        End If

        If propertyTypeID <> 0 Then
            PropertyType.DataBind()
            PropertyType.Items.Insert(0, New ListItem("Property *", "0"))
            PropertyType.Items.FindByValue(propertyTypeID).Selected = True
        Else
            PropertyType.AppendDataBoundItems = True
            PropertyType.Items.Insert(0, New ListItem("Property *", "0"))
        End If

        If unitTypeID <> 0 Then
            UnitType.DataBind()
            UnitType.Items.Insert(0, New ListItem("Unit *", "0"))
            UnitType.Items.FindByValue(unitTypeID).Selected = True
        Else
            UnitType.AppendDataBoundItems = True
            UnitType.Items.Insert(0, New ListItem("Unit *", "0"))
        End If
    End Sub

    Public Function UpdateAmentities(ByVal landlordPropertyID As Integer) As Boolean
        conn.Open()
        Dim queryDelete As New SqlCommand("DELETE FROM LandlordPropertyAmentity 
                                           WHERE LandlordPropertyID ='" & landlordPropertyID & "'", conn)
        queryDelete.ExecuteNonQuery()
        conn.Close()

        Dim hasAmentities As Boolean = 0
        Dim query As String = String.Empty
        query &= "INSERT INTO LandlordPropertyAmentity (LandlordPropertyID, AmentityID)"
        query &= "VALUES (@LandlordPropertyID, @AmentityID)"

        If Not Request.Form("amentityCentralAirHeat") Is Nothing Or Not Request.Form("amentityCentralAirHeat") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityCentralAirHeat"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityWasher") Is Nothing Or Not Request.Form("amentityWasher") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityWasher"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityDryer") Is Nothing Or Not Request.Form("amentityDryer") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityDryer"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityAlarm") Is Nothing Or Not Request.Form("amentityAlarm") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityAlarm"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityWasherDryerHookups") Is Nothing Or Not Request.Form("amentityWasherDryerHookups") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityWasherDryerHookups"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityCeilingFans") Is Nothing Or Not Request.Form("amentityCeilingFans") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityCeilingFans"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityDishwasher") Is Nothing Or Not Request.Form("amentityDishwasher") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityDishwasher"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityRefrigerator") Is Nothing Or Not Request.Form("amentityRefrigerator") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityRefrigerator"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityGarbageDisposal") Is Nothing Or Not Request.Form("amentityGarbageDisposal") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityGarbageDisposal"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityStove") Is Nothing Or Not Request.Form("amentityStove") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityStove"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityOffStreetParking") Is Nothing Or Not Request.Form("amentityOffStreetParking") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityOffStreetParking"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityCoveredParking") Is Nothing Or Not Request.Form("amentityCoveredParking") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityCoveredParking"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityFrontYard") Is Nothing Or Not Request.Form("amentityFrontYard") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityFrontYard"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityBackYard") Is Nothing Or Not Request.Form("amentityBackYard") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityBackYard"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityGated") Is Nothing Or Not Request.Form("amentityGated") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityGated"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        If Not Request.Form("amentityOnsiteSecurity") Is Nothing Or Not Request.Form("amentityOnsiteSecurity") = "" Then
            hasAmentities = 1
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                    .Parameters.AddWithValue("@AmentityID", Request.Form("amentityOnsiteSecurity"))
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

        Return hasAmentities
    End Function

    Public Function UpdateHandicapAccessibilites(ByVal landlordPropertyID As Integer) As Boolean
        Dim isHandicapAccessible As Boolean = 0
        Dim handicapParkingClose As Boolean
        Dim rampedEntry As Boolean
        Dim doorways32InchesOrWider As Boolean
        Dim accessiblePathIn32InchesOrWider As Boolean
        Dim automaticEntryDoor As Boolean
        Dim lowCounterOrSinkBelow34Inches As Boolean
        Dim accessibleAppliances As Boolean
        Dim showerOrTubGrabBars As Boolean
        Dim rollInShowers As Boolean
        Dim handHeldShowerSprayer As Boolean
        Dim fixedSeatInShowerOrTub As Boolean
        Dim raisedTiolet As Boolean
        Dim firstFloorBathroom As Boolean
        Dim liftOrElevator As Boolean
        Dim audioOrVisualDoorbell As Boolean
        Dim audioOrVisualSmokeOrFireAlarm As Boolean
        Dim firstFloorBedroom As Boolean
        Dim elevatorAccess As Boolean

        If Request.Form("handicapParkingClose") = "Yes" Then
            handicapParkingClose = 1
            isHandicapAccessible = 1
        Else
            handicapParkingClose = 0
        End If

        If Request.Form("rampedEntry") = "Yes" Then
            rampedEntry = 1
            isHandicapAccessible = 1
        Else
            rampedEntry = 0
        End If

        If Request.Form("doorways32InchesOrWider") = "Yes" Then
            doorways32InchesOrWider = 1
            isHandicapAccessible = 1
        Else
            doorways32InchesOrWider = 0
        End If

        If Request.Form("accessiblePathIn32InchesOrWider") = "Yes" Then
            accessiblePathIn32InchesOrWider = 1
            isHandicapAccessible = 1
        Else
            accessiblePathIn32InchesOrWider = 0
        End If

        If Request.Form("automaticEntryDoor") = "Yes" Then
            automaticEntryDoor = 1
            isHandicapAccessible = 1
        Else
            automaticEntryDoor = 0
        End If

        If Request.Form("lowCounterOrSinkBelow34Inches") = "Yes" Then
            lowCounterOrSinkBelow34Inches = 1
            isHandicapAccessible = 1
        Else
            lowCounterOrSinkBelow34Inches = 0
        End If

        If Request.Form("accessibleAppliances") = "Yes" Then
            accessibleAppliances = 1
            isHandicapAccessible = 1
        Else
            accessibleAppliances = 0
        End If

        If Request.Form("showerOrTubGrabBars") = "Yes" Then
            showerOrTubGrabBars = 1
            isHandicapAccessible = 1
        Else
            showerOrTubGrabBars = 0
        End If

        If Request.Form("rollInShowers") = "Yes" Then
            rollInShowers = 1
            isHandicapAccessible = 1
        Else
            rollInShowers = 0
        End If

        If Request.Form("handHeldShowerSprayer") = "Yes" Then
            handHeldShowerSprayer = 1
            isHandicapAccessible = 1
        Else
            handHeldShowerSprayer = 0
        End If

        If Request.Form("fixedSeatInShowerOrTub") = "Yes" Then
            fixedSeatInShowerOrTub = 1
            isHandicapAccessible = 1
        Else
            fixedSeatInShowerOrTub = 0
        End If

        If Request.Form("raisedTiolet") = "Yes" Then
            raisedTiolet = 1
            isHandicapAccessible = 1
        Else
            raisedTiolet = 0
        End If

        If Request.Form("firstFloorBathroom") = "Yes" Then
            firstFloorBathroom = 1
            isHandicapAccessible = 1
        Else
            firstFloorBathroom = 0
        End If

        If Request.Form("liftOrElevator") = "Yes" Then
            liftOrElevator = 1
            isHandicapAccessible = 1
        Else
            liftOrElevator = 0
        End If

        If Request.Form("audioOrVisualDoorbell") = "Yes" Then
            audioOrVisualDoorbell = 1
            isHandicapAccessible = 1
        Else
            audioOrVisualDoorbell = 0
        End If

        If Request.Form("audioOrVisualSmokeOrFireAlarm") = "Yes" Then
            audioOrVisualSmokeOrFireAlarm = 1
            isHandicapAccessible = 1
        Else
            audioOrVisualSmokeOrFireAlarm = 0
        End If

        If Request.Form("firstFloorBedroom") = "Yes" Then
            firstFloorBedroom = 1
            isHandicapAccessible = 1
        Else
            firstFloorBedroom = 0
        End If

        If Request.Form("elevatorAccess") = "Yes" Then
            elevatorAccess = 1
            isHandicapAccessible = 1
        Else
            elevatorAccess = 0
        End If

        Dim query As String = String.Empty
        query &= "UPDATE LandlordPropertyHandicapAccessibility SET IsAccessibleParkingCloseToHome = '" & handicapParkingClose & "', IsRampedEntry = '" & rampedEntry & "', IsDoorways32InchesWider = '" & doorways32InchesOrWider & "',"
        query &= " IsAccessiblePathToAndInHome32Inches_Wider = '" & accessiblePathIn32InchesOrWider & "', IsAutomaticEntryDoor = '" & automaticEntryDoor & "', IsLowCounterSinkAtBelow34Inches = '" & lowCounterOrSinkBelow34Inches & "', "
        query &= " IsAccessibleAppliances = '" & accessibleAppliances & "', IsShowerTubGrabBars = '" & showerOrTubGrabBars & "', IsRollInShower = '" & rollInShowers & "', IsHandHeldShowerSprayer = '" & handHeldShowerSprayer & "',  "
        query &= " IsFixedSeatInShowerTub = '" & fixedSeatInShowerOrTub & "', IsRaisedToilet = '" & raisedTiolet & "', IsFirstFloorBedroom = '" & firstFloorBedroom & "', IsFirstFloorBathroom = '" & firstFloorBathroom & "',  "
        query &= " IsLiftElevator = '" & liftOrElevator & "', IsAudioVisualDoorbell = '" & audioOrVisualDoorbell & "', IsAudioVisualSmokeFireAlarm = '" & audioOrVisualSmokeOrFireAlarm & "', IsElevatorAccess = '" & elevatorAccess & "' "
        query &= " WHERE LandlordPropertyID = '" & landlordPropertyID & "'"

        conn.Open()
        Dim queryUpdate As New SqlCommand(query, conn)
        queryUpdate.ExecuteNonQuery()
        conn.Close()
        Return isHandicapAccessible
    End Function

    Public Sub UpdatePropertyInfo(ByVal landlordPropertyID As Integer)
        Dim address As String
        Dim aptOrSuite As String
        Dim neighborhoodID As Integer = Neighborhood.SelectedValue
        Dim rent As String
        Dim deposit As String
        Dim bedroomID As Integer = Bedroom.SelectedValue
        Dim bathroomID As Double = Bathroom.SelectedValue
        Dim propertyTypeID As Integer = PropertyType.SelectedValue
        Dim unitTypeID As Integer = UnitType.SelectedValue
        Dim dateAvailableToRent As String
        Dim readyForOccupancy As Boolean
        Dim isPetsPermitted As Boolean
        Dim petDeposit As Integer
        Dim description As String
        Dim utilityElectric As Boolean
        Dim utilityWater As Boolean
        Dim utilityGas As Boolean
        Dim contactName As String
        Dim contactNumber As String
        Dim dateLastUpdated As Date = Date.Today

        If Request.Form("address") Is Nothing Then
            address = ""
        Else
            address = Request.Form("address")
        End If

        If Request.Form("aptOrSuite") Is Nothing Then
            aptOrSuite = ""
        Else
            aptOrSuite = Request.Form("aptOrSuite")
        End If

        If Request.Form("rent") Is Nothing Then
            rent = 0
        Else
            rent = Request.Form("rent")
        End If

        If Request.Form("deposit") Is Nothing Then
            deposit = 0
        Else
            deposit = Request.Form("deposit")
        End If

        If Request.Form("petsPermitted") = "Yes" Then
            isPetsPermitted = 1
            If Request.Form("petDeposit") = Nothing Or Request.Form("petDeposit") = "" Then
                petDeposit = 0
            Else
                petDeposit = Request.Form("petDeposit")
            End If
        ElseIf Request.Form("petsPermitted") = "No" Then
            isPetsPermitted = 0
            petDeposit = 0
        Else
            isPetsPermitted = 0
            petDeposit = 0
        End If

        If Request.Form("readyForOccupancy") = "Yes" Then
            readyForOccupancy = 1
        Else
            readyForOccupancy = 0
        End If

        If Request.Form("dateAvailableToRent") Is Nothing Then
            dateAvailableToRent = Date.Today
        Else
            dateAvailableToRent = Request.Form("dateAvailableToRent")
        End If

        If Request.Form("description") Is Nothing Then
            description = ""
        Else
            description = Request.Form("description")
        End If

        If Request.Form("utilityElectric") = "Yes" Then
            utilityElectric = 1
        Else
            utilityElectric = 0
        End If

        If Request.Form("utilityWater") = "Yes" Then
            utilityWater = 1
        Else
            utilityWater = 0
        End If

        If Request.Form("utilityGas") = "Yes" Then
            utilityGas = 1
        Else
            utilityGas = 0
        End If

        If Request.Form("contactName") Is Nothing Then
            contactName = ""
        Else
            contactName = Request.Form("contactName")
        End If

        If Request.Form("contactNumber") Is Nothing Then
            contactNumber = ""
        Else
            contactNumber = Request.Form("contactNumber")
        End If

        Dim query As String = String.Empty
        query &= "UPDATE LandlordProperty SET AddressProperty = '" & address & "', Apt_Suite = '" & aptOrSuite & "', Description = '" & description & "',"
        query &= "Rent = '" & rent & "', Deposit = '" & deposit & "', PetDeposit = '" & petDeposit & "', PersonOfContact = '" & contactName & "',"
        query &= "PersonToContactPhoneNumber ='" & contactNumber & "', IsUtilityElectricPaidByLandlord= '" & utilityElectric & "', IsUtilityWaterPaidByLandlord = '" & utilityWater & "', IsUtilityGasPaidByLandlord = '" & utilityGas & "', "
        query &= "IsPropertyReadyForOccupancy = '" & readyForOccupancy & "', IsPetsPermitted =  '" & isPetsPermitted & "',  "
        query &= "DateAvaiableToRent = '" & dateAvailableToRent & "', DateLastUpdated = '" & dateLastUpdated & "', fk_NeighborhoodID = '" & neighborhoodID & "', BedroomNumber = '" & bedroomID & "',"
        query &= "BathroomNumber = '" & bathroomID & "', fk_PropertyTypeID = '" & propertyTypeID & "', fk_UnitTypeID =  '" & unitTypeID & "' "
        query &= " WHERE LandlordPropertyID = '" & landlordPropertyID & "'"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
            End With

            conn.Open()
            comm.ExecuteNonQuery()
            conn.Close()
        End Using
    End Sub

    Public Sub UpdatePropertyAmentityHandicap(ByVal landlordPropertyID As Integer, ByVal isAmentitiesIncluded As Boolean, ByVal isHandicapAccessible As Boolean)
        conn.Open()
        Dim query As New SqlCommand("UPDATE LandlordProperty 
                                     SET IsAmentitiesIncluded = '" & isAmentitiesIncluded & "', 
                                         IsHandicapAccessible = '" & isHandicapAccessible & "' 
                                     WHERE LandlordPropertyID ='" & landlordPropertyID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub

    Public Sub UploadMultiplePictures(ByVal landlordPropertyID As Integer)
        Const MAX_PICTURES As Integer = 6

        For value As Integer = 1 To MAX_PICTURES
            If value = 1 Then
                If picture1.HasFile Then
                    UploadSinglePicture(picture1, value, landlordPropertyID)
                End If
            ElseIf value = 2 Then
                If picture2.HasFile Then
                    UploadSinglePicture(picture2, value, landlordPropertyID)
                End If
            ElseIf value = 3 Then
                If picture3.HasFile Then
                    UploadSinglePicture(picture3, value, landlordPropertyID)
                End If
            ElseIf value = 4 Then
                If picture4.HasFile Then
                    UploadSinglePicture(picture4, value, landlordPropertyID)
                End If
            ElseIf value = 5 Then
                If picture5.HasFile Then
                    UploadSinglePicture(picture5, value, landlordPropertyID)
                End If
            ElseIf value = 6 Then
                If picture6.HasFile Then
                    UploadSinglePicture(picture6, value, landlordPropertyID)
                End If
            End If
        Next
    End Sub

    Public Sub UploadSinglePicture(ByVal upload As FileUpload, ByVal value As Integer, ByVal landlordPropertyID As Integer)
        If upload.HasFile Then
            Dim pictureID As Integer
            Dim count As Integer = 0

            If value = 1 Then
                conn.Open()
                Dim queryPicture1 As New SqlCommand("SELECT TOP 1 LandlordPropertyPictureID 
                                                     FROM LandlordPropertyPictures 
                                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
                Dim readerPicture1 As SqlDataReader = queryPicture1.ExecuteReader()
                If readerPicture1.HasRows Then
                    While readerPicture1.Read
                        pictureID = CStr(readerPicture1("LandlordPropertyPictureID"))
                    End While
                End If
                conn.Close()

                conn.Open()
                Dim queryCount As New SqlCommand("SELECT COUNT(*) AS PictureCount 
                                                  FROM LandlordPropertyPictures 
                                                  WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
                Dim readerCount As SqlDataReader = queryCount.ExecuteReader()
                If readerCount.HasRows Then
                    While readerCount.Read
                        count = CStr(readerCount("PictureCount"))
                    End While
                End If
                conn.Close()

                If picture1.HasFile Then
                    If count < 2 Then
                        conn.Open()
                        Dim queryUpdate As New SqlCommand("DELETE FROM LandlordPropertyPictures 
                                                           WHERE LandlordPropertyPictureID = '" & pictureID & "'", conn)
                        queryUpdate.ExecuteNonQuery()
                        conn.Close()
                    End If

                End If
            ElseIf value = 2 Then
                conn.Open()
                Dim queryPicture2 As New SqlCommand("SELECT TOP 2 LandlordPropertyPictureID 
                                                     FROM LandlordPropertyPictures 
                                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "' 
                                                     ORDER BY ROW_NUMBER() OVER(ORDER BY LandlordPropertyPictureID) ASC ", conn)
                Dim readerPicture2 As SqlDataReader = queryPicture2.ExecuteReader()
                If readerPicture2.HasRows Then
                    While readerPicture2.Read
                        pictureID = CStr(readerPicture2("LandlordPropertyPictureID"))
                    End While
                End If
                conn.Close()

                conn.Open()
                Dim queryCount As New SqlCommand("SELECT COUNT(*) AS PictureCount 
                                                  FROM LandlordPropertyPictures 
                                                  WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
                Dim readerCount As SqlDataReader = queryCount.ExecuteReader()
                If readerCount.HasRows Then
                    While readerCount.Read
                        count = CStr(readerCount("PictureCount"))
                    End While
                End If
                conn.Close()

                If picture2.HasFile Then
                    If count = 2 Then
                        conn.Open()
                        Dim queryUpdate As New SqlCommand("DELETE FROM LandlordPropertyPictures WHERE LandlordPropertyPictureID = '" & pictureID & "'", conn)
                        queryUpdate.ExecuteNonQuery()
                        conn.Close()
                    End If
                End If
            ElseIf value = 3 Then
                conn.Open()
                Dim queryPicture3 As New SqlCommand("SELECT TOP 3 LandlordPropertyPictureID 
                                                     FROM LandlordPropertyPictures 
                                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "' 
                                                     ORDER BY ROW_NUMBER() OVER(ORDER BY LandlordPropertyPictureID) ASC ", conn)
                Dim readerPicture3 As SqlDataReader = queryPicture3.ExecuteReader()
                If readerPicture3.HasRows Then
                    While readerPicture3.Read
                        pictureID = CStr(readerPicture3("LandlordPropertyPictureID"))
                    End While
                End If
                conn.Close()

                conn.Open()
                Dim queryCount As New SqlCommand("SELECT COUNT(*) AS PictureCount 
                                                  FROM LandlordPropertyPictures 
                                                  WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
                Dim readerCount As SqlDataReader = queryCount.ExecuteReader()
                If readerCount.HasRows Then
                    While readerCount.Read
                        count = CStr(readerCount("PictureCount"))
                    End While
                End If
                conn.Close()

                If picture3.HasFile Then
                    If count = 3 Then
                        conn.Open()
                        Dim queryUpdate As New SqlCommand("DELETE FROM LandlordPropertyPictures 
                                                           WHERE LandlordPropertyPictureID = '" & pictureID & "'", conn)
                        queryUpdate.ExecuteNonQuery()
                        conn.Close()
                    End If
                End If
            ElseIf value = 4 Then
                conn.Open()
                Dim queryPicture4 As New SqlCommand("SELECT TOP 4 LandlordPropertyPictureID 
                                                     FROM LandlordPropertyPictures 
                                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "' 
                                                     ORDER BY ROW_NUMBER() OVER(ORDER BY LandlordPropertyPictureID) ASC ", conn)
                Dim readerPicture4 As SqlDataReader = queryPicture4.ExecuteReader()
                If readerPicture4.HasRows Then
                    While readerPicture4.Read
                        pictureID = CStr(readerPicture4("LandlordPropertyPictureID"))
                    End While
                End If
                conn.Close()

                conn.Open()
                Dim queryCount As New SqlCommand("SELECT COUNT(*) AS PictureCount 
                                                  FROM LandlordPropertyPictures 
                                                  WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
                Dim readerCount As SqlDataReader = queryCount.ExecuteReader()
                If readerCount.HasRows Then
                    While readerCount.Read
                        count = CStr(readerCount("PictureCount"))
                    End While
                End If
                conn.Close()

                If picture4.HasFile Then
                    If count = 4 Then
                        conn.Open()
                        Dim queryUpdate As New SqlCommand("DELETE FROM LandlordPropertyPictures 
                                                           WHERE LandlordPropertyPictureID = '" & pictureID & "'", conn)
                        queryUpdate.ExecuteNonQuery()
                        conn.Close()
                    End If
                End If
            ElseIf value = 5 Then
                conn.Open()
                Dim queryPicture5 As New SqlCommand("SELECT TOP 5 LandlordPropertyPictureID 
                                                     FROM LandlordPropertyPictures 
                                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "' 
                                                     ORDER BY ROW_NUMBER() OVER(ORDER BY LandlordPropertyPictureID) ASC ", conn)
                Dim readerPicture5 As SqlDataReader = queryPicture5.ExecuteReader()
                If readerPicture5.HasRows Then
                    While readerPicture5.Read
                        pictureID = CStr(readerPicture5("LandlordPropertyPictureID"))
                    End While
                End If
                conn.Close()

                conn.Open()
                Dim queryCount As New SqlCommand("SELECT COUNT(*) AS PictureCount 
                                                  FROM LandlordPropertyPictures 
                                                  WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
                Dim readerCount As SqlDataReader = queryCount.ExecuteReader()
                If readerCount.HasRows Then
                    While readerCount.Read
                        count = CStr(readerCount("PictureCount"))
                    End While
                End If
                conn.Close()

                If picture5.HasFile Then
                    If count = 5 Then
                        conn.Open()
                        Dim queryUpdate As New SqlCommand("DELETE FROM LandlordPropertyPictures 
                                                           WHERE LandlordPropertyPictureID = '" & pictureID & "'", conn)
                        queryUpdate.ExecuteNonQuery()
                        conn.Close()
                    End If
                End If
            ElseIf value = 6 Then
                conn.Open()
                Dim queryPicture6 As New SqlCommand("SELECT TOP 6 LandlordPropertyPictureID 
                                                     FROM LandlordPropertyPictures 
                                                     WHERE LandlordPropertyID = '" & landlordPropertyID & "' 
                                                     ORDER BY ROW_NUMBER() OVER(ORDER BY LandlordPropertyPictureID) ASC ", conn)
                Dim readerPicture6 As SqlDataReader = queryPicture6.ExecuteReader()
                If readerPicture6.HasRows Then
                    While readerPicture6.Read
                        pictureID = CStr(readerPicture6("LandlordPropertyPictureID"))
                    End While
                End If
                conn.Close()

                conn.Open()
                Dim queryCount As New SqlCommand("SELECT COUNT(*) AS PictureCount 
                                                  FROM LandlordPropertyPictures 
                                                  WHERE LandlordPropertyID = '" & landlordPropertyID & "'", conn)
                Dim readerCount As SqlDataReader = queryCount.ExecuteReader()
                If readerCount.HasRows Then
                    While readerCount.Read
                        count = CStr(readerCount("PictureCount"))
                    End While
                End If
                conn.Close()

                If picture6.HasFile Then
                    If count = 6 Then
                        conn.Open()
                        Dim queryUpdate As New SqlCommand("DELETE FROM LandlordPropertyPictures 
                                                           WHERE LandlordPropertyPictureID = '" & pictureID & "'", conn)
                        queryUpdate.ExecuteNonQuery()
                        conn.Close()
                    End If
                End If
            End If

            'Make sure we are dealing with a JPG or PNG  file
            Dim extension As String = Path.GetExtension(upload.PostedFile.FileName).ToLower()
            Dim MIMEType As String = Nothing

            Select Case extension
                Case ".jpg", ".jpeg", ".jpe"
                    MIMEType = "image/jpeg"
                Case ".png"
                    MIMEType = "image/png"
                Case Else
                    Exit Sub
            End Select

            Dim query As String = "INSERT INTO LandlordPropertyPictures (MIMEType, ImageData, LandlordPropertyID) 
                                   VALUES                               (@MIMEType, @ImageData, @LandlordPropertyID)"
            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@MIMEType", MIMEType)

                    'Load FileUpload's InputStream into Byte array
                    Dim imageBytes(upload.PostedFile.InputStream.Length) As Byte
                    upload.PostedFile.InputStream.Read(imageBytes, 0, imageBytes.Length)
                    .Parameters.AddWithValue("@ImageData", imageBytes)
                    .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
                End With

                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
            End Using
        End If
    End Sub
End Class