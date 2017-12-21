<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductStockChange.aspx.cs" Inherits="Warehousing.Storage.ProductStockChange" %>

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
<form runat="server" id="form1" action="ProductStockChange.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ʒ���䶯�鿴</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="9" align="left" bgcolor="#FFFFFF">
            ����<asp:TextBox ID="pro_txm" runat="server" Width="100px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="����" OnClick="Button1_Click" />
            </td>
		</tr>   
		<tr align="center">
             <td width=100>����</td>
              <td width=100>�ֿ�</td>
			<td width=100>�䶯ʱ��</td>
            <td width=40>�䶯����</td>
            <td width=40>ԭ���</td>
            <td width=40>�¿��</td>
            <td>�䶯ԭ��</td>
            <td>����IP</td>
            <td>��������</td>
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
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
            PageSize="20" CustomInfoHTML="��%CurrentPageIndex%ҳ����%PageCount%ҳ��ÿҳ%PageSize%��,��%RecordCount%��¼" 
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
