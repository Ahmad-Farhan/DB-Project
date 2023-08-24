using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;


public partial class FC6_FeedbackReport : System.Web.UI.Page
{
    static string User_Id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
            User_Id = Request.QueryString["id"];
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        int TeacherID = Convert.ToInt32(User_Id);
        BindGridView(TeacherID);
    }

    protected void BindGridView(int TeacherID)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["FlexConnectionString"].ConnectionString; // Replace with your actual connection string

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT (SUM(Eval1) * 100 / (COUNT(Eval1) * 5)) AS Eval1_Percent, (SUM(Eval2) * 100 / (COUNT(Eval2) * 5)) AS Eval2_Percent, (SUM(Eval3) * 100 / (COUNT(Eval3) * 5)) AS Eval3_Percent," +
                "(SUM(Eval4) * 100 / (COUNT(Eval4) * 5)) AS Eval4_Percent, (SUM(Eval5) * 100 / (COUNT(Eval5) * 5)) AS Eval5_Percent FROM FEEDBACK WHERE Instructor_Id = @instructorID GROUP BY Instructor_Id";

            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@instructorID", TeacherID);
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);

                GridView1.DataSource = dataTable;
                GridView1.DataBind();
                LogEvent("Generated Feedback Report");
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
