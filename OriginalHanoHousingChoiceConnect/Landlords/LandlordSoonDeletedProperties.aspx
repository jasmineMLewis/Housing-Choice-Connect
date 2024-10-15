<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="LandlordSoonDeletedProperties.aspx.vb" Inherits="HanoChoiceConnect.LandlordProximityProperties" %>

<%@ Import Namespace="System.Web.Hosting" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
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
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-battery-full fa-fw"></i>
                        <%
                            Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01;MultipleActiveResultSets=true")
                            conn.Open()
                            Dim userSessionRoleID As Integer
                            Dim queryUserSessionRole As New SqlCommand("SELECT fk_RoleID FROM Users WHERE UserID='" & Web.HttpContext.Current.Session("UserID").ToString() & "'", conn)
                            Dim readerUserSessionRole As SqlDataReader = queryUserSessionRole.ExecuteReader()
                            If readerUserSessionRole.HasRows Then
                                While readerUserSessionRole.Read
                                    userSessionRoleID = CStr(readerUserSessionRole("fk_RoleID"))
                                End While
                                conn.Close()
                            End If
                            
                            Dim firstName As String
                            Dim lastName As String
                            conn.Open()
                            Dim queryLandlord As New SqlCommand("SELECT FirstName, LastName FROM Users WHERE UserID='" & userID & "'", conn)
                            Dim readerLandlord As SqlDataReader = queryLandlord.ExecuteReader()

                            If readerLandlord.HasRows Then
                                While readerLandlord.Read
                                    firstName = CStr(readerLandlord("FirstName"))
                                    lastName = CStr(readerLandlord("LastName"))
                                End While
                                conn.Close()
                            End If
                            
                            Const ADMIN_ROLE_ID As Integer = 1
                            If userSessionRoleID = ADMIN_ROLE_ID Then
                                Response.Write(firstName & " " & lastName & "'s")
                            End If
                        %>
                        Soon to be Deleted Properties
                    </h1>
                </div>
            </div>
            <div class="row">
                <%
                    Dim soonToBeDeletedProperties As Integer
                    conn.Open()
                    Dim querySoonToBeDeletedProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countSoonToBeDeleted FROM LandlordProperty WHERE [fk_UserID] = '" & userID & "' AND [DateLastUpdated] < DATEADD(day, -90, GETDATE())", conn)
                    Dim readerSoonToBeDeletedProperties As SqlDataReader = querySoonToBeDeletedProperties.ExecuteReader()
                    While readerSoonToBeDeletedProperties.Read
                        soonToBeDeletedProperties = CStr(readerSoonToBeDeletedProperties("countSoonToBeDeleted"))
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
                                        <% Response.Write(soonToBeDeletedProperties)%></div>
                                    <div>
                                        Soon To Be Deleted Properties</div>
                                </div>
                            </div>
                        </div>
                        <a href="#" class="text-danger">
                            <div class="panel-footer">
                                <span class="pull-left">View Soon To Be Deleted Properties</span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-list-ol" aria-hidden="true"></i>&nbsp;Stats
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-danger">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-list-ol" aria-hidden="true"></i>&nbsp;Stats</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <a class="list-group-item" href="#">Total Soon To Be Deleted Properties <span class="badge">
                                            <%  Response.Write(soonToBeDeletedProperties)%></span> </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-home"></i>&nbsp;Properties
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-danger">
                                <div class="panel-heading text-center">
                                    <i class="fa fa-home"></i>&nbsp;Properties
                                </div>
                                <div class="panel-body">
                                    <asp:SqlDataSource ID="sqlProperties" runat="server" ConnectionString="<%$ ConnectionStrings:HanoChoiceConnectConnectionString %>"
                                        SelectCommand="SELECT LandlordPropertyID, RTRIM([AddressProperty] + ' ' + [Apt_Suite]) As &quot;Address&quot;,
                                                      Rent, BedroomNumber AS Bed, BathroomNumber As Bath, ZipCode
                                               FROM LandlordProperty 
                                               INNER JOIN Neighborhood ON LandlordProperty.fk_NeighborhoodID = Neighborhood.NeighborhoodID">
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
