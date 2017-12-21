<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagepriv.aspx.cs" Inherits="Warehousing.member.pagepriv" %>
<html><head><title>模块列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>模块列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
		<tr align="center">
			<td colspan="6" bgcolor="#FFFFFF" align=right><a href="addpage.aspx">新增模块</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr align="center">
			<td width="17%">模块名称</td>
          	<td width="39%">模块页面</td>
		  	<td width="21%">模块描述</td>
		  	<td width="7%">序号</td>
		  	<td width="6%">菜单</td>
			<td width="10%">操作</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
          <td align="left"><%#Eval("ModuleName")%></td>
          <td align="left"><%#Eval("PageUrl")%></td>
		  <td align="left"><%#Eval("ModuleDesc")%></td>
		  <td><%#Eval("OrderNum")%></td>
		  <td><%#Warehousing.Business.PublicHelper.getStatusText(Eval("IsShow"))%></td>
		  <td><a href="addpage.aspx?id=<%#Eval("ID")%>">修改</a></td>
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