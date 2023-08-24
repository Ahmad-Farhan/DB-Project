<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AC8_StudentSectionsReport.aspx.cs" Inherits="AC8_StudentSectionsReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Sections Report</title>
    <style>

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

        #gvResults {
            border-collapse: collapse;
            width: 100%;
        }

        #gvResults th,
        #gvResults td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        #gvResults th {
            background-color: #4CAF50;
            color: #fff;
        }

        #gvResults tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        #gvResults tr:hover {
            background-color: #ddd;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            padding: 0px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .dropdown-label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="TextBox1" runat="server" BackColor="#3366FF" BorderColor="#3399FF"
                BorderWidth="5px" Columns="2" Font-Size="X-Large" ForeColor="White" Height="40px"
                Width="100%" CssClass="StdHeader">Flex | Admin Profile </asp:Label>
            <asp:Label ID="TextBox2" runat="server" BackColor="#000099" BorderColor="#000099"
                    BorderWidth="5px" Columns="2" Font-Size="X-Large" ForeColor="#CC9900" Height="40px"
                    Width="100%" CssClass="StdHeader">Student Sections Report |
                <asp:Button Text="Menu" ForeColor="White" runat="server" OnClick="Unnamed_Click" Horizontal-Align="Left" BackColor="#24248B" />
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
        <div class="container">
            <h1>Parent Section Report</h1>
            <label class="dropdown-label" for="ddlCourses">Select Batch:</label>
            <asp:DropDownList ID="ddlCourses" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCourses_SelectedIndexChanged"></asp:DropDownList>
            <br />
            <br />
            <div id="content">
                <asp:GridView ID="gvResults" runat="server" Width="100%">
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>