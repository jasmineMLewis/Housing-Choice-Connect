<%@ Page Title="Housing Choice Connect" Language="vb"  AutoEventWireup="false" MasterPageFile="~/Footer.Master"
    CodeBehind="LandlordPasswordResetSecurityQuestions.aspx.vb" Inherits="HanoChoiceConnect.LandlordpasswordResetSecurityQuestios" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/signIn.css" rel="stylesheet" />
    <link href="Styles/custom.css" rel="stylesheet" />
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

    <div id="landlordSecurityQuestions">
     <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading text-center">
                    <h3 class="panel-title">Landlord Password Reset</h3>
                </div>
                <div class="panel-body">
                            <div class="alert alert-warning text-center" role="alert">Answer 2 of your 6 Random Security Questions</div>
                        <div class="text-center">
                            <i class="fa fa-key big-icon" aria-hidden="true"></i>
                        </div>
                        <div class="formEmail">
                            <br />
                            <form id="questionsAnswers">
                            <%
                                      Dim email As String
                                      If email = Nothing Then
                                          email = Request.QueryString("Email")
                                      End If
                                      
                                      If Not email Is Nothing Then
                                          Response.Write("<div class='alert alert-success text-center' role='alert'>Your email address is: " & email & "</div>")
                                      Else
                                          Response.Write("<div class='alert alert-danger text-center' role='alert'>Click <a href='LandlordEmailPasswordReset.aspx'>HERE</a>, if your email is not displaying</div>")
                                      End If

                                    Dim list As New ArrayList
                                    Dim questionID As New ArrayList
                                    Dim questions As New ArrayList
                                    Dim rand As New Random
                                    Dim index As Integer

                                    For i As Integer = 0 To 5
                                        list.Add(i)
                                    Next (i)

                                    While (list.Count > 4)
                                        index = rand.Next(0, list.Count)
                                        questionID.Add(list(index))
                                        list.RemoveAt(index)
                                    End While
                                      
                                    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")
                                    conn.Open()
                                     
                                    Dim queryQuestion As New SqlCommand("SELECT Question FROM SecurityQuestion", conn)
                                    Dim readerQuestion As SqlDataReader = queryQuestion.ExecuteReader()
                                    While readerQuestion.Read
                                        questions.Add(CStr(readerQuestion("Question")))
                                    End While
                                    conn.Close()
                                 %>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-question-sign"></span></span>
                                    <input type="text" class="form-control" value="<% Response.Write(questions.Item(questionID.Item(0))) %>" disabled="disabled" />
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"> </span></span>
                                    <asp:TextBox ID="securityQuestionAnswerOne" runat="server" class="form-control" name="securityQuestionAnswerOne"
                                        placeholder="Security Question Answer" maxlength="50">
                                    </asp:TextBox>
                                </div>
                                <input type="hidden" id="questionOneID" name="questionOneID" value="<% Response.Write(questionID.Item(0)) %>"/>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-question-sign">  </span></span>
                                    <input type="text" class="form-control" value="<% Response.Write(questions.Item(questionID.Item(1))) %>" disabled="disabled" />
                                </div>
                                <div class="input-group input-group-lg inputFormat">
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"> </span></span>
                                        <asp:TextBox ID="securityQuestionAnswerTwo" runat="server" class="form-control" name="securityQuestionAnswerTwo"
                                         placeholder="Security Question Answer" maxlength="50">
                                        </asp:TextBox>
                                    <input type="hidden" id="questionTwoID" name="questionTwoID" value="<% Response.Write(questionID.Item(1)) %>"/>
                                </div>
                                 <button type="button" class="btn btn-info btn-block btn-lg" id="btnSecurityQuestions" runat="server" onserverclick="btnSubmitClick">
                                    <i class="fa fa-key"></i> Reset Password
                                 </button>
                                   <div class="input-group input-group-lg inputFormat">
                                <asp:Label ID="lblMsg" runat="server" Style="font-size: 14px; font-weight: 700; color: #1A926A"
                                    EnableViewState="False">
                                </asp:Label>
                            </div>
                            </form>
                        </div>
                </div>
            </div>
        </div>
     </div>
    </div>
</asp:Content>