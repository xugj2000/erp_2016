<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="Warehousing.User.UserList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>��Ա�б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
</head>
<body>
<form runat="server" id="form1" action="UserList.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ա�б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="13" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="AddUser.aspx" style="color:red;font-size:16px;text-decoration:underline">������Ա</a>&nbsp;&nbsp;
            </td>
		</tr>
    		<tr align="center">
			<td colspan="13" align="left" bgcolor="#FFFFFF">
            �û���<asp:TextBox ID="User_name" runat="server" Width="80px"></asp:TextBox>
            �ֻ���<asp:TextBox ID="User_Mobile" runat="server" Width="80px"></asp:TextBox>
            ��Ա����
            <asp:DropDownList ID="User_Level" runat="server" AutoPostBack="false">
                  <asp:ListItem Text="����" Value=""></asp:ListItem>
                  <asp:ListItem Text="��ͨ��Ա" Value="0"></asp:ListItem>
                  <asp:ListItem Text="һ��������" Value="1"></asp:ListItem>
                  <asp:ListItem Text="����������" Value="2"></asp:ListItem>
                  <asp:ListItem Text="������" Value="9"></asp:ListItem>
                  </asp:DropDownList>

            ע��ʱ��
            ��<asp:TextBox ID="txtStartDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtStartDate','');" Width="91px"></asp:TextBox> ��
            <asp:TextBox ID="txtEndDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtEndDate','');" Width="83px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="����" OnClick="Button1_Click" />

            </td>
		</tr>   
		<tr align="center">
             <td>ID</td>
			<td>��Ա��</td>
            <td>��Ա����</td>
            <td>�ֻ���</td>
            <td>��Ա����</td>
            <td>ע��ʱ��</td>
            <td>��Ծʱ��</td>
            <td>�ۼ�Ӧ��</td>
            <td>�ۼ�����</td>
            <td>�ۼ�Ƿ��</td>
          	<td>Ԥ���ʻ�</td>
		  	<td>�����ʻ�</td>
			<td>����</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr  style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>' align="center">
        <td><%#Eval("User_id")%></td>
          <td><%#Eval("User_name")%></td>
          <td><%#Eval("True_name")%></td>
          <td><%#Eval("User_Mobile")%></td>
          <td><%#Warehousing.Business.UserHelper.getUserLevelText(Convert.ToInt32(Eval("User_level")))%></td>
          <td><%#Eval("Add_time")%></td>
          <td><%#Eval("last_login")%></td>
          <td><%#Convert.ToDouble(Eval("PayAll"))%></td>
          
           <td><%#Convert.ToDouble(Eval("PayAlready"))%></td>
            <td><%#Convert.ToDouble(Eval("PayWill"))%></td>
		  <td><%#Eval("Account_money")%></td>
		  <td><%#Eval("Account_score")%></td>
		  <td><a href="AddUser.aspx?id=<%#Eval("User_id")%>">�޸�</a>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="13" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
            PageSize="20" CustomInfoHTML="��%CurrentPageIndex%ҳ����%PageCount%ҳ��ÿҳ%PageSize%��,��%RecordCount%��¼" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="UserList.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
