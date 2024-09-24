<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="AdminDashboard.aspx.vb" Inherits="HousingChoiceConnect.AdminDashboard" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/custom.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim userID As String = Session("UserID")
        If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
            userID = Web.HttpContext.Current.Session("UserID").ToString()
        End If

        If userID = Nothing Then
            userID = Request.QueryString("UserID")
            Web.HttpContext.Current.Session("UserID") = userID
        End If

        Const ADMIN_ROLE_ID As Integer = 1
        Const TENANT_ROLE_ID As Integer = 2
        Const LANDLORD_ROLE_ID As Integer = 3

        Dim firstName As String
        Dim lastName As String
        Dim email As String
        Dim dateRegistered As Date
        Dim lastlogin As Date

        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
        conn.Open()
        Dim query As New SqlCommand("SELECT FirstName, LastName, Email, DateRegistered, LastLogin 
                                     FROM Users 
                                     WHERE UserID='" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            firstName = CStr(reader("FirstName"))
            lastName = CStr(reader("LastName"))
            email = CStr(reader("Email"))
            dateRegistered = CStr(reader("DateRegistered"))
            lastlogin = CStr(reader("LastLogin"))
        End While
        conn.Close()

        Dim numOfAdmin As Integer
        conn.Open()
        Dim queryAdmins As New SqlCommand("SELECT COUNT(UserID) AS countAdmins 
                                           FROM Users 
                                           WHERE RoleID = '" & ADMIN_ROLE_ID & "'", conn)
        Dim readerAdmins As SqlDataReader = queryAdmins.ExecuteReader()
        While readerAdmins.Read
            numOfAdmin = CStr(readerAdmins("countAdmins"))
        End While
        conn.Close()

        Dim numOfTenants As Integer
        conn.Open()
        Dim queryTenants As New SqlCommand("SELECT COUNT(UserID) AS countTenants 
                                            FROM Users 
                                            WHERE RoleID = '" & TENANT_ROLE_ID & "'", conn)
        Dim readerTenants As SqlDataReader = queryTenants.ExecuteReader()
        While readerTenants.Read
            numOfTenants = CStr(readerTenants("countTenants"))
        End While
        conn.Close()

        Dim numOfLandlords As Integer
        conn.Open()
        Dim queryLandlords As New SqlCommand("SELECT COUNT(UserID) AS countLandlords 
                                              FROM Users 
                                              WHERE RoleID = '" & LANDLORD_ROLE_ID & "'", conn)
        Dim readerLandlords As SqlDataReader = queryLandlords.ExecuteReader()
        While readerLandlords.Read
            numOfLandlords = CStr(readerLandlords("countLandlords"))
        End While
        conn.Close()

        Dim allProperties As Integer
        conn.Open()
        Dim queryAllProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countAll 
                                                  FROM LandlordProperty", conn)
        Dim readerAllProperties As SqlDataReader = queryAllProperties.ExecuteReader()
        While readerAllProperties.Read
            allProperties = CStr(readerAllProperties("countAll"))
        End While
        conn.Close()

        Dim activeProperties As Integer
        conn.Open()
        Dim queryActiveProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countActive 
                                                     FROM LandlordProperty 
                                                     WHERE IsActive = 1", conn)
        Dim readerActiveProperties As SqlDataReader = queryActiveProperties.ExecuteReader()
        While readerActiveProperties.Read
            activeProperties = CStr(readerActiveProperties("countActive"))
        End While
        conn.Close()

        Dim inactiveProperties As Integer
        conn.Open()
        Dim queryInactiveProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countInactive 
                                                       FROM LandlordProperty 
                                                       WHERE IsActive = 0", conn)
        Dim readerInactiveProperties As SqlDataReader = queryInactiveProperties.ExecuteReader()
        While readerInactiveProperties.Read
            inactiveProperties = CStr(readerInactiveProperties("countInactive"))
        End While
        conn.Close()

        Dim proximityProperties As Integer
        conn.Open()
        Dim queryProximityProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countProximity 
                                                        FROM LandlordProperty 
                                                        WHERE DateLastUpdated < DATEADD(day, -90, GETDATE()) ", conn)
        Dim readerProximityProperties As SqlDataReader = queryProximityProperties.ExecuteReader()
        While readerProximityProperties.Read
            proximityProperties = CStr(readerProximityProperties("countProximity"))
        End While
        conn.Close()
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-tasks fa-fw"></i>
                        <% 
                            Response.Write(firstName & " " & lastName & "'s")
                        %>
                        Dashboard</h1>
                </div>
            </div>
            <%--Users--%>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-user-secret fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(numOfAdmin)%></div>
                                    <div> Admins</div>
                                </div>
                            </div>
                        </div>
                        <a href="Admins.aspx?UserID=<% Response.Write(userID) %>">
                            <div class="panel-footer text-muted">
                                <span class="pull-left">View Admins</span> <span class="pull-right"><i class="fa fa-arrow-circle-right">
                                </i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-home fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(numOfLandlords)%>
                                    </div>
                                    <div>
                                        Landlords</div>
                                </div>
                            </div>
                        </div>
                        <a href="Landlords.aspx?UserID=<% Response.Write(userID) %>">
                            <div class="panel-footer text-success">
                                <span class="pull-left">View Landlords</span> <span class="pull-right"><i class="fa fa-arrow-circle-right">
                                </i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4">
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
                        <a href="Tenants.aspx?UserID=<% Response.Write(userID) %>">
                            <div class="panel-footer text-info">
                                <span class="pull-left">View Tenants</span> <span class="pull-right"><i class="fa fa-arrow-circle-right">
                                </i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <%--Properties--%>
            <div class="row">
                <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-battery-full fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(allProperties)%></div>
                                    <div>
                                        All Properties</div>
                                </div>
                            </div>
                        </div>
                        <a href="AdminAllProperties.aspx?UserID=<% Response.Write(userID) %>">
                            <div class="panel-footer text-muted">
                                <span class="pull-left">View All Properties</span> <span class="pull-right"><i class="fa fa-arrow-circle-right">
                                </i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-battery-three-quarters fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(activeProperties)%></div>
                                    <div>
                                        Active Properties</div>
                                </div>
                            </div>
                        </div>
                        <a href="AdminActiveProperties.aspx?UserID=<% Response.Write(userID) %>">
                            <div class="panel-footer text-warning">
                                <span class="pull-left">View Active Properties</span> <span class="pull-right"><i
                                    class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3">
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
                        <a href="AdminInactiveProperties.aspx?UserID=<% Response.Write(userID) %>">
                            <div class="panel-footer text-info">
                                <span class="pull-left">View Inactive Properties</span> <span class="pull-right"><i
                                    class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="panel panel-danger">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-battery-quarter fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(proximityProperties)%></div>
                                    <div>
                                        Soon To Be Deleted Properties</div>
                                </div>
                            </div>
                        </div>
                        <a href="AdminSoonToBeDeletedProperties.aspx?UserID=<% Response.Write(userID) %>">
                            <div class="panel-footer text-danger">
                                <span class="pull-left">View Soon To Be Deleted Properties</span> <span class="pull-right">
                                    <i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <%--Profile Information--%>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-info fa-fw"></i>&nbsp;Profile Information
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-info"></i>&nbsp; Profile Information</h3>
                                </div>
                                <div class="panel-body table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <i class="fa fa-bookmark"></i>&nbsp;Title
                                                </th>
                                                <th>
                                                    <i class="fa fa-tag"></i>&nbsp;Personal Info
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <i>Email</i>
                                                </td>
                                                <td>
                                                    <% Response.Write(email)%>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-file"></i>&nbsp;Tutorials
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-file"></i>&nbsp; Tutorials
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <a href="../Assets/Admins/admin-manual.pdf" target="_blank"
                                            class="list-group-item">&nbsp; Admin Tutorial <span class="pull-right text-primary">
                                                <i class="fa fa-file"></i></span></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-qrcode" aria-hidden="true"></i>&nbsp; Zip Code Amentities
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-qrcode" aria-hidden="true"></i>&nbsp; Zip Code Amentities</h3>
                                </div>
                                <div class="list-group">
                                    <a href="../Assets/Tenants/ZipCodeAmenities/70115-amenities.pdf" target="_blank" class="list-group-item">
                                        &nbsp;70115 <span class="pull-right text-primary"><i class="fa fa-qrcode"></i></span>
                                    </a>
                                    <a href="../Assets/Tenants/ZipCodeAmenities/70116-amenities.pdf" target="_blank"
                                        class="list-group-item">&nbsp;70116 <span class="pull-right text-primary"><i class="fa fa-qrcode">
                                        </i></span>
                                    </a>
                                    <a href="../Assets/Tenants/ZipCodeAmenities/70118-amenities.pdf" target="_blank"
                                            class="list-group-item">&nbsp;70118 <span class="pull-right text-primary"><i class="fa fa-qrcode">
                                            </i></span>
                                    </a>
                                    <a href="../Assets/Tenants/ZipCodeAmenities/70124-amenities.pdf" target="_blank"
                                         class="list-group-item">&nbsp;70124 <span class="pull-right text-primary"><i class="fa fa-qrcode">
                                         </i></span>
                                    </a>
                                    <a href="../Assets/Tenants/ZipCodeAmenities/70130-amenities.pdf" target="_blank"
                                        class="list-group-item">&nbsp;70130 <span class="pull-right text-primary"><i class="fa fa-qrcode">
                                        </i></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-map" aria-hidden="true"></i>&nbsp; Poverty Maps
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-map" aria-hidden="true"></i>&nbsp; Poverty Maps</h3>
                                </div>
                                <div class="list-group">
                                    <a href="../Assets/Tenants/Maps/PovertyMaps/jefferson-parish-poverty-map.pdf" target="_blank" class="list-group-item">
                                        Jefferson Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map"></i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/PovertyMaps/orleans-parish-poverty-map.pdf" target="_blank"
                                        class="list-group-item">Orleans Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map">
                                        </i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/PovertyMaps/plaquemines-parish-poverty-map.pdf" target="_blank"
                                            class="list-group-item">Plaquemines Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map">
                                            </i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/PovertyMaps/st-bernard-parish-poverty-map.pdf" target="_blank" class="list-group-item">
                                       St Bernard Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map"></i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/PovertyMaps/st-charles-parish-poverty-map.pdf" target="_blank"
                                        class="list-group-item">St Charles Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map">
                                        </i></span></a>
                                     <a href="../Assets/Tenants/Maps/PovertyMaps/st-john-parish-poverty-map.pdf" target="_blank"
                                            class="list-group-item">St John Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map">
                                            </i></span>
                                     </a>
                                      <a href="../Assets/Tenants/Maps/PovertyMaps/st-tammany-parish-poverty-map.pdf" target="_blank"
                                            class="list-group-item">St Tammany Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map">
                                            </i></span>
                                      </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-map-o" aria-hidden="true"></i>&nbsp; Minority Maps
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-map-o" aria-hidden="true"></i>&nbsp; Minority Maps</h3>
                                </div>
                                <div class="list-group">
                                    <a href="../Assets/Tenants/Maps/MinorityMaps/jefferson-parish-minority-map.pdf" target="_blank" class="list-group-item">
                                        Jefferson Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map-o"></i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/MinorityMaps/orleans-parish-minority-map.pdf" target="_blank"
                                        class="list-group-item">Orleans Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map-o">
                                        </i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/MinorityMaps/plaquemines-parish-minority-map.pdf" target="_blank"
                                            class="list-group-item">Plaquemines Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map-o">
                                            </i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/MinorityMaps/st-bernard-parish-minority-map.pdf" target="_blank" class="list-group-item">
                                       St Bernard Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map-o"></i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/MinorityMaps/st-charles-parish-minority-map.pdf" target="_blank"
                                        class="list-group-item">St Charles Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map-o">
                                        </i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/MinorityMaps/st-john-parish-minority-map.pdf" target="_blank"
                                            class="list-group-item">St John Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map-o">
                                            </i></span>
                                    </a>
                                    <a href="../Assets/Tenants/Maps/MinorityMaps/st-tammany-parish-minority-map.pdf" target="_blank"
                                            class="list-group-item">St Tammany Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map-o">
                                            </i></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
