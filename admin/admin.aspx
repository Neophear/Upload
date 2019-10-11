<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" ValidateRequest="false"
    AutoEventWireup="true" CodeFile="admin.aspx.cs" Inherits="admin_admin" Title="Untitled Page" %>

<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <center>
        <h1>Admin</h1>
        Her kan du redigere siden:<br />
        <br />
        <strong>Udfør SQL-sætning:</strong><br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server" Height="97px" TextMode="MultiLine" Width="294px"></asp:TextBox><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
            ErrorMessage="Du skal skrive noget i feltet." ValidationGroup="SQL"></asp:RequiredFieldValidator><br />
        Syntax:<br />
        <table border="1">
            <tr>
                <td style="height: 20px">
                    Select</td>
                <td style="height: 20px">
                    SELECT [rows] FROM [table] (WHERE [row] =<>! [value])</td>
            </tr>
            <tr>
                <td>
                    Update</td>
                <td>
                    UPDATE [table] SET [row] =<>! [value] (WHERE [row] =<>! [value])</td>
            </tr>
            <tr>
                <td>
                    Insert</td>
                <td>
                    INSERT INTO [table] ([row1],[row2]) VALUES([value1],[value2])</td>
            </tr>
            <tr>
                <td>
                    Delete</td>
                <td>
                    DELETE FROM [table] (WHERE [row] =<>! [value])</td>
            </tr>
        </table>
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Udfør" ValidationGroup="SQL" /><br />
        <br />
        <asp:GridView ID="GridView1" runat="server" Visible="False" CellPadding="4" ForeColor="#333333"
            GridLines="None" CellSpacing="3" HorizontalAlign="Center">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:Label ID="Label1" runat="server" Visible="False" Font-Bold="True"></asp:Label><br />
        <br />
        <hr />
        <b>Oprydning:</b><br />
        <br />
        <asp:Button ID="Button7" runat="server" OnClick="Button7_Click" Text="Slet gamle links" /><asp:Button
            ID="Button8" runat="server" OnClick="Button8_Click" Text="Slet gamle tagwall-beskeder" /><br />
        <br />
        <hr style="font-weight: bold" />
        <b>Send mail:</b><br />
        <br />
        Send til:<br />
        <asp:DropDownList ID="DropDownList3" runat="server">
        </asp:DropDownList><br />
        <br />
        Emne:<br />
        <asp:TextBox ID="TextBox4" runat="server" ValidationGroup="Mail"></asp:TextBox><br />
        <br />
        Tekst:<br />
        <asp:TextBox ID="TextBox5" runat="server" Height="183px" TextMode="MultiLine" ValidationGroup="Mail"
            Width="445px"></asp:TextBox><br />
        <br />
        <asp:Button ID="Button5" runat="server" Text="Send mail" ValidationGroup="Mail" OnClick="Button5_Click" /><br />
        <br />
        <hr />
        <b>Rediger titel:</b><br />
        <br />
        <asp:TextBox ID="TextBox6" runat="server" Height="102px" TextMode="MultiLine" Width="304px"></asp:TextBox><br />
        <br />
        <asp:Button ID="Button6" runat="server" OnClick="Button6_Click" Text="Gem titel" /><br />
        <asp:Panel ID="Panel1" runat="server" Visible="False" Width="100%">
            <hr />
            <b>Rediger "About":</b><br />
            <br />
            <table width="100%">
                <tr>
                    <td style="width:100%;text-align:center;">
                        <FTB:FreeTextBox ID="FreeTextBox1" runat="Server" Focus="False" StartMode="DesignMode" ButtonSet="NotSet" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:Button ID="Button9" runat="server" OnClick="Button9_Click" Text='Gem "About"' /></asp:Panel>
        <br />
        <asp:Panel ID="Panel2" runat="server" Visible="False" Width="100%">
            <hr />
            <b>Sæt gruppe for brugere:<br />
            </b>
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridView2_RowDataBound" HorizontalAlign="Center">
                <Columns>
                    <asp:TemplateField HeaderText="&lt;b&gt;Bruger:&lt;/b&gt;">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("UserName") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="&lt;b&gt;Admin:&lt;/b&gt;">
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <asp:Button ID="Button10" runat="server" OnClick="Button10_Click" Text="Gem" />
        </asp:Panel>
        <br />
        <hr />
        <strong>Opret tilladt filtype:<br />
        </strong>
        <asp:Label ID="Label2" runat="server" Text='<span style="color:#FF0000">Den filtype eksisterer i forvejen.</span>'
            Visible="False"></asp:Label><br />
        <table>
            <tr>
                <td>
                    Efternavn (fx. ".jpg" uden ""):
                </td>
                <td style="width: 119px">
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><br />
                </td>
            </tr>
            <tr>
                <td>
                    Type (fx. "Billede" uden ""):
                </td>
                <td style="width: 119px">
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox><br />
                </td>
            </tr>
        </table>
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Opret" ValidationGroup="Extension" /><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
            ErrorMessage="Du skal angive et efternavn." ValidationGroup="Extension"></asp:RequiredFieldValidator><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3"
            ErrorMessage="Du skal angive et navn." ValidationGroup="Extension"></asp:RequiredFieldValidator><br />
        <br />
        <strong>Slet tilladt filtype:<br />
        </strong>
        <br />
        <asp:DropDownList ID="DropDownList2" runat="server">
        </asp:DropDownList><asp:Button ID="Button4" runat="server" Text="Slet" OnClick="Button4_Click" /><br />
        <br />
        <hr />
        <strong>Slet bruger:</strong><br />
        <br />
        <asp:DropDownList ID="DropDownList1" runat="server">
        </asp:DropDownList><asp:Button ID="Button2" runat="server" OnClick="Button2_Click"
            Text="Slet bruger" CausesValidation="False" /><br />
    </center>
</asp:Content>