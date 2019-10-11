<%@ WebHandler Language="C#" Class="ThumbnailHandler" %>
using System;
using System.IO;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
public class ThumbnailHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        int _width = 0;
        int _height = 0;
        string _path = String.Empty;
        if (context.Request["width"] != null)
            _width = Int32.Parse(context.Request["width"]);
        else
        {
            { _width = 30; }
        }
        if (context.Request["height"] != null)
            _height = Int32.Parse(context.Request["height"]);
        else
        {
            { _height = 30; }
        }
        // get path for 'no thumbnail' image if you want one
        const String NoThumbFile = "nothumb.jpg";
        String sNoThumbPath = context.Request.MapPath(
         context.Request.ApplicationPath.TrimEnd('/') + "/images/" + NoThumbFile);
        // map requested path
        if (context.Request["ImgFilePath"] != null)
            _path = context.Request.MapPath(context.Request["ImgFilePath"]);
        else _path = sNoThumbPath;

        Bitmap thumbBitmap;
        thumbBitmap = new Bitmap(_path);
        if (thumbBitmap == null)
        {
            thumbBitmap = new Bitmap(sNoThumbPath);
        }

        if (context.Request["thumb"] != null && context.Request["thumb"] == "no")
        {
            context.Response.ContentType = "image/Jpeg";
            thumbBitmap.Save(context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
        }
        else
        {

            thumbBitmap = (Bitmap)thumbBitmap.GetThumbnailImage(_width, _height,
            new System.Drawing.Image.GetThumbnailImageAbort(ThumbCallback), IntPtr.Zero);
            context.Response.ContentType = "image/Jpeg";
            thumbBitmap.Save(context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
        }
    }

    public bool ThumbCallback() { return false; }

    public bool IsReusable
    {
        get { return true; }
    }
}