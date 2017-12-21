<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="membergroup.aspx.cs" Inherits="Warehousing.member.membergroup" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>分组角色列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>分组角色列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
		<tr align="center">
			<td colspan="6" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="groupEdit.aspx">新增分组</a></td>
		</tr>
		<tr align="center">
			<td width="20%">分组名称</td>
            <td width="6%">是否代理</td>
          	<td>分组描述</td>
		  	<td width="8%">包含人数</td>
			<td width="20%">建立时间</td>
			<td>操作</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
          <td align="center"><%#Eval("RoleName")%></td>
          <td align="left"><%#Warehousing.Business.PublicHelper.getStatusText(Eval("isAgent"))%></td>
          <td align="left"><%#Eval("RoleDes")%></td>
		  <td></td>
		  <td><%#Eval("CreateTime")%></td>
		  <td><a href="groupEdit.aspx?id=<%#Eval("ID")%>">修改分组</a> | <a href="grouproles.aspx?id=<%#Eval("ID")%>">权限配置</a></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="6" align=center>
		  	<form runat="server" id="form1">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到" OnPageChanging="AspNetPager1_PageChanging"
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