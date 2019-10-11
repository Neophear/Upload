<%@ WebHandler Language="C#" Class="download" %>

using System;
using System.Data;
using System.Web;
using System.IO;
using Stiig;

public class download : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        DataAccessLayer dal = new DataAccessLayer();

        string user = context.Request.QueryString["user"];
        string dir = context.Request.QueryString["dir"];
        string filename = context.Request.QueryString["file"];
        
        if (dir == "Privat")
        {
            if (context.User.Identity.Name == user || context.User.IsInRole("Admin"))
            {
                dal.AddParameter("@Username", user, DbType.String);
                dal.AddParameter("@FileName", filename, DbType.String);
                string count = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE Username = @Username AND Directory = 'Privat' AND FileName = @FileName").ToString();
                dal.ClearParameters();
                
                if (count != "0")
                {
                    context.Response.ContentType = CheckType(filename);
                    context.Response.AppendHeader("content-disposition", "attachment; filename=" + filename);
                    context.Response.WriteFile(context.Server.MapPath("upload/" + user + "¤Privat¤" + filename));
                    dal.AddParameter("@Username", user, DbType.String);
                    dal.AddParameter("@FileName", filename, DbType.String);
                    dal.ExecuteNonQuery("UPDATE Files SET [Count] = ((SELECT [Count] FROM Files WHERE Username = @Username AND Directory = 'Privat' AND FileName = @FileName) + 1) WHERE Username = @Username AND Directory = 'Privat' AND FileName = @FileName");
                    dal.ClearParameters();
                }
                else
                {
                    context.Response.Redirect("error.aspx?error=404");
                }
            }
            else
            {
                context.Response.Redirect("error.aspx?error=401");
            }
        }
        else
        {
            dal.AddParameter("@Username", user, DbType.String);
            dal.AddParameter("@Directory", dir, DbType.String);
            dal.AddParameter("@FileName", filename, DbType.String);
            string count = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE Username = @Username AND Directory = @Directory AND FileName = @FileName").ToString();
            dal.ClearParameters();
            
            if (count != "0")
            {
                context.Response.ContentType = CheckType(filename);
                context.Response.AppendHeader("content-disposition", "attachment; filename=" + filename);
                context.Response.WriteFile(context.Server.MapPath("upload/" + user + "¤" + dir + "¤" + filename));
                
                dal.AddParameter("@Username", user, DbType.String);
                dal.AddParameter("@Directory", dir, DbType.String);
                dal.AddParameter("@FileName", filename, DbType.String);
                dal.ExecuteNonQuery("UPDATE Files SET [Count] = ((SELECT [Count] FROM Files WHERE Username = @Username AND Directory = @Directory AND FileName = @FileName) + 1) WHERE Username = @Username AND Directory = @Directory AND FileName = @FileName");
                dal.ClearParameters();
            }
            else
            {
                context.Response.Redirect("error.aspx?error=404");
            }
        }

        //Tjek referrer
        if (context.Request.UrlReferrer != null)
        {
            if (context.Request.UrlReferrer.Host != "www.cyber-blade.dk")
            {
                if (context.Request.UrlReferrer.Host != "cyber-blade.dk")
                {
                    if (context.Request.UrlReferrer.Host != "upload.cyber-blade.dk")
                    {
                        dal.AddParameter("@Referrer", context.Request.UrlReferrer.ToString(), DbType.String);
                        object count = dal.ExecuteScalar("SELECT COUNT(*) FROM FileReferrers WHERE Referrer LIKE @Referrer");
                        dal.ClearParameters();

                        if (count != null)
                        {
                            if (count.ToString() == "0")
                            {
                                dal.AddParameter("@Referrer", context.Request.UrlReferrer.ToString(), DbType.String);
                                dal.AddParameter("@Username", user, DbType.String);
                                dal.AddParameter("@Directory", dir, DbType.String);
                                dal.AddParameter("@FileName", filename, DbType.String);
                                dal.ExecuteNonQuery("INSERT INTO FileReferrers (Referrer, Username, Directory, Filename, [Count]) VALUES(@Referrer, @Username, @Directory, @Filename, 1)");
                                dal.ClearParameters();
                            }
                            else
                            {
                                dal.AddParameter("@Referrer", context.Request.UrlReferrer.ToString(), DbType.String);
                                dal.ExecuteNonQuery("UPDATE FileReferrers SET [Count] = ((SELECT [Count] FROM FileReferrers WHERE Referrer LIKE @Referrer) + 1) WHERE Referrer LIKE @Referrer");
                                dal.ClearParameters();
                            }
                        }
                    }
                }
            }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    private string CheckType(string filename)
    {
        string type;
        
        switch (Path.GetExtension(filename.ToLower()))
        {
            case ".txt":
                type = "text/plain";
                break;
            //Billeder
            case ".bmp":
                type = "image/bmp";
                break;
            case ".fif":
                type = "image/fif";
                break;
            case ".gif":
                type = "image/gif";
                break;
            case ".ief":
                type = "image/ief";
                break;
            case ".jpe":
                type = "image/jpeg";
                break;
            case ".jpeg":
                type = "image/jpeg";
                break;
            case ".jpg" :
                type = "image/jpeg";
                break;
            case ".png":
                type = "image/png";
                break;
            case ".tif":
                type = "image/tiff";
                break;
            case ".tiff":
                type = "image/tiff";
                break;
            case ".mcf":
                type = "image/vasa";
                break;
            case ".rp":
                type = "image/vnd.rn-realpix";
                break;
            case ".ras":
                type = "image/x-cmu-raster";
                break;
            case ".fh":
                type = "image/x-freehand";
                break;
            case ".fh4":
                type = "image/x-freehand";
                break;
            case ".fh5":
                type = "image/x-freehand";
                break;
            case ".fh7":
                type = "image/x-freehand";
                break;
            case ".fhc":
                type = "image/x-freehand";
                break;
            case ".jps":
                type = "image/x-jps";
                break;
            case ".pnm":
                type = "image/x-portable-anymap";
                break;
            case ".pbm":
                type = "image/x-portable-bitmap";
                break;
            case ".pgm":
                type = "image/x-portable-graymap";
                break;
            case ".ppm":
                type = "image/x-portable-pixmap";
                break;
            case ".rgb":
                type = "image/x-rgb";
                break;
            case ".xbm":
                type = "image/x-xbitmap";
                break;
            case ".xpm":
                type = "image/x-xpixmap";
                break;
            case ".swx":
                type = "image/x-xres";
                break;
            case ".xwd":
                type = "image/x-xwindowdump";
                break;
            //Slut på billeder
            default:
                type = "application/x-download";
                break;
        }

        return type;
    }
}