<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductListToExcel.aspx.cs" Inherits="Warehousing.Storage.ProductListToExcel" %>
<table width="800" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
  <asp:Repeater ID="MemberList" runat="server">
  <HeaderTemplate>
	<table width="900" border="0" cellpadding="4" cellspacing="1" border=1>
		<tr align="center">
            <td>商品名称</td>
			<td>商品名称</td>
            <td>货号</td>
            <td>条码</td>
            <td>仓库</td>
          	<td>供应商</td>
		  	<td>规格</td>
			<td>型号</td>
			<td>品牌</td>
            <td>单位</td>
            <td>库存</td>
            <td>零售价</td>
            <td>进价</td>
		</tr>
		</HeaderTemplate>
                           <ItemTemplate>   
        <tr align="center">
        <td><%#Eval("pro_id")%></td>
          <td align="center"><%#Eval("pro_name")%></td>
          <td><%#Eval("pro_code")%></td>
          <td><%#Eval("pro_txm")%></td>
           <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id")))%></td>
          <td><%#Warehousing.Business.StorageHelper.getSupplierName(Convert.ToInt32(Eval("pro_supplierid")))%></td>
		  <td><%#Eval("pro_spec")%></td>
		  <td><%#Eval("pro_model")%></td>
          <td><%#Eval("pro_brand")%></td>
          <td><%#Eval("pro_unit")%></td>
          <td><%#Convert.ToDouble(Eval("kc_nums"))%></td>
          <td><%#Eval("pro_outprice")%></td>
          <td><%#Eval("pro_inprice")%></td>
          </tr>
          </ItemTemplate>
          <FooterTemplate>
	</table>
    </FooterTemplate>
    </asp:Repeater>
</td>
  </tr>          
</table>
