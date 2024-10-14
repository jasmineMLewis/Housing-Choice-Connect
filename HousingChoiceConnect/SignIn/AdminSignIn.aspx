<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Footer.Master" 
    CodeBehind="AdminSignIn.aspx.vb" Inherits="HousingChoiceConnect.AdminSignIn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/sign-in.css" rel="stylesheet" />
    <link href="../Styles/custom.css" rel="stylesheet" />
        <style type="text/css">
            html, body
            {
                width: 100%;
                height: 100%;
                overflow-x: hidden;
            }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <nav class="navbar navbar-default navbar-fixed-top">
        <div class="navbar-header">
            <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="logo" href="Default.aspx"><img src="../Images/hano-logo.png" alt="hano-logo" /></a>
        </div>
        <div id="navbarCollapse" class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right" style = "margin-right: 150px;">
            <li>
                <div class="dropdownBtn">
                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" name="btnSignIn" id="btnSignIn"><i class="fa fa-download"></i> Sign In <span class="caret"></span></button>
                    
                    <ul class="dropdown-menu" role="menu">
                          <li>
                            <a href="/SignIn/TenantSignIn.aspx"><i class="fa fa-user"> <b>Tenant</b></i> <span class="tab-space-tenant"></span>
                                 <span class="glyphicon glyphicon-chevron-right"></span></a>
                          </li>
                        <li><a href="/SignIn/LandlordSignIn.aspx"><i class="fa fa-home"> <b>Landlord</b></i> <span class="tab-space-landlord"></span>
                        <span class="glyphicon glyphicon-chevron-right"></span></a></li>
                    </ul>      
                </div>
            </li>
            <li>
                <div class="dropdownBtn">
                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" name="btnSignUp" id="btnSignUp"><i class="fa fa-upload"></i> Sign Up <span class="caret"></span></button>
                    <ul class="dropdown-menu" role="menu">
                        <li>
                            <a href="/SignUp/TenantSignUp.aspx"><i class="fa fa-user"> <b>Tenant</b></i> <span class="tab-space-tenant"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                        <li>
                            <a href="/SignUp/LandlordSignUp.aspx"><i class="fa fa-home"> <b>Landlord</b></i> <span class="tab-space-landlord"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                    </ul>
                </div>
            </li>
            </ul>
        </div>
   </nav>

    <div id="signIn">
     <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading text-center">
                    <h3 class="panel-title">Admin Sign In</h3>
                </div>
                <div class="panel-body">
                    <div class="text-center">
                        <i class="fa fa-user-secret big-icon"></i>
                    </div>
                    <div class="form">
                        <div class="input-group input-group-lg inputFormat">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                            <asp:TextBox ID="email" runat="server" class="form-control" placeholder="Email" name="email" maxlength="100"></asp:TextBox>
                        </div>
                        <div class="input-group input-group-lg inputFormat">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                            <asp:TextBox ID="password" runat="server" class="form-control" placeholder="Password" name="password" maxlength="50"></asp:TextBox>
                        </div>
                         <button type="button" class="btn btn-info btn-block btn-lg" runat="server" onserverclick="BtnAdminSignIn">
                             <i class="fa fa-download"></i>&nbsp; Sign In
                         </button>
                        <div class="input-group input-group-lg inputFormat">
                            <asp:Label ID="lblMsg" runat="server" Style="font-size: 14px; font-weight: 700; color: #1A926A"
                                EnableViewState="False">
                             </asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </div>
    </div>
  <div id="space" style="margin-top: 210px;"></div>
</asp:Content>
