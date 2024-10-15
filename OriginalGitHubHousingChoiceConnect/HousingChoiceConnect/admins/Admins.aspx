<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="Admins.aspx.vb" Inherits="HousingChoiceConnect.Admins" %>

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

        Const ADMIN_ROLE_ID As Integer = 1
        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
        conn.Open()
        Dim numOfAdmin As Integer
        Dim queryAdmins As New SqlCommand("SELECT COUNT(UserID) AS countAdmins FROM Users WHERE fk_RoleID = '" & ADMIN_ROLE_ID & "'", conn)
        Dim readerAdmins As SqlDataReader = queryAdmins.ExecuteReader()
        While readerAdmins.Read
            numOfAdmin = CStr(readerAdmins("countAdmins"))
        End While
        conn.Close()
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-user-secret fa-fw"></i>&nbsp; Admins
                    </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-user-secret fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(numOfAdmin)%></div>
                                    <div>
                                        Admin</div>
                                </div>
                            </div>
                        </div>
                        <a href="#" class="text-muted">
                            <div class="panel-footer">
                                <span class="pull-left">Admin</span>
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
                            <i class="fa fa-search fa-fw"></i>&nbsp;Admin Search
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-default">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-search"></i>&nbsp;Admin Search
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
                                                    SelectCommand="SELECT [UserID], [FirstName] + ' ' + [LastName] As FullName FROM [Users] WHERE [fk_RoleID] = '1' ORDER BY [FullName] ASC">
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
                                                    SelectCommand="SELECT [Email] FROM [Users] WHERE [fk_RoleID] = '1' ORDER BY [Email] ASC">
                                                </asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <div class="list-group-item text-center">
                                            <button id="button" type="button" class="btn btn-default btn-block btn-lg" runat="server" onserverclick="btnSearchAdmin">
                                                <i class="fa fa-search"></i>&nbsp;Admin
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
                            <i class="fa fa-user-secret fa-fw"></i>Admins
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-default">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-user-secret"></i>&nbsp; Admins</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group table-responsive">
                                        <asp:SqlDataSource ID="sqlGridView" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                            SelectCommand="SELECT UserID, FirstName + ' ' + LastName AS Name, Email, DateRegistered, LastLogin FROM Users WHERE fk_RoleID = 1 ORDER BY Name ASC">
                                        </asp:SqlDataSource>
                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table"
                                            DataKeyNames="UserID" DataSourceID="sqlGridView" ShowHeader="True" AllowPaging="True" BorderStyle="None" GridLines="None" 
                                            PageSize="9" PagerStyle-CssClass="bs-pagination text-center">
                                            <Columns>
                                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                                <asp:BoundField DataField="DateRegistered" HeaderText="Date Registered" SortExpression="DateRegistered" DataFormatString="{0:MM/dd/yyyy}" />
                                                <asp:BoundField DataField="LastLogin" HeaderText="Last Login" SortExpression="LastLogin" DataFormatString="{0:MM/dd/yyyy}"  />
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

