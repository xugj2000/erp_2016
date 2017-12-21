<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="storagelist.aspx.cs" Inherits="Warehousing.member.storagelist" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>仓库列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>仓库列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="10" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="addstorage.aspx">新增仓库</a></td>
		</tr>
		<tr align="center">
             <td   width=30>仓库ID</td>
			<td   width=150>仓库名称</td>
            <td  width=120>加盟区域</td>
          	<td>地址</td>
		  	<td   width=100>联系电话</td>
			<td   width=120>加入时间</td>
            <td   width=50>是否主仓</td>
            <td   width=50>支持采购</td>
            <td   width=50>是否锁定</td>
			<td   width=40>操作</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF">
        <td><%#Eval("warehouse_id")%></td>
          <td><%#Eval("warehouse_name")%></td>
          <td><%#Warehousing.Business.StorageHelper.getAgentName(Convert.ToInt32(Eval("Agent_id")))%></td>
          <td><%#Eval("warehouse_address")%></td>
		  <td><%#Eval("warehouse_tel")%></td>
		  <td><%#Eval("add_date")%></td>
           <td><%#Warehousing.Business.PublicHelper.getStatusText(Eval("is_manage"))%></td>
           <td><%#Warehousing.Business.PublicHelper.getStatusText(Eval("is_caigou"))%></td>
           <td><%#Warehousing.Business.PublicHelper.getStatusText(Eval("IsLock"))%></td>
		  <td><a href="addstorage.aspx?id=<%#Eval("warehouse_id")%>">修改</a></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="10" align=center>
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
