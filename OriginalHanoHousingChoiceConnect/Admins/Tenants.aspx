<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="Tenants.aspx.vb" Inherits="HanoChoiceConnect.Tenants" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/custom.css" rel="stylesheet" />
</asp:Content>
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
        
        Const TENANT_ROLE_ID As Integer = 4
        Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

        conn.Open()
        Dim numOfTenants As Integer
        Dim queryTenants As New SqlCommand("SELECT COUNT(UserID) AS countTenants FROM Users WHERE fk_RoleID = '" & TENANT_ROLE_ID & "'", conn)
        Dim readerTenants As SqlDataReader = queryTenants.ExecuteReader()
        While readerTenants.Read
            numOfTenants = CStr(readerTenants("countTenants"))
        End While
        conn.Close()
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-user fa-fw"></i>&nbsp; Tenants
                    </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-user fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(numOfTenants)%></div>
                                    <div>
                                        Tenants</div>
                                </div>
                            </div>
                        </div>
                        <a href="#" class="text-info">
                            <div class="panel-footer">
                                <span class="pull-left">Tenants</span>
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
                            <i class="fa fa-search fa-fw"></i>&nbsp;Tenant Search
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-info">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-search"></i>&nbsp;Tenant Search
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
                                                    SelectCommand="SELECT [UserID], [FirstName] + ' ' + [LastName] As FullName FROM [Users] WHERE [fk_RoleID] = '4' ORDER BY [FullName] ASC">
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
                                                    SelectCommand="SELECT [Email] FROM [Users] WHERE [fk_RoleID] = '4' ORDER BY [Email] ASC">
                                                </asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <div class="list-group-item text-center">
                                            <button type="button" class="btn btn-info btn-block btn-lg" runat="server" onserverclick="btnSearchTenant">
                                                <i class="fa fa-search"></i>&nbsp;Search Tenant
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
                            <i class="fa fa-user fa-fw"></i>Tenants
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-info">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title"><i class="fa fa-user"></i>&nbsp; Tenants</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group table-responsive">
                                        <asp:SqlDataSource ID="sqlGridView" runat="server" ConnectionString="<%$ ConnectionStrings:HanoChoiceConnectConnectionString %>"
                                            SelectCommand="SELECT UserID, FirstName + ' ' + LastName AS Name, Email, DateRegistered, LastLogin FROM Users WHERE fk_RoleID = 4 ORDER BY Name ASC">
                                        </asp:SqlDataSource>
                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table"
                                            DataKeyNames="UserID" DataSourceID="sqlGridView" ShowHeader="True" AllowPaging="True" BorderStyle="None" GridLines="None" 
                                            PageSize="9" PagerStyle-CssClass="bs-pagination text-center">
                                            <Columns>
                                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                                <asp:BoundField DataField="DateRegistered" HeaderText="Date Registered" SortExpression="DateRegistered" DataFormatString="{0:MM/dd/yyyy}" />
                                                <asp:BoundField DataField="LastLogin" HeaderText="Last Login" SortExpression="LastLogin" DataFormatString="{0:MM/dd/yyyy}"  />
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
