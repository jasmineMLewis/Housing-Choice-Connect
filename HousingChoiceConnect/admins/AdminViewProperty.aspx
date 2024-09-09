<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master" 
    CodeBehind="AdminViewProperty.aspx.vb" Inherits="HousingChoiceConnect.AdminViewProperty" %>

<%@ Import Namespace="System.Web.Hosting" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HEAD" runat="server">
    <style type="text/css">
        .carousel-inner > .item > img{
                margin:auto;
        }
    </style>

    <script type="text/javascript">
        function viewOnMap() {
            var label = document.getElementById("addressLink");
            var zip = document.getElementById("zipCodeAddress");
            var iframe = document.getElementById("map");
            var address = label.innerHTML + "," + zip.innerHTML;
            iframe.src = "https://www.google.com/maps/embed/v1/place?key=AIzaSyAxcxxJxw4XCeaaVpYsdHDP3CsXyeLAQmI&q=" + address;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim landlordPropertyID As String

        If landlordPropertyID = Nothing Then
            landlordPropertyID = Request.QueryString("LandlordPropertyID")
        End If

        Dim userID As String = Session("UserID")
        If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
            userID = Web.HttpContext.Current.Session("UserID").ToString()
        End If

        If userID = Nothing Then
            userID = Request.QueryString("UserID")
            Web.HttpContext.Current.Session("UserID") = userID
        End If

        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
        conn.Open()
        Dim landlordPropertyTenantViews As Integer
        Dim queryViewsInfo As New SqlCommand("SELECT NumberOfTenantViews 
                                              FROM LandlordProperty 
                                              WHERE LandlordPropertyID='" & landlordPropertyID & "'", conn)
        Dim readerViewsInfo As SqlDataReader = queryViewsInfo.ExecuteReader()
        While readerViewsInfo.Read
            landlordPropertyTenantViews = CStr(readerViewsInfo("NumberOfTenantViews"))
        End While
        conn.Close()

        conn.Open()
        Dim roleID As Integer
        Dim queryRoleInfo As New SqlCommand("SELECT RoleID 
                                             FROM Users 
                                             WHERE UserID='" & userID & "'", conn)
        Dim readerRoleInfo As SqlDataReader = queryRoleInfo.ExecuteReader()
        While readerRoleInfo.Read
            roleID = CStr(readerRoleInfo("RoleID"))
        End While
        conn.Close()

        Const TENANT_ROLE_ID As Integer = 2
        If roleID = TENANT_ROLE_ID Then
            landlordPropertyTenantViews = landlordPropertyTenantViews + 1
            conn.Open()
            Dim queryUpdateViews As New SqlCommand("UPDATE LandlordProperty 
                                                    SET NumberOfTenantViews = '" & landlordPropertyTenantViews & "' 
                                                    WHERE LandlordPropertyID='" & landlordPropertyID & "'", conn)
            queryUpdateViews.ExecuteNonQuery()
            conn.Close()
        End If

        'Property Info
        Dim landlordUserID As Integer
        Dim addressProperty As String
        Dim aptSuite As String
        Dim neighborhood As String
        Dim zipCode As Integer
        Dim bathNumber As Double
        Dim bedroomNumber As Integer
        Dim rent As Decimal
        Dim deposit As Decimal
        Dim personOfContact As String
        Dim personToContactPhoneNumber As String
        Dim propertyType As String
        Dim unitType As String
        Dim utilityElectric As Boolean
        Dim utilityWater As Boolean
        Dim utilityGas As Boolean
        Dim isPropertyReadyForOccupancy As Boolean
        Dim isPetsPermitted As Boolean
        Dim dateAvailableToRent As String
        Dim petDeposit As Decimal
        Dim description As String

        conn.Open()
        Dim queryPropertyInfo As String = String.Empty
        queryPropertyInfo &= "SELECT UserID, AddressProperty, AptSuite, Neighborhood.Neighborhood, Neighborhood.ZipCode,  "
        queryPropertyInfo &= "       BathroomNumber, BedroomNumber, Property.Property AS Property, Unit.Unit As Unit, Rent, "
        queryPropertyInfo &= "       Deposit, PersonOfContact, PersonToContactPhoneNumber, IsUtilityElectricPaidByLandlord, "
        queryPropertyInfo &= "       IsUtilityWaterPaidByLandlord, IsUtilityGasPaidByLandlord, IsPropertyReadyForOccupancy, "
        queryPropertyInfo &= "       IsPetsPermitted, DateAvaiableToRent, PetDeposit, LandlordProperty.Description AS descrp "
        queryPropertyInfo &= "FROM LandlordProperty "
        queryPropertyInfo &= "INNER JOIN Neighborhood ON LandlordProperty.NeighborhoodID = Neighborhood.NeighborhoodID "
        queryPropertyInfo &= "INNER JOIN Property ON LandlordProperty.PropertyID = Property.PropertyID "
        queryPropertyInfo &= "INNER JOIN Unit ON LandlordProperty.UnitID = Unit.UnitID "
        queryPropertyInfo &= "WHERE LandlordPropertyID='" & landlordPropertyID & "'"

        Dim query As New SqlCommand(queryPropertyInfo, conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            landlordUserID = CStr(reader("UserID"))
            addressProperty = CStr(reader("AddressProperty"))
            aptSuite = CStr(reader("AptSuite"))
            neighborhood = CStr(reader("Neighborhood"))
            zipCode = CStr(reader("ZipCode"))
            bathNumber = CStr(reader("BathroomNumber"))
            bedroomNumber = CStr(reader("BedroomNumber"))
            rent = CStr(reader("Rent"))
            deposit = CStr(reader("Deposit"))
            personOfContact = CStr(reader("PersonOfContact"))
            personToContactPhoneNumber = CStr(reader("PersonToContactPhoneNumber"))
            propertyType = CStr(reader("Property"))
            unitType = CStr(reader("Unit"))
            utilityElectric = CStr(reader("IsUtilityElectricPaidByLandlord"))
            utilityWater = CStr(reader("IsUtilityWaterPaidByLandlord"))
            utilityGas = CStr(reader("IsUtilityGasPaidByLandlord"))
            isPropertyReadyForOccupancy = CStr(reader("IsPropertyReadyForOccupancy"))
            isPetsPermitted = CStr(reader("IsPetsPermitted"))
            dateAvailableToRent = CStr(reader("DateAvaiableToRent"))
            petDeposit = CStr(reader("PetDeposit"))
            description = CStr(reader("descrp"))
        End While
        conn.Close()

        'Landlord Email Address
        conn.Open()
        Dim personOfContactEmail As String
        Dim querypersonOfContactEmail As New SqlCommand("SELECT Email FROM Users WHERE UserID='" & landlordUserID & "'", conn)
        Dim readerpersonOfContactEmail As SqlDataReader = querypersonOfContactEmail.ExecuteReader()
        While readerpersonOfContactEmail.Read
            personOfContactEmail = CStr(readerpersonOfContactEmail("Email"))
        End While
        conn.Close()

        'Handicap Accessibility
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

        conn.Open()
        Dim queryHandicapInfo As String = String.Empty
        queryHandicapInfo &= "SELECT * FROM LandlordPropertyHandicapAccessibility WHERE fk_LandlordPropertyID = '" & landlordPropertyID & "'"
        Dim queryHandicap As New SqlCommand(queryHandicapInfo, conn)
        Dim readerHandicapInfo As SqlDataReader = queryHandicap.ExecuteReader()
        While readerHandicapInfo.Read
            isAccessibleParkingCloseToHome = CStr(readerHandicapInfo("IsAccessibleParkingCloseToHome"))
            isRampedEntry = CStr(readerHandicapInfo("IsRampedEntry"))
            isDoorways32InchesWider = CStr(readerHandicapInfo("IsDoorways32Inches_Wider"))
            isAccessiblePathToAndInHome32InchesWider = CStr(readerHandicapInfo("IsAccessiblePathToAndInHome32Inches_Wider"))
            isAutomaticEntryDoor = CStr(readerHandicapInfo("IsAutomaticEntryDoor"))
            isLowCounterSinkAtBelow34Inches = CStr(readerHandicapInfo("IsLowCounter_SinkAt_Below34Inches"))
            isAccessibleAppliances = CStr(readerHandicapInfo("IsAccessibleAppliances"))
            isShowerTubGrabBars = CStr(readerHandicapInfo("IsShower_TubGrabBars"))
            isRollInShower = CStr(readerHandicapInfo("IsRollInShower"))
            isHandHeldShowerSprayer = CStr(readerHandicapInfo("IsHandHeldShowerSprayer"))
            isFixedSeatInShowerTub = CStr(readerHandicapInfo("IsFixedSeatInShower_Tub"))
            isRaisedToilet = CStr(readerHandicapInfo("IsRaisedToilet"))
            isFirstFloorBedroom = CStr(readerHandicapInfo("IsFirstFloorBedroom"))
            isFirstFloorBathroom = CStr(readerHandicapInfo("IsFirstFloorBathroom"))
            isLiftElevator = CStr(readerHandicapInfo("IsLift_Elevator"))
            isAudioVisualDoorbell = CStr(readerHandicapInfo("IsAudio_VisualDoorbell"))
            isAudioVisualSmokeFireAlarm = CStr(readerHandicapInfo("IsAudio_VisualSmoke_FireAlarm"))
            isElevatorAccess = CStr(readerHandicapInfo("IsElevatorAccess"))
        End While
        conn.Close()

        'Amentities
        Dim dBpropertyAmetities As New ArrayList
        conn.Open()
        Dim queryAmentityInfo As String = String.Empty
        queryAmentityInfo &= "SELECT fk_AmentityID FROM LandlordPropertyAmentity WHERE fk_LandlordPropertyID = '" & landlordPropertyID & "'"
        Dim queryAmentity As New SqlCommand(queryAmentityInfo, conn)
        Dim readerAmentityInfo As SqlDataReader = queryAmentity.ExecuteReader()
        While readerAmentityInfo.Read
            dBpropertyAmetities.Add(CStr(readerAmentityInfo("fk_AmentityID")))
        End While

        Dim amentityResponses As New ArrayList
        For value As Integer = 1 To 16
            If dBpropertyAmetities.Contains(CStr(value)) Then
                amentityResponses.Add("Yes")
            Else
                amentityResponses.Add("No")
            End If
        Next
        conn.Close()

        'Pictures
        conn.Open()
        Dim imageType As String
        Dim pictureCount As Integer = 0
        Dim hasPictures As Boolean = False
        Dim picturesExists As Boolean() = {False, False, False, False, False, False}
        Dim queryPictrue As New SqlCommand("SELECT MIMEType, ImageData FROM LandlordPropertyPictures WHERE fk_LandlordPropertyID = '" & landlordPropertyID & "'", conn)
        Dim readerPictureInfo As SqlDataReader = queryPictrue.ExecuteReader()
        If readerPictureInfo.HasRows Then
            While readerPictureInfo.Read
                imageType = readerPictureInfo("MIMEType").ToString()

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
                hasPictures = True
            End While
        End If
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-home"></i>&nbsp;Property</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8">
                    <div class="panel panel-custom">
                        <div class="panel-heading text-center">
                            <i class="fa fa-home" aria-hidden="true"></i>&nbsp;View Property
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-map-marker"></i>&nbsp;Property Location</h3>
                                </div>
                                <div class="panel-body">
                                    <h2>
                                        <strong><i class="fa fa-map-marker" aria-hidden="true"></i><em>
                                            <% Response.Write(addressProperty)%></em></strong></h2>
                                    <%
                                        If Not aptSuite = "" Then
                                            Response.Write("<h4><strong><i class='fa fa-building' aria-hidden='true'></i>&nbsp; Apt/Suite </strong>" & aptSuite & "</h4>")
                                        End If
                                    %>
                                    <h4>
                                        <strong><i class="fa fa-road"></i>&nbsp;Neighbordhood</strong>
                                        <em>
                                            <% Response.Write(neighborhood)%></em>
                                    </h4>
                                    <h4>
                                        <strong><i class="fa fa-qrcode"></i>&nbsp;Zip Code</strong> <em>
                                            <% Response.Write(zipCode)%></em>
                                    </h4>
                                    <h4>
                                        <strong><i class="fa fa-bed"></i>&nbsp;Bedroom</strong> <em>
                                            <% Response.Write(bedroomNumber)%></em>
                                    </h4>
                                    <h4>
                                        <strong><i class="fa fa-btc"></i>&nbsp;Bath</strong> <em>
                                            <% Response.Write(bathNumber)%></em>
                                    </h4>
                                    <h4>
                                        <strong><i class="fa fa-money"></i>&nbsp;Rent</strong> <em>
                                            <% Response.Write(Math.Round(rent, 2))%></em>
                                    </h4>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-map-pin"></i>&nbsp;Map</h3>
                                </div>
                                <div class="panel-body">
                                    <p>
                                        <i class="fa fa-map-pin"></i>&nbsp;
                                        <label id="addressLink" onclick="viewOnMap();">
                                            <% Response.Write(addressProperty)%>
                                        </label>
                                        &nbsp;
                                        <label id="zipCodeAddress">
                                            <% Response.Write(zipCode)%></label>
                                    </p>
                                    <a onclick="viewOnMap();" href="#"><i class="fa fa-eye"></i>&nbsp;
                                        View on Map </a>
                                    <div style="margin-top: 55px">
                                        <iframe id="map" width="100%" height="450" frameborder="0" style="border: 0" src="https://www.google.com/maps/embed/v1/place?key=AIzaSyAxcxxJxw4XCeaaVpYsdHDP3CsXyeLAQmI&q=New+Orleans"
                                            allowfullscreen></iframe>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-picture-o"></i>&nbsp;Pictures</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="container">
                                        <div id="mycarousel" class="carousel slide" data-ride="carousel">
                                            <ol class="carousel-indicators">
                                                <%
                                                    If hasPictures = False Then
                                                %>
                                                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                                <li data-target="#myCarousel" data-slide-to="1"></li>
                                                <li data-target="#myCarousel" data-slide-to="2"></li>
                                                <li data-target="#myCarousel" data-slide-to="3"></li>
                                                <li data-target="#myCarousel" data-slide-to="4"></li>
                                                <li data-target="#myCarousel" data-slide-to="5"></li>
                                                <%
                                                Else
                                                    If picturesExists(0) = True Then
                                                        Response.Write("<li data-target='#myCarousel' data-slide-to='0' class='active'></li>")
                                                    End If
                                                            
                                                    If picturesExists(1) = True Then
                                                        Response.Write("<li data-target='#myCarousel' data-slide-to='1'></li>")
                                                    End If
                                                            
                                                    If picturesExists(2) = True Then
                                                        Response.Write("<li data-target='#myCarousel' data-slide-to='2'></li>")
                                                    End If
                                                            
                                                    If picturesExists(3) = True Then
                                                        Response.Write("<li data-target='#myCarousel' data-slide-to='3'></li>")
                                                    End If
                                                            
                                                    If picturesExists(4) = True Then
                                                        Response.Write("<li data-target='#myCarousel' data-slide-to='4'></li>")
                                                    End If
                                                            
                                                    If picturesExists(5) = True Then
                                                        Response.Write("<li data-target='#myCarousel' data-slide-to='5'></li>")
                                                    End If
                                                End If
                                                %>
                                            </ol>
                                            <div class="carousel-inner" role="listbox">
                                                <%
                                                    If hasPictures = True Then
                                                %>
                                                <div class="item active">
                                                    <asp:Image ID="Image1" runat="server" Height="300" Width="400"></asp:Image>
                                                </div>
                                                <%
                                                    If picturesExists(1) = True Then
                                                %>
                                                <div class="item">
                                                    <asp:Image ID="Image2" runat="server" Height="300" Width="400"></asp:Image>
                                                </div>
                                                <%
                                                End If
                                                %>
                                                <%
                                                    If picturesExists(2) = True Then
                                                %>
                                                <div class="item">
                                                    <asp:Image ID="Image3" runat="server" Height="300" Width="400"></asp:Image>
                                                </div>
                                                <%
                                                End If
                                                %>
                                                <%
                                                    If picturesExists(3) = True Then
                                                %>
                                                <div class="item">
                                                    <asp:Image ID="Image4" runat="server" Height="300" Width="400"></asp:Image>
                                                </div>
                                                <%
                                                End If
                                                %>
                                                <%
                                                    If picturesExists(4) = True Then
                                                %>
                                                <div class="item">
                                                    <asp:Image ID="Image5" runat="server" Height="300" Width="400"></asp:Image>
                                                </div>
                                                <%
                                                End If
                                                %>
                                                <%
                                                    If picturesExists(5) = True Then
                                                %>
                                                <div class="item">
                                                    <asp:Image ID="Image6" runat="server" Height="300" Width="400"></asp:Image>
                                                </div>
                                                <%
                                                End If
                                                %>
                                                <%
                                                Else
                                                %>
                                                <div class="item active">
                                                    <img src="../img/houseDefault.jpg" alt="House" style='width: 300px; height: 400px;' />
                                                </div>
                                                <div class="item">
                                                    <img src="../img/houseDefault.jpg" alt="House" style='width: 300px; height: 400px' />
                                                </div>
                                                <div class="item">
                                                    <img src="../img/houseDefault.jpg" alt="House" style='width: 300px; height: 400px' />
                                                </div>
                                                <div class="item">
                                                    <img src="../img/houseDefault.jpg" alt="House" style='width: 300px; height: 400px' />
                                                </div>
                                                <div class="item">
                                                    <img src="../img/houseDefault.jpg" alt="House" style='width: 300px; height: 400px' />
                                                </div>
                                                <div class="item">
                                                    <img src="../img/houseDefault.jpg" alt="House" style='width: 300px; height: 400px' />
                                                </div>
                                                <%
                                                End If
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-phone" aria-hidden="true"></i>&nbsp;Landlord Contact</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <span class="input-group-addon">Name</span>
                                                <input type="text" class="form-control" placeholder=" <% Response.Write(personOfContact)%> " disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-phone"></span></span>
                                                <span class="input-group-addon">Number</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(personToContactPhoneNumber)%>" disabled="disabled" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-info"></i>&nbsp;Basic Property Info</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-piggy-bank">
                                                </span></span><span class="input-group-addon">Deposit</span>
                                                <input type="text" class="form-control" placeholder=" <% Response.Write(Math.Round(deposit, 2))%> " disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span>
                                                </span><span class="input-group-addon">Property Type</span>
                                                <input type="text" class="form-control" placeholder=" <% Response.Write(propertyType)%> " disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span>
                                                </span><span class="input-group-addon">Unit Type</span>
                                                <input type="text" class="form-control" id="Text2" placeholder="<% Response.Write(unitType)%>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar">
                                                </span></span><span class="input-group-addon">Date Available</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(dateAvailableToRent) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-cog"></span>
                                                </span><span class="input-group-addon">Pets Permitted</span>
                                                <%
                                                    If isPetsPermitted = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-piggy-bank">
                                                </span></span><span class="input-group-addon">Pet Deposit</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(Math.Round(petDeposit, 2)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span>
                                                </span><span class="input-group-addon">Occupant Ready</span>
                                                <%
                                                    If isPropertyReadyForOccupancy = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <label class="col-xs-12" for="TextArea">
                                                <h4>
                                                    Property Description</h4>
                                            </label>
                                            <textarea class="form-control" placeholder="<% Response.Write(description) %>" cols="5"
                                                rows="5" disabled="disabled"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                                        <div class="list-group-item">
                                            <h4 class="text-center">
                                                <i class="fa fa-money"></i>&nbsp;Owner Pays</h4>
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-flash">
                                                </span></span><span class="input-group-addon">Electric</span>
                                                <%
                                                    If utilityElectric = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tint"></span>
                                                </span><span class="input-group-addon">Water</span>
                                                <%
                                                    If utilityWater = "True" Then
                                                        Response.Write("<input type='text' class='form-control'  placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled'/>")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control'  placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-cloud">
                                                </span></span><span class="input-group-addon">Gas</span>
                                                <%
                                                    If utilityGas = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <h4 class="text-center">
                                        <i class="fa fa-usb"></i>&nbsp;Amenities</h4>
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <h4 class="text-center">
                                                <i class="fa fa-home"></i>&nbsp;Indoor <em>(included)</em>
                                            </h4>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                                <span class="input-group-addon">Central Air/Heat</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(0)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                                <span class="input-group-addon">Washer</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(1)) %>" disabled="disabled"/>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                                <span class="input-group-addon">Dryer</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(2)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                                <span class="input-group-addon">Alarm</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(3)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                                <span class="input-group-addon">Washer/Dryer Hookups</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(4)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                                <span class="input-group-addon">Ceiling Fans</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(5)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <h4 class="text-center">
                                                <i class="fa fa-cutlery"></i>&nbsp;Kitchen <em>(included)</em>
                                            </h4>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-cutlery"></span>
                                                </span><span class="input-group-addon">Dishwasher</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(6)) %>" disabled="disabled"/>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-cutlery"></span>
                                                </span><span class="input-group-addon">Refrigerator</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(7)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-cutlery"></span>
                                                </span><span class="input-group-addon">Garbage Disposal</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(8)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-cutlery"></span>
                                                </span><span class="input-group-addon">Stove</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(15)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <h4 class="text-center">
                                                <i class="fa fa-road" aria-hidden="true"></i>&nbsp;Outdoor <em>(included)</em>
                                            </h4>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-road"></span></span>
                                                <span class="input-group-addon">Off Street Parking</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(9)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-road"></span></span>
                                                <span class="input-group-addon">Covered Parking</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(10)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-road"></span></span>
                                                <span class="input-group-addon">Front Yard</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(11)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-road"></span></span>
                                                <span class="input-group-addon">Back Yard</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(12)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-road"></span></span>
                                                <span class="input-group-addon">Gated</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(13)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <h4 class="text-center">
                                                <i class="fa fa-th"></i>&nbsp;Miscellaneous <em>(included)</em>
                                            </h4>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                                <span class="input-group-addon">Onsite Security</span>
                                                <input type="text" class="form-control" placeholder="<% Response.Write(amentityResponses.Item(14)) %>" disabled="disabled" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-wheelchair"></i>&nbsp;Handicap Accessibility</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <h4 class="text-center">
                                                <i class="fa fa-arrows-alt"></i>&nbsp;Entry and Doorway <em>(included)</em>
                                            </h4>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-fullscreen"></span>
                                                </span><span class="input-group-addon">Parking Close to Home</span>
                                                <%
                                                    If isAccessibleParkingCloseToHome = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-fullscreen"></span>
                                                </span><span class="input-group-addon">Ramped Entry</span>
                                                <%
                                                    If isRampedEntry = "True" Then
                                                        Response.Write("<input type='text' class='form-control'  placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-fullscreen"></span>
                                                </span><span class="input-group-addon">Doorways 32" Inches/Wider</span>
                                                <%
                                                    If isDoorways32InchesWider = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-fullscreen"></span>
                                                </span><span class="input-group-addon" id="Span62">Path to/and in Home 32" Inches/Wider</span>
                                                <%
                                                    If isAccessiblePathToAndInHome32InchesWider = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-fullscreen"></span>
                                                </span><span class="input-group-addon">Automatic Entry Door</span>
                                                <%
                                                    If isAutomaticEntryDoor = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <h4 class="text-center">
                                                <i class="fa fa-cutlery"></i>&nbsp;Kitchen <em>(included)</em>
                                            </h4>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-cutlery"></span>
                                                </span><span class="input-group-addon">Low Counter or Sink/Below 34" Inches</span>
                                                <%
                                                    If isLowCounterSinkAtBelow34Inches = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-cutlery"></span>
                                                </span><span class="input-group-addon">Accessible Appliances</span>
                                                <%
                                                    If isAccessibleAppliances = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <h4 class="text-center">
                                                <i class="fa fa-btc"></i>&nbsp;Bathroom <em>(included)</em>
                                            </h4>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-xbt"></span></span>
                                                <span class="input-group-addon">Shower/Tub Grab Bars</span>
                                                <%
                                                    If isShowerTubGrabBars = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-xbt"></span></span>
                                                <span class="input-group-addon">Roll in Showers</span>
                                                <%
                                                    If isRollInShower = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-xbt"></span></span>
                                                <span class="input-group-addon">Hand Held Shower Sprayer</span>
                                                <%
                                                    If isHandHeldShowerSprayer = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control'  placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-xbt"></span></span>
                                                <span class="input-group-addon">Fixed Seat in Shower/Tub</span>
                                                <%
                                                    If isFixedSeatInShowerTub = "True" Then
                                                        Response.Write("<input type='text' class='form-control' placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control' placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-xbt"></span></span>
                                                <span class="input-group-addon">Raised Tiolet</span>
                                                <%
                                                    If isRaisedToilet = "True" Then
                                                        Response.Write("<input type='text' class='form-control'  placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control'  placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-xbt"></span></span>
                                                <span class="input-group-addon">First Floor Bathroom</span>
                                                <%
                                                    If isFirstFloorBathroom = "True" Then
                                                        Response.Write("<input type='text' class='form-control'  placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control'  placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <h4 class="text-center">
                                                <i class="fa fa-th"></i>&nbsp;Miscellaneous <em>(included)</em>
                                            </h4>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                                                <span class="input-group-addon">Lift/Elevator</span>
                                                <%
                                                    If isLiftElevator = "True" Then
                                                        Response.Write("<input type='text' class='form-control'  placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control'  placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                                                <span class="input-group-addon">Audio/Visual Doorbell</span>
                                                <%
                                                    If isAudioVisualDoorbell = "True" Then
                                                        Response.Write("<input type='text' class='form-control'  placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control'  placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                                                <span class="input-group-addon">Audio/Visual Smoke/Fire Alarm</span>
                                                <%
                                                    If isAudioVisualSmokeFireAlarm = "True" Then
                                                        Response.Write("<input type='text' class='form-control'  placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control'  placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                                                <span class="input-group-addon">First Floor Bedroom</span>
                                                <%
                                                    If isFirstFloorBedroom = "True" Then
                                                        Response.Write("<input type='text' class='form-control'  placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control'  placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                                                <span class="input-group-addon">Elevator Access</span>
                                                <%
                                                    If isElevatorAccess = "True" Then
                                                        Response.Write("<input type='text' class='form-control'  placeholder='Yes' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    Else
                                                        Response.Write("<input type='text' class='form-control'  placeholder='No' aria-describedby='sizing-addon3' disabled='disabled' />")
                                                    End If
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

