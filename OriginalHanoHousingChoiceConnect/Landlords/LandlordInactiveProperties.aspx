<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="LandlordInactiveProperties.aspx.vb" Inherits="HanoChoiceConnect.LandlordInactiveProperties" %>

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
                        <i class="fa fa-battery-empty fa-fw"></i>
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
                            Dim queryLandlord As New SqlCommand("SELECT FirstName,LastName FROM Users WHERE UserID='" & userID & "'", conn)
                            Dim readerLandlord As SqlDataReader = queryLandlord.ExecuteReader()

                            If readerLandlord.HasRows Then
                                While readerLandlord.Read
                                    firstName = CStr(readerLandlord("FirstName"))
                                    lastName = CStr(readerLandlord("LastName"))
                                End While
                                conn.Close()
                            End If
                            
                            If userSessionRoleID = 1 Then
                                Response.Write(firstName & " " & lastName & "'s")
                            End If
                        %>
                        Inactive Properties
                    </h1>
                </div>
            </div>
            <div class="row">
                <%
                    Dim inactiveProperties As Integer
                    conn.Open()
                    Dim queryInactiveProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countInactive FROM LandlordProperty WHERE fk_UserID='" & userID & "' AND IsActive = 0", conn)
                    Dim readerInactiveProperties As SqlDataReader = queryInactiveProperties.ExecuteReader()
                    While readerInactiveProperties.Read
                        inactiveProperties = CStr(readerInactiveProperties("countInactive"))
                    End While
                    conn.Close()
                %>
                <div class="col-lg-12 col-md-6">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-battery-empty fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(inactiveProperties)%></div>
                                    <div>
                                        Inactive Properties</div>
                                </div>
                            </div>
                        </div>
                        <a href="#" class="text-info">
                            <div class="panel-footer">
                                <span class="pull-left">View Inactive Properties</span>
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
                            <div class="panel panel-info">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-list-ol" aria-hidden="true"></i>&nbsp;Stats</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <a class="list-group-item" href="#">Total Inactive Properties <span class="badge">
                                            <%  Response.Write(inactiveProperties)%></span> </a>
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
                            <div class="panel panel-info">
                                <div class="panel-heading text-center">
                                    <i class="fa fa-home"></i>&nbsp;Properties
                                </div>
                                <div class="panel-body">
                                    <asp:SqlDataSource ID="sqlProperties" runat="server" ConnectionString="<%$ ConnectionStrings:HanoChoiceConnectConnectionString %>"
                                        SelectCommand="SELECT LandlordPropertyID, RTRIM([AddressProperty] + ' ' + [Apt_Suite]) As &quot;Address&quot;,
                                                            Rent, BedroomNumber AS Bed, BathroomNumber As Bath, ZipCode,
                                                            convert(varchar(max), cast([DateOfPostage] as date), 101) As DateOfPostage,
                                                            convert(varchar(max), cast([DateOfInactivation] as date), 101) As DateOfInactivation
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
                                                <asp:BoundField DataField="DateOfPostage" HeaderText="Date Posted" SortExpression="DateOfPostage" />
                                                <asp:BoundField DataField="DateOfInactivation" HeaderText="Date Of Inactivation" SortExpression="DateOfInactivation" />
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
