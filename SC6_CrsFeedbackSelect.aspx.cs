using System;
using System.Activities.Expressions;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

public class CrsSelect
{
    public string Course_Code { set; get; }
    public string Course_Name { set; get; }
    public string Section_Id { set; get; }
}
public partial class SC6_CrsFeedbackSelect : System.Web.UI.Page
{
    protected static string currSemester;
    protected static string User_Id;
    private static List<CrsSelect> Courses;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            User_Id = Request.QueryString["id"];
            LoadCourseOptions();
            LoadCurrentSemester();
        }

    }
    private void LoadCourseOptions()
    {
        string query = @"SELECT Course_Code, C.Name, T.Section_Id FROM COURSE C INNER JOIN OFFEREDCOURSE O ON O.Course_Id = C.Course_Id INNER JOIN
                        SECTION S ON S.Course_Id = O.OfferCourse_Id INNER JOIN TRANSCRIPT T ON T.Section_Id = S.Section_Id
                        WHERE T.Student_Id = " + User_Id + " AND O.OfferedIn = '" + currSemester + "'";

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FlexConnectionString"].ConnectionString);
        connection.Open();
        SqlCommand command = new SqlCommand(query, connection);
        SqlDataReader reader = command.ExecuteReader();

        Courses = new List<CrsSelect>();
        while (reader.Read())
        {
            CrsSelect course = new CrsSelect();
            course.Course_Code = reader.GetString(0);
            course.Course_Name = reader.GetString(1);
            course.Section_Id = reader.GetValue(2).ToString();
            Courses.Add(course);
        }
        CourseList.DataSource = Courses;
        CourseList.DataBind();
        LogEvent("Selected Course For Feedback Submission");
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
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        if (e.Item.Text == "Home")
            e.Item.NavigateUrl = "~/StudentMain?id=" + User_Id;
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
    protected void Unnamed_Click(object sender, EventArgs e)
    {
        if (!Menu1.Visible)
            Menu1.Visible = true;
        else Menu1.Visible = false;
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