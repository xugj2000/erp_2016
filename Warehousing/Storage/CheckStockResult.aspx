<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckStockResult.aspx.cs" Inherits="Warehousing.Storage.CheckStockResult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>����̵�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<form runat="server" id="form1">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>����̵�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="7" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button
            ID="Button4" runat="server" Text="����" onclick="Button4_Click" /></td>
		</tr>
		<tr align="center">
            <td width="60">���</td>
            <td width="80">��ƷID</td>
			<td width="150">����</td>
            <td width="150">��׼����</td>
            <td width="150">ʵ������</td>
            <td width="150">ƫ��</td>
            <td></td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
         <td><%# Container.ItemIndex + 1%></td>
         <td align="left"><%#Eval("pro_id")%></td>
          <td align="left"><%#Eval("pro_txm")%></td>
		  <td><%#Eval("kc_num")%></td>
		  <td><%#Eval("check_num")%></td>
          <td><%#Eval("plus_num")%></td>
          <td><%#Eval("exist_info")%></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="7" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
            PageSize="20" CustomInfoHTML="��%CurrentPageIndex%ҳ����%PageCount%ҳ��ÿҳ%PageSize%��,��%RecordCount%��¼" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="CheckStockResult.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
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
		</form>		

</body>
</html>
