<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierList.aspx.cs" Inherits="Warehousing.Storage.SupplierList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>��Ӧ���б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ӧ���б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="10" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="addsupplier.aspx" style="color:red;font-size:16px;text-decoration:underline">������Ӧ��</a>&nbsp;&nbsp;</td>
		</tr>
		<tr align="center">
        <td width="60">��Ӧ��ID</td>
			<td width="120">��Ӧ������</td>
          	<td>��ַ</td>
		  	<td width="120">��ϵ�绰</td>
			<td width="120">����ʱ��</td>
            <td width="60">�ۼ�Ӧ��</td>
            <td width="60">�ۼ��Ѹ�</td>
            <td width="60">�ۼ�Ƿ��</td>
             <td width="30">״̬</td>
			<td width="60">����</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr  style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>' align="center">
         <td><%#Eval("id")%></td>
          <td align="left"><%#Eval("supplier_name")%></td>
          <td><%#Eval("supplier_address")%></td>
		  <td><%#Eval("serviceTel")%></td>
		  <td><%#Eval("add_date")%></td>
          
          <td><%#Convert.ToDouble(Eval("PayAll"))%></td>
          
           <td><%#Convert.ToDouble(Eval("PayAlready"))%></td>
            <td><%#Convert.ToDouble(Eval("PayWill"))%></td>
            <td><%#Convert.ToInt32(Eval("IsLock")) == 1 ? "����" : "����"%></td>
		  <td><a href="addsupplier.aspx?id=<%#Eval("id")%>">�޸�</a></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="10" align=center>
		  	<form runat="server" id="form1">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��" OnPageChanging="AspNetPager1_PageChanging"
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
