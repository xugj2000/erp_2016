<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellList.aspx.cs" Inherits="Warehousing.Cashier.SellList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>��Ʒ�б�</title>
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
<td  align="center"><b><strong>�����б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="11" align="right" bgcolor="#FFFFFF">&nbsp;</td>
		</tr>
    		<tr align="center">
			<td colspan="11" align="left" bgcolor="#FFFFFF">
            ����<asp:TextBox ID="pro_txm" runat="server" Width="120px"></asp:TextBox>
            &nbsp;
            ������<asp:TextBox ID="dingdan" runat="server" Width="120px"></asp:TextBox>
            &nbsp;

            ����Ա��
        <asp:DropDownList ID="cashier_list" runat="server">
          <asp:ListItem Value="">��������Ա</asp:ListItem>
        </asp:DropDownList>  

            ����Ա��
        <asp:DropDownList ID="guide_list" runat="server">
          <asp:ListItem Value="">���е���Ա</asp:ListItem>
        </asp:DropDownList>        
            ���:��<asp:TextBox ID="order_amount0" runat="server" Width="40px"></asp:TextBox>
            ��<asp:TextBox ID="order_amount1" runat="server" Width="40px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="����" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="����" onclick="Button4_Click" />
            </td>
		</tr>   
		<tr align="center">
            <td>ID</td>
			<td>������</td>
            <td>����ʱ��</td>
            <td>�������</td>
            <td>ʵ�ս��</td>
          	<td>���</td>
		  	<td>���ʽ</td>
            <td>����Ա</td>
            <td>����Ա</td>
            <td>״̬</td>
            <td>����</td>
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
          <a href="CashierPrint.aspx?dingdan=<%#Eval("dingdan")%>">��ӡ</a> 
          <a href="SellList.aspx?act=drop&id=<%#Eval("shopxpacid")%>" onclick="return confirm('ȷ������ȡ����');"<%#Convert.ToInt32(Eval("zhuangtai"))!=8?" style='display:none'":"" %>>ȡ��</a> 
          <a href="SellReturn.aspx?id=<%#Eval("shopxpacid")%>"<%#Convert.ToInt32(Eval("zhuangtai"))!=8?" style='display:none'":"" %>>�˻���</a>
          </td>
          </tr>
          <tr bgcolor="#FFFFFF" align="center"><td colspan=10>
          <table width=100% cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#EEEEEE"><td>��Ʒ����</td><td width=200>����</td><td width=120>����</td><td width=60>�۸�</td><td width=60>����</td><td width=60>����</td></tr>
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
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
            PageSize="20" CustomInfoHTML="��%CurrentPageIndex%ҳ����%PageCount%ҳ��ÿҳ%PageSize%��,��%RecordCount%��¼" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="SellList.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
		<tr align="center" bgcolor="#FFFFFF">
            <td colspan=3>�ϼ�</td>
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
