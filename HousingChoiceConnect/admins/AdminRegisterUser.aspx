<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="AdminRegisterUser.aspx.vb" Inherits="HousingChoiceConnect.AdminRegisterUser" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/custom.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim userID As String = Session("UserID")
        If Not Web.HttpContext.Current.Session("UserID") Is Nothing Then
            userID = Web.HttpContext.Current.Session("UserID").ToString()
        End If

        If userID = Nothing Then
            userID = Request.QueryString("UserID")
            Web.HttpContext.Current.Session("UserID") = userID
        End If
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-sign-in"></i>&nbsp; User Account Registration
                    </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-list fa-fw"></i>&nbsp;Registration Checklist
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-warning">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-list"></i>&nbsp; Registration Checklist
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <div class="list-group">
                                        <div class="list-group-item">
                                            EMAIL is correct<span class="pull-right text-primary"> <i class="fa fa-envelope"></i>
                                            </span>
                                        </div>
                                        <div class="list-group-item">
                                            EMAIL is unquie<span class="pull-right text-primary"> <i class="fa fa-envelope"></i>
                                            </span>
                                        </div>
                                        <div class="list-group-item">
                                            PASSWORD is correct <span class="pull-right text-primary"><i class="fa fa-lock"></i>
                                            </span>
                                        </div>
                                        <div class="list-group-item">
                                            NAME is correct <span class="pull-right text-primary"><i class="fa fa-user"></i>
                                            </span>
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
                            <i class="fa fa-sign-in fa-fw"></i>&nbsp;User Account Registration
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-warning">
                                <div class="panel-heading text-center">
                                    <h3 class="panel-title">
                                        <i class="fa fa-sign-in"></i>&nbsp; User Account Registration
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <ul class="nav nav-tabs nav-justified">
                                        <li class="active"><a data-toggle="tab" href="#landlord"><i class="fa fa-home fa-fw">
                                        </i>&nbsp; Landlord</a></li>
                                        <li><a data-toggle="tab" href="#tenant"><i class="fa fa-user fa-fw"></i>&nbsp; Tenant</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="landlord" class="tab-pane fade in active">
                                            <p>
                                            </p>
                                            <div class="alert alert-success text-center" role="alert">
                                                <h4 class="text-center">
                                                    Landlord User Account Registration
                                                </h4>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span>
                                                </span>
                                                <asp:TextBox ID="landlordEmail" runat="server" class="form-control" placeholder="Email"
                                                    name="landlordEmail" MaxLength="100"></asp:TextBox>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                                <asp:TextBox ID="landlordPassword" runat="server" class="form-control" placeholder="Password"
                                                    name="landlordPassword" MaxLength="25"></asp:TextBox>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <asp:TextBox ID="landlordFirstName" runat="server" class="form-control" placeholder="First Name"
                                                    name="landlordFirstName" MaxLength="25"></asp:TextBox>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <asp:TextBox ID="landlordLastName" runat="server" class="form-control" placeholder="Last Name"
                                                    name="landlordLastName" MaxLength="25"></asp:TextBox>
                                            </div>

                                            <button type="button" class="btn btn-success btn-block btn-lg" runat="server" onserverclick="BtnRegisterLandlord">
                                                <i class="fa fa-upload"></i>&nbsp; Sign Up
                                            </button>
                                        </div>
                                        <div id="tenant" class="tab-pane fade text-center">
                                            <p>
                                            </p>
                                            <div class="alert alert-info text-center" role="alert">
                                                <h4 class="text-center">
                                                    Tenant User Account Registration
                                                </h4>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <asp:DropDownList ID="FullDescrp" runat="server" CssClass="selectpicker" DataSourceID="SqlFullDescrp"
                                                    DataTextField="FullDescrp" DataValueField="ID">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlFullDescrp" runat="server" ConnectionString="<%$ ConnectionStrings:HousingChoiceConnectConnectionString %>"
                                                    SelectCommand="SELECT EliteTenantImportID, FirstName + ' ' + LastName  + ' :: ' + EntityID As FullDescrp 
                                                                   FROM EliteTenantImport
                                                                   ORDER BY FullDescrp ASC">
                                                </asp:SqlDataSource>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span>
                                                </span>
                                                <asp:TextBox ID="tenantEmail" runat="server" class="form-control" placeholder="Email" MaxLength="100"></asp:TextBox>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                                <asp:TextBox ID="tenantPassword" runat="server" class="form-control" placeholder="Password"
                                                    name="password" TextMode="Password" MaxLength="50"></asp:TextBox>
                                            </div>
                                            <button id="ButtonRegisterTenant" type="button" 
                                                    class="btn btn-info btn-block btn-lg" runat="server" 
                                                    onserverclick="BtnRegisterTenant">
                                                <i class="fa fa-upload"></i>&nbsp; Sign Up
                                            </button>
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
