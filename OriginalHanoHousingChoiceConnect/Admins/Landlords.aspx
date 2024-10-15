<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="Landlords.aspx.vb" Inherits="HanoChoiceConnect.Landlords" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Data.SqlClient" %>
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
        
        Const LANDLORD_ROLE_ID As Integer = 5
        Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")
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
                    Dim queryLandlords As New SqlCommand("SELECT COUNT(UserID) AS countLandlords FROM Users WHERE fk_RoleID = '" & LANDLORD_ROLE_ID & "'", conn)
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
                                                <asp:SqlDataSource ID="SqlFullName" runat="server" ConnectionString="<%$ ConnectionStrings:HanoChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT [UserID], [FirstName] + ' ' + [LastName] As FullName FROM [Users] WHERE [fk_RoleID] = '5' ORDER BY [FullName] ASC">
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
                                                <asp:SqlDataSource ID="SqlEmail" runat="server" ConnectionString="<%$ ConnectionStrings:HanoChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT [Email] FROM [Users] WHERE [fk_RoleID] = '5' ORDER BY [Email] ASC">
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
                                        <asp:SqlDataSource ID="sqlGridView" runat="server" ConnectionString="<%$ ConnectionStrings:HanoChoiceConnectConnectionString %>"
                                            SelectCommand="SELECT UserID, FirstName + ' ' + LastName AS FullName, Email, IsEmailVerified, DateRegistered, LastLogin, (SELECT COUNT(LandlordPropertyID) AS Expr1 FROM LandlordProperty WHERE (fk_UserID = Users.UserID) AND (IsActive = '1')) AS CountActive, (SELECT COUNT(LandlordPropertyID) AS Expr1 FROM LandlordProperty AS LandlordProperty_2 WHERE (fk_UserID = Users.UserID) AND (IsActive = '0')) AS CountInactive, (SELECT COUNT(LandlordPropertyID) AS countSoonToBeDeleted FROM LandlordProperty AS LandlordProperty_1 WHERE (fk_UserID = Users.UserID) AND (DateLastUpdated &lt; DATEADD(day, - 90, GETDATE()))) AS CountSoonToBeDeleted FROM Users WHERE (fk_RoleID = '5') ORDER BY FullName">
                                        </asp:SqlDataSource>
                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table"
                                            DataKeyNames="UserID" DataSourceID="sqlGridView" AllowPaging="True"
                                            BorderStyle="None" GridLines="None" PageSize="9" 
                                            PagerStyle-CssClass="bs-pagination text-center">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                                    <ItemTemplate>
                                                        <%# DisplayNameLink(Eval("UserID"), Eval("FullName"), Request.QueryString("UserID"))%>
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
                                                        <%# DisplayEditLink(Eval("UserID"), Request.QueryString("UserID"))%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete">
                                                    <ItemTemplate>
                                                        <%# DisplayDeleteLink(Eval("UserID"), Request.QueryString("UserID"))%>
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
