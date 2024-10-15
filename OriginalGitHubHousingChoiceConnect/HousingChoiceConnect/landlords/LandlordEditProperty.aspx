<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="LandlordEditProperty.aspx.vb" Inherits="HousingChoiceConnect.LandlordEditProperty" %>

<%@ Import Namespace="System.Web.Hosting" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/custom.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim landlordPropertyID As String

        If landlordPropertyID = Nothing Then
            landlordPropertyID = Request.QueryString("LandlordPropertyID")
        End If

        Dim userID As String
        If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
            userID = Web.HttpContext.Current.Session("UserID").ToString()
        End If

        If userID = Nothing Then
            userID = Request.QueryString("UserID")
            Web.HttpContext.Current.Session("UserID") = userID
        End If


        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
        Dim addressProperty As String
        Dim aptSuite As String
        Dim rent As Decimal
        Dim deposit As Decimal
        Dim personOfContact As String
        Dim personToContactPhoneNumber As String
        Dim utilityElectric As Boolean
        Dim utilityWater As Boolean
        Dim utilityGas As Boolean
        Dim isPropertyReadyForOccupancy As Boolean
        Dim isPetsPermitted As Boolean
        Dim dateAvailableToRent As String
        Dim petDeposit As Decimal
        Dim description As String

        conn.Open()
        Dim queryPropertyInfo As String = "SELECT * FROM LandlordProperty WHERE LandlordPropertyID='" & landlordPropertyID & "'"
        Dim query As New SqlCommand(queryPropertyInfo, conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            addressProperty = CStr(reader("AddressProperty"))
            aptSuite = CStr(reader("Apt_Suite"))
            rent = CStr(reader("Rent"))
            deposit = CStr(reader("Deposit"))
            personOfContact = CStr(reader("PersonOfContact"))
            personToContactPhoneNumber = CStr(reader("PersonToContactPhoneNumber"))
            utilityElectric = CStr(reader("IsUtilityElectricPaidByLandlord"))
            utilityWater = CStr(reader("IsUtilityWaterPaidByLandlord"))
            utilityGas = CStr(reader("IsUtilityGasPaidByLandlord"))
            isPropertyReadyForOccupancy = CStr(reader("IsPropertyReadyForOccupancy"))
            isPetsPermitted = CStr(reader("IsPetsPermitted"))
            dateAvailableToRent = CStr(reader("DateAvaiableToRent"))
            petDeposit = CStr(reader("PetDeposit"))
            description = CStr(reader("Description"))
        End While
        conn.Close()

        conn.Open()
        Dim isAccessibleParkingCloseToHome As Boolean
        Dim isRampedEntry As Boolean
        Dim isDoorways32InchesWider As Boolean
        Dim isAccessiblePathToAndInHome32InchesWider As Boolean
        Dim isAutomaticEntryDoor As Boolean
        Dim isLowCounterSinkAtBelow34Inches As Boolean
        Dim isAccessibleAppliances As Boolean
        Dim isShowerTubGrabBars As Boolean
        Dim isRollInShower As Boolean
        Dim isHandHeldShowerSprayer As Boolean
        Dim isFixedSeatInShowerTub As Boolean
        Dim isRaisedToilet As Boolean
        Dim isFirstFloorBedroom As Boolean
        Dim isFirstFloorBathroom As Boolean
        Dim isLiftElevator As Boolean
        Dim isAudioVisualDoorbell As Boolean
        Dim isAudioVisualSmokeFireAlarm As Boolean
        Dim isElevatorAccess As Boolean

        Dim queryHandicapAccessibility As String = "SELECT * FROM LandlordPropertyHandicapAccessibility WHERE fk_LandlordPropertyID='" & landlordPropertyID & "'"
        Dim query2 As New SqlCommand(queryHandicapAccessibility, conn)
        Dim readerHandicapAccessibility As SqlDataReader = query2.ExecuteReader()
        While readerHandicapAccessibility.Read
            isAccessibleParkingCloseToHome = CStr(readerHandicapAccessibility("IsAccessibleParkingCloseToHome"))
            isRampedEntry = CStr(readerHandicapAccessibility("IsRampedEntry"))
            isDoorways32InchesWider = CStr(readerHandicapAccessibility("IsDoorways32Inches_Wider"))
            isAccessiblePathToAndInHome32InchesWider = CStr(readerHandicapAccessibility("IsAccessiblePathToAndInHome32Inches_Wider"))
            isAutomaticEntryDoor = CStr(readerHandicapAccessibility("IsAutomaticEntryDoor"))
            isLowCounterSinkAtBelow34Inches = CStr(readerHandicapAccessibility("IsLowCounter_SinkAt_Below34Inches"))
            isAccessibleAppliances = CStr(readerHandicapAccessibility("IsAccessibleAppliances"))
            isShowerTubGrabBars = CStr(readerHandicapAccessibility("IsShower_TubGrabBars"))
            isRollInShower = CStr(readerHandicapAccessibility("IsRollInShower"))
            isHandHeldShowerSprayer = CStr(readerHandicapAccessibility("IsHandHeldShowerSprayer"))
            isFixedSeatInShowerTub = CStr(readerHandicapAccessibility("IsFixedSeatInShower_Tub"))
            isRaisedToilet = CStr(readerHandicapAccessibility("IsRaisedToilet"))
            isFirstFloorBedroom = CStr(readerHandicapAccessibility("IsFirstFloorBedroom"))
            isFirstFloorBathroom = CStr(readerHandicapAccessibility("IsFirstFloorBathroom"))
            isLiftElevator = CStr(readerHandicapAccessibility("IsLift_Elevator"))
            isAudioVisualDoorbell = CStr(readerHandicapAccessibility("IsAudio_VisualDoorbell"))
            isAudioVisualSmokeFireAlarm = CStr(readerHandicapAccessibility("IsAudio_VisualSmoke_FireAlarm"))
            isElevatorAccess = CStr(readerHandicapAccessibility("IsElevatorAccess"))
        End While
        conn.Close()

        conn.Open()
        Dim propertyAmentities As New ArrayList
        Dim queryAmentities As String = "SELECT * FROM LandlordPropertyAmentity WHERE fk_LandlordPropertyID='" & landlordPropertyID & "'"
        Dim query3 As New SqlCommand(queryAmentities, conn)
        Dim readerAmentities As SqlDataReader = query3.ExecuteReader()
        If readerAmentities.HasRows Then
            While readerAmentities.Read
                propertyAmentities.Add(CStr(readerAmentities("fk_AmentityID")))
            End While
        End If
        conn.Close()

        conn.Open()
        Dim imageType As String
        Dim pictureCount As Integer = 0
        Dim pictureID As Integer
        Dim picturesExists As Boolean() = {False, False, False, False, False, False}
        Dim pictureIDs As Integer() = {0, 0, 0, 0, 0, 0}
        Dim queryPictrue As New SqlCommand("SELECT LandlordPropertyPictureID, MIMEType, ImageData FROM LandlordPropertyPictures WHERE fk_LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        Dim readerPictureInfo As SqlDataReader = queryPictrue.ExecuteReader()
        If readerPictureInfo.HasRows Then
            While readerPictureInfo.Read
                imageType = readerPictureInfo("MIMEType").ToString()
                pictureID = CStr(readerPictureInfo("LandlordPropertyPictureID"))

                Dim fs As New IO.MemoryStream(CType(readerPictureInfo("ImageData"), Byte()))
                Dim br As New System.IO.BinaryReader(fs)
                Dim bytes As Byte() = br.ReadBytes(CType(fs.Length, Integer))
                Dim base64String As String = Convert.ToBase64String(bytes, 0, bytes.Length)

                If pictureCount = 0 Then
                    If imageType = "image/jpeg" Then
                        Image1.ImageUrl = "data:image/jpeg;base64," & base64String
                    ElseIf imageType = "image/png" Then
                        Image1.ImageUrl = "data:image/png;base64," & base64String
                    End If
                    picturesExists(0) = True
                    pictureIDs(0) = pictureID
                ElseIf pictureCount = 1 Then
                    If imageType = "image/jpeg" Then
                        Image2.ImageUrl = "data:image/jpeg;base64," & base64String
                    ElseIf imageType = "image/png" Then
                        Image2.ImageUrl = "data:image/png;base64," & base64String
                    End If
                    picturesExists(1) = True
                ElseIf pictureCount = 2 Then
                    If imageType = "image/jpeg" Then
                        Image3.ImageUrl = "data:image/jpeg;base64," & base64String
                    ElseIf imageType = "image/png" Then
                        Image3.ImageUrl = "data:image/png;base64," & base64String
                    End If
                    picturesExists(2) = True
                ElseIf pictureCount = 3 Then
                    If imageType = "image/jpeg" Then
                        Image4.ImageUrl = "data:image/jpeg;base64," & base64String
                    ElseIf imageType = "image/png" Then
                        Image4.ImageUrl = "data:image/png;base64," & base64String
                    End If
                    picturesExists(3) = True
                ElseIf pictureCount = 4 Then
                    If imageType = "image/jpeg" Then
                        Image5.ImageUrl = "data:image/jpeg;base64," & base64String
                    ElseIf imageType = "image/png" Then
                        Image5.ImageUrl = "data:image/png;base64," & base64String
                    End If
                    picturesExists(4) = True
                ElseIf pictureCount = 5 Then
                    If imageType = "image/jpeg" Then
                        Image6.ImageUrl = "data:image/jpeg;base64," & base64String
                    ElseIf imageType = "image/png" Then
                        Image6.ImageUrl = "data:image/png;base64," & base64String
                    End If
                    picturesExists(5) = True
                End If

                pictureCount = pictureCount + 1
            End While
        End If
        conn.Close()
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-eraser fa-fw"></i>Edit Property</h1>
                </div>
            </div>
            <form id="multiphase" enctype="multipart/form-data" onsubmit="return false">
            <div class="row">
                <div class="panel-group col-lg-12" id="accordion">
                    <%--Property Location--%>
                    <div class="panel panel-warning">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapsePropertyLocation">
                                    <i class="fa fa-map-marker"></i>&nbsp; Property Location</a>
                            </h4>
                        </div>
                        <div id="collapsePropertyLocation" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-map-marker"></i>&nbsp; Property Location</h3>
                                    </div>
                                    <div class="panel-body table-responsive">
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span1"><span class="glyphicon glyphicon-map-marker">
                                            </span></span>
                                            <input type="text" id="address" name="address" class="form-control" placeholder="Physical Street Address *"
                                                value="<% Response.Write(addressProperty) %>" maxlength="30" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span2"><span class="glyphicon glyphicon-home"></span>
                                            </span>
                                            <input type="text" id="aptOrSuite" name="aptOrSuite" class="form-control" placeholder="Apt Number or Suite"
                                                value="<% Response.Write(aptSuite) %>" maxlength="15" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span12"><span class="glyphicon glyphicon-globe">
                                            </span></span>
                                            <asp:DropDownList ID="Neighborhood" runat="server" CssClass="selectpicker" DataSourceID="SqlNeighborhood"
                                                DataTextField="Neighborhood" DataValueField="NeighborhoodID">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlNeighborhood" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                SelectCommand="SELECT [Neighborhood], [NeighborhoodID] FROM [Neighborhood] ORDER BY [Neighborhood]">
                                            </asp:SqlDataSource>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Basic Property Info--%>
                    <div class="panel panel-info">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseBasicPropertyInfo">
                                    <i class="fa fa-info"></i>&nbsp; Basic Property Info</a>
                            </h4>
                        </div>
                        <div id="collapseBasicPropertyInfo" class="panel-collapse collapse">
                            <div class="panel-body table-responsive">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-info"></i>&nbsp; Basic Property Info</h3>
                                    </div>
                                    <div class="panel-body table-responsive">
                                        <div class="alert alert-info text-center">
                                            <strong>Heads up!</strong> All fields below are required, but the <i>Description</i>
                                            is OPTIONAL.
                                        </div>
                                        <div class="form-inline text-center">
                                            <div class="input-group input-group-lg inputFormat col-sm-4">
                                                <span class="input-group-addon">$</span>
                                                <input type="text" class="form-control" id="rent" name="rent" placeholder="Rent *"
                                                    value="<% Response.Write(Math.Round(rent, 0)) %>" maxlength="4" required="requried" />
                                                <span class="input-group-addon">.00</span>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat col-sm-4">
                                                <span class="input-group-addon">$</span>
                                                <input type="text" class="form-control" id="deposit" name="deposit" placeholder="Deposit *"
                                                    value="<% Response.Write(Math.Round(deposit, 0)) %>" maxlength="4" required="requried" />
                                                <span class="input-group-addon">.00</span>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat col-sm-3">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                                <input type="text" id="dateAvailableToRent" name="dateAvailableToRent" class="form-control"
                                                    placeholder="Date Available To Rent *" maxlength="10" required="requried" value="<% Response.Write(dateAvailableToRent) %>" />
                                            </div>
                                        </div>
                                        <div class="form-inline text-center">
                                            <div class="input-group input-group-lg inputFormat col-sm-3">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-bed"></span></span>
                                                <asp:DropDownList ID="Bedroom" runat="server" CssClass="selectpicker">
                                                    <asp:ListItem Enabled="true" Text="Bedroom *" Value="-1"></asp:ListItem>
                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat col-sm-2">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-bitcoin"></span>
                                                </span>
                                                <asp:DropDownList ID="Bathroom" runat="server" CssClass="selectpicker">
                                                    <asp:ListItem Enabled="true" Text="Bathroom *" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="1.5" Value="1.5"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="2.5" Value="2.5"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="3.5" Value="3.5"></asp:ListItem>
                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="4.5" Value="4.5"></asp:ListItem>
                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat col-sm-2">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span>
                                                <asp:DropDownList ID="PropertyType" runat="server" CssClass="selectpicker" DataSourceID="SqlPropertyType"
                                                    DataTextField="Type" DataValueField="PropertyTypeID">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlPropertyType" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT [Type], [PropertyTypeID] FROM [PropertyType]"></asp:SqlDataSource>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat col-sm-3">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span>
                                                <asp:DropDownList ID="UnitType" runat="server" CssClass="selectpicker" DataSourceID="SqlUnitType"
                                                    DataTextField="Type" DataValueField="UnitTypeID">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlUnitType" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT [Type], [UnitTypeID] FROM [UnitType]"></asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <br />
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>
                                                    </th>
                                                    <th>
                                                        Yes
                                                    </th>
                                                    <th>
                                                        No
                                                    </th>
                                                    <th>
                                                        If Yes, Deposit
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <i>Pets Permitted*</i>
                                                    </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <%
                                                                If isPetsPermitted = "True" Then
                                                                    Response.Write("<input type='radio' name='petsPermitted' value='Yes' checked='' />")
                                                                Else
                                                            %>
                                                            <input type="radio" name="petsPermitted" value="Yes" />
                                                            <%
                                                            End If
                                                            %>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <%
                                                                If isPetsPermitted = "False" Then
                                                                    Response.Write("<input type='radio' name='petsPermitted' value='No' checked='' />")
                                                                Else
                                                            %>
                                                            <input type="radio" name="petsPermitted" value="No" />
                                                            <%
                                                            End If
                                                            %>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="input-group input-group-sm propertyFormat">
                                                            <span class="input-group-addon">$</span>
                                                            <%
                                                                If petDeposit = 0.0 Then
                                                            %>
                                                            <input type="text" class="form-control" aria-label="Amount (to the nearest dollar)"
                                                                name="petDeposit" placeholder="Deposit (i.e. 123)" maxlength="4" />
                                                            <%
                                                            Else
                                                            %>
                                                            <input type="text" class="form-control" aria-label="Amount (to the nearest dollar)"
                                                                value="<% Response.Write(Math.Round(petDeposit, 0)) %>" name="petDeposit" placeholder="Deposit (i.e. 123)"
                                                                maxlength="4" />
                                                            <%
                                                            End If
                                                            %>
                                                            <span class="input-group-addon">.00</span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>
                                                    </th>
                                                    <th>
                                                        Yes
                                                    </th>
                                                    <th>
                                                        No
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <i>Property Ready For Occupancy *</i>
                                                    </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <%
                                                                If isPropertyReadyForOccupancy = "True" Then
                                                                    Response.Write("<input type='radio' name='readyForOccupancy' value='Yes' checked='' />")
                                                                Else
                                                            %>
                                                            <input type="radio" name="readyForOccupancy" value="Yes" />
                                                            <%
                                                            End If
                                                            %>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <%
                                                                If isPropertyReadyForOccupancy = "False" Then
                                                                    Response.Write("<input type='radio' name='readyForOccupancy' value='No' checked='' />")
                                                                Else
                                                            %>
                                                            <input type="radio" name="readyForOccupancy" value="No" />
                                                            <%
                                                            End If
                                                            %>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <br />
                                        <div class="form-group">
                                            <textarea class="form-control" placeholder="Property Description" cols="5" rows="5"
                                                name="description" id="description" maxlength="140"> <% Response.Write(description)%></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--  Utilities & Amenities--%>
                    <div class="panel panel-warning">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseUtilitiesAmenities">
                                    <i class="fa fa-usb"></i>&nbsp; Utilities & Amenities</a>
                            </h4>
                        </div>
                        <div id="collapseUtilitiesAmenities" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-usb"></i>&nbsp;Utilities & Amenities</h3>
                                    </div>
                                    <div class="panel-body">
                                        <h4 class="text-center">
                                            <i class="fa fa-usb"></i>&nbsp;Utilities</h4>
                                        <div class="list-group">
                                            <div class="list-group-item table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                Type
                                                            </th>
                                                            <th>
                                                                Owner Pays
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                            </th>
                                                            <th>
                                                                Yes
                                                            </th>
                                                            <th>
                                                                No
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <i>Electric *</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If utilityElectric = "True" Then
                                                                            Response.Write("<input type='radio' name='utilityElectric' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="utilityElectric" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If utilityElectric = "False" Then
                                                                            Response.Write("<input type='radio' name='utilityElectric' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="utilityElectric" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Water *</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If utilityWater = "True" Then
                                                                            Response.Write("<input type='radio' name='utilityWater' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="utilityWater" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If utilityWater = "False" Then
                                                                            Response.Write("<input type='radio' name='utilityWater' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="utilityWater" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Gas *</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If utilityGas = "True" Then
                                                                            Response.Write("<input type='radio' name='utilityGas' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="utilityGas" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If utilityGas = "False" Then
                                                                            Response.Write("<input type='radio' name='utilityGas' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="utilityGas" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <h4 class="text-center">
                                            <i class="fa fa-usb" aria-hidden="true"></i>&nbsp; Amenities</h4>
                                        <div class="list-group table-responsive">
                                            <div class="list-group-item table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                Indoor
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Type
                                                            </th>
                                                            <th>
                                                                Included
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <i>Central Air/Heat</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("1") Then
                                                                                Response.Write("<input type='checkbox' name='amentityCentralAirHeat' value='1' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityCentralAirHeat' value='1' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityCentralAirHeat' value='1' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Washer</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("2") Then
                                                                                Response.Write("<input type='checkbox' name='amentityWasher' value='2' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityWasher' value='2' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityWasher' value='2' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Dryer</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("3") Then
                                                                                Response.Write("<input type='checkbox' name='amentityDryer' value='3' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityDryer' value='3' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityDryer' value='3' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Alarm</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("4") Then
                                                                                Response.Write("<input type='checkbox' name='amentityAlarm' value='4' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityAlarm' value='4' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityAlarm' value='4' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Washer/Dryer Hookups</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("5") Then
                                                                                Response.Write("<input type='checkbox' name='amentityWasherDryerHookups' value='5' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityWasherDryerHookups' value='5' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityWasherDryerHookups' value='5' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Ceiling Fans</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("6") Then
                                                                                Response.Write("<input type='checkbox' name='amentityCeilingFans' value='6' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityCeilingFans' value='6' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityCeilingFans' value='6' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <%--Kitchen--%>
                                            <div class="list-group-item table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                Kitchen
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Type
                                                            </th>
                                                            <th>
                                                                Included
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <i>Dishwasher</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("7") Then
                                                                                Response.Write("<input type='checkbox' name='amentityDishwasher' value='7' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityDishwasher' value='7' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityDishwasher' value='7' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Refrigerator</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("8") Then
                                                                                Response.Write("<input type='checkbox' name='amentityRefrigerator' value='8' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityRefrigerator' value='8' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityRefrigerator' value='8' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Garbage Disposal</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("9") Then
                                                                                Response.Write("<input type='checkbox' name='amentityGarbageDisposal' value='9' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityGarbageDisposal' value='9' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityGarbageDisposal' value='9' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Stove</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("16") Then
                                                                                Response.Write("<input type='checkbox' name='amentityStove' value='16' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityStove' value='16' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityStove' value='16' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <%--Outdoor --%>
                                            <div class="list-group-item table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                Outdoor
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Type
                                                            </th>
                                                            <th>
                                                                Included
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <i>Off Street Parking</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("10") Then
                                                                                Response.Write("<input type='checkbox' name='amentityOffStreetParking' value='10' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityOffStreetParking' value='10' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityOffStreetParking' value='10' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Covered Parking</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("11") Then
                                                                                Response.Write("<input type='checkbox' name='amentityCoveredParking' value='11' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityCoveredParking' value='11' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityCoveredParking' value='11' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Front Yard</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("12") Then
                                                                                Response.Write("<input type='checkbox' name='amentityFrontYard' value='12' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityFrontYard' value='12' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityFrontYard' value='12' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Back Yard</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("13") Then
                                                                                Response.Write("<input type='checkbox' name='amentityBackYard' value='13' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityBackYard' value='13' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityBackYard' value='13' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Gated</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("14") Then
                                                                                Response.Write("<input type='checkbox' name='amentityGated' value='14' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityGated' value='14' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityGated' value='14' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <%--Other--%>
                                            <div class="list-group-item table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                Other
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Type
                                                            </th>
                                                            <th>
                                                                Included
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <i>Onsite Security</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <%
                                                                        If propertyAmentities.Count > 0 Then
                                                                            If propertyAmentities.Contains("15") Then
                                                                                Response.Write("<input type='checkbox' name='amentityOnsiteSecurity' value='15' checked='' />")
                                                                            Else
                                                                                Response.Write("<input type='checkbox' name='amentityOnsiteSecurity' value='15' />")
                                                                            End If
                                                                        Else
                                                                            Response.Write("<input type='checkbox' name='amentityOnsiteSecurity' value='15' />")
                                                                        End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Handicap Accessibility--%>
                    <div class="panel panel-info">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseHandicapAccessibility">
                                    <i class="fa fa-wheelchair" aria-hidden="true"></i>&nbsp; Handicap Accessibility</a>
                            </h4>
                        </div>
                        <div id="collapseHandicapAccessibility" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-wheelchair" aria-hidden="true"></i>&nbsp; Handicap Accessibility</h3>
                                    </div>
                                    <div class="panel-body">
                                        <div class="alert alert-info text-center">
                                            <strong>Heads up! </strong>All fields below are required.
                                        </div>
                                        <div class="list-group">
                                            <%--  Entry and Doorway --%>
                                            <div class="list-group-item table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                Entry and Doorway
                                                            </th>
                                                            <th>
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Type
                                                            </th>
                                                            <th>
                                                                Yes
                                                            </th>
                                                            <th>
                                                                No
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <i>Accessible Parking Close to Home</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAccessibleParkingCloseToHome = "True" Then
                                                                            Response.Write("<input type='radio' name='handicapParkingClose' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="handicapParkingClose" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAccessibleParkingCloseToHome = "False" Then
                                                                            Response.Write("<input type='radio' name='handicapParkingClose' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="handicapParkingClose" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Ramped Entry</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isRampedEntry = "True" Then
                                                                            Response.Write("<input type='radio' name='rampedEntry' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="rampedEntry" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isRampedEntry = "False" Then
                                                                            Response.Write("<input type='radio' name='rampedEntry' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="rampedEntry" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Doorways 32" Inches or Wider</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isDoorways32InchesWider = "True" Then
                                                                            Response.Write("<input type='radio' name='doorways32InchesOrWider' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="doorways32InchesOrWider" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isDoorways32InchesWider = "False" Then
                                                                            Response.Write("<input type='radio' name='doorways32InchesOrWider' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="doorways32InchesOrWider" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Accessible Path to/and in Home 32" Inches or Wider</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAccessiblePathToAndInHome32InchesWider = "True" Then
                                                                            Response.Write("<input type='radio' name='accessiblePathIn32InchesOrWider' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="accessiblePathIn32InchesOrWider" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAccessiblePathToAndInHome32InchesWider = "False" Then
                                                                            Response.Write("<input type='radio' name='accessiblePathIn32InchesOrWider' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="accessiblePathIn32InchesOrWider" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Automatic Entry Door</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAutomaticEntryDoor = "True" Then
                                                                            Response.Write("<input type='radio' name='automaticEntryDoor' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="automaticEntryDoor" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAutomaticEntryDoor = "False" Then
                                                                            Response.Write("<input type='radio' name='automaticEntryDoor' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="automaticEntryDoor" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <%--Kitchen--%>
                                            <div class="list-group-item table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                Kitchen
                                                            </th>
                                                            <th>
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Type
                                                            </th>
                                                            <th>
                                                                Yes
                                                            </th>
                                                            <th>
                                                                No
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <i>Low Counter or Sink at/or Below 34" Inches</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isLowCounterSinkAtBelow34Inches = "True" Then
                                                                            Response.Write("<input type='radio' name='lowCounterOrSinkBelow34Inches' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="lowCounterOrSinkBelow34Inches" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isLowCounterSinkAtBelow34Inches = "False" Then
                                                                            Response.Write("<input type='radio' name='lowCounterOrSinkBelow34Inches' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="lowCounterOrSinkBelow34Inches" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Accessible Appliances</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAccessibleAppliances = "True" Then
                                                                            Response.Write("<input type='radio' name='accessibleAppliances' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="accessibleAppliances" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAccessibleAppliances = "False" Then
                                                                            Response.Write("<input type='radio' name='accessibleAppliances' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="accessibleAppliances" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <%-- Bathroom--%>
                                            <div class="list-group-item table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                Bathroom
                                                            </th>
                                                            <th>
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Type
                                                            </th>
                                                            <th>
                                                                Yes
                                                            </th>
                                                            <th>
                                                                No
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <i>Shower or Tub Grab Bars</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isShowerTubGrabBars = "True" Then
                                                                            Response.Write("<input type='radio' name='showerOrTubGrabBars' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="showerOrTubGrabBars" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isShowerTubGrabBars = "False" Then
                                                                            Response.Write("<input type='radio' name='showerOrTubGrabBars' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="showerOrTubGrabBars" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Roll in Showers*</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isRollInShower = "True" Then
                                                                            Response.Write("<input type='radio' name='rollInShowers' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="rollInShowers" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isRollInShower = "False" Then
                                                                            Response.Write("<input type='radio' name='rollInShowers' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="rollInShowers" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Hand Held Shower Sprayer</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isHandHeldShowerSprayer = "True" Then
                                                                            Response.Write("<input type='radio' name='handHeldShowerSprayer' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="handHeldShowerSprayer" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isHandHeldShowerSprayer = "False" Then
                                                                            Response.Write("<input type='radio' name='handHeldShowerSprayer' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="handHeldShowerSprayer" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Fixed Seat in Shower or Tub*</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isFixedSeatInShowerTub = "True" Then
                                                                            Response.Write("<input type='radio' name='fixedSeatInShowerOrTub' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="fixedSeatInShowerOrTub" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isFixedSeatInShowerTub = "False" Then
                                                                            Response.Write("<input type='radio' name='fixedSeatInShowerOrTub' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="fixedSeatInShowerOrTub" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Raised Tiolet</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isRaisedToilet = "True" Then
                                                                            Response.Write("<input type='radio' name='raisedTiolet' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="raisedTiolet" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isRaisedToilet = "False" Then
                                                                            Response.Write("<input type='radio' name='raisedTiolet' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="raisedTiolet" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>First Floor Bathroom</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isFirstFloorBathroom = "True" Then
                                                                            Response.Write("<input type='radio' name='firstFloorBathroom' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="firstFloorBathroom" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isFirstFloorBathroom = "False" Then
                                                                            Response.Write("<input type='radio' name='firstFloorBathroom' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="firstFloorBathroom" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <%--Miscellaneous--%>
                                            <div class="list-group-item table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                Miscellaneous
                                                            </th>
                                                            <th>
                                                            </th>
                                                            <th>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Type
                                                            </th>
                                                            <th>
                                                                Yes
                                                            </th>
                                                            <th>
                                                                No
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <i>Lift or Elevator</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isLiftElevator = "True" Then
                                                                            Response.Write("<input type='radio' name='liftOrElevator' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="liftOrElevator" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isLiftElevator = "False" Then
                                                                            Response.Write("<input type='radio' name='liftOrElevator' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="liftOrElevator" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Audio or Visual Doorbell</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAudioVisualDoorbell = "True" Then
                                                                            Response.Write("<input type='radio' name='audioOrVisualDoorbell' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="audioOrVisualDoorbell" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAudioVisualDoorbell = "False" Then
                                                                            Response.Write("<input type='radio' name='audioOrVisualDoorbell' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="audioOrVisualDoorbell" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Audio or Visual Smoke or Fire Alarm</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAudioVisualSmokeFireAlarm = "True" Then
                                                                            Response.Write("<input type='radio' name='audioOrVisualSmokeOrFireAlarm' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="audioOrVisualSmokeOrFireAlarm" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isAudioVisualSmokeFireAlarm = "False" Then
                                                                            Response.Write("<input type='radio' name='audioOrVisualSmokeOrFireAlarm' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="audioOrVisualSmokeOrFireAlarm" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>First Floor Bedroom</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isFirstFloorBedroom = "True" Then
                                                                            Response.Write("<input type='radio' name='firstFloorBedroom' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="firstFloorBedroom" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isFirstFloorBedroom = "False" Then
                                                                            Response.Write("<input type='radio' name='firstFloorBedroom' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="firstFloorBedroom" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Elevator Access</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isElevatorAccess = "True" Then
                                                                            Response.Write("<input type='radio' name='elevatorAccess' value='Yes' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="elevatorAccess" value="Yes" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <%
                                                                        If isElevatorAccess = "False" Then
                                                                            Response.Write("<input type='radio' name='elevatorAccess' value='No' checked='' />")
                                                                        Else
                                                                    %>
                                                                    <input type="radio" name="elevatorAccess" value="No" />
                                                                    <%
                                                                    End If
                                                                    %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Pictures--%>
                    <div class="panel panel-warning">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapsePictures"><i class="fa fa-picture-o"
                                    aria-hidden="true"></i>&nbsp; Pictures</a>
                            </h4>
                        </div>
                        <div id="collapsePictures" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-picture-o" aria-hidden="true"></i>&nbsp; Pictures</h3>
                                    </div>
                                    <div class="panel-body table-responsive">
                                      <div class="alert alert-info text-center">
                                            <strong>Heads up!</strong> Picture Photo will NOT change until form is submitted.
                                      </div>
                                        <div class="form-inline">
                                            <div class="input-group input-group-lg inputFormat">
                                                <%
                                                    If picturesExists(0) = False Then
                                                        Response.Write("<div><img alt='House' height='300' width='400' src='img/houseDefault.jpg'></div>")
                                                    Else
                                                %>
                                                <div>
                                                    <asp:Image ID="Image1" runat="server" Height="300" Width="400"></asp:Image>
                                                </div>
                                                <%
                                                End If
                                                %>
                                                <asp:FileUpload ID="picture1" name="picture1" runat="server" class="form-control" Width="400" accept="image/*" />
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <%
                                                    If picturesExists(1) = False Then
                                                        Response.Write("<div><img alt='House' height='300' width='400' src='img/houseDefault.jpg'></div>")
                                                    Else
                                                %>
                                                <div>
                                                    <asp:Image ID="Image2" runat="server" Height="300" Width="400"></asp:Image>
                                                </div>
                                                <%
                                                End If
                                                %>
                                                <asp:FileUpload ID="picture2" name="picture2" runat="server" class="form-control" Width="400" accept="image/*" />
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <%
                                                    If picturesExists(2) = False Then
                                                        Response.Write("<div><img alt='House' height='300' width='400' src='img/houseDefault.jpg'></div>")
                                                    Else
                                                %>
                                                <asp:Image ID="Image3" runat="server" Height="300" Width="400"></asp:Image>
                                                <%
                                                End If
                                                %>
                                                <asp:FileUpload ID="picture3" name="picture3" runat="server" class="form-control" Width="400" accept="image/*" />
                                            </div>
                                        </div>
                                        <div class="form-inline">
                                            <div class="input-group input-group-lg inputFormat">
                                                <%
                                                    If picturesExists(3) = False Then
                                                        Response.Write("<div><img alt='House' height='300' width='400' src='img/houseDefault.jpg'></div>")
                                                    Else
                                                %>
                                                <asp:Image ID="Image4" runat="server" Height="300" Width="400"></asp:Image>
                                                <%
                                                End If
                                                %>
                                                <asp:FileUpload ID="picture4" name="picture4" runat="server" class="form-control" Width="400" accept="image/*" />
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <%
                                                    If picturesExists(4) = False Then
                                                        Response.Write("<div><img alt='House' height='300' width='400' src='img/houseDefault.jpg'></div>")
                                                    Else
                                                %>
                                                <asp:Image ID="Image5" runat="server" Height="300" Width="400"></asp:Image>
                                                <%
                                                End If
                                                %>
                                                <asp:FileUpload ID="picture5" name="picture5" runat="server" class="form-control" Width="400"  accept="image/*" />
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <%
                                                    If picturesExists(5) = False Then
                                                        Response.Write("<div><img alt='House' height='300' width='400' src='img/houseDefault.jpg'></div>")
                                                    Else
                                                %>
                                                <asp:Image ID="Image6" runat="server" Height="300" Width="400"></asp:Image>
                                                <%
                                                End If
                                                %>
                                                <asp:FileUpload ID="picture6" name="picture6" runat="server" class="form-control" Width="400"  accept="image/*" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Contact Info--%>
                    <div class="panel panel-info">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseContactInfo"><i
                                    class="fa fa-phone" aria-hidden="true"></i>&nbsp; Contact Info</a>
                            </h4>
                        </div>
                        <div id="collapseContactInfo" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-phone" aria-hidden="true"></i>&nbsp; Contact Info</h3>
                                    </div>
                                    <div class="panel-body table-responsive">
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span>
                                            </span>
                                            <input type="text" name="contactName" class="form-control" placeholder="Person of Contact Name *" value="<% Response.Write(personOfContact) %>"
                                                maxlength="25" required="required" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-phone">
                                            </span></span>
                                            <input type="text" name="contactNumber" class="form-control" placeholder="Person of Contact Number * (i.e. 5043407700)" value="<% Response.Write(personToContactPhoneNumber) %>"
                                               maxlength="10" required="required" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Edit Property--%>
                    <div class="panel panel-warning">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseEditProperty"><i
                                    class="fa fa-eraser" aria-hidden="true"></i>&nbsp; Edit Property</a>
                            </h4>
                        </div>
                        <div id="collapseEditProperty" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-eraser" aria-hidden="true"></i>&nbsp; Edit Property</h3>
                                    </div>
                                    <div class="panel-body table-responsive">
                                        <div class="text-center">
                                            <button id="button" type="button" class="btn btn-info btn-block btn-lg" runat="server"
                                                onserverclick="btnEditProperty">
                                                <i class="fa fa-eraser"></i>&nbsp; Submit
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>
</asp:Content>