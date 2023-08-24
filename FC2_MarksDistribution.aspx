﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FC2_MarksDistribution.aspx.cs" Inherits="FC2_MarksDistribution" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Set Marks Distribution</title>
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
            font-weight: 700;
        }
        </style>
    <link rel = "stylesheet" type = "text/css" href = "~/StyleSheet.css" />
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div style="text-align:left">
            <asp:Label ID="Label1" runat="server" BackColor="#3366FF" BorderColor="#3399FF"
                    BorderWidth="5px" Columns="2" Font-Size="X-Large" ForeColor="White" Height="40px"
                    Width="100%" ><div class="StdHeader">Flex | Faculty Profile</div>
            </asp:Label>
            <asp:Label ID="TextBox2" runat="server" BackColor="#000099" BorderColor="#000099"
                    BorderWidth="5px" Font-Size="X-Large" ForeColor="#CC9900" Height="40px"
                    Width="100%" ><div class="StdHeader">Marks Distribution |
                    <asp:Button Text="Menu" ForeColor="White" runat="server" OnClick="Unnamed_Click" BackColor="#24248B" />
                </div>
            </asp:Label>
        </div>
        <asp:Menu ID="Menu1" runat="server" Font-Size="13" OnMenuItemClick="Menu1_MenuItemClick"
            Font-Underline="True" ForeColor="White" Height="15" Width="50%" Visible="false" EnableTheming="True">
            <Items>
                <asp:MenuItem Text="Home" />
                <asp:MenuItem Text="Mark Attendence" />
                <asp:MenuItem Text="Set Marks Distribution" />
                <asp:MenuItem Text="Mark Evaluations" />
                <asp:MenuItem Text="Finalize Grades" />
                <asp:MenuItem Text="Grade Report" />
                <asp:MenuItem Text="Feedback Report" />
                <asp:MenuItem Text="Transcript Report" />
                <asp:MenuItem Text="Log out" />
            </Items>
            <StaticHoverStyle BackColor="#0066FF" />
            <StaticMenuItemStyle BorderColor="#3399FF" BorderWidth="2px" Font-Size="20pt" Height="40px" HorizontalPadding="30px" VerticalPadding="10px" />
            <StaticMenuStyle BackColor="#000099" />
        </asp:Menu>
        <br /><br />
        <div class="UserRegTables"style="border: 3px solid #3399FF">
            <div class="auto-style1">
                <asp:Label ID="UserTypeHeader" runat="server" BackColor="#3366FF" 
                    Font-Size="X-Large" ForeColor="White" Height="50px" Width="100%" >Marks Distribution
                </asp:Label>                 
                <br /><br />
                <asp:DropDownList ID="DropDownList1" runat="server" Width="50%" AutoPostBack="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Font-Size="14pt" >
                </asp:DropDownList>
            </div>
            <p class="COTxtBoxes">
                <asp:PlaceHolder ID="PlaceHolder4" runat="server" Visible="false"></asp:PlaceHolder><br />
                <asp:Label ID="Label3" runat="server" Text="Evaluation Title" Width="30%" Font-Size="14pt"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" AutoPostBack="True" Width="50%" Font-Size="14pt" ></asp:TextBox>
            </p>
            <p class="COTxtBoxes">
                <asp:PlaceHolder ID="PlaceHolder3" runat="server" Visible="false"></asp:PlaceHolder><br />
                <asp:Label ID="Label4" runat="server" Text="Weightage" Width="30%" Font-Size="14pt"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" Width="50%" Font-Size="14pt"></asp:TextBox>
            </p>
            <p class="COTxtBoxes">
                <asp:PlaceHolder ID="PlaceHolder2" runat="server" Visible="false"></asp:PlaceHolder><br />
                <asp:Label ID="Label5" runat="server" Text="Total Marks" Width="30%" Font-Size="14pt"></asp:Label>
                <asp:TextBox ID="TextBox4" runat="server" Width="50%" Font-Size="14pt"></asp:TextBox>
            </p>
            <p class="COTxtBoxes">
                <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false"></asp:PlaceHolder><br />
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Remove From List" />
                <asp:Label ID="PaddingSpace" runat="server" Width="30%" ></asp:Label>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add To List" Width="172px" />
            </p>
        </div>
        <br /><br />
        <p>
            <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" TabIndex="20" Width="80%" CssClass="CList">
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
        </p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FlexConnectionString %>" DeleteCommand="DELETE FROM [EVALUATION] WHERE [Eval_Id] = @Eval_Id" InsertCommand="INSERT INTO [EVALUATION] ([Name], [Range], [Weightage]) VALUES (@Name, @Range, @Weightage)" SelectCommand="SELECT [Name], [Range], [Eval_Id], [Weightage] FROM [EVALUATION]" UpdateCommand="UPDATE [EVALUATION] SET [Name] = @Name, [Range] = @Range, [Weightage] = @Weightage WHERE [Eval_Id] = @Eval_Id">
            <DeleteParameters>
                <asp:Parameter Name="Eval_Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Range" Type="Byte" />
                <asp:Parameter Name="Weightage" Type="Byte" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Range" Type="Byte" />
                <asp:Parameter Name="Weightage" Type="Byte" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <br />
    </form>
</body>
</html>
