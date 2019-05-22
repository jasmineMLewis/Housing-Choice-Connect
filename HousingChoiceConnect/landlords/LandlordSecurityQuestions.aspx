<%@ Page Title="Housing Choice Connect" Language="vb" AutoEventWireup="false" MasterPageFile="~/UserDashboard.Master"
    CodeBehind="LandlordSecurityQuestions.aspx.vb" Inherits="HousingChoiceConnect.LandlordSecurityQuestions" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/custom.css" rel="stylesheet" />
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
           
        Dim securityQuestionsID As Integer
        securityQuestionsID = Request.QueryString("SecurityQuestionsState")
    %>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-key fa-fw"></i>&nbsp; Security Questions</h1>
                </div>
            </div>
            <%
                Select Case securityQuestionsID
                    'Questions Not Completed
                    Case 0
                        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
                        conn.Open()
                        Dim questions As New ArrayList
                        Dim query As New SqlCommand("SELECT Question FROM SecurityQuestion", conn)
                        Dim reader As SqlDataReader = query.ExecuteReader()
                        While reader.Read
                            questions.Add(CStr(reader("Question")))
                        End While
                        conn.Close()
            %>
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default text-center">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <i class="fa fa-plus fa-fw"></i>&nbsp; Answer Security Questions</h3>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title ">
                                        <i class="fa fa-plus fa-fw"></i>&nbsp; Answer Security Questions</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="text-center">
                                        <i class="fa fa-plus big-icon" aria-hidden="true"></i>
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon" id="Span10"><i class="fa fa-plus fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerOne" placeholder="<% Response.Write(questions.Item(0)) %>"
                                            aria-describedby="sizing-addon5" required="required" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon" id="Span1"><i class="fa fa-plus fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerTwo" placeholder="<% Response.Write(questions.Item(1)) %>"
                                            aria-describedby="sizing-addon" required="required" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon" id="Span2"><i class="fa fa-plus fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerThree" placeholder="<% Response.Write(questions.Item(2)) %>"
                                            aria-describedby="sizing-addon" required="required" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="panel panel-default text-center">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <i class="fa fa-plus fa-fw"></i>&nbsp; Answer Security Questions</h3>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title ">
                                        <i class="fa fa-plus fa-fw"></i>&nbsp; Answer Security Questions</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="text-center">
                                        <i class="fa fa-plus big-icon" aria-hidden="true"></i>
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon" id="Span3"><i class="fa fa-plus fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerFour" placeholder="<% Response.Write(questions.Item(3)) %>"
                                            aria-describedby="sizing-addon5" required="required" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon" id="Span4"><i class="fa fa-plus fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerFive" placeholder="<% Response.Write(questions.Item(4)) %>"
                                            aria-describedby="sizing-addon" required="required" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon" id="Span5"><i class="fa fa-plus fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerSix" placeholder="<% Response.Write(questions.Item(5)) %>"
                                            aria-describedby="sizing-addon" required="required" />
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
                                <i class="fa fa-key fa-fw"></i>&nbsp; Submit Security Questions</h3>
                        </div>
                        <div class="panel-body">
                            <div class="text-center">
                                <button type="button" class="btn btn-info btn-block btn-lg" id="AnswerSecurityQuestion"
                                    runat="server" onserverclick="btnAnswerSecurityQuestions">
                                    <i class="fa fa-key"></i>&nbsp; Submit Security Questions
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% 
                'Question Completed
                Case 1
                    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("HousingChoiceConnectConnectionString").ConnectionString)
                    conn.Open()
                    Dim questions As New ArrayList
                    Dim query As New SqlCommand("SELECT Question FROM SecurityQuestion", conn)
                    Dim reader As SqlDataReader = query.ExecuteReader()
                    While reader.Read
                        questions.Add(CStr(reader("Question")))
                    End While
                    conn.Close()

                    conn.Open()
                    Dim responses As New ArrayList
                    Dim queryResponses As New SqlCommand("SELECT Response FROM UserSecurityQuestion WHERE fk_UserID ='" & userID & "'", conn)
                    Dim readerResponses As SqlDataReader = queryResponses.ExecuteReader()
                    While readerResponses.Read
                        responses.Add(CStr(readerResponses("Response")))
                    End While
                    conn.Close()
            %>
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default text-center">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <i class="fa fa-pencil fa-fw"></i>&nbsp; Update Security Questions</h3>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title ">
                                        <i class="fa fa-pencil fa-fw"></i>&nbsp; Update Security Questions</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="text-center">
                                        <i class="fa fa-pencil big-icon"></i>
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionOne" placeholder="<% Response.Write(questions.Item(0)) %>" disabled="disabled" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerOne" placeholer="Answer" value="<% Response.Write(responses.Item(0)) %>" required="required" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionTwo" placeholder="<% Response.Write(questions.Item(1)) %>" disabled="disabled" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerTwo" placeholer="Answer" value="<% Response.Write(responses.Item(1)) %>" required="required" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionThree" placeholder="<% Response.Write(questions.Item(2)) %>" disabled="disabled" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerThree" placeholer="Answer" value="<% Response.Write(responses.Item(2)) %>"
                                           required="required" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="panel panel-default text-center">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <i class="fa fa-pencil fa-fw"></i>&nbsp; Update Security Questions</h3>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title ">
                                        <i class="fa fa-pencil fa-fw"></i>&nbsp; Update Security Questions</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="text-center">
                                        <i class="fa fa-pencil big-icon"></i>
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionFour" placeholder="<% Response.Write(questions.Item(3)) %>"
                                           disabled="disabled" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerFour" placeholer="Answer" value="<% Response.Write(responses.Item(3)) %>"
                                            required="required" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionFive" placeholder="<% Response.Write(questions.Item(4)) %>"
                                            disabled="disabled" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerFive" placeholer="Answer" value="<% Response.Write(responses.Item(4)) %>"
                                            required="required" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionSix" placeholder="<% Response.Write(questions.Item(5)) %>"
                                           disabled="disabled" />
                                    </div>
                                    <div class="input-group input-group-lg inputFormat">
                                        <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
                                        <input type="text" class="form-control" name="securityQuestionAnswerSix" placeholer="Answer" value="<% Response.Write(responses.Item(5)) %>"
                                           required="required" />
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
                                <i class="fa fa-key fa-fw"></i>&nbsp; Submit Security Questions</h3>
                        </div>
                        <div class="panel-body">
                            <div class="text-center">
                                <button type="button" class="btn btn-info btn-block btn-lg" id="UpdateSecurityQuestion"
                                    runat="server" onserverclick="btnUpdateSecurityQuestions">
                                    <i class="fa fa-key"></i>&nbsp; Submit Security Questions
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%     
        End Select
            %>
        </div>
    </div>
</asp:Content>
