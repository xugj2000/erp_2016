<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckStock.aspx.cs" Inherits="Warehousing.Storage.CheckStock" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>����̵�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>����̵�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="6" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="AddCheckStock.Aspx" style="color:red;font-size:16px;text-decoration:underline">�����̵�</a>&nbsp;&nbsp;</td>
		</tr>
		<tr align="center">
        <td width="60">�̴���</td>
			<td width="19%">�̴�ֿ�</td>
            <td width="20%">�̴�����</td>
          	<td>��ʼʱ��</td>
		  	<td>����ʱ��</td>
			<td width="160">����</td>
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
          <a href="CheckStockInput.aspx?id=<%#Eval("main_id")%>">¼��</a>&nbsp;
          <a href="CheckStockDetail.aspx?id=<%#Eval("main_id")%>">����</a>&nbsp;
          <a href="CheckStockResult.aspx?id=<%#Eval("main_id")%>">����</a>&nbsp;
          <a href="CheckStock.Aspx?act=truncate&id=<%#Eval("main_id")%>" onclick="return confirm('���̽��������¼������,ȷ����?');">����</a>&nbsp;
          <a href="CheckStock.Aspx?act=drop&id=<%#Eval("main_id")%>" onclick="return confirm('δ¼�����ݿ���ɾ��,ȷ��ɾ����?');">ɾ��</a>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="6" align=center>
		  	<form runat="server" id="form1">
                 <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
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
