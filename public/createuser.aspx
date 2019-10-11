<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="createuser.aspx.cs" Inherits="createuser" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" AnswerLabelText="Sikkerhedssvar:"
            AnswerRequiredErrorMessage="Sikkerhedssvar er p�kr�vet." CancelButtonText="Annuller"
            CompleteSuccessText="Din bruger er oprettet.<br /><br />" ConfirmPasswordCompareErrorMessage="Begge passwords skal v�re ens."
            ConfirmPasswordLabelText="Bekr�ft password:" ConfirmPasswordRequiredErrorMessage="B�kreft password er p�kr�vet."
            ContinueButtonText="Forts�t" CreateUserButtonText="Opret bruger" DuplicateEmailErrorMessage="E-mail-adressen du har indtastet eksisterer i forvejen. Brug venligst en ny."
            DuplicateUserNameErrorMessage="Indtast venligst et nyt brugernavn." EmailRegularExpressionErrorMessage="Indtast venligst en ny e-mail."
            EmailRequiredErrorMessage="E-mail er p�kr�vet." FinishCompleteButtonText="Afslut"
            FinishDestinationPageUrl="~/Default.aspx" FinishPreviousButtonText="Tilbage"
            InvalidAnswerErrorMessage="Indtast venligst et andet sikkerhedssvar." InvalidEmailErrorMessage="Indtast venligst en valid e-mail."
            InvalidPasswordErrorMessage="Minimum password-l�ngde: {0}" InvalidQuestionErrorMessage="Indtast venligst et andet sikkerhedssp�rgsm�l."
            LoginCreatedUser="False" PasswordRegularExpressionErrorMessage="Indtast venligst et nyt password."
            PasswordRequiredErrorMessage="Password er p�kr�vet." QuestionLabelText="Sikkerhedssp�rgsm�l:"
            QuestionRequiredErrorMessage="Sikkerhedssp�rgsm�l er p�kr�vet." StartNextButtonText="N�ste"
            StepNextButtonText="N�ste" StepPreviousButtonText="Tilbage" UnknownErrorMessage="Din bruger blev ikke oprettet. Pr�v venligst igen."
            UserNameLabelText="Brugernavn:" UserNameRequiredErrorMessage="Brugernavn er p�kr�vet." CancelDestinationPageUrl="~/Default.aspx" ContinueDestinationPageUrl="~/Default.aspx" OnCreatedUser="CreateUserWizard1_CreatedUser" OnCreatingUser="CreateUserWizard1_CreatingUser" >
            <WizardSteps>
                <asp:CreateUserWizardStep runat="server" Title="&lt;h1&gt;Opret bruger&lt;/h1&gt;">
                    <ContentTemplate>
                        <table border="0">
                            <tr>
                                <td align="center" colspan="2">
                                    <h1>
                                        Opret bruger</h1>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Brugernavn:<br /><span style="font-size:7pt;">Du m� ikke bruge f�lgende tegn:<br />\ / : * ? " < > | & %</span></asp:Label><br />
                                    <asp:Label ID="Label1" runat="server" Text='<span style="color:#FF0000">Du har brugt et forkert tegn i dit brugernavn.</span>'
                                        Visible="False"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                        ErrorMessage="Brugernavn er p�kr�vet." ToolTip="Brugernavn er p�kr�vet." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                        ErrorMessage="Password er p�kr�vet." ToolTip="Password er p�kr�vet." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Bekr�ft password:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                        ErrorMessage="B�kreft password er p�kr�vet." ToolTip="B�kreft password er p�kr�vet."
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                        ErrorMessage="E-mail er p�kr�vet." ToolTip="E-mail er p�kr�vet." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">Sikkerhedssp�rgsm�l:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Question" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question"
                                        ErrorMessage="Sikkerhedssp�rgsm�l er p�kr�vet." ToolTip="Sikkerhedssp�rgsm�l er p�kr�vet."
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Sikkerhedssvar:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
                                        ErrorMessage="Sikkerhedssvar er p�kr�vet." ToolTip="Sikkerhedssvar er p�kr�vet."
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                        ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="Begge passwords skal v�re ens."
                                        ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="color: red">
                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep runat="server" Title=" &lt;h1&gt;Opret bruger&lt;/h1&gt; ">
                </asp:CompleteWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>
        &nbsp;
    </center>
</asp:Content>