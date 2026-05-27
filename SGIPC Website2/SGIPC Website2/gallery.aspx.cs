using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.IO;

namespace SGIPC_Website2
{
    public partial class gallery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGalleryItems();
            }

            try
            {
                if (Session["UserId"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserId"]);
                    string userName = Session["UserName"] != null ? Session["UserName"].ToString() : "User";
                    bool isTeamMember = IsTeamMemberByUserId(userId);
                    if (pnlNotLoggedIn != null) pnlNotLoggedIn.Visible = false;
                    if (pnlSidebarNotLoggedIn != null) pnlSidebarNotLoggedIn.Visible = false;
                    if (pnlLoggedIn != null) pnlLoggedIn.Visible = true;
                    if (pnlSidebarLoggedIn != null) pnlSidebarLoggedIn.Visible = true;
                    if (lblUserName != null) lblUserName.Text = userName;
                    if (lblSidebarUserName != null) lblSidebarUserName.Text = "Logged in as: " + userName;
                    SetGalleryManagementVisibility(isTeamMember);

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "galleryUser",
                        $"var isCurrentUserTeamMember = {(isTeamMember ? "true" : "false")}; var currentUserId = {userId};", true);
                }
                else
                {
                    if (pnlNotLoggedIn != null) pnlNotLoggedIn.Visible = true;
                    if (pnlSidebarNotLoggedIn != null) pnlSidebarNotLoggedIn.Visible = true;
                    if (pnlLoggedIn != null) pnlLoggedIn.Visible = false;
                    if (pnlSidebarLoggedIn != null) pnlSidebarLoggedIn.Visible = false;
                    SetGalleryManagementVisibility(false);

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "galleryUser",
                        "var isCurrentUserTeamMember = false; var currentUserId = null;", true);
                }
            }
            catch (Exception ex)
            {
                // Control handling
            }
        }

        private void LoadGalleryItems()
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT GalleryId, Title, Description, ImagePath, Category FROM GalleryItems ORDER BY CreatedDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        // You can bind this to a Repeater if needed
                        // For now, the HTML form handles display
                    }
                }
                catch (Exception ex)
                {
                    // Log error
                }
            }
        }

        private void SetGalleryManagementVisibility(bool isVisible)
        {
            if (btnAddAchievements != null) btnAddAchievements.Visible = isVisible;
            if (btnAddWorkshops != null) btnAddWorkshops.Visible = isVisible;
            if (btnAddTeamEvents != null) btnAddTeamEvents.Visible = isVisible;
        }

        private static bool IsTeamMemberByUserId(int userId)
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT COUNT(*)
                                    FROM Users u
                                    WHERE u.UserId = @UserId
                                      AND (
                                            ISNULL(u.IsTeamMember, 0) = 1
                                            OR EXISTS (
                                                SELECT 1
                                                FROM TeamMembers tm
                                                WHERE tm.IsActive = 1
                                                  AND LTRIM(RTRIM(tm.RollNumber)) = LTRIM(RTRIM(u.Roll))
                                            )
                                          )";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Gallery IsTeamMemberByUserId error: " + ex.Message);
                    return false;
                }
            }
        }

        [WebMethod]
        public static string GetGalleryItems()
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;
            List<Dictionary<string, string>> items = new List<Dictionary<string, string>>();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT GalleryId, Title, Description, ImagePath, Category
                                    FROM GalleryItems
                                    ORDER BY CreatedDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            items.Add(new Dictionary<string, string>
                            {
                                { "id", reader["GalleryId"].ToString() },
                                { "title", reader["Title"].ToString() },
                                { "description", reader["Description"].ToString() },
                                { "imagePath", reader["ImagePath"].ToString() },
                                { "category", NormalizeCategory(reader["Category"].ToString()) }
                            });
                        }
                    }
                }
                catch (Exception ex)
                {
                    return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(items);
        }

        [WebMethod]
        public static string AddGalleryItem(int userId, string title, string description, string fileName, string imageData, string category)
        {
            if (!IsTeamMemberByUserId(userId))
            {
                return "{\"success\": false, \"message\": \"Only team members can add gallery photos\"}";
            }

            title = (title ?? "").Trim();
            description = (description ?? "").Trim();
            fileName = Path.GetFileName((fileName ?? "").Trim());
            imageData = (imageData ?? "").Trim();
            category = NormalizeCategory(category);

            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(fileName) ||
                string.IsNullOrWhiteSpace(imageData) || string.IsNullOrWhiteSpace(category))
            {
                return "{\"success\": false, \"message\": \"Title, image file, and section are required\"}";
            }

            string extension = Path.GetExtension(fileName).ToLowerInvariant();
            if (extension != ".jpg" && extension != ".jpeg" && extension != ".png" && extension != ".webp" && extension != ".gif")
            {
                return "{\"success\": false, \"message\": \"Only JPG, PNG, WEBP, and GIF images are allowed\"}";
            }

            string imagePath;
            try
            {
                int commaIndex = imageData.IndexOf(',');
                string base64 = commaIndex >= 0 ? imageData.Substring(commaIndex + 1) : imageData;
                byte[] bytes = Convert.FromBase64String(base64);

                if (bytes.Length > 5 * 1024 * 1024)
                {
                    return "{\"success\": false, \"message\": \"Image must be 5 MB or smaller\"}";
                }

                string uploadRelativeDir = "Images2/Gallery";
                string uploadDir = HttpContext.Current.Server.MapPath("~/" + uploadRelativeDir);
                Directory.CreateDirectory(uploadDir);

                string safeName = Path.GetFileNameWithoutExtension(fileName);
                foreach (char invalidChar in Path.GetInvalidFileNameChars())
                {
                    safeName = safeName.Replace(invalidChar, '-');
                }
                safeName = string.IsNullOrWhiteSpace(safeName) ? "gallery-photo" : safeName;

                string storedFileName = safeName + "-" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + extension;
                string fullPath = Path.Combine(uploadDir, storedFileName);
                File.WriteAllBytes(fullPath, bytes);
                imagePath = uploadRelativeDir + "/" + storedFileName;
            }
            catch (Exception ex)
            {
                return "{\"success\": false, \"message\": \"Image upload failed: " + ex.Message.Replace("\"", "'") + "\"}";
            }

            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = @"INSERT INTO GalleryItems (Title, Description, ImagePath, Category, CreatedDate)
                                    VALUES (@Title, @Description, @ImagePath, @Category, GETDATE());
                                    SELECT SCOPE_IDENTITY();";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                        cmd.Parameters.AddWithValue("@Category", category);
                        object galleryId = cmd.ExecuteScalar();

                        return "{\"success\": true, \"message\": \"Photo added successfully\", \"galleryId\": " + galleryId + ", \"imagePath\": \"" + imagePath.Replace("\"", "'") + "\"}";
                    }
                }
                catch (Exception ex)
                {
                    return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
                }
            }
        }

        [WebMethod]
        public static string DeleteGalleryItem(int userId, int galleryId)
        {
            if (!IsTeamMemberByUserId(userId))
            {
                return "{\"success\": false, \"message\": \"Only team members can delete gallery photos\"}";
            }

            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;
            string imagePath = "";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    using (SqlCommand cmd = new SqlCommand("SELECT ImagePath FROM GalleryItems WHERE GalleryId = @GalleryId", conn))
                    {
                        cmd.Parameters.AddWithValue("@GalleryId", galleryId);
                        object result = cmd.ExecuteScalar();
                        if (result == null)
                        {
                            return "{\"success\": false, \"message\": \"Photo not found\"}";
                        }
                        imagePath = result.ToString();
                    }

                    using (SqlCommand cmd = new SqlCommand("DELETE FROM GalleryItems WHERE GalleryId = @GalleryId", conn))
                    {
                        cmd.Parameters.AddWithValue("@GalleryId", galleryId);
                        cmd.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {
                    return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
                }
            }

            try
            {
                string normalized = imagePath.Replace("\\", "/");
                if (normalized.StartsWith("Images2/Gallery/", StringComparison.OrdinalIgnoreCase))
                {
                    string fullPath = HttpContext.Current.Server.MapPath("~/" + normalized);
                    if (File.Exists(fullPath))
                    {
                        File.Delete(fullPath);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Delete gallery image file error: " + ex.Message);
            }

            return "{\"success\": true, \"message\": \"Photo deleted successfully\"}";
        }

        private static string NormalizeCategory(string category)
        {
            string normalized = (category ?? "").Trim().ToLowerInvariant();

            if (normalized == "achievement" || normalized == "achievements")
                return "achievements";
            if (normalized == "workshop" || normalized == "workshops" || normalized == "workshop events")
                return "workshops";
            if (normalized == "team" || normalized == "team event" || normalized == "team events" || normalized == "team-events")
                return "team-events";

            return normalized;
        }
    }
}
