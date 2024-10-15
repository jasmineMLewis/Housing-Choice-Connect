<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="AdminSoonToBeDeletedProperties.aspx.vb" Inherits="HousingChoiceConnect.AdminProximityProperties" %>

<%@ Import Namespace="System.Web.Hosting" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim userID As String

        If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
            userID = Web.HttpContext.Current.Session("UserID").ToString()
        End If
    
        If userID = Nothing Then
            userID = Request.QueryString("UserID")
            Web.HttpContext.Current.Session("UserID") = userID
        End If
        
        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-battery-quarter fa-fw"></i>&nbsp; Soon To Be Deleted Properties
                    </h1>
                </div>
            </div>
            <div class="row">
                <%
                    Dim properties As Integer
                    conn.Open()
                    Dim queryProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countSoon FROM LandlordProperty WHERE [DateLastUpdated] < DATEADD(day, -90, GETDATE())", conn)
                    Dim readerProperties As SqlDataReader = queryProperties.ExecuteReader()
                    While readerProperties.Read
                        properties = CStr(readerProperties("countSoon"))
                    End While
                    conn.Close()
                %>
                <div class="col-lg-12">
                    <div class="panel panel-danger">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-battery-quarter fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(properties)%></div>
                                    <div>
                                        Soon To Be Deletd Properties</div>
                                </div>
                            </div>
                        </div>
                        <a href="#" class="text-danger">
                            <div class="panel-footer">
                                <span class="pull-left">Soon To Be Deleted Properties</span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-search fa-fw"></i>&nbsp;Property Search
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-danger">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-search"></i>&nbsp;Property Search
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-map-marker"></span>
                                                </span>
                                                <asp:DropDownList ID="PropertyAddress" runat="server" CssClass="selectpicker" DataSourceID="SqlPropertyAddress"
                                                    DataTextField="AddressProperty" DataValueField="LandlordPropertyID">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlPropertyAddress" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT LandlordPropertyID, AddressProperty FROM LandlordProperty WHERE DateLastUpdated < DATEADD(day, -90, GETDATE()) ORDER BY AddressProperty ASC">
                                                </asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-qrcode"></span>
                                                </span>
                                                <asp:DropDownList ID="ZipCode" runat="server" CssClass="selectpicker" DataSourceID="SqlZipCode"
                                                    DataTextField="ZipCode" DataValueField="ZipCode">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlZipCode" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT DISTINCT ZipCode FROM Neighborhood"></asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon" id="Span4"><span class="glyphicon glyphicon-bed"></span>
                                                </span>
                                                <asp:DropDownList ID="Bedroom" runat="server" CssClass="selectpicker">
                                                    <asp:ListItem Enabled="true" Text="Bedroom" Value="-1"></asp:ListItem>
                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="list-group-item text-center">
                                            <button id="button" type="button" class="btn btn-danger btn-block btn-lg" runat="server"
                                                onserverclick="BtnFilterProperties">
                                                <i class="fa fa-search"></i>&nbsp;Property Search
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-battery-quarter fa-fw"></i>&nbsp; Soon To Be Deleted Properties
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-danger">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-battery-quarter fa-fw"></i>&nbsp; Soon To Be Deleted Properties</h3>
                                </div>
                                <div class="panel-body">
                                    <asp:SqlDataSource ID="sqlProperties" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                          SelectCommand="SELECT LandlordPropertyID, RTRIM([AddressProperty] + ' ' + [Apt_Suite]) As &quot;Address&quot;,
                                                                Rent, BedroomNumber AS Bed, BathroomNumber As Bath, ZipCode,
                                                                CONVERT (varchar(MAX), CAST(LandlordProperty.DateOfPostage AS date), 101) AS DateOfPostage, 
                                                                CONVERT (varchar(MAX), CAST(LandlordProperty.DateLastUpdated AS date), 101) AS DateLastUpdated,
                                                                PersonOfContact As Landlord, PersonToContactPhoneNumber As LandlordNumber 
                                                        FROM LandlordProperty 
                                                        INNER JOIN Neighborhood ON LandlordProperty.fk_NeighborhoodID = Neighborhood.NeighborhoodID 
                                                        WHERE DateLastUpdated < DATEADD(day, -90, GETDATE()) ORDER BY ZipCode, Bed ASC">
                                    </asp:SqlDataSource>
                                    <div class="table-responsive">
                                        <asp:GridView ID="GridViewProperties" runat="server" CssClass="table" AutoGenerateColumns="False"
                                            DataKeyNames="LandlordPropertyID, Address" GridLines="None" DataSourceID="sqlProperties"
                                            AllowPaging="True" PageSize="20" PagerStyle-CssClass="bs-pagination text-center">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Address">
                                                    <ItemTemplate>
                                                        <%# DisplayViewLink(Eval("LandlordPropertyID"), Eval("Address"))%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ZipCode" HeaderText="Zip Code" SortExpression="ZipCode" />
                                                <asp:BoundField DataField="Rent" HeaderText="Rent" SortExpression="Rent" />
                                                <asp:BoundField DataField="Bed" HeaderText="Bed" SortExpression="Bed" />
                                                <asp:BoundField DataField="Bath" HeaderText="Bath" SortExpression="Bath" />
                                                <asp:BoundField DataField="DateOfPostage" HeaderText="Date Posted" SortExpression="DateOfPostage" /> 
                                                <asp:BoundField DataField="DateLastUpdated" HeaderText="Date Last Updated" SortExpression="DateLastUpdated" /> 
                                                <asp:BoundField DataField="Landlord" HeaderText="Landlord" SortExpression="Landlord" />
                                                <asp:BoundField DataField="LandlordNumber" HeaderText="Landlord Number" SortExpression="LandlordNumber" />
                                                <asp:TemplateField HeaderText="Activate">
                                                    <ItemTemplate>
                                                        <%# DisplayActivateLink(Eval("LandlordPropertyID"))%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete">
                                                    <ItemTemplate>
                                                        <%# DisplayDeleteLink(Eval("LandlordPropertyID"))%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Edit">
                                                    <ItemTemplate>
                                                        <%# DisplayEditLink(Eval("LandlordPropertyID"))%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
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
