<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="AdminEditLandlord.aspx.vb" Inherits="HanoChoiceConnect.AdminEditLandlord" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/custom.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Dim landlordUserID As String
        If landlordUserID = Nothing Then
            landlordUserID = Request.QueryString("LandlordUserID")
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
        Dim query As New SqlCommand("SELECT FirstName, LastName, Email, Password FROM Users WHERE UserID='" & landlordUserID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            firstName = CStr(reader("FirstName"))
            lastName = CStr(reader("LastName"))
            email = CStr(reader("Email"))
            password = CStr(reader("Password"))
        End While
        conn.Close()
        
        conn.Open()
        Dim questions As New ArrayList
        Dim queryQuestions As New SqlCommand("SELECT Question FROM SecurityQuestion", conn)
        Dim readerQuestions As SqlDataReader = queryQuestions.ExecuteReader()
        While readerQuestions.Read
            questions.Add(CStr(readerQuestions("Question")))
        End While
        conn.Close()
        
        conn.Open()
        Dim responses As New ArrayList
        Dim queryResponses As New SqlCommand("SELECT Response FROM UserSecurityQuestion WHERE fk_UserID ='" & landlordUserID & "'", conn)
        Dim readerResponses As SqlDataReader = queryResponses.ExecuteReader()
        While readerResponses.Read
            responses.Add(CStr(readerResponses("Response")))
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
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">
                            <i class="fa fa-key fa-fw"></i>&nbsp; Security Questions
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success text-center">
                                <div class="panel-heading">
                                    <h3 class="panel-title text-center">
                                        <i class="fa fa-key fa-fw"></i>&nbsp; Security Questions</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="picture">
                                        <i class="fa fa-key big-icon"></i>
                                    </div>
                                    <div class="form">
                                        <h2>
                                            Security Questions</h2>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionOne" placeholder="<% Response.Write(questions.Item(0)) %>"
                                                disabled="disabled" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionAnswerOne" placeholer="Answer"
                                                value="<% Response.Write(responses.Item(0)) %>" required="required" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionTwo" placeholder="<% Response.Write(questions.Item(1)) %>"
                                                disabled="disabled" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionAnswerTwo" placeholer="Answer"
                                                value="<% Response.Write(responses.Item(1)) %>" required="required" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionThree" placeholder="<% Response.Write(questions.Item(2)) %>"
                                                disabled="disabled" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionAnswerThree" placeholer="Answer"
                                                value="<% Response.Write(responses.Item(2)) %>" required="required" />
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
                            <i class="fa fa-key fa-fw"></i>&nbsp; Security Questions
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success text-center">
                                <div class="panel-heading">
                                    <h3 class="panel-title text-center">
                                        <i class="fa fa-key fa-fw"></i>&nbsp; Security Questions</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="picture">
                                        <i class="fa fa-key big-icon"></i>
                                    </div>
                                    <div class="form">
                                        <h2>
                                            Security Questions</h2>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionFour" placeholder="<% Response.Write(questions.Item(3)) %>"
                                                disabled="disabled" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionAnswerFour" placeholer="Answer"
                                                value="<% Response.Write(responses.Item(3)) %>" required="required" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionFive" placeholder="<% Response.Write(questions.Item(4)) %>"
                                                disabled="disabled" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionAnswerFive" placeholer="Answer"
                                                value="<% Response.Write(responses.Item(4)) %>" required="required" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionSox" placeholder="<% Response.Write(questions.Item(5)) %>"
                                                disabled="disabled" />
                                        </div>
                                        <div class="input-group input-group-lg inputFormat">
                                            <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                            <input type="text" class="form-control" name="securityQuestionAnswerSix" placeholer="Answer"
                                                value="<% Response.Write(responses.Item(5)) %>" required="required" />
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
                                <i class="fa fa-pencil fa-fw"></i>&nbsp; Update Landlord</h3>
                        </div>
                        <div class="panel-body">
                            <div class="text-center">
                                <button type="button" class="btn btn-info btn-block btn-lg" runat="server" onserverclick="btnUpdateLandlord">
                                    <i class="fa fa-pencil"></i>&nbsp; Update Landlord
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
