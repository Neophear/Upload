<%@ Page Language="C#" AutoEventWireup="true" CodeFile="overview.aspx.cs" Inherits="questionnaire_overview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title>Oversigt</title>
    </head>
    <body>
        <form id="form1" runat="server">
            1. Har du hørt om politiets nye 114 nummer?<br />
            2. Hvis ja, hvor har du hørt om det? (Sæt gerne flere krydser)<br />
            3. Ved du hvornår du skal benytte det nye 114 nummer frem for 112?<br />
            4. Hvis ja, ved du i hvilke(n) situation(er) du skal benytte 114 nummer frem for 112?<br />
            5. Hvor søger du normalt informationer vedrørende din hverdag? (Sæt gerne flere krydser)<br />
            6. Alder<br />
            7. Køn<br />
            <br />
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField ButtonType="Button" CancelText="Fortryd" DeleteText="Slet" EditText="Rediger"
                        InsertText="Inds&#230;t" NewText="Ny" SelectText="V&#230;lg" ShowDeleteButton="True"
                        UpdateText="Opdater" />
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="ID" Visible="False" />
                    <asp:BoundField DataField="Question1" HeaderText="1." SortExpression="Question1" />
                    <asp:BoundField DataField="Question2" HeaderText="2." SortExpression="Question2" />
                    <asp:BoundField DataField="Question3" HeaderText="3." SortExpression="Question3" />
                    <asp:BoundField DataField="Question4" HeaderText="4." SortExpression="Question4" />
                    <asp:BoundField DataField="Question5" HeaderText="5." SortExpression="Question5" />
                    <asp:BoundField DataField="Age" HeaderText="Alder" SortExpression="Age" />
                    <asp:BoundField DataField="Gender" HeaderText="K&#248;n" SortExpression="Gender" />
                    <asp:BoundField DataField="Created" HeaderText="Besvaret" SortExpression="Created" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                DeleteCommand="DELETE FROM [lp_questionnaire] WHERE [ID] = @ID" InsertCommand="INSERT INTO [lp_questionnaire] ([Question1], [Question2], [Question3], [Question4], [Question5], [Age], [Gender], [Created]) VALUES (@Question1, @Question2, @Question3, @Question4, @Question5, @Age, @Gender, @Created)"
                SelectCommand="SELECT * FROM [lp_questionnaire]" UpdateCommand="UPDATE [lp_questionnaire] SET [Question1] = @Question1, [Question2] = @Question2, [Question3] = @Question3, [Question4] = @Question4, [Question5] = @Question5, [Age] = @Age, [Gender] = @Gender, [Created] = @Created WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Question1" Type="String" />
                    <asp:Parameter Name="Question2" Type="String" />
                    <asp:Parameter Name="Question3" Type="String" />
                    <asp:Parameter Name="Question4" Type="String" />
                    <asp:Parameter Name="Question5" Type="String" />
                    <asp:Parameter Name="Age" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:Parameter Name="Created" Type="DateTime" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="Question1" Type="String" />
                    <asp:Parameter Name="Question2" Type="String" />
                    <asp:Parameter Name="Question3" Type="String" />
                    <asp:Parameter Name="Question4" Type="String" />
                    <asp:Parameter Name="Question5" Type="String" />
                    <asp:Parameter Name="Age" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:Parameter Name="Created" Type="DateTime" />
                </InsertParameters>
            </asp:SqlDataSource>
        </form>
    </body>
</html>