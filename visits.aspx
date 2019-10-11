<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="visits.aspx.cs" Inherits="visits" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>
        Besøgstæller:</h1>
    Her kan du se alle sidens besøg.<br />
    <center>
        <asp:Repeater ID="Repeater1" runat="server">
            <HeaderTemplate>
                <table cellpadding="5">
                    <tr>
                        <td align="center">
                            <b>Bruger:</b>
                        </td>
                        <td align="center">
                            <b>Besøg:</b>
                        </td>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr style="<%# RowCounter++ % 2 != 0 ? "": "background-color:#CCCCCC;" %>">
                    <td>
                        <%# Eval("VisitUsername") %>
                    </td>
                    <td>
                        <%# Eval("VisitCount") %>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <br />
        <asp:Label ID="Label1" runat="server"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label><br />
    </center>
</asp:Content>