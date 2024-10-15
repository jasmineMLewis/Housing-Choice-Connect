<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="LandlordProfileUpdate.aspx.vb" Inherits="HousingChoiceConnect.LandlordProfileUpdate" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/custom.css" rel="stylesheet" />
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

        Dim firstName As String
        Dim lastName As String
        Dim email As String
        Dim password As String

        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
        conn.Open()
        Dim query As New SqlCommand("SELECT FirstName, LastName, Email, Password FROM Users WHERE UserID='" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            firstName = CStr(reader("FirstName"))
            lastName = CStr(reader("LastName"))
            email = CStr(reader("Email"))
            password = CStr(reader("Password"))
        End While
        conn.Close()
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-info"></i>&nbsp;Info</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                             <i class="fa fa-info fa-fw"></i>&nbsp; Info
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success text-center">
                                <div class="panel-heading">
                                    <h3 class="panel-title text-center">
                                        <i class="fa fa-id-badge"></i> &nbsp; Personal</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="picture">
                                        <i class="fa fa-id-badge big-icon"></i>
                                    </div>
                                    <div id="basicProfileInfoForm">
                                        <div class="form">
                                            <h2>
                                                Personal</h2>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon" id="Span1"><span class="glyphicon glyphicon-info-sign">
                                                </span></span>
                                                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name"
                                                    value="<% Response.Write(firstName) %>" aria-describedby="sizing-addon1" maxlength="50"
                                                    required="required" />
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon" id="Span2"><span class="glyphicon glyphicon-info-sign">
                                                </span></span>
                                                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name"
                                                    value="<% Response.Write(lastName) %>" aria-describedby="sizing-addon3" maxlength="50"
                                                    required="required" />
                                            </div>
                                           
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-info fa-fw"></i>&nbsp; Info
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success text-center">
                                <div class="panel-heading">
                                    <h3 class="panel-title ">
                                        <i class="fa fa-mobile"></i>&nbsp; Login</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="picture">
                                        <i class="fa fa-mobile big-icon"></i>
                                    </div>
                                    <div id="contactInfoForm">
                                        <div class="form">
                                            <h2>  Login</h2>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon" id="Span3"><span class="glyphicon glyphicon-lock"></span>
                                                </span>
                                                <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Reset Password"
                                                    value="<% Response.Write(password) %>" aria-describedby="sizing-addon2" maxlength="50"
                                                    required="required" />
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon" id="Span4"><span class="glyphicon glyphicon-envelope">
                                                </span></span>
                                                <input type="email" class="form-control" id="email" name="email" value="<% Response.Write(email) %>"
                                                    aria-describedby="sizing-addon4" maxlength="100" required="required" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title text-center">
                                <i class="fa fa-info fa-fw"></i>&nbsp; Update Info</h3>
                        </div>
                        <div class="panel-body">
                            <div class="text-center">
                                <button type="button" class="btn btn-info btn-block btn-lg" runat="server" onserverclick="btnUpdateProfile">
                                    <i class="fa fa-info"></i>&nbsp; Update Info
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
