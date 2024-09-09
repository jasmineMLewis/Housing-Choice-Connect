<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="AdminAddProperty.aspx.vb" Inherits="HousingChoiceConnect.AdminAddProperty" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim userID As String = Session("UserID")
        If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
            userID = Web.HttpContext.Current.Session("UserID").ToString()
        End If

        If userID = Nothing Then
            userID = Request.QueryString("UserID")
            Web.HttpContext.Current.Session("UserID") = userID
        End If
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-plus fa-fw"></i>Add NEW Property</h1>
                </div>
            </div>
            <div class="alert alert-warning text-center" role="alert">
                Click on the linked heading text to expand or collapse accordion panels.</div>
            <form id="multiphase" enctype="multipart/form-data" onsubmit="return false">
            <div class="row">
                <div class="panel-group col-lg-12" id="accordion">
                    <%-- Landlord Account--%>
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseLandlordAccount"><i
                                    class="fa fa-user"></i>&nbsp; Landlord Account</a>
                            </h4>
                        </div>
                        <div id="collapseLandlordAccount" class="panel-collapse collapse in">
                            <div class="panel-body text-center">
                                <div class="panel panel-success">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">
                                            <i class="fa fa-user"></i>&nbsp; Landlord Account</h3>
                                    </div>
                                    <div class="panel-body">
                                        <div class="list-group">
                                            <div class="list-group-item">
                                                <div class="input-group input-group-lg">
                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                    <asp:DropDownList ID="FullDescrp" runat="server" CssClass="selectpicker" DataSourceID="SqlFullDescrp"
                                                        DataTextField="FullDescrp" DataValueField="UserID">
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="SqlFullDescrp" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                        SelectCommand="SELECT UserID, FirstName + ' ' + LastName  + ' :: ' + Email As FullDescrp 
                                                                       FROM Users 
                                                                       WHERE RoleID = '3' 
                                                                       ORDER BY FullDescrp ASC">
                                                    </asp:SqlDataSource>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Property Location--%>
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapsePropertyLocation">
                                    <i class="fa fa-map-marker"></i>&nbsp; Property Location</a>
                            </h4>
                        </div>
                        <div id="collapsePropertyLocation" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-map-marker"></i>&nbsp; Property Location</h3>
                                    </div>
                                    <div class="panel-body">
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-map-marker">
                                            </span></span>
                                            <input type="text" id="address" name="address" class="form-control" placeholder="Physical Street Address (Do NOT include City, State or Zip Code) *"
                                                maxlength="30" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span>
                                            </span>
                                            <input type="text" id="aptOrSuite" name="aptOrSuite" class="form-control" placeholder="Apt Number or Suite"
                                                maxlength="15" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-globe">
                                            </span></span>
                                            <asp:DropDownList ID="Neighborhood" runat="server" CssClass="selectpicker" DataSourceID="SqlNeighborhood"
                                                DataTextField="Neighborhood" DataValueField="NeighborhoodID">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlNeighborhood" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                SelectCommand="SELECT DISTINCT Neighborhood, NeighborhoodID 
                                                               FROM Neighborhood 
                                                               ORDER BY Neighborhood">
                                            </asp:SqlDataSource>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Basic Property Info--%>
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseBasicPropertyInfo">
                                    <i class="fa fa-info"></i>&nbsp; Basic Property Info</a>
                            </h4>
                        </div>
                        <div id="collapseBasicPropertyInfo" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-info"></i>&nbsp; Basic Property Info</h3>
                                    </div>
                                    <div class="panel-body table-responsive">
                                        <div class="form-inline text-center">
                                            <div class="input-group input-group-lg inputFormat col-sm-4">
                                                <span class="input-group-addon">$</span>
                                                <input type="text" class="form-control" id="rent" name="rent" placeholder="Rent *"
                                                    maxlength="4" required="requried" />
                                                <span class="input-group-addon">.00</span>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat col-sm-4">
                                                <span class="input-group-addon">$</span>
                                                <input type="text" class="form-control" id="deposit" name="deposit" placeholder="Deposit *"
                                                    maxlength="4" required="requried" />
                                                <span class="input-group-addon">.00</span>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat col-sm-3">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                                <input type="text" id="dateAvailableToRent" name="dateAvailableToRent" class="form-control"
                                                    placeholder="Date Available To Rent *" maxlength="10" required="requried" />
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
                                                    DataTextField="Property" DataValueField="PropertyTypeID">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlPropertyType" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT Property, PropertyTypeID 
                                                                   FROM Property">
                                                </asp:SqlDataSource>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat col-sm-3">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span>
                                                <asp:DropDownList ID="UnitType" runat="server" CssClass="selectpicker" DataSourceID="SqlUnitType"
                                                    DataTextField="Unit" DataValueField="UnitTypeID">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlUnitType" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT Unit, UnitTypeID
                                                                   FROM UnitType">
                                                </asp:SqlDataSource>
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
                                                            <input type="radio" name="petsPermitted" value="Yes" /></div>
                                                    </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <input type="radio" name="petsPermitted" value="No" /></div>
                                                    </td>
                                                    <td>
                                                        <div class="input-group input-group-sm propertyFormat">
                                                            <span class="input-group-addon">$</span>
                                                            <input type="text" class="form-control" aria-label="Amount (to the nearest dollar)"
                                                                id="petDeposit" name="petDeposit" placeholder="Deposit (i.e. 123)" maxlength="4" />
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
                                                            <input type="radio" name="readyForOccupancy" value="Yes" /></div>
                                                    </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <input type="radio" name="readyForOccupancy" value="No" /></div>
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
                                                name="description" id="description" maxlength="140"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--  Utilities & Amenities--%>
                    <div class="panel panel-default">
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
                                    <div class="panel-body table-responsive">
                                        <h4 class="text-center">
                                            <i class="fa fa-usb"></i>&nbsp;Utilities</h4>
                                        <div class="list-group table-responsive">
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
                                                                <i>Electric*</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="utilityElectric" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="utilityElectric" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Water*</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="utilityWater" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="utilityWater" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Gas*</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="utilityGas" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="utilityGas" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <h4 class="text-center">
                                            <i class="fa fa-usb" aria-hidden="true"></i>&nbsp; Amenities</h4>
                                        <div class="list-group">
                                            <div class="list-group-item">
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
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityCentralAirHeat"
                                                                        value="1" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Washer</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityWasher" value="2" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Dryer</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityDryer" value="3" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Alarm</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityAlarm" value="4" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Washer/Dryer Hookups</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityWasherDryerHookups"
                                                                        value="5" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Ceiling Fans</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityCeilingFans" value="6" /></div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="list-group-item">
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
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityDishwasher" value="7" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Refrigerator</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityRefrigerator"
                                                                        value="8" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Garbage Disposal</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityGarbageDisposal"
                                                                        value="9" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Stove</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityStove"
                                                                        value="16" /></div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="list-group-item">
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
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityOffStreetParking"
                                                                        value="10" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Covered Parking</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityCoveredParking"
                                                                        value="11" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Front Yard</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityFrontYard" value="12" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Back Yard</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityBackYard" value="13" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Gated</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityGated" value="14" /></div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="list-group-item">
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
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="amentityOnsiteSecurity"
                                                                        value="15" /></div>
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
                    <div class="panel panel-default">
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
                                    <div class="panel-body table-responsive">
                                        <div class="list-group table-responsive">
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
                                                                    <input type="radio" name="handicapParkingClose" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="handicapParkingClose" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Ramped Entry</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="rampedEntry" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="rampedEntry" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Doorways 32" Inches or Wider</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="doorways32InchesOrWider" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="doorways32InchesOrWider" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Accessible Path to/and in Home 32" Inches or Wider</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="accessiblePathIn32InchesOrWider" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="accessiblePathIn32InchesOrWider" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Automatic Entry Door</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="automaticEntryDoor" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="automaticEntryDoor" value="No" /></div>
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
                                                                    <input type="radio" name="lowCounterOrSinkBelow34Inches" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="lowCounterOrSinkBelow34Inches" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Accessible Appliances</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="accessibleAppliances" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="accessibleAppliances" value="No" /></div>
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
                                                                    <input type="radio" name="showerOrTubGrabBars" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="showerOrTubGrabBars" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Roll in Showers</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="rollInShowers" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="rollInShowers" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Hand Held Shower Sprayer</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="handHeldShowerSprayer" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="handHeldShowerSprayer" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Fixed Seat in Shower or Tub</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="fixedSeatInShowerOrTub" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="fixedSeatInShowerOrTub" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Raised Tiolet</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="raisedTiolet" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="raisedTiolet" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>First Floor Bathroom</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="firstFloorBathroom" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="firstFloorBathroom" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <!-- /.table -->
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
                                                                    <input type="radio" name="liftOrElevator" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="liftOrElevator" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Audio or Visual Doorbell</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="audioOrVisualDoorbell" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="audioOrVisualDoorbell" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Audio or Visual Smoke or Fire Alarm</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="audioOrVisualSmokeOrFireAlarm" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="audioOrVisualSmokeOrFireAlarm" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>First Floor Bedroom</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="firstFloorBedroom" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="firstFloorBedroom" value="No" /></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <i>Elevator Access</i>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="elevatorAccess" value="Yes" /></div>
                                                            </td>
                                                            <td>
                                                                <div class="input-group">
                                                                    <input type="radio" name="elevatorAccess" value="No" /></div>
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
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapsePictures"><i class="fa fa-picture-o"
                                    aria-hidden="true"></i>&nbsp; Pictures</a>
                            </h4>
                        </div>
                        <div id="collapsePictures" class="panel-collapse collapse">
                            <div class="panel-body table-responsive">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-picture-o" aria-hidden="true"></i>&nbsp; Pictures</h3>
                                    </div>
                                    <div class="panel-body table-responsive">
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span15"><span class="glyphicon glyphicon-picture">
                                            </span></span>
                                            <asp:FileUpload ID="picture1" name="picture1" runat="server" class="form-control"
                                                aria-describedby="sizing-addon7" accept="image/*" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span3"><span class="glyphicon glyphicon-picture">
                                            </span></span>
                                            <asp:FileUpload ID="picture2" name="picture2" runat="server" class="form-control"
                                                aria-describedby="sizing-addon7" accept="image/*" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span4"><span class="glyphicon glyphicon-picture">
                                            </span></span>
                                            <asp:FileUpload ID="picture3" name="picture3" runat="server" class="form-control"
                                                aria-describedby="sizing-addon7" accept="image/*" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span10"><span class="glyphicon glyphicon-picture">
                                            </span></span>
                                            <asp:FileUpload ID="picture4" name="picture4" runat="server" class="form-control"
                                                aria-describedby="sizing-addon7" accept="image/*" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span11"><span class="glyphicon glyphicon-picture">
                                            </span></span>
                                            <asp:FileUpload ID="picture5" name="picture5" runat="server" class="form-control"
                                                aria-describedby="sizing-addon7" accept="image/*" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span13"><span class="glyphicon glyphicon-picture">
                                            </span></span>
                                            <asp:FileUpload ID="picture6" name="picture6" runat="server" class="form-control"
                                                aria-describedby="sizing-addon7" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Contact Info--%>
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseContactInfo"><i
                                    class="fa fa-phone" aria-hidden="true"></i>&nbsp; Contact Info</a>
                            </h4>
                        </div>
                        <div id="collapseContactInfo" class="panel-collapse collapse">
                            <div class="panel-body table-responsive">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-phone" aria-hidden="true"></i>&nbsp; Contact Info</h3>
                                    </div>
                                    <div class="panel-body table-responsive">
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span18"><span class="glyphicon glyphicon-user"></span>
                                            </span>
                                            <input type="text" name="contactName" class="form-control" placeholder="Person of Contact Name*"
                                                aria-describedby="sizing-addon7" maxlength="50" required="required" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon" id="Span19"><span class="glyphicon glyphicon-phone">
                                            </span></span>
                                            <input type="text" name="contactNumber" class="form-control" placeholder="Person of Contact Number* (i.e. 5043407700)"
                                                aria-describedby="sizing-addon7" maxlength="10" required="required" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Add NEW Property--%>
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseAddProperty"><i
                                    class="fa fa-plus" aria-hidden="true"></i>&nbsp; Add NEW Property</a>
                            </h4>
                        </div>
                        <div id="collapseAddProperty" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="panel panel-success">
                                    <div class="panel-heading text-center">
                                        <h3 class="panel-title">
                                            <i class="fa fa-plus" aria-hidden="true"></i>&nbsp; Add NEW Property</h3>
                                    </div>
                                    <div class="panel-body table-responsive">
                                        <div class="text-center">
                                            <button id="button" type="button" class="btn btn-info btn-block btn-lg" runat="server"
                                                onserverclick="BtnAddProperty">
                                                <i class="fa fa-plus"></i>&nbsp; Add NEW Property
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
    <script type="text/javascript">
        $(document).ready(function () {
            $(".selectpicker").selectpicker();
        });
    </script>
</asp:Content>
