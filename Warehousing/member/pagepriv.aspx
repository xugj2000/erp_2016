<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagepriv.aspx.cs" Inherits="Warehousing.member.pagepriv" %>
<html><head><title>ģ���б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>ģ���б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
		<tr align="center">
			<td colspan="6" bgcolor="#FFFFFF" align=right><a href="addpage.aspx">����ģ��</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr align="center">
			<td width="17%">ģ������</td>
          	<td width="39%">ģ��ҳ��</td>
		  	<td width="21%">ģ������</td>
		  	<td width="7%">���</td>
		  	<td width="6%">�˵�</td>
			<td width="10%">����</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
          <td align="left"><%#Eval("ModuleName")%></td>
          <td align="left"><%#Eval("PageUrl")%></td>
		  <td align="left"><%#Eval("ModuleDesc")%></td>
		  <td><%#Eval("OrderNum")%></td>
		  <td><%#Warehousing.Business.PublicHelper.getStatusText(Eval("IsShow"))%></td>
		  <td><a href="addpage.aspx?id=<%#Eval("ID")%>">�޸�</a></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="6" align=center>
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