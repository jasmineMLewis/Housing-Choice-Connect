<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UnloggedUser.Master"
    CodeBehind="ContactUs.aspx.vb" Inherits="HanoChoiceConnect.ContactUs" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/custom.css" rel="stylesheet" />
    <link href="Styles/sb-admin-2.css" rel="stylesheet" />
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
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-phone fa-fw"></i>&nbsp;|&nbsp;<i class="fa fa-envelope fa-fw"></i>&nbsp;Contact Us</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-phone fa-fw"></i>&nbsp;Phone</div>
                        <div class="panel-body">
                            <div class="panel panel-success text-center">
                                <div class="panel-heading">
                                    <h3 class="panel-title text-center">
                                        <i class="fa fa-phone" aria-hidden="true"></i>&nbsp;Contact Us via Phone</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="picture">
                                        <i class="fa fa-phone big-icon" aria-hidden="true"></i>
                                    </div>
                                    <div id="hanoPhoneInfo">
                                        <h2>
                                            Phone Contact Info</h2>
                                        <div class="text-center">
                                            <ul class="list-group">
                                                <li class="list-group-item">
                                                    <p>
                                                        <strong>Housing Authority of New Orleans</strong></p>
                                                    <p>
                                                        4100 Touro St</p>
                                                    <p>
                                                        New Orleans, LA 70122</p>
                                                    <p>
                                                        <i class="fa fa-calendar" aria-hidden="true"></i> &nbsp;Monday - Friday, 8AM - 5PM</p>
                                                    <p>
                                                        <i class="fa fa-phone fa-fw"></i>&nbsp;<strong>Main</strong> (504) 670 - 3300</p>
                                                </li>
                                            </ul>
                                            <ul class="list-group">
                                                <li class="list-group-item">
                                                    <p>
                                                        Need assistance with Housing Choice Connect
                                                    </p>
                                                    <p>
                                                        <i class="fa fa-phone fa-fw"></i> &nbsp;<strong>Housing Choice Connect</strong> &nbsp;(504) 670- 3300
                                                    </p>
                                                    <p> <i class="fa fa-envelope fa-fw"></i> &nbsp;<strong>Housing Choice Connect</strong> &nbsp;hconnect@hano.org</p>
                                                </li>
                                            </ul>
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
                            <i class="fa fa-envelope fa-fw"></i>&nbsp;Email</div>
                        <div class="panel-body">
                            <div class="panel panel-success text-center">
                                <div class="panel-heading">
                                    <h3 class="panel-title text-center">
                                        <i class="fa fa-envelope" aria-hidden="true"></i>&nbsp;Contact Us via Email</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="picture">
                                        <i class="fa fa-envelope big-icon" aria-hidden="true"></i>
                                    </div>
                                    <div id="Div1">
                                        <div class="form">
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span>
                                                </span>
                                                <asp:TextBox ID="name" runat="server" class="form-control" placeholder="Name" name="name" MaxLength="50"  required="required"></asp:TextBox>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-earphone">
                                                </span></span>
                                                <asp:TextBox ID="phone" runat="server" class="form-control" placeholder="Phone" MaxLength="10" required="required"></asp:TextBox>
                                            </div>
                                            <div class="input-group input-group-lg inputFormat">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-envelope">
                                                </span></span>
                                                <asp:TextBox ID="email" runat="server" class="form-control" placeholder="Email" MaxLength="100" required="required"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <asp:TextBox runat="server" class="form-control" placeholder="Comment" cols="15"
                                                    Style="height: 165px" Rows="15" ID="comment" name="comment" required="required"></asp:TextBox>
                                            </div>
                                            <button type="button" class="btn btn-info btn-block btn-lg" id="emailUs" runat="server"
                                                onserverclick="btnSubmitClick">
                                                <i class="fa fa-envelope"></i>&nbsp;Email Us
                                            </button>
                                            <div class="input-group input-group-lg entityIDFormat">
                                                <p>
                                                    <asp:Label ID="lblMsg" runat="server" Style="font-size: 14px; font-weight: 700; color: #1A926A"
                                                        EnableViewState="False"></asp:Label></p>
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
    </div>
</asp:Content>
