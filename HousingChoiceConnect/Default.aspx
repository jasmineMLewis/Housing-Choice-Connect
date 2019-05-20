<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Footer.Master" CodeBehind="Default.aspx.vb" 
    Inherits="HousingChoiceConnect._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/default.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
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
                <li><a href="#home" class="white-color"><i class="fa fa-home"></i> Home</a></li>
                <li><a href="#about" class="white-color"><i class="fa fa-book"></i> About</a></li>
                <li><a href="#services" class="white-color"><i class="fa fa-bars"></i> Services</a></li>
                <li><a href="#tutorials" class="white-color"><i class="fa fa-play"></i> Tutorials</a></li>
                <li><a href="#contact" class="white-color"><i class="fa fa-phone"></i> Contact</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right" style="margin-right: 150px;">
                <li>
                 <div class="dropdownBtn">
                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" name="btnSignIn" id="btnSignIn"><i class="fa fa-download"></i> Sign In <span class="caret"></span></button>
                    <ul class="dropdown-menu" role="menu">
                          <li>
                            <a href="/sign_in/TenantSignIn.aspx"><i class="fa fa-user">&nbsp; <b>Tenant</b></i>  <span class="tab-space-tenant"></span>
                                 <span class="glyphicon glyphicon-chevron-right"></span></a>
                          </li>
                        <li>
                            <a href="/sign_in/LandlordSignIn.aspx"><i class="fa fa-home">&nbsp; <b>Landlord</b></i> <span class="tab-space-landlord"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                        <li>
                            <a href="/sign_in/AdminSignIn.aspx"><i class="fa fa-lock">&nbsp; <b>Admin</b></i> <span class="tab-space-admin"></span>
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
                            <a href="TenantSignUp.aspx"><i class="fa fa-user">&nbsp; <b>Tenant</b></i> <span class="tab-space-tenant"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                        <li>
                            <a href="LandlordSignUp.aspx"><i class="fa fa-home">&nbsp; <b>Landlord</b></i> <span class="tab-space-landlord"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                    </ul>
                  </div>
                </li>
            </ul>
        </div>
    </nav>
    <header id="home" class="home">
     <section class="section-carousel">
      <div class="carousel-container">
       <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            <li data-target="#carousel-example-generic" data-slide-to="3"></li>
            <li data-target="#carousel-example-generic" data-slide-to="4"></li>
          </ol>
         <div class="carousel-inner">
            <div class="item active">
                <img src="img/carousel2.png" alt="Tenant Property Search" width="auto" height="auto" />
                 <div class="carousel-caption"><h2></h2></div>
            </div>
           <div class="item">
                <img src="img/carousel1.png" alt="Tenant Filter Properties" width="auto" height="auto" />
                <div class="carousel-caption"><h2></h2></div>
           </div>
           <div class="item">
            <img src="img/carousel3.png" alt="Landlord Dashboard" width="auto" height="auto" />
            <div class="carousel-caption"><h2></h2></div>
           </div>
           <div class="item">
            <img src="img/carousel5.png" alt="Landlord Active Properties" width="auto" height="auto" />
            <div class="carousel-caption"><h2></h2></div>
           </div>
           <div class="item">
            <img src="img/carousel4.png" alt="Landlord Add Property" width="auto" height="auto" />
            <div class="carousel-caption"><h2></h2></div>
           </div>
         </div>
       </div>
      </div>
     </section>
    </header>
    <section id="about" class="about">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                     <h2><i class="fa fa-book"></i> Housing Choice Connect</h2>
                    <hr class="small" />
                    <p class="lead">Redeveloped in 2016, the Housing Choice Connect program
                        allows HCVP voucher holders and participating landlords to easily search through
                        or add rental properties without reviewing an extensive list.
                    </p>
                </div>
            </div>
        </div>
    </section>
    <section id="services" class="services">
        <div class="container">
            <div class="row text-center">
                <div class="col-lg-10 col-lg-offset-1">
                    <h2 class="white-color"><i class="fa fa-bars"></i> Our Services</h2>
                    <hr class="small" />
                    <div class="row">
                        <div class="col-md-3 col-sm-6">
                            <div class="service-item">
                                <span class="fa-stack fa-4x">
                                    <i class="fa fa-circle fa-stack-2x white-color"></i>
                                    <i class="fa fa-home fa-stack-1x text-primary"></i>
                                </span>
                                <h4>
                                    <strong class="white-color">Search Houses Based on Location</strong>
                                </h4>
                                <p class="white-color">Tenants can search listings based on neighborhoods or zip codes</p>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="service-item">
                               <span class="fa-stack fa-4x">
                                <i class="fa fa-circle fa-stack-2x white-color"></i>
                                <i class="fa fa-filter fa-stack-1x text-primary"></i>
                               </span>
                                <h4>
                                    <strong class="white-color">Search Houses via Filters</strong>
                                </h4>
                                <p class="white-color">Tenants can use a plethora of filters to find the PERFECT home</p>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="service-item">
                                <span class="fa-stack fa-4x">
                                    <i class="fa fa-circle fa-stack-2x white-color"></i>
                                    <i class="fa fa-user fa-stack-1x text-primary"></i>
                                </span>
                                <h4>
                                    <strong class="white-color">Easy Access to Personal Info</strong>
                                </h4>
                                <p class="white-color">Users have easy access to manage their personal information</p>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="service-item">
                                <span class="fa-stack fa-4x">
                                 <i class="fa fa-circle fa-stack-2x white-color"></i>
                                 <i class="fa fa-tasks fa-stack-1x text-primary"></i>
                                </span>
                                <h4>
                                    <strong class="white-color">View Active, Inactive & Proximity Properties</strong>
                                </h4>
                                <p class="white-color">Landlords have a dashboard for easy access to rental listings</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section id="tutorials" class="tutorials">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 text-center">
                    <h2><i class="fa fa-play"></i> Tutorials</h2>
                    <hr class="small" />
                    <div class="row">
                      <div class="col-sm-6">
                            <div class="embed-responsive embed-responsive-16by9">
                                 <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/-c9XAsDTITk" allowfullscreen></iframe>
                            </div>
                      </div>
                      <div class="col-sm-6">
                            <div class="embed-responsive embed-responsive-16by9">
                                 <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/_VC6lKYgT24" allowfullscreen></iframe>
                            </div>
                      </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="embed-responsive embed-responsive-16by9">
                                 <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/vrkbzuotivg" allowfullscreen></iframe>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="embed-responsive embed-responsive-16by9">
                                 <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/S9sGqM7C4ks" allowfullscreen></iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>