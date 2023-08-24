﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AC6_OfferedCoursesReport.aspx.cs" Inherits="AC6_OfferedCoursesReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Offered Courses Report</title>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        #content {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 36px;
            color: #333;
            margin-top: 0;
        }

        p {
            font-size: 20px;
            color: #666;
            margin-bottom: 20px;
        }

        #generate-report-btn {
            background-color: #4CAF50;
            color: #fff;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #generate-report-btn:hover {
            background-color: #45a049;
        }

        #GridView1 {
            border-collapse: collapse;
            width: 100%;
        }

        #GridView1 th,
        #GridView1 td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        #GridView1 th {
            background-color: #4CAF50;
            color: #fff;
        }

        #GridView1 tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        #GridView1 tr:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="TextBox1" runat="server" BackColor="#3366FF" BorderColor="#3399FF"
                    BorderWidth="5px" Columns="2" Font-Size="X-Large" ForeColor="White" Height="40px"
                    Width="100%" ><div class="StdHeader">Flex | Offered Courses Report</div>
            </asp:Label>
            <asp:Label ID="TextBox2" runat="server" BackColor="#000099" BorderColor="#000099"
                    BorderWidth="5px" Font-Size="X-Large" ForeColor="#CC9900" Height="40px"
                    Width="100%" ><div class="StdHeader">Offered Courses Report |
                    <asp:Button Text="Menu" ForeColor="White" runat="server" OnClick="Unnamed_Click" BackColor="#24248B" />
                </div>
            </asp:Label>
        </div>
        <asp:Menu ID="Menu1" runat="server" Font-Size="13" OnMenuItemClick="Menu1_MenuItemClick"
            Font-Underline="True" ForeColor="White" Height="15" Width="50%" Visible="false" EnableTheming="True">
            <Items>
                <asp:MenuItem Text="Home" />
                <asp:MenuItem Text="Offer Courses" />
                <asp:MenuItem Text="Assign Coordinators" />
                <asp:MenuItem Text="Allocate Instructors" />
                <asp:MenuItem Text="Register Users" />
                <asp:MenuItem Text="Audit Trail Report" />
                <asp:MenuItem Text="Offered Courses Report" />
                <asp:MenuItem Text="Course Allocation Report" />
                <asp:MenuItem Text="Student Sections Report" />
                <asp:MenuItem Text="Log out" />
            </Items>
            <StaticHoverStyle BackColor="#0066FF" />
            <StaticMenuItemStyle BorderColor="#3399FF" BorderWidth="2px" Font-Size="20pt" Height="40px" HorizontalPadding="30px" VerticalPadding="10px" />
            <StaticMenuStyle BackColor="#000099" />
        </asp:Menu>
        <br />
        <div id="content">
            <h1>Offered Courses</h1>
            <p>Click the button to show current Offered Courses:</p>
            <div>
                <asp:Button ID="Button1" runat="server" Text="Generate Report" CssClass="btn" ForeColor="White" BackColor="#009900" BorderColor="#003300" BorderStyle="Double" OnClick="Button1_Click"/>
            </div>
            <br /><br />
            <div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="Course_Code" HeaderText="Course_Code" />
                        <asp:BoundField DataField="Name" HeaderText="Course_Name" />
                        <asp:BoundField DataField="CrdHrs" HeaderText="Credit_Hours" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>