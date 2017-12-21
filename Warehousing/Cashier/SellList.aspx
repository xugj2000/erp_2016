<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellList.aspx.cs" Inherits="Warehousing.Cashier.SellList" %>
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
<form runat="server" id="form1" action="SellList.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>收银列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="11" align="right" bgcolor="#FFFFFF">&nbsp;</td>
		</tr>
    		<tr align="center">
			<td colspan="11" align="left" bgcolor="#FFFFFF">
            条码<asp:TextBox ID="pro_txm" runat="server" Width="120px"></asp:TextBox>
            &nbsp;
            订单号<asp:TextBox ID="dingdan" runat="server" Width="120px"></asp:TextBox>
            &nbsp;

            收银员：
        <asp:DropDownList ID="cashier_list" runat="server">
          <asp:ListItem Value="">所有收银员</asp:ListItem>
        </asp:DropDownList>  

            导购员：
        <asp:DropDownList ID="guide_list" runat="server">
          <asp:ListItem Value="">所有导购员</asp:ListItem>
        </asp:DropDownList>        
            金额:从<asp:TextBox ID="order_amount0" runat="server" Width="40px"></asp:TextBox>
            到<asp:TextBox ID="order_amount1" runat="server" Width="40px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="导出" onclick="Button4_Click" />
            </td>
		</tr>   
		<tr align="center">
            <td>ID</td>
			<td>订单号</td>
            <td>付款时间</td>
            <td>订单金额</td>
            <td>实收金额</td>
          	<td>买家</td>
		  	<td>付款方式</td>
            <td>收银员</td>
            <td>导购员</td>
            <td>状态</td>
            <td>操作</td>
		</tr>
		<asp:Repeater ID="OrderList" runat="server" OnItemDataBound="OrderList_ItemDataBound">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
        <td><%#Eval("shopxpacid")%></td>
          <td><%#Eval("dingdan")%></td>
          <td><%#Eval("fksj")%></td>
          <td><%#Convert.ToDecimal(Eval("order_amount")) + Convert.ToDecimal(Eval("order_plus"))%></td>
          <td><%#Eval("order_amount")%></td>
          <td><%#Eval("user_name")%></td>
		  <td><%#Eval("payment_name")%></td>
          <td><%#Eval("cashier_name")%></td>
          <td><%#Eval("guide_name")%></td>
          <td><%#Warehousing.Business.StorageHelper.getOrderStatusText(Convert.ToInt32(Eval("zhuangtai")))%></td>
		  <td rowspan=2>
          <a href="CashierPrint.aspx?dingdan=<%#Eval("dingdan")%>">打印</a> 
          <a href="SellList.aspx?act=drop&id=<%#Eval("shopxpacid")%>" onclick="return confirm('确定整单取消吗');"<%#Convert.ToInt32(Eval("zhuangtai"))!=8?" style='display:none'":"" %>>取消</a> 
          <a href="SellReturn.aspx?id=<%#Eval("shopxpacid")%>"<%#Convert.ToInt32(Eval("zhuangtai"))!=8?" style='display:none'":"" %>>退换货</a>
          </td>
          </tr>
          <tr bgcolor="#FFFFFF" align="center"><td colspan=10>
          <table width=100% cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#EEEEEE"><td>商品名称</td><td width=200>属性</td><td width=120>条码</td><td width=60>价格</td><td width=60>数量</td><td width=60>已退</td></tr>
          <asp:Repeater runat="server" ID="GoodsList">
           <ItemTemplate>
          <tr bgcolor="#FFFFFF"><td><%#Eval("shopxpptname")%></td><td><%#Eval("p_size")%></td><td><%#Eval("txm")%></td><td><%#Eval("danjia")%></td><td><%#Eval("productcount")%></td><td><%#Eval("productcount_return")%></td></tr>
          </ItemTemplate>
          </asp:Repeater>
          </table>
          </td></tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="11" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="第%CurrentPageIndex%页，共%PageCount%页，每页%PageSize%条,共%RecordCount%记录" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="SellList.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
		<tr align="center" bgcolor="#FFFFFF">
            <td colspan=3>合计</td>
            <td><%=order_amount_all %></td>
            <td><%=order_real_all %></td>
          	<td colspan=6></td>
		</tr>
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
