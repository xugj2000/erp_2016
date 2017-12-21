<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckStockResult.aspx.cs" Inherits="Warehousing.Storage.CheckStockResult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>库存盘点</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<form runat="server" id="form1">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>库存盘点</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="7" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button
            ID="Button4" runat="server" Text="导出" onclick="Button4_Click" /></td>
		</tr>
		<tr align="center">
            <td width="60">序号</td>
            <td width="80">商品ID</td>
			<td width="150">条码</td>
            <td width="150">基准数量</td>
            <td width="150">实盘数量</td>
            <td width="150">偏差</td>
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
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="第%CurrentPageIndex%页，共%PageCount%页，每页%PageSize%条,共%RecordCount%记录" 
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
