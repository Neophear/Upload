<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Namespace="System.IO" TagPrefix="lol" %>
<%@ Register Namespace="Stiig" TagPrefix="lol" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Brugere:</h1>
    <center>
        <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
            <HeaderTemplate>
                <table cellpadding="5">
                    <tr>
	                    <td align="left">
		                    <b>Navn:</b>
	                    </td>
	                    <td align="left">
		                    <b>Antal filer:</b>
	                    </td>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:HyperLink ID="HyperLink1" runat="server"></asp:HyperLink>
                    </td>
                    <td>
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </td>
                </tr>
            </ItemTemplate>
            <AlternatingItemTemplate>
                <tr style="background-color:#CCCCCC;">
                    <td>
                        <asp:HyperLink ID="HyperLink1" runat="server"></asp:HyperLink>
                    </td>
                    <td>
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </center>
</asp:Content>