Imports System.Security.Cryptography
Imports System.Text

Namespace UniqueKey
    Public Class KeyGenerator
        Public Shared Function GetUniqueKey(maxSize As Integer) As String
            Dim chars As Char() = New Char(61) {}
            chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".ToCharArray()
            Dim data As Byte() = New Byte(0) {}
            Using crypto As New RNGCryptoServiceProvider()
                crypto.GetNonZeroBytes(data)
                data = New Byte(maxSize - 1) {}
                crypto.GetNonZeroBytes(data)
            End Using
            Dim result As New StringBuilder(maxSize)
            For Each b As Byte In data
                result.Append(chars(b Mod (chars.Length)))
            Next
            Return result.ToString()
        End Function
    End Class
End Namespace
