<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="membergroup.aspx.cs" Inherits="Warehousing.member.membergroup" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>�����ɫ�б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>�����ɫ�б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
		<tr align="center">
			<td colspan="6" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="groupEdit.aspx">��������</a></td>
		</tr>
		<tr align="center">
			<td width="20%">��������</td>
            <td width="6%">�Ƿ����</td>
          	<td>��������</td>
		  	<td width="8%">��������</td>
			<td width="20%">����ʱ��</td>
			<td>����</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
          <td align="center"><%#Eval("RoleName")%></td>
          <td align="left"><%#Warehousing.Business.PublicHelper.getStatusText(Eval("isAgent"))%></td>
          <td align="left"><%#Eval("RoleDes")%></td>
		  <td></td>
		  <td><%#Eval("CreateTime")%></td>
		  <td><a href="groupEdit.aspx?id=<%#Eval("ID")%>">�޸ķ���</a> | <a href="grouproles.aspx?id=<%#Eval("ID")%>">Ȩ������</a></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="6" align=center>
		  	<form runat="server" id="form1">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��" OnPageChanging="AspNetPager1_PageChanging"
            PageSize="20" CustomInfoHTML="">
        </webdiyer:AspNetPager>
          </form>
			</td>
		  </tr>
	</table>
</td>
  </tr>          
<tr bgcolor="#FFFFFF" > 
<td height="30"  align="right">&nbsp;</td>
</tr>
</table>
</div>
				

</body>
</html>