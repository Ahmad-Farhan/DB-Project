using System;
using System.Activities.Expressions;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IdentityModel.Protocols.WSTrust;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Collections.Specialized.BitVector32;


public class CourseTSC3
{
    public string Course_Code;
    public string Course_Id;
}
public partial class SC3_ViewEvaluations : System.Web.UI.Page
{
    private static string currSemester;
    private static string User_Id;
    private static List<CourseTSC3> Courses;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            User_Id = Request.QueryString["id"];
            //User_Id = "9";
            LoadCurrentSemester();
            LoadCourseOptions();
            LoadEvaluations(CourseList.SelectedIndex);
        }
    }
    private void LoadCourseOptions()
    {
        string query = @"SELECT '-', '-' UNION SELECT Course_Code, O.OfferCourse_Id FROM COURSE C INNER JOIN OFFEREDCOURSE O ON O.Course_Id = C.Course_Id INNER JOIN
                        SECTION S ON S.Course_Id = O.OfferCourse_Id INNER JOIN TRANSCRIPT T ON T.Section_Id = S.Section_Id
                        WHERE T.Student_Id = " + User_Id + " AND O.OfferedIn = '" + currSemester + "'";
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FlexConnectionString"].ConnectionString);
        connection.Open();
        SqlCommand command = new SqlCommand(query, connection);
        SqlDataReader reader = command.ExecuteReader();

        CourseList.Items.Clear();
        Courses = new List<CourseTSC3>();
        while (reader.Read())
        {
            CourseTSC3 course = new CourseTSC3();
            course.Course_Code = reader.GetString(0);
            course.Course_Id = reader.GetValue(1).ToString();
            Courses.Add(course);
            CourseList.Items.Add(course.Course_Code);
        }
        CourseList.DataBind();
    }
    private void LoadEvaluations(int idx)
    {
        if (idx == -1 || idx == 0)
            return;
        string query = "SELECT Name, Weightage, Range, Obtained FROM EVALUATION INNER JOIN MARKS ON EVALUATION.Eval_Id = MARKS.Eval_Id" +
            " WHERE Course_Id = " + Courses[idx].Course_Id + " AND Student_Id = " + User_Id;
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FlexConnectionString"].ConnectionString);
        connection.Open();
        SqlCommand command = new SqlCommand(query, connection);
        SqlDataReader reader = command.ExecuteReader();
        AttendenceList.DataSource = reader;
        AttendenceList.DataBind();
        LogEvent("Viewed Their Evaluations");
    }
    protected void CourseOptionSelected(object sender, EventArgs e)
    {
        LoadEvaluations(CourseList.SelectedIndex);
    }
    public string ExecuteReader(string query, string Column)
    {
        string res;
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FlexConnectionString"].ConnectionString);
        connection.Open();
        SqlCommand cmd = new SqlCommand(query, connection);
        SqlDataReader reader = cmd.ExecuteReader();
        if (!reader.Read())
            res = "";
        else res = reader[Column].ToString();
        connection.Close();
        return res;
    }
    private void LoadCurrentSemester()
    {
        currSemester = ExecuteReader("SELECT TOP(1) Semester FROM SEMESTERRECORD ORDER BY Start_Date DESC", "Semester");
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
            e.Item.NavigateUrl = "~/StudentMain.aspx?id=" + User_Id;
        else if (e.Item.Text == "Course Registeration")
            e.Item.NavigateUrl = "~/SC1_RegisterCourse.aspx?id=" + User_Id;
        else if (e.Item.Text == "Attendence")
            e.Item.NavigateUrl = "~/SC2_ViewAttendence.aspx?id=" + User_Id;
        else if (e.Item.Text == "Evaluations")
            e.Item.NavigateUrl = "~/SC3_ViewEvaluations.aspx?id=" + User_Id;
        else if (e.Item.Text == "Transcript")
            e.Item.NavigateUrl = "~/SC4_ViewTranscript.aspx?id=" + User_Id;
        else if (e.Item.Text == "Course Feedback")
            e.Item.NavigateUrl = "~/SC6_CrsFeedbackSelect.aspx?id=" + User_Id;
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