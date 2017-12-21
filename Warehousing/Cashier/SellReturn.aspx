<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellReturn.aspx.cs" Inherits="Warehousing.Cashier.SellReturn" %>
<html><head><title>商品列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
<form runat="server" id="form1">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>收银列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="9" align="right" bgcolor="#FFFFFF">
            </td>
		<tr align="center">
            <td>ID</td>
			<td>订单号</td>
            <td>付款时间</td>
            <td>订单金额</td>
            <td>实收金额</td>
          	<td>买家</td>
		  	<td>付款方式</td>
            <td>状态</td>
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
		  <td></td>
          <td><%#Warehousing.Business.StorageHelper.getOrderStatusText(Convert.ToInt32(Eval("zhuangtai")))%></td>
          </tr>
          <tr bgcolor="#FFFFFF" align="center"><td colspan=8>
          <table width=100% cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#EEEEEE"><td>商品名称</td><td width=200>属性</td><td width=120>条码</td><td width=60>价格</td><td width=60>初始数量</td><td width=60>可退数量</td><td width=60>退换货数量</td></tr>
          <asp:Repeater runat="server" ID="GoodsList">
           <ItemTemplate>
          <tr bgcolor="#FFFFFF"><td><%#Eval("shopxpptname")%></td><td><%#Eval("p_size")%></td><td><%#Eval("txm")%></td><td><%#Eval("danjia")%></td><td><%#Eval("productcount")%></td><td><%#Convert.ToInt32(Eval("productcount"))-Convert.ToInt32(Eval("productcount_return"))%></td>
          <td>
          <input type=hidden value='<%#Eval("id")%>' name="detail_id" />
          <input type=hidden value='<%#Convert.ToInt32(Eval("productcount"))-Convert.ToInt32(Eval("productcount_return"))%>' name="can_return" />
          <input type=text value="0" name="return_count" size=6/></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
          </table>
          </td></tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="8" align=left bgcolor="#FFFFFF">
            <asp:Button ID="Button1" runat="server" Text="  提 交  " onclick="Button1_Click" />
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
