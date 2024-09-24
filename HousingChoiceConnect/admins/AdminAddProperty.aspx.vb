Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Configuration

Public Class AdminAddProperty
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SetDropdownList()
        End If
    End Sub

    Public Function AddProperty(ByVal landlordUserID As Integer) As Integer
        Const CITY As String = "New Orleans"
        Const PROPERTY_ACTIVE As Boolean = 1

        Dim landlordPropertyID As Integer
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
        Dim isPetsPermitted As Boolean
        Dim petDeposit As Integer
        Dim readyForOccupancy As Boolean
        Dim description As String
        Dim utilityElectric As Boolean
        Dim utilityWater As Boolean
        Dim utilityGas As Boolean
        Dim contactName As String
        Dim contactNumber As String
        Dim dateOfPostage As Date = Date.Today

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

        If Request.Form("readyForOccupancy") Is Nothing Then
            readyForOccupancy = 0
        Else
            If Request.Form("readyForOccupancy") = "Yes" Then
                readyForOccupancy = 1
            Else
                readyForOccupancy = 0
            End If
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
        query &= "INSERT INTO LandlordProperty (AddressProperty, AptSuite, City, Description, Rent, Deposit, PetDeposit, PersonOfContact, PersonToContactPhoneNumber, NumberOfTenantViews, IsUtilityElectricPaidByLandlord, IsUtilityWaterPaidByLandlord, IsUtilityGasPaidByLandlord, IsAmentitiesIncluded, IsHandicapAccessible, IsPropertyReadyForOccupancy, IsPetsPermitted, IsPicturesExists, IsActive, DateAvaiableToRent, DateLastUpdated, DateOfInactivation, DateOfPostage, UserID, NeighborhoodID, BedroomNumber, BathroomNumber, PropertyID, UnitID)"
        query &= "VALUES (@AddressProperty, @AptSuite, @City, @Description, @Rent, @Deposit, @PetDeposit, @PersonOfContact, @PersonToContactPhoneNumber, @NumberOfTenantViews, @IsUtilityElectricPaidByLandlord, @IsUtilityWaterPaidByLandlord, @IsUtilityGasPaidByLandlord, @IsAmentitiesIncluded, @IsHandicapAccessible, @IsPropertyReadyForOccupancy, @IsPetsPermitted, @IsPicturesExists, @IsActive, @DateAvaiableToRent, @DateLastUpdated, @DateOfInactivation, @DateOfPostage, @UserID, @NeighborhoodID, @BedroomNumber, @BathroomNumber, @PropertyID, @UnitID);"
        query &= "SELECT @@IDENTITY from LandlordProperty"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
                .Parameters.AddWithValue("@AddressProperty", address)
                .Parameters.AddWithValue("@AptSuite", aptOrSuite)
                .Parameters.AddWithValue("@City", ApplicationConstants.Constants.City)
                .Parameters.AddWithValue("@Description", description)
                .Parameters.AddWithValue("@Rent", rent)
                .Parameters.AddWithValue("@Deposit", deposit)
                .Parameters.AddWithValue("@PetDeposit", petDeposit)
                .Parameters.AddWithValue("@PersonOfContact", contactName)
                .Parameters.AddWithValue("@PersonToContactPhoneNumber", contactNumber)
                .Parameters.AddWithValue("@NumberOfTenantViews", 0)
                .Parameters.AddWithValue("@IsUtilityElectricPaidByLandlord", utilityElectric)
                .Parameters.AddWithValue("@IsUtilityWaterPaidByLandlord", utilityWater)
                .Parameters.AddWithValue("@IsUtilityGasPaidByLandlord", utilityGas)
                .Parameters.AddWithValue("@IsAmentitiesIncluded", 0)
                .Parameters.AddWithValue("@IsHandicapAccessible", 0)
                .Parameters.AddWithValue("@IsPropertyReadyForOccupancy", readyForOccupancy)
                .Parameters.AddWithValue("@IsPetsPermitted", isPetsPermitted)
                .Parameters.AddWithValue("@IsPicturesExists", 0)
                .Parameters.AddWithValue("@IsActive", ApplicationConstants.Constants.PropertyActive)
                .Parameters.AddWithValue("@DateAvaiableToRent", dateAvailableToRent)
                .Parameters.AddWithValue("@DateLastUpdated", dateOfPostage)
                .Parameters.AddWithValue("@DateOfInactivation", DBNull.Value)
                .Parameters.AddWithValue("@DateOfPostage", dateOfPostage)
                .Parameters.AddWithValue("@UserID", landlordUserID)
                .Parameters.AddWithValue("@NeighborhoodID", neighborhoodID)
                .Parameters.AddWithValue("@BedroomNumber", bedroomID)
                .Parameters.AddWithValue("@BathroomNumber", bathroomID)
                .Parameters.AddWithValue("@PropertyID", propertyTypeID)
                .Parameters.AddWithValue("@UnitID", unitTypeID)
            End With

            conn.Open()
            landlordPropertyID = comm.ExecuteScalar()
            conn.Close()
        End Using
        Return landlordPropertyID
    End Function

    Protected Sub BtnAddProperty(ByVal sender As Object, ByVal e As EventArgs)
        Dim userID As String = GetSessionUserID()
        Dim landlordUserID As Integer = FullDescrp.SelectedValue.Trim
        Dim landlordPropertyID As Integer = AddProperty(landlordUserID)
        Dim hasAmentities As Boolean = InsertAmentities(landlordPropertyID)
        Dim isHandicapAccessible As Boolean = InsertHandicapAccessibilites(landlordPropertyID)

        UpdatePropertyAmentityHandicap(landlordPropertyID, hasAmentities, isHandicapAccessible)
        UploadMultiplePictures(landlordPropertyID)
        Response.Redirect("AdminViewProperty.aspx?LandlordPropertyID=" & landlordPropertyID & "&UserID=" & userID)
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

    Public Function InsertAmentities(ByVal landlordPropertyID As Integer) As Boolean
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
                    .Parameters.AddWithValue("@fkAmentityID", Request.Form("amentityCentralAirHeat"))
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

    Public Function InsertHandicapAccessibilites(ByVal landlordPropertyID As Integer) As Boolean
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
        query &= "INSERT INTO LandlordPropertyHandicapAccessibility (IsAccessibleParkingCloseToHome, IsRampedEntry, IsDoorways32Inches_Wider, IsAccessiblePathToAndInHome32Inches_Wider, IsAutomaticEntryDoor, IsLowCounter_SinkAt_Below34Inches, IsAccessibleAppliances, IsShower_TubGrabBars, IsRollInShower, IsHandHeldShowerSprayer, IsFixedSeatInShower_Tub, IsRaisedToilet, IsFirstFloorBedroom, IsFirstFloorBathroom, IsLift_Elevator, IsAudio_VisualDoorbell, IsAudio_VisualSmoke_FireAlarm, IsElevatorAccess, LandlordPropertyID)"
        query &= "VALUES (@IsAccessibleParkingCloseToHome, @IsRampedEntry, @IsDoorways32Inches_Wider, @IsAccessiblePathToAndInHome32Inches_Wider, @IsAutomaticEntryDoor, @IsLowCounter_SinkAt_Below34Inches, @IsAccessibleAppliances, @IsShower_TubGrabBars, @IsRollInShower, @IsHandHeldShowerSprayer, @IsFixedSeatInShower_Tub, @IsRaisedToilet, @IsFirstFloorBedroom, @IsFirstFloorBathroom, @IsLift_Elevator, @IsAudio_VisualDoorbell, @IsAudio_VisualSmoke_FireAlarm, @IsElevatorAccess, @LandlordPropertyID)"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
                .Parameters.AddWithValue("@IsAccessibleParkingCloseToHome", handicapParkingClose)
                .Parameters.AddWithValue("@IsRampedEntry", rampedEntry)
                .Parameters.AddWithValue("@IsDoorways32Inches_Wider", doorways32InchesOrWider)
                .Parameters.AddWithValue("@IsAccessiblePathToAndInHome32Inches_Wider", accessiblePathIn32InchesOrWider)
                .Parameters.AddWithValue("@IsAutomaticEntryDoor", automaticEntryDoor)
                .Parameters.AddWithValue("@IsLowCounter_SinkAt_Below34Inches", lowCounterOrSinkBelow34Inches)
                .Parameters.AddWithValue("@IsAccessibleAppliances", accessibleAppliances)
                .Parameters.AddWithValue("@IsShower_TubGrabBars", showerOrTubGrabBars)
                .Parameters.AddWithValue("@IsRollInShower", rollInShowers)
                .Parameters.AddWithValue("@IsHandHeldShowerSprayer", handHeldShowerSprayer)
                .Parameters.AddWithValue("@IsFixedSeatInShower_Tub", fixedSeatInShowerOrTub)
                .Parameters.AddWithValue("@IsRaisedToilet", raisedTiolet)
                .Parameters.AddWithValue("@IsFirstFloorBedroom", firstFloorBedroom)
                .Parameters.AddWithValue("@IsFirstFloorBathroom", firstFloorBathroom)
                .Parameters.AddWithValue("@IsLift_Elevator", liftOrElevator)
                .Parameters.AddWithValue("@IsAudio_VisualDoorbell", audioOrVisualDoorbell)
                .Parameters.AddWithValue("@IsAudio_VisualSmoke_FireAlarm", audioOrVisualSmokeOrFireAlarm)
                .Parameters.AddWithValue("@IsElevatorAccess", elevatorAccess)
                .Parameters.AddWithValue("@LandlordPropertyID", landlordPropertyID)
            End With

            conn.Open()
            comm.ExecuteNonQuery()
            conn.Close()
        End Using

        Return isHandicapAccessible
    End Function

    Public Sub UpdatePropertyAmentityHandicap(ByVal landlordPropertyID As Integer, ByVal isAmentitiesIncluded As Boolean, ByVal isHandicapAccessible As Boolean)
        conn.Open()
        Dim query As New SqlCommand("UPDATE LandlordProperty 
                                     SET IsAmentitiesIncluded = '" & isAmentitiesIncluded & "', 
                                         IsHandicapAccessible = '" & isHandicapAccessible & "' 
                                     WHERE LandlordPropertyID ='" & landlordPropertyID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub

    Protected Sub UploadMultiplePictures(ByVal landlordPropertyID As Integer)
        Const MAX_PICTURES As Integer = 6

        For value As Integer = 1 To MAX_PICTURES
            If value = 1 Then
                UploadSinglePicture(picture1, landlordPropertyID)
            ElseIf value = 2 Then
                UploadSinglePicture(picture2, landlordPropertyID)
            ElseIf value = 3 Then
                UploadSinglePicture(picture3, landlordPropertyID)
            ElseIf value = 4 Then
                UploadSinglePicture(picture4, landlordPropertyID)
            ElseIf value = 5 Then
                UploadSinglePicture(picture5, landlordPropertyID)
            ElseIf value = 6 Then
                UploadSinglePicture(picture6, landlordPropertyID)
            End If
        Next
    End Sub

    Protected Sub UploadSinglePicture(ByVal upload As FileUpload, ByVal landlordPropertyID As Integer)
        If upload.HasFile Then
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
                                                                 VALUES (@MIMEType, @ImageData, @LandlordPropertyID)"
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

    Public Sub SetDropdownList()
        FullDescrp.AppendDataBoundItems = True
        FullDescrp.Items.Insert(0, New ListItem("User *", "0"))

        Neighborhood.AppendDataBoundItems = True
        Neighborhood.Items.Insert(0, New ListItem("Neighborhood *", "0"))

        PropertyType.AppendDataBoundItems = True
        PropertyType.Items.Insert(0, New ListItem("Property *", "0"))

        UnitType.AppendDataBoundItems = True
        UnitType.Items.Insert(0, New ListItem("Unit *", "0"))
    End Sub
End Class