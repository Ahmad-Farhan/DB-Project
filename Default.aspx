<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="LogIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel = "stylesheet" type = "text/css" href = "~/StyleSheet.css" />
    <title>Flex</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" BackColor="#3366FF" BorderColor="#3399FF"
                    BorderWidth="5px" Columns="2" Font-Size="X-Large" ForeColor="White" Height="40px"
                    Width="100%" ><div class="StdHeader">Flex | </div>
            </asp:Label>
            <asp:Label ID="Label5" runat="server" BackColor="#000099" BorderColor="#000099"
                    BorderWidth="5px" Font-Size="X-Large" ForeColor="#CC9900" Height="40px"
                    Width="100%" ><div class="StdHeader">LogIn | </div>
            </asp:Label>
        </div>
        <br /><br />
        <div class="logInFormat">
            <p dir="ltr">
                &nbsp;</p>
            <p>
                <asp:Label ID="Label2" runat="server" Text="Username" Width="40%"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" Height="18px" Width="50%"></asp:TextBox>
            </p>
            <p>
                <asp:Label ID="Label3" runat="server" Text="Password" Width="40%"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" Height="18px" Width="50%"></asp:TextBox>
            </p>
            <p style="height: 0px">
                &nbsp;</p>
            <p>
                <asp:Button ID="LogInButton" runat="server" OnClick="Button1_Click" Text="Login" CssClass="logInButton" Width="200px" />
            </p>
            <p>
                <asp:Label ID="LoginErrorLabel" runat="server" CssClass="loginError" ForeColor="Red" Text="Invalid Username or Password Entered" Visible="False"></asp:Label>
            </p>
            <p>
                &nbsp;</p>
        </div>
        <br /><br /><br />
    </form>
</body>
</html>
