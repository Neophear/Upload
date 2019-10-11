<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="user.aspx.cs" Inherits="User" Title="Untitled Page" %>

<%@ Register Namespace="System.IO" TagPrefix="lol" %>
<%@ Register Namespace="Stiig" TagPrefix="lol" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <center>
        <h1><asp:Label ID="Label1" runat="server"></asp:Label>'s mappe:</h1>
        <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" Font-Size="Medium">Tilbage</asp:HyperLink><br />
        <br />
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="View1" runat="server">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Large">Mapper:<br /></asp:Label>
                <asp:Label ID="Label3" runat="server" Text="Denne mappe indeholder ingen undermapper."
                    Visible="False"></asp:Label><br />
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
                                <asp:HyperLink ID="HyperLink3" runat="server"></asp:HyperLink>
                            </td>
                            <td>
                                <asp:Label ID="Label13" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <br />
                <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Large">Filer:<br /></asp:Label><asp:Label
                    ID="Label5" runat="server" Text="Denne mappe indeholder ingen filer.<br />"></asp:Label>
                <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
                    <HeaderTemplate>
                        <table cellpadding="5">
                            <tr>
                                <td align="left">
                                    <b>Navn:</b>
                                </td>
                                <td align="left">
                                    <b>St&oslash;rrelse:</b>
                                </td>
                                <td align="left">
                                    <b>Antal downloads:</b>
                                </td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperLink2" runat="server"></asp:HyperLink>
                            </td>
                            <td>
                                <asp:Label ID="Label15" runat="server"></asp:Label>
                            </td>
                            <td>
                                <%# Eval("Count") %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </asp:View>
            <asp:View ID="View2" runat="server">
                <asp:Panel ID="Panel1" runat="server">
                    <center>
                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="Large">Mapper:<br /></asp:Label><asp:Label
                        ID="Label7" runat="server" Text="Denne mappe indeholder ingen undermapper." Visible="False"></asp:Label><br />
                    <asp:Repeater ID="Repeater3" runat="server" OnItemCommand="Repeater3_ItemCommand"
                        OnItemDataBound="Repeater3_ItemDataBound">
                        <HeaderTemplate>
                            <table cellpadding="5">
                                <tr>
                                    <td align="left">
                                        <b>Navn:</b>
                                    </td>
                                    <td align="left">
                                        <b>Antal filer:</b>
                                    </td>
                                    <td align="left">
                                        <b>Slet:</b>
                                    </td>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:HyperLink ID="HyperLink4" runat="server"></asp:HyperLink>
                                </td>
                                <td>
                                    <asp:Label ID="Label14" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:LinkButton CausesValidation="false" ID="DeleteButton" runat="server" CommandName="Delete"
                                        CommandArgument='<%# Eval("Directory") %>'><img style="border:none;" alt="Slet <%# Eval("Directory") %>" src="images/delete.gif" /></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                <br />
                    <asp:Label ID="Label10" runat="server" Text='Opret mappe<br /> (Du kan ikke bruge navnet "Main", "Privat" og tegnene \ / : ; * ? " < > | & %)'></asp:Label><br />
                    <asp:Label ID="Label11" runat="server" Text="Navn:"></asp:Label><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="Opret" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                        ErrorMessage="Du skal angive et mappenavn."></asp:RequiredFieldValidator></center>
                    <center>
                        <asp:Label
                            ID="Label12" runat="server" Text='<span style="color:#FF0000">Den mappe eksisterer i forvejen</span>'
                            Visible="False"></asp:Label>&nbsp;</center>
                </asp:Panel>
                <br />
                <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Size="Large">Filer:<br /></asp:Label><asp:Label
                    ID="Label9" runat="server" Text="Denne mappe indeholder ingen filer.<br />"></asp:Label><br />
                <asp:Repeater ID="Repeater4" runat="server" OnItemDataBound="Repeater4_ItemDataBound"
                    OnItemCommand="Repeater4_ItemCommand" Visible="False">
                    <HeaderTemplate>
                        <table cellpadding="5">
                            <tr>
                                <td align="left">
                                    <b>Navn:</b>
                                </td>
                                <td align="left">
                                    <b>St&oslash;rrelse:</b>
                                </td>
                                <td align="left">
                                    <b>Antal downloads:</b>
                                </td>
                                <td align="left">
                                    <b>Slet</b>
                                </td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:HyperLink ID="HyperLink2" runat="server"></asp:HyperLink>
                            </td>
                            <td>
                                <asp:Label ID="Label16" runat="server"></asp:Label>
                            </td>
                            <td>
                                <%# Eval("Count") %>
                            </td>
                            <td>
                                <asp:LinkButton CausesValidation="false" ID="DeleteButton2" runat="server" CommandName="DeleteFile"><img style="border:none;" alt="Slet <%# Eval("FileName") %>" src="images/delete.gif" /></asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </asp:View>
        </asp:MultiView>
    </center>
    <br />
</asp:Content>