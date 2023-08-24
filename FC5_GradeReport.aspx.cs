using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Data;
using ReportPortal.Client.Abstractions.Responses;
using System.Activities.Expressions;
using System.Activities.Statements;
using System.Diagnostics;
using System.Windows.Forms;
using static System.Collections.Specialized.BitVector32;
using System.Reflection;


public partial class FC5_GradeReport : System.Web.UI.Page
{
    static string User_Id;
    static List<string> CourseIds = new List<string>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            User_Id = Request.QueryString["id"];
            // Populate the dropdown list on initial page load
            PopulateCoursesDropDown();
        }
    }

    protected void ddlCourses_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Retrieve the selected course number from the dropdown
        string courseNumber = CourseIds[ddlCourses.SelectedIndex];

        // Fetch the result from the SQL Server based on the selected course number
        DataTable result = GetGradeCount(courseNumber);

        // Bind the result to the GridView control for display
        gvResults.DataSource = result;
        gvResults.DataBind();
    }

    private void PopulateCoursesDropDown()
    {
        int teacherid = Convert.ToInt32(User_Id);
        // Connect to the SQL Server and retrieve the list of course numbers
        GetCourseNumbers(teacherid);
        LogEvent("Generated Gardes Report");
    }

    private void GetCourseNumbers(int TeacherID)
    {
        // Replace "YourConnectionString" with your actual SQL Server connection string
        string connectionString = ConfigurationManager.ConnectionStrings["FlexConnectionString"].ConnectionString;

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = @"SELECT '-' AS Name, 0 as Course_id UNION SELECT C.Name, S.Course_Id FROM SECTION S INNER JOIN OFFEREDCOURSE O ON
                            O.OfferCourse_Id = S.Course_Id INNER JOIN COURSE C ON C.Course_Id = O.Course_Id WHERE Instructor_Id = @instructorId";

            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@instructorId", TeacherID);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                CourseIds.Clear();
                ddlCourses.Items.Clear();
                while (reader.Read())
                {
                    ddlCourses.Items.Add(reader.GetValue(0).ToString());
                    CourseIds.Add(reader.GetValue(1).ToString());
                }
                ddlCourses.DataBind();
                return;
            }
        }
    }

    private DataTable GetGradeCount(string courseNumber)
    {
        // Replace "YourConnectionString" with your actual SQL Server connection string
        string connectionString = ConfigurationManager.ConnectionStrings["FlexConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = @"SELECT Grade, COUNT(Grade) AS Total_Grades FROM TRANSCRIPT T INNER JOIN SECTION S ON S.Section_Id = T.Section_Id
                            INNER JOIN OFFEREDCOURSE O ON O.OfferCourse_Id = S.Course_Id WHERE S.Course_Id = @CourseNumber GROUP BY Grade";

            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@CourseNumber", courseNumber);
                connection.Open();

                DataTable result = new DataTable();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(result);

                return result;
            }
        }
    }
    protected void Unnamed_Click(object sender, EventArgs e)
    {
        if (!Menu1.Visible)
            Menu1.Visible = true;
        else Menu1.Visible = false;
    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        if (e.Item.Text == "Home")
            e.Item.NavigateUrl = "~/FacultyMain.aspx?id=" + User_Id;
        else if (e.Item.Text == "Mark Attendence")
            e.Item.NavigateUrl = "~/FC1_MarkAttendence.aspx?id=" + User_Id;
        else if (e.Item.Text == "Set Marks Distribution")
            e.Item.NavigateUrl = "~/FC2_MarksDistribution.aspx?id=" + User_Id;
        else if (e.Item.Text == "Mark Evaluations")
            e.Item.NavigateUrl = "~/FC3_MarkEvaluations.aspx?id=" + User_Id;
        else if (e.Item.Text == "Finalize Grades")
            e.Item.NavigateUrl = "~/FC4_FinalizeGrades.aspx?id=" + User_Id;
        else if (e.Item.Text == "Grade Report")
            e.Item.NavigateUrl = "~/FC5_GradeReport.aspx?id=" + User_Id;
        else if (e.Item.Text == "Feedback Report")
            e.Item.NavigateUrl = "~/FC6_FeedbackReport.aspx?id=" + User_Id;
        else if (e.Item.Text == "Transcript Report")
            e.Item.NavigateUrl = "~/FC7_TranscriptReport.aspx?id=" + User_Id;
        else if (e.Item.Text == "Log out")
            e.Item.NavigateUrl = "~/Default.aspx";
        Response.Redirect(e.Item.NavigateUrl);
    }
    public static void LogEvent(string action)
    {
        int userId = Convert.ToInt32(User_Id);
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FlexConnectionString"].ConnectionString))
        {
            connection.Open();
            SqlCommand command = new SqlCommand("INSERT INTO AUDITTRAIL (User_Id, Activity) VALUES (@UserId, @Action)", connection);
            command.Parameters.AddWithValue("@UserId", userId);
            command.Parameters.AddWithValue("@Action", action);
            command.ExecuteNonQuery();
        }
    }
}
