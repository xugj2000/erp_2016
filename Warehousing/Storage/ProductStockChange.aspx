<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductStockChange.aspx.cs" Inherits="Warehousing.Storage.ProductStockChange" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>商品列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<style>
#pro_supplierid {width:90px;}
#warehouse_id {width:50px;}
</style>
</head>
<body>
<form runat="server" id="form1" action="ProductStockChange.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品库存变动查看</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="9" align="left" bgcolor="#FFFFFF">
            条码<asp:TextBox ID="pro_txm" runat="server" Width="100px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            </td>
		</tr>   
		<tr align="center">
             <td width=100>条码</td>
              <td width=100>仓库</td>
			<td width=100>变动时间</td>
            <td width=40>变动个数</td>
            <td width=40>原库存</td>
            <td width=40>新库存</td>
            <td>变动原因</td>
            <td>发生IP</td>
            <td>关联单号</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
        <td><%#Eval("pro_txm")%></td>
        <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id")))%></td>
          <td><%#Eval("change_time")%></td>
          <td><%#Eval("quantity")%></td>
          <td><%#Eval("old_num")%></td>
          <td><%#Eval("new_num")%></td>
          <td><%#Eval("do_why")%></td>
		  <td><%#Eval("do_ip")%></td>
          <td><%#Eval("order_sn")%></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="9" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="第%CurrentPageIndex%页，共%PageCount%页，每页%PageSize%条,共%RecordCount%记录" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductStockChange.aspx?page={0}" ShowCustomInfoSection="Left">
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
