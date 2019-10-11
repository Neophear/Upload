<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="error.aspx.cs" Inherits="error" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Fejl</h1>
    <asp:Label ID="Label1" runat="server" Text="Der skete en fejl."></asp:Label><br />
    <br />
    <span style="font-size: 8pt">Klik </span>
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="javascript:history.back(1)">her</asp:HyperLink><span
        style="font-size: 8pt"> for at gå tilbage.<br />
    </span>
</asp:Content>