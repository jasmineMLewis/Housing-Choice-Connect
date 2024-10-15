<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="LandlordDashboard.aspx.vb" Inherits="HanoChoiceConnect.LandlordDashboard" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Styles/custom.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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

        Dim activeProperties As Integer
        conn.Open()
        Dim queryActiveProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countActive FROM LandlordProperty WHERE fk_UserID='" & userID & "' AND IsActive = 1", conn)
        Dim readerActiveProperties As SqlDataReader = queryActiveProperties.ExecuteReader()
        While readerActiveProperties.Read
            activeProperties = CStr(readerActiveProperties("countActive"))
        End While
        conn.Close()
   
        Dim inactiveProperties As Integer
        conn.Open()
        Dim queryInactiveProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countInactive FROM LandlordProperty WHERE fk_UserID='" & userID & "' AND IsActive = 0", conn)
        Dim readerInactiveProperties As SqlDataReader = queryInactiveProperties.ExecuteReader()
        While readerInactiveProperties.Read
            inactiveProperties = CStr(readerInactiveProperties("countInactive"))
        End While
        conn.Close()
    
        Dim proximityProperties As Integer
        conn.Open()
        Dim queryProximityProperties As New SqlCommand("SELECT COUNT(LandlordPropertyID) AS countProximity FROM LandlordProperty WHERE fk_UserID='" & userID & "' AND [DateLastUpdated] < DATEADD(day, -90, GETDATE()) ", conn)
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
            <div class="row">
                <div class="col-lg-4">
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
                        <a href="LandlordActiveProperties.aspx?UserID=<% Response.Write(userID) %>" class="text-warning">
                            <div class="panel-footer">
                                <span class="pull-left">View Active Properties</span> <span class="pull-right"><i
                                    class="fa fa-arrow-circle-right"></i></span>
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
                        <a href="LandlordInactiveProperties.aspx?UserID=<% Response.Write(userID) %>" class="text-info">
                            <div class="panel-footer">
                                <span class="pull-left">View Inactive Properties</span> <span class="pull-right"><i
                                    class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4">
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
                        <a href="LandlordSoonDeletedProperties.aspx?UserID=<% Response.Write(userID) %>" class="text-danger">
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
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-user fa-fw"></i>&nbsp;Profile Information
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-user" aria-hidden="true"></i>&nbsp;Basic Profile Info</h3>
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
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-folder" aria-hidden="true"></i>&nbsp;Relevant Documents
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-folder" aria-hidden="true"></i>&nbsp;Relevant Documents</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <a href="../assets/Landlords/HudLandlordPropertyInspectionChecklist.pdf" target="_blank"
                                            class="list-group-item">&nbsp;Landlord Property Inspection Checklist <span class="pull-right text-primary">
                                            <i class="fa fa-list-alt" aria-hidden="true"></i></span>
                                        </a>
                                        <a href="../assets/Landlords/HANOPaymentStandards_2019.pdf" target="_blank" 
                                            class="list-group-item">&nbsp;HANO Payment Standard <span class="pull-right text-primary">
                                           <i class="fa fa-credit-card" aria-hidden="true"></i></span>
                                        </a>
                                        <a href="../assets/Landlords/Mutual Agreement To Terminate.pdf" target="_blank" 
                                            class="list-group-item">&nbsp;Mutual Agreement To Terminate <span
                                             class="pull-right text-primary"><i class="fa fa-ban" aria-hidden="true"></i>
                                                            </span>
                                        </a>                
                                        <a href="../assets/Landlords/Contract Rent Adjustment Request Form.pdf" target="_blank"
                                           class="list-group-item">&nbsp;Contract Rent Increase Form <span class="pull-right text-primary">
                                           <i class="fa fa-money" aria-hidden="true"></i></span>
                                        </a>
                                        <a href="../assets/Landlords/Smoke Detectors Guidelines.pdf" target="_blank" 
                                            class="list-group-item"> &nbsp;Smoke Dectors Form <span class="pull-right text-primary"><i class="fa fa-cloud"
                                                aria-hidden="true"></i></span>
                                        </a>
                                        <a href="../assets/Landlords/Address Change Form.pdf"
                                            target="_blank" class="list-group-item">&nbsp;Address Change Form <span class="pull-right text-primary">
                                             <i class="fa fa-home" aria-hidden="true"></i></span>
                                        </a>
                                        <a href="../assets/Landlords/HANOExceptionPaymentStandards_2018.pdf"
                                              target="_blank" class="list-group-item">&nbsp;HANO Exception Payment Standards by Zip Code<span class="pull-right text-primary">
                                              <i class="fa fa-arrows-alt" aria-hidden="true"></i></span>
                                        </a>
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
