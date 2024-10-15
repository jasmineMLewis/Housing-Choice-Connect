<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/Footer.Master"
    CodeBehind="EmailVerification.aspx.vb" Inherits="HanoChoiceConnect.EmailVerification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/custom.css" rel="stylesheet" />
    <link href="Styles/signIn.css" rel="stylesheet" />
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
            <ul class="nav navbar-nav navbar-right" style = "margin-right: 150px;">
            <li>
                <div class="dropdownBtn">
                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" name="btnSignIn" id="btnSignIn"><i class="fa fa-download"></i> Sign In <span class="caret"></span></button>
                    
                    <ul class="dropdown-menu" role="menu">
                          <li>
                            <a href="TenantSignIn.aspx"><i class="fa fa-user"> <b>Tenant</b></i> <span class="tab-space-tenant"></span>
                                 <span class="glyphicon glyphicon-chevron-right"></span></a>
                          </li>
                        <li><a href="LandlordSignIn.aspx"><i class="fa fa-home"> <b>Landlord</b></i> <span class="tab-space-landlord"></span>
                        <span class="glyphicon glyphicon-chevron-right"></span></a></li>
                    </ul>      
                </div>
            </li>
            <li>
                <div class="dropdownBtn">
                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" name="btnSignUp" id="btnSignUp"><i class="fa fa-upload"></i> Sign Up <span class="caret"></span></button>
                    <ul class="dropdown-menu" role="menu">
                        <li>
                            <a href="TenantSignUp.aspx"><i class="fa fa-user"> <b>Tenant</b></i> <span class="tab-space-tenant"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                        <li>
                            <a href="LandlordSignUp.aspx"><i class="fa fa-home"> <b>Landlord</b></i> <span class="tab-space-landlord"></span>
                            <span class="glyphicon glyphicon-chevron-right"></span></a>
                        </li>
                    </ul>
                </div>
            </li>
            </ul>
        </div>
   </nav>
    <div id="emailVerification">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default">
                    <div class="panel-heading text-center">
                        <h3 class="panel-title">
                            Email Verification</h3>
                    </div>
                    <div class="panel-body">
                        <div class="alert alert-warning text-center" role="alert">
                            Haven't received the code yet? &nbsp;<a href="SendEmailVerification.aspx">Send NEW Code</a></div>
                        <div class="text-center">
                            <i class="fa fa-envelope big-icon" aria-hidden="true"></i>
                        </div>
                        <div class="form">
                            <div class="description text-center">
                                <p>
                                    <b>Enter the verification code</b>
                                </p>
                                <%
                                    Dim email As String
                                    If Not Web.HttpContext.Current.Session("Email") Is Nothing Then
                                        email = Web.HttpContext.Current.Session("Email").ToString()
                                    End If
                                    
                                    If Not email Is Nothing Then
                                        Response.Write("<p>An email message with a verification code was just sent to <u>" & email & "</u></p>")
                                %>
                                <div class="alert alert-success" role="alert">
                                    You will receive an email confirming your information within the next 5 minutes.
                                </div>
                                <%
                                End If

                                If email Is Nothing Then
                                %>
                                <div class="alert alert-danger" role="alert">
                                    There was a error with your registreation. Please immediately contact HANO.</div>
                                <%
                                End If
                                %>
                            </div>
                            <div class="form">
                                <div class="input-group input-group-lg">
                                    <span class="input-group-addon" id="Span1"><span class="glyphicon glyphicon-tag"></span>
                                    </span>
                                    <asp:TextBox ID="verificationCode" runat="server" class="form-control" placeholder="Enter Email Verification Code"
                                        name="verificationCode" aria-describedby="sizing-addon5"></asp:TextBox>
                                </div>
                                <br />
                                <button type="button" class="btn btn-info btn-block btn-lg" id="btnEmailVerificationCode" runat="server" onserverclick="btnSubmitClick">
                                    <i class="fa fa-envelope"></i> &nbsp; Verify Email Adrdress
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
    </div>

     <div id="space" style="margin-top: 120px;">
    </div>
</asp:Content>
