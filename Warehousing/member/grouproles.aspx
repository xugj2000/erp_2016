<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="grouproles.aspx.cs" Inherits="Warehousing.member.grouproles" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>��ɫȨ������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<form runat="server" id="form1">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��ɫȨ������</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
		<tr align="center">
			<td width="21%">ģ������</td>
          	<td width="37%">ģ��ҳ��</td>
		  	<td width="42%">Ȩ������</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
          <td align="left"><%#Eval("ModuleName")%></td>
          <td align="left"><%#Eval("PageUrl")%></td>
		  <td>
		  <input type="checkbox" value="1" id="o_<%#Eval("ID")%>_1" name="o_<%#Eval("ID")%>_1"<%#Eval("P1")%>/>�鿴
		  <input type="checkbox" value="1" id="o_<%#Eval("ID")%>_2" name="o_<%#Eval("ID")%>_2"<%#Eval("P2")%>/>���
		  <input type="checkbox" value="1" id="o_<%#Eval("ID")%>_3" name="o_<%#Eval("ID")%>_3"<%#Eval("P3")%>/>ɾ��
		  <input type="checkbox" value="1" id="o_<%#Eval("ID")%>_4" name="o_<%#Eval("ID")%>_4"<%#Eval("P4")%>/>�޸�
		  <input type="checkbox" value="1" id="o_<%#Eval("ID")%>_5" name="o_<%#Eval("ID")%>_5"<%#Eval("P5")%>/>���
		  <input type="checkbox" value="1" id="o_<%#Eval("ID")%>_6" name="o_<%#Eval("ID")%>_6"<%#Eval("P6")%>/>��Ȩ
		  </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="3" align=center>
		  	
          
			    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text=" �� �� " />
		  	
          
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
		</form>		

</body>
</html>