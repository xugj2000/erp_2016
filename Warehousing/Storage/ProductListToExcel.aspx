<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductListToExcel.aspx.cs" Inherits="Warehousing.Storage.ProductListToExcel" %>
<table width="800" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ʒ�б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
  <asp:Repeater ID="MemberList" runat="server">
  <HeaderTemplate>
	<table width="900" border="0" cellpadding="4" cellspacing="1" border=1>
		<tr align="center">
            <td>��Ʒ����</td>
			<td>��Ʒ����</td>
            <td>����</td>
            <td>����</td>
            <td>�ֿ�</td>
          	<td>��Ӧ��</td>
		  	<td>���</td>
			<td>�ͺ�</td>
			<td>Ʒ��</td>
            <td>��λ</td>
            <td>���</td>
            <td>���ۼ�</td>
            <td>����</td>
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
