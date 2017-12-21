<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckStock.aspx.cs" Inherits="Warehousing.Storage.CheckStock" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>库存盘点</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>库存盘点</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="6" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="AddCheckStock.Aspx" style="color:red;font-size:16px;text-decoration:underline">新起盘点</a>&nbsp;&nbsp;</td>
		</tr>
		<tr align="center">
        <td width="60">盘存编号</td>
			<td width="19%">盘存仓库</td>
            <td width="20%">盘存类型</td>
          	<td>开始时间</td>
		  	<td>更新时间</td>
			<td width="160">操作</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
         <td><%#Eval("check_sn")%></td>
          <td align="left"><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id")))%></td>
          <td></td>
		  <td><%#Eval("add_time")%></td>
		  <td><%#Eval("update_time")%></td>
		  <td>
          <a href="CheckStockInput.aspx?id=<%#Eval("main_id")%>">录入</a>&nbsp;
          <a href="CheckStockDetail.aspx?id=<%#Eval("main_id")%>">数据</a>&nbsp;
          <a href="CheckStockResult.aspx?id=<%#Eval("main_id")%>">差异</a>&nbsp;
          <a href="CheckStock.Aspx?act=truncate&id=<%#Eval("main_id")%>" onclick="return confirm('重盘将清除所有录入数据,确定吗?');">重盘</a>&nbsp;
          <a href="CheckStock.Aspx?act=drop&id=<%#Eval("main_id")%>" onclick="return confirm('未录入数据可以删除,确定删除吗?');">删除</a>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="6" align=center>
		  	<form runat="server" id="form1">
                 <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="" EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="CheckStock.Aspx?page={0}">
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
