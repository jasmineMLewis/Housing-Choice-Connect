<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="Landlords.aspx.vb" Inherits="HousingChoiceConnect.Landlords" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim sessionUserID As String = Session("SessionUserID")

        If Not Web.HttpContext.Current.Session("SessionUserID") Is Nothing Then
            sessionUserID = Web.HttpContext.Current.Session("SessionUserID").ToString()
        End If

        If sessionUserID = Nothing Or String.IsNullOrEmpty(sessionUserID) Then
            sessionUserID = Request.QueryString("SessionUserID")
            Web.HttpContext.Current.Session("SessionUserID") = sessionUserID
        End If

        Const LANDLORD_ROLE_ID As Integer = 3

        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-home fa-fw"></i>Landlords
                    </h1>
                </div>
            </div>
            <div class="row">
                <%
                    Dim numOfLandlords As Integer
                    conn.Open()
                    Dim queryLandlords As New SqlCommand("SELECT COUNT(UserID) AS countLandlords 
                                                          FROM [Security].[UserRole] 
                                                          WHERE RoleID = '" & LANDLORD_ROLE_ID & "'", conn)
                    Dim readerLandlords As SqlDataReader = queryLandlords.ExecuteReader()
                    While readerLandlords.Read
                        numOfLandlords = CStr(readerLandlords("countLandlords"))
                    End While
                    conn.Close()
                %>
                <div class="col-lg-12">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-home fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(numOfLandlords)%></div>
                                    <div>
                                        Landlords</div>
                                </div>
                            </div>
                        </div>
                        <a href="#" class="text-success">
                            <div class="panel-footer">
                                <span class="pull-left">Landlords</span>
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
                            <i class="fa fa-search fa-fw"></i>&nbsp;Landlord Search
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-search"></i>&nbsp;Landlord Search
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <asp:DropDownList ID="FullName" runat="server" CssClass="selectpicker" DataSourceID="SqlFullName"
                                                    DataTextField="FullName" DataValueField="UserID">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlFullName" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT Users.UserID, (FirstName + ' ' + LastName) As FullName 
                                                                    FROM [Security].[User] AS Users
                                                                    INNER JOIN [Security].[UserRole] As UserRoles ON Users.UserID = UserRoles.UserID
                                                                    WHERE UserRoles.RoleID = '3' 
                                                                    ORDER BY FullName ASC">
                                                </asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <div class="list-group-item">
                                            <div class="input-group input-group-lg">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span>
                                                </span>
                                                <asp:DropDownList ID="Email" runat="server" CssClass="selectpicker" DataSourceID="SqlEmail"
                                                    DataTextField="Email" DataValueField="Email">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlEmail" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT Email 
                                                                   FROM [Security].[User] AS Users
                                                                   INNER JOIN [Security].[UserRole] As UserRoles ON Users.UserID = UserRoles.UserID
                                                                   WHERE UserRoles.RoleID = '3' 
                                                                   ORDER BY Email ASC">
                                                </asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <div class="list-group-item text-center">
                                            <button id="button" type="button" class="btn btn-success btn-block btn-lg" runat="server"
                                                onserverclick="btnSearchLandlord">
                                                <i class="fa fa-search"></i>&nbsp;Search Landlord
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
                            <i class="fa fa-home fa-fw"></i>Landlords
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-home"></i>&nbsp; Landlords</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group table-responsive">
                                        <asp:SqlDataSource ID="sqlGridViewLandlords" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                            SelectCommand="SELECT Users.UserID, FirstName + ' ' + LastName AS FullName, Email,
                                                                   IsEmailVerified, DateRegistered, LastLogin,
		                                                           (SELECT COUNT(LandlordPropertyID) AS CountLandlordActive 
	                                                                FROM [Landlord].[Property]
		                                                            WHERE ([Landlord].[Property].UserID = Users.UserID) AND IsActive = '1') AS CountActive,
		                                                           (SELECT COUNT(LandlordPropertyID) AS CountLandlordInactive 
		                                                            FROM [Landlord].[Property]
		                                                            WHERE ([Landlord].[Property].UserID = Users.UserID) AND IsActive = '0') AS CountInactive,
		                                                           (SELECT COUNT(LandlordPropertyID) AS CountSoonToBeDeleted 
		                                                            FROM [Landlord].[Property]
		                                                            WHERE ([Landlord].[Property].UserID = Users.UserID) AND 
			                                                               DateLastUpdated  &lt; DATEADD(day, - 90, GETDATE())) AS CountSoonToBeDeleted 
                                                           FROM [Security].[User] AS Users
                                                           INNER JOIN [Security].[UserRole] As UserRoles ON Users.UserID = UserRoles.UserID
                                                           WHERE RoleID = '3'
                                                           ORDER BY FullName">
                                        </asp:SqlDataSource>
                                        <asp:GridView ID="GridViewLandlords" runat="server" AutoGenerateColumns="False" CssClass="table"
                                            DataKeyNames="UserID" DataSourceID="sqlGridViewLandlords" AllowPaging="True"
                                            BorderStyle="None" GridLines="None" PageSize="9" 
                                            PagerStyle-CssClass="bs-pagination text-center">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                                    <ItemTemplate>
                                                        <%# DisplayNameLink(Eval("UserID"), Eval("FullName"), Request.QueryString("SessionUserID"))%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                                <asp:BoundField DataField="IsEmailVerified" HeaderText="Email Verified" SortExpression="IsEmailVerified" />
                                                <asp:BoundField DataField="DateRegistered" HeaderText="Date Registered" DataFormatString="{0:MM/dd/yyyy}" SortExpression="DateRegistered" />
                                                <asp:BoundField DataField="LastLogin" HeaderText="Last Login" DataFormatString="{0:MM/dd/yyyy}"  SortExpression="LastLogin" />
                                                <asp:BoundField DataField="CountActive" HeaderText="Active"  SortExpression="CountActive" />
                                                <asp:BoundField DataField="CountInactive" HeaderText="Inactive" SortExpression="CountInactive" />
                                                <asp:BoundField DataField="CountSoonToBeDeleted" HeaderText="Soon To Be Deleted" SortExpression="CountSoonToBeDeleted" />
                                                <asp:TemplateField HeaderText="Edit">
                                                    <ItemTemplate>
                                                        <%# DisplayEditLink(Eval("UserID"), Request.QueryString("SessionUserID"))%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete">
                                                    <ItemTemplate>
                                                        <%# DisplayDeleteLink(Eval("UserID"), Request.QueryString("SessionUserID"))%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerStyle CssClass="bs-pagination text-center"></PagerStyle>
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
