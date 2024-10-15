<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/Footer.Master"
    CodeBehind="LandlordSignUp.aspx.vb" Inherits="HanoChoiceConnect.LandlordSignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/custom.css" rel="stylesheet" />
    <link href="Styles/signUp.css" rel="stylesheet" />
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
            <a class="logo" href="Default.aspx"><img src="img/hanoLogo.png" alt="hanoLogo" /></a>
        </div>
        <div id="navbarCollapse" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="#top" class="white-color"><i class="fa fa-home"></i> Home</a></li>
                <li><a href="#benefits" class="white-color"><i class="fa fa-balance-scale"></i> Benefits</a></li>
                <li><a href="#contact" class="white-color"><i class="fa fa-phone"></i> Contact</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right" style="margin-right: 150px;">
             <li>
                <div class="dropdownBtn">
                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" name="btnSignIn" id="btnSignIn"><i class="fa fa-download"></i> Sign In <span class="caret"></span></button>
                    <ul class="dropdown-menu" role="menu">
                          <li>
                            <a href="TenantSignIn.aspx"><i class="fa fa-user">&nbsp; <b>Tenant</b></i>&nbsp;  <span class="tab-space-tenant"></span>
                                 <span class="glyphicon glyphicon-chevron-right"></span></a>
                          </li>
                        <li><a href="LandlordSignIn.aspx"><i class="fa fa-home">&nbsp; <b>Landlord</b></i>&nbsp; <span class="tab-space-landlord"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                    </ul>      
                </div>
             </li>
             <li>
                <div class="dropdownBtn">
                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" name="btnSignUp" id="btnSignUp"><i class="fa fa-upload"></i> Sign Up <span class="caret"></span></button>
                    <ul class="dropdown-menu" role="menu">
                        <li>
                            <a href="TenantSignUp.aspx"><i class="fa fa-user">&nbsp; <b>Tenant</b></i>&nbsp; <span class="tab-space-tenant"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                        <li>
                            <a href="LandlordSignUp.aspx"><i class="fa fa-home">&nbsp; <b>Landlord</b></i>&nbsp; <span class="tab-space-landlord"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                    </ul>
                </div>
             </li>
            </ul>
        </div>
 </nav>
    <header id="top" class="header">
        <div id="signUp">
            <div class="row">
              <div class="col-md-4 col-sm-offset-1">
                 <div class="panel panel-success">
                        <div class="panel-heading text-center">
                            <h1 class="panel-title">Your Perfect Tenant</h1>
                        </div>
                        <div class="panel-body">
                             <p><h2 class="text-center">Your <i>NEXT</i> tenant is <i><span class="label label-warning">HERE</span></i></h2></p>
                             <h4 class="text-center">Post vacant Section 8 properties in the New Orleans area</h4>
                             <p class="text-center"><a href="#benefits" class="btn btn-info btn-lg text-center">View Benefits</a></p>
                        </div>
                 </div>
                 <div class="panel panel-success">
                        <div class="panel-heading text-center">
                            <h1 class="panel-title">Property Listings Note</h1>
                        </div>
                        <div class="panel-body">
                            <h4 class="text-center">The Housing Authority of New Orleans (HANO) would like to thank you for your interest in our Housing Choice Voucher Program, 
                                                    formerly called Section 8. In an effort to ensure that HANO tenants are viewing the most up-to-date listings possible the 
                                                    Housing Choice Connect site requires a listing renewal every 30 days. </h4>
                        </div>
                 </div>
              </div>
                <div class="col-md-4 col-md-offset-2">
                    <div class="panel panel-success">
                        <div class="panel-heading text-center">
                            <h1 class="panel-title">Landlord Sign Up</h1>
                        </div>
                        <div class="panel-body">
                            <div class="form">
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                                    <asp:TextBox ID="email" runat="server" class="form-control" placeholder="Email" name="email" maxlength="100"></asp:TextBox>
                                </div>
                                <asp:HiddenField ID="hdCode" runat="server"></asp:HiddenField>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                                    <asp:TextBox ID="confEmail" runat="server" class="form-control" placeholder="Confirm Email" name="confEmail"  maxlength="100"></asp:TextBox>
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                    <asp:TextBox ID="password" runat="server" class="form-control" placeholder="Password"   name="password" maxlength="50"></asp:TextBox>
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                    <asp:TextBox ID="firstName" runat="server" class="form-control" placeholder="First Name" name="firstName" maxlength="50"></asp:TextBox>
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                    <asp:TextBox ID="lastName" runat="server" class="form-control" placeholder="Last Name" name="lastName" maxlength="50"></asp:TextBox>
                                </div>  
                                 <button type="button" class="btn btn-info btn-block btn-lg" id="btnTenantSignUp" runat="server" onserverclick="btnSubmitClick">
                                        <i class="fa fa-upload"></i> Sign Up
                                 </button>
                                 <div class="input-group input-group-lg inputFormat">
                                    <asp:Label ID="lblMsg" runat="server" Style="font-size: 14px; font-weight: 700;
                                        color: #1A926A" EnableViewState="False">
                                    </asp:Label>
                                 </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <section id="benefits" class="benefits">
        <div class="container">           
            <div class="row">
             <div class="col-lg-10 text-center">
                  <h2 class="col-md-offset-3"><i class="fa fa-balance-scale"></i> Landlord Benefits<hr class="small"/></h2>
                  <div class="col-lg-10 col-md-offset-3">
                    <div class="col-md-6">
                      <div class="flip3D">
                        <div class="back">
                          <br />
                          <br />
                          <br />
                          <p class="white-color">Easily add, modify, and remove <i>PROPERTIES</i> to indicate to tenants openess of homes</p>
                        </div>
                        <div class="front">
                            <h4 class="white-color">Easily Manage Properties</h4>
                            <i class="fa fa-home big-icon"></i>
                        </div>
                      </div>
                    </div>

                    <div class="col-md-6">
                        <div class="flip3D">
                            <div class="back">
                                <br />
                                <br />
                                <br />
                                   <p class="white-color">A <i>DASHBOARD</i> to easily access personal information, properties and additional content</p>
                            </div>
                            <div class="front">
                                    <h4 class="white-color">Dashboard for Easy Access</h4>
                                    <i class="fa fa-tasks big-icon"></i>
                            </div>
                        </div>
                    </div>
                  </div>
             </div>
            </div>
        </div>
    </section>
</asp:Content>
