<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="AdminViewLandlord.aspx.vb" Inherits="HanoChoiceConnect.LandlordView" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim landlordUserID As String
        If landlordUserID = Nothing Then
            landlordUserID = Request.QueryString("LandlordUserID")
        End If
        
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
        Dim query As New SqlCommand("SELECT FirstName, LastName, Email, DateRegistered, LastLogin FROM Users WHERE UserID='" & landlordUserID & "'", conn)
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
        Dim activeProperties As Integer
        Dim queryActiveProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countActive FROM LandlordProperty WHERE fk_UserID='" & landlordUserID & "' AND IsActive = 1", conn)
        Dim readerActiveProperties As SqlDataReader = queryActiveProperties.ExecuteReader()
        While readerActiveProperties.Read
            activeProperties = CStr(readerActiveProperties("countActive"))
        End While
        conn.Close()
   
        conn.Open()
        Dim inactiveProperties As Integer
        Dim queryInactiveProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countInactive FROM LandlordProperty WHERE fk_UserID='" & landlordUserID & "' AND IsActive = 0", conn)
        Dim readerInactiveProperties As SqlDataReader = queryInactiveProperties.ExecuteReader()
        While readerInactiveProperties.Read
            inactiveProperties = CStr(readerInactiveProperties("countInactive"))
        End While
        conn.Close()
    
        conn.Open()
        Dim proximityProperties As Integer
        Dim queryProximityProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countProximity FROM LandlordProperty WHERE fk_UserID='" & landlordUserID & "' AND [DateOfPostage] < DATEADD(day, -240, GETDATE()) ", conn)
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
                        <i class="fa fa-home fa-fw"></i>
                        <% 
                            Response.Write(firstName & " " & lastName & "'s")
                        %>
                        Info</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-battery-full fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <% Response.Write(activeProperties)%></div>
                                    <div>
                                        Active Properties</div>
                                </div>
                            </div>
                        </div>
                        <a href="LandlordActiveProperties.aspx?LandlordUserID=<% Response.Write(landlordUserID) %>"
                            class="text-warning">
                            <div class="panel-footer">
                                <span class="pull-left">View Active Properties</span> <span class="pull-right"><i
                                    class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
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
                        <a href="LandlordInactiveProperties.aspx?LandlordUserID=<% Response.Write(landlordUserID) %>"
                            class="text-info">
                            <div class="panel-footer">
                                <span class="pull-left">View Inactive Properties</span> <span class="pull-right"><i
                                    class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
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
                        <a href="LandlordProximityProperties.aspx?LandlordUserID=<% Response.Write(landlordUserID) %>"
                            class="text-danger">
                            <div class="panel-footer">
                                <span class="pull-left">View Soon To Be Deleted Properties</span> <span class="pull-right">
                                    <i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-home"></i>&nbsp;Landlord Info
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-home"></i>&nbsp; Landlord Info</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            <i class="fa fa-envelope"></i>&nbsp; Email <span class="pull-right">
                                                <% Response.Write(email)%>
                                            </span>
                                        </div>
                                        <div class="list-group-item">
                                            <i class="fa fa-calendar"></i>&nbsp;Register <span class="pull-right">
                                                <% Response.Write(dateRegistered.ToString("MMMMM dd, yyyy", CultureInfo.InvariantCulture))%>
                                            </span>
                                        </div>
                                        <div class="list-group-item">
                                            <i class="fa fa-calendar"></i>&nbsp;Last Login <span class="pull-right">
                                                <% Response.Write(lastlogin.ToString("MMMMM dd, yyyy", CultureInfo.InvariantCulture))%>
                                            </span>
                                        </div>
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
