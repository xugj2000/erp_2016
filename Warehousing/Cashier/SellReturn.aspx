<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellReturn.aspx.cs" Inherits="Warehousing.Cashier.SellReturn" %>
<html><head><title>��Ʒ�б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
<form runat="server" id="form1">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>�����б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="9" align="right" bgcolor="#FFFFFF">
            </td>
		<tr align="center">
            <td>ID</td>
			<td>������</td>
            <td>����ʱ��</td>
            <td>�������</td>
            <td>ʵ�ս��</td>
          	<td>���</td>
		  	<td>���ʽ</td>
            <td>״̬</td>
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
          <tr bgcolor="#EEEEEE"><td>��Ʒ����</td><td width=200>����</td><td width=120>����</td><td width=60>�۸�</td><td width=60>��ʼ����</td><td width=60>��������</td><td width=60>�˻�������</td></tr>
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
            <asp:Button ID="Button1" runat="server" Text="  �� ��  " onclick="Button1_Click" />
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
