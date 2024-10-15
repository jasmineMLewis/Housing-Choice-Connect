<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/Footer.Master"
    CodeBehind="TenantSignUp.aspx.vb" Inherits="HanoChoiceConnect.TenantSignUp" %>

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
            <a class="logo" href="Default.aspx"><img src="img/hanoLogo.png" alt="hanoLogo"></a>
        </div>
        <div id="navbarCollapse" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="#top" class="white-color"><i class="fa fa-home"></i> Home</a></li>
                <li><a href="#benefits" class="white-color"><i class="fa fa-balance-scale"></i> Benefits</a></li>
                <li><a href="#contact" class="white-color"><i class="fa fa-phone"></i> Contact</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right" style = "margin-right: 150px;">
                <li>
                <div class="dropdownBtn">
                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" name="btnSignIn" id="btnSignIn"><i class="fa fa-download"></i> Sign In <span class="caret"></span></button>
                    
                    <ul class="dropdown-menu" role="menu">
                          <li>
                            <a href="TenantSignIn.aspx"><i class="fa fa-user">&nbsp; <b>Tenant</b></i>  <span class="tab-space-tenant"></span>
                                 <span class="glyphicon glyphicon-chevron-right"></span></a>
                          </li>
                        <li><a href="LandlordSignIn.aspx"><i class="fa fa-home">&nbsp; <b>Landlord</b></i> <span class="tab-space-landlord"></span>
                        <span class="glyphicon glyphicon-chevron-right"></span></a></li>
                    </ul>      
                </div>
            </li>
            <li>
                <div class="dropdownBtn">
                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" name="btnSignUp" id="btnSignUp"><i class="fa fa-upload"></i> Sign Up <span class="caret"></span></button>
                    <ul class="dropdown-menu" role="menu">
                        <li>
                            <a href="TenantSignUp.aspx"><i class="fa fa-user">&nbsp; <b>Tenant</b></i> <span class="tab-space-tenant"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                        <li>
                            <a href="LandlordSignUp.aspx"><i class="fa fa-home">&nbsp; <b>Landlord</b></i><span class="tab-space-landlord"></span>
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
              <div class="col-md-4 col-md-offset-1">
                 <div class="panel panel-success">
                        <div class="panel-heading text-center">
                            <h1 class="panel-title">Your Perfect Home</h1>
                        </div>
                        <div class="panel-body">
                             <h2 class="text-center"><i>SIGN UP</i> to find your <i>NEXT</i> perfect</h2> 
                             <p><h2 class="text-center"><i><span class="label label-warning">HOME</span></i></h2></p>
                             <br />
                             <h4 class="text-center">Search &amp; filter Section 8 properties in the New Orleans area that meet your needs</h4>
                           <br />
                           <p class="text-center"><a href="#benefits" class="btn btn-info btn-lg text-center">View Benefits</a></p>
                        </div>
                 </div>
              </div>
                <div class="col-md-4 col-md-offset-2">
                    <div class="panel panel-success">
                        <div class="panel-heading text-center">
                            <h1 class="panel-title">Tenant Sign Up</h1>
                        </div>
                        <div class="panel-body">
                            <div class="form">
                                <div class="input-group input-group-lg inputFormat">
                                      <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                                      <asp:TextBox ID="email" runat="server" class="form-control" placeholder="Email" maxlength="100"></asp:TextBox>
                                </div>
                                <asp:HiddenField ID="hdCode" runat="server"></asp:HiddenField>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                                    <asp:TextBox ID="confEmail" runat="server" class="form-control" placeholder="Confirm Email" maxlength="100"></asp:TextBox>
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                    <asp:TextBox ID="password" runat="server" class="form-control" placeholder="Password" name="password" TextMode="Password" maxlength="50"></asp:TextBox>
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                    <asp:TextBox ID="firstName" runat="server" class="form-control" placeholder="First Name" name="firstName" maxlength="50"></asp:TextBox> 
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                    <asp:TextBox ID="lastName" runat="server" class="form-control" placeholder="Last Name"  name="lastName"  maxlength="50"></asp:TextBox>
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-italic"></span></span>
                                    <asp:TextBox ID="tenantEntityID" runat="server" class="form-control" placeholder="Tenant Entity ID ( i.e. 000012345)" name="tenantEntityID" maxlength="9"></asp:TextBox>
                                </div>
                                <div class="inputFormat">
                                    &nbsp; &nbsp; 
                                  <a href="http://www.hano.org/housing/hcvp_caseload_tenantid_lookup.aspx" target="_blank">
                                    <span class="glyphicon glyphicon-search"></span>&nbsp; Click here to lookup your Tenant Entity ID
                                  </a> 
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                   <span class="input-group-addon"><span class="glyphicon glyphicon-flash"></span></span>
                                   <asp:TextBox ID="lastFourSSN" runat="server" class="form-control" placeholder="Last Four of Social Security Number (i.e. 2345)"  name="lastFourSSN"  maxlength="4"></asp:TextBox>
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
            <div class="row">
                <div class="col-lg-10 text-center">
                    <h2 class="col-md-offset-3"><i class="fa fa-balance-scale"></i> Tenant Benefits<hr class="small"/></h2>
                    <div class="col-lg-10 col-md-offset-4">
                     <div class="col-md-4">
                       <div class="flip3D">
                        <div class="back">
                          <br />
                          <br />
                          <br />
                            <p class="white-color">Easily <i>FILTER</i> properties to locate your desired home preferences</p>
                        </div>
                        <div class="front">
                            <h4 class="white-color">Filter Properties</h4><i class="fa fa-filter big-icon"></i>
                        </div>
                       </div>
                     </div>

                     <div class="col-md-4">
                       <div class="flip3D">
                        <div class="back">
                          <br />
                          <br />
                          <br />
                            <p class="white-color">Easily <i>SEARCH</i> properties without having to scroll down a long list</p>
                        </div>
                        <div class="front">
                            <h4 class="white-color">Search Properties</h4><i class="fa fa-search big-icon"></i>
                        </div>
                       </div>
                     </div>
                    </div>
                </div>
            </div>
    </section>
</asp:Content>
