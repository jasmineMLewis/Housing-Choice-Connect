<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="TenantDashboard.aspx.vb" Inherits="HanoChoiceConnect.TenantDashboard2" %>

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

        Dim firstName As String
        Dim lastName As String
        Dim email As String
        Dim dateRegistered As Date
        Dim lastlogin As Date

        Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")
        conn.Open()
        Dim query As New SqlCommand("SELECT FirstName, LastName, Email, DateRegistered, LastLogin FROM Users WHERE UserID='" & userID & "'", conn)

        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            firstName = CStr(reader("FirstName"))
            lastName = CStr(reader("LastName"))
            email = CStr(reader("Email"))
            dateRegistered = CStr(reader("DateRegistered"))
            lastlogin = CStr(reader("LastLogin"))
        End While
        conn.Close()
        
        conn.Open()
        Dim totalActiveProperties As Integer
        Dim queryTotalProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) As TotalActive FROM LandlordProperty WHERE IsActive = '1'", conn)
        Dim readerTotalProperties As SqlDataReader = queryTotalProperties.ExecuteReader()
        While readerTotalProperties.Read
            totalActiveProperties = CStr(readerTotalProperties("TotalActive"))
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
                        Dashboard
                    </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-home fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(totalActiveProperties)%></div>
                                    <div>
                                        Total Available Properties</div>
                                </div>
                            </div>
                        </div>
                        <a href="TenantPropertyList.aspx?UserID=<% Response.Write(userID) %>">
                            <div class="panel-footer">
                                <span class="pull-left">View Total Available Properties</span> <span class="pull-right">
                                    <i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-file fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                       1</div>
                                    <div>
                                        Tutorial</div>
                                </div>
                            </div>
                        </div>
                        <a href="../assets/Tenants/Tenant Manual.pdf" target="_blank">
                            <div class="panel-footer">
                                <span class="pull-left">View Tutorial</span> <span class="pull-right">
                                    <i class="fa fa-arrow-circle-right"></i></span>
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
                            <i class="fa fa-user fa-fw"></i>&nbsp; Profile Information
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-user" aria-hidden="true"></i>&nbsp; Profile Information</h3>
                                </div>
                                <div class="panel-body">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <i class="fa fa-bookmark" aria-hidden="true"></i>&nbsp;Title
                                                </th>
                                                <th>
                                                    <i class="fa fa-tag" aria-hidden="true"></i>&nbsp;Personal Info
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <i>Name</i>
                                                </td>
                                                <td>
                                                    <%
                                                        Response.Write(firstName & " " & lastName)
                                                    %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <i>Email</i>
                                                </td>
                                                <td>
                                                    <% Response.Write(email)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <i>Date Registered</i>
                                                </td>
                                                <td>
                                                    <% Response.Write(dateRegistered.ToString("MMMMM dd, yyyy", CultureInfo.InvariantCulture))%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <i>Last Login</i>
                                                </td>
                                                <td>
                                                    <% Response.Write(lastlogin.ToString("MMMMM dd, yyyy", CultureInfo.InvariantCulture))%>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
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
                                    <a href="../assets/Tenants/Zip Code Amenities/70115 Amenities.pdf" target="_blank" class="list-group-item">
                                        &nbsp;70115 <span class="pull-right text-primary"><i class="fa fa-qrcode"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Zip Code Amenities/70116 Amenities.pdf" target="_blank"
                                        class="list-group-item">&nbsp;70116 <span class="pull-right text-primary"><i class="fa fa-qrcode">
                                        </i></span>
                                    </a>
                                    <a href="../assets/Tenants/Zip Code Amenities/70118 Amenities.pdf" target="_blank"
                                        class="list-group-item">&nbsp;70118 <span class="pull-right text-primary"><i class="fa fa-qrcode">
                                        </i></span>
                                    </a>
                                    <a href="../assets/Tenants/Zip Code Amenities/70124 Amenities.pdf" target="_blank"
                                        class="list-group-item">&nbsp;70124 <span class="pull-right text-primary"><i class="fa fa-qrcode">
                                        </i></span>
                                    </a>
                                    <a href="../assets/Tenants/Zip Code Amenities/70130 Amenities.pdf" target="_blank"
                                        class="list-group-item">&nbsp;70130 <span class="pull-right text-primary"><i class="fa fa-qrcode">
                                        </i></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
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
                                    <a href="../assets/Tenants/Maps/Jefferson Parish Poverty Map.pdf" target="_blank" class="list-group-item">
                                        Jefferson Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/Orleans Parish Poverty Map.pdf" target="_blank"
                                        class="list-group-item">Orleans Parish &nbsp; <span class="pull-right text-primary">
                                        <i class="fa fa-map"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/Plaquemines Parish Poverty Map.pdf" target="_blank"
                                        class="list-group-item">Plaquemines Parish &nbsp; <span class="pull-right text-primary">
                                        <i class="fa fa-map">
                                        </i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/St Bernard Parish Poverty Map.pdf" target="_blank" 
                                        class="list-group-item">St Bernard Parish &nbsp; <span class="pull-right text-primary">
                                        <i class="fa fa-map"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/St Charles Parish Poverty Map.pdf" target="_blank"
                                        class="list-group-item">St Charles Parish &nbsp; <span class="pull-right text-primary">
                                        <i class="fa fa-map"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/St John Parish Poverty Map.pdf" target="_blank"
                                       class="list-group-item">St John Parish &nbsp; <span class="pull-right text-primary">
                                       <i class="fa fa-map"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/St Tammany Parish Poverty Map.pdf" target="_blank"
                                       class="list-group-item">St Tammany Parish &nbsp; <span class="pull-right text-primary">
                                       <i class="fa fa-map"></i></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
               <div class="col-lg-3">
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
                                    <a href="../assets/Tenants/Maps/Jefferson Parish Minority Map.pdf" target="_blank" class="list-group-item">
                                        Jefferson Parish &nbsp; <span class="pull-right text-primary"><i class="fa fa-map-o"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/Orleans Parish Minority Map.pdf" target="_blank"
                                        class="list-group-item">Orleans Parish &nbsp; <span class="pull-right text-primary">
                                        <i class="fa fa-map-o"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/Plaquemines Parish Minority Map.pdf" target="_blank"
                                       class="list-group-item">Plaquemines Parish &nbsp; <span class="pull-right text-primary">
                                        <i class="fa fa-map-o"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/St Bernard Parish Minority Map.pdf" target="_blank" 
                                       class="list-group-item">St Bernard Parish &nbsp; <span class="pull-right text-primary">
                                       <i class="fa fa-map-o"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/St Charles Parish Minority Map.pdf" target="_blank"
                                        class="list-group-item">St Charles Parish &nbsp; <span class="pull-right text-primary">
                                        <i class="fa fa-map-o"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/St John Parish Minority Map.pdf" target="_blank"
                                       class="list-group-item">St John Parish &nbsp; <span class="pull-right text-primary">
                                       <i class="fa fa-map-o"></i></span>
                                    </a>
                                    <a href="../assets/Tenants/Maps/St Tammany Parish Minority Map.pdf" target="_blank"
                                       class="list-group-item">St Tammany Parish &nbsp; <span class="pull-right text-primary">
                                       <i class="fa fa-map-o"></i></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             <div class="row">
             <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-file" aria-hidden="true"></i>&nbsp; Relevant Documents
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-file" aria-hidden="true"></i>&nbsp; Relevant Documents </h3>
                                </div>
                                <div class="list-group">
                                    <a href="../assets/Tenants/HANO_HCVP_InfoPacket.pdf" target="_blank" class="list-group-item">
                                        &nbsp;HCVP InfoPacket <span class="pull-right text-primary"><i class="fa fa-file"></i></span>
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
