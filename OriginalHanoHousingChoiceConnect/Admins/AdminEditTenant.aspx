<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master" CodeBehind="AdminEditTenant.aspx.vb" Inherits="HanoChoiceConnect.AdminEditTenant" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HEAD" runat="server">
 <link href="Styles/custom.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim tenantUserID As String
        If tenantUserID = Nothing Then
            tenantUserID = Request.QueryString("TenantUserID")
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
        Dim password As String
    
        Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")
        conn.Open()
        Dim query As New SqlCommand("SELECT FirstName, LastName, Email, Password FROM Users WHERE UserID='" & tenantUserID & "'", conn)
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
                        <i class="fa fa-home fa-fw"></i>Edit
                        <% 
                            Response.Write(firstName & " " & lastName & "'s")
                        %>
                        Info
                    </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-info fa-fw"></i>&nbsp; Info
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success text-center">
                                <div class="panel-heading">
                                    <h3 class="panel-title text-center">
                                        <i class="fa fa-id-badge"></i>&nbsp; Personal</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="picture">
                                        <i class="fa fa-id-badge big-icon"></i>
                                    </div>
                                        <div class="form">
                                            <h2> Personal</h2>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-info-sign"></span></span>
                                                <input type="text" class="form-control"name="firstName" placeholder="First Name"
                                                    value="<% Response.Write(firstName) %>" maxlength="50"
                                                    required="required" />
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-info-sign"></span></span>
                                                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name"
                                                    value="<% Response.Write(lastName) %>" maxlength="50"
                                                    required="required" />
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                                <input type="password" class="form-control" name="password" placeholder="Reset Password"
                                                    value="<% Response.Write(password) %>" maxlength="50"
                                                    required="required" />
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                                                <input type="email" class="form-control" name="email" value="<% Response.Write(email) %>" maxlength="100" required="required" />
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
                                <i class="fa fa-pencil fa-fw"></i>&nbsp; Update Tenant</h3>
                        </div>
                        <div class="panel-body">
                            <div class="text-center">
                                <button id="Button1" type="button" class="btn btn-info btn-block btn-lg" runat="server" onserverclick="btnUpdateTenant">
                                    <i class="fa fa-pencil"></i>&nbsp; Update Tenant
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>