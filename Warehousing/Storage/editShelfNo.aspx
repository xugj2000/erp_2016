<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editShelfNo.aspx.cs" Inherits="Warehousing.Storage.editShelfNo" %>

<html><head><title>库存管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
.editor { margin:0px 22px 0px 125px; }
.width4{height:30px;line-height:30px;padding-left:2px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width4{width:60px;margin:0px;text-align:center;}
</style>

</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>仓位调整</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  商品名称：</td>
              <td width="86%">
                  <asp:Label ID="LBpro_name" runat="server" Text="Label"></asp:Label>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  商品货号：</td>
              <td width="86%">
                  <asp:Label ID="LBpro_code" runat="server" Text="Label"></asp:Label>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  所在仓库：</td>
              <td width="86%">
                  <asp:Label ID="LBwarehouse_name" runat="server" Text="Label"></asp:Label>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  商品库存：</td>
              <td width="86%">
              <table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC" id="mytable">
             <tr bgcolor="#FFFFFF"><td>条码</td><td>规格</td><td>型号</td><td>仓位号</td></tr>
             <asp:Repeater ID="StockList" runat="server">
              <ItemTemplate>  
              <tr bgcolor="#FFFFFF"><td><%#Eval("pro_txm")%></td><td><%#Eval("pro_spec")%></td><td><%#Eval("pro_model")%></td><td><input type="hidden" name="stock_id" value="<%#Eval("stock_id")%>"/><input type="text" name="shelf_no" value="<%#Eval("shelf_no")%>" class="width4" onclick="select(this)" maxlength=10/></td></tr>
              </ItemTemplate>
            </asp:Repeater>
            </table>
               </td>
          </tr>
          <tr>
              <td class="style2">
            
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" 提 交 " onclick="Button1_Click" />
                                <input type=hidden value="<%=fromUrl%>" name="fromUrl" />
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