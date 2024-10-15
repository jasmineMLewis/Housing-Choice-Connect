Imports System.Data.SqlClient

Public Class LandlordEmailPasswordReset
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOWEB;Database=HousingChoiceConnect;User Id=hccuser;Password=P@ssword01")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmitClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim _email As String = email.Text
        Dim roleID As Integer

        If (_email = "") Then
            lblMsg.Text = "Oh No! All Fields are REQUIRED"
        Else
            conn.Open()
            Dim query As New SqlCommand("SELECT fk_RoleID FROM Users WHERE Email='" & _email & "'", conn)
            Dim reader As SqlDataReader = query.ExecuteReader()
            If reader.HasRows Then
                While reader.Read
                    roleID = CStr(reader("fk_RoleID"))
                End While
                conn.Close()

                If roleID = 4 Then
                    Response.Redirect("TenantSignIn.aspx")
                ElseIf roleID = 5 Then
                    Response.Redirect("LandlordPasswordResetSecurityQuestions.aspx?Email=" & _email & "")
                End If
            Else
                lblMsg.Text = "Oh No! Email does NOT exists."
            End If
        End If
    End Sub
End Class