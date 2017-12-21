<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editStockPm.aspx.cs" Inherits="Warehousing.Storage.editStockPm" %>

<html><head><title>库存管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
.editor { margin:0px 22px 0px 125px; }
.width4{height:30px;line-height:30px;padding-left:2px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width4{width:40px;margin:0px;text-align:center;}
</style>
<script type="text/javascript">
    $(function () {
        $('#form1').validate({
            errorLabelContainer: $('#warning'),
            invalidHandler: function (form, validator) {
                var errors = validator.numberOfInvalids();
                if (errors) {
                    $('#warning').show();
                }
                else {
                    $('#warning').hide();
                }
            },
            rules: {
                TextRemark: {
                    required: true
                }
            },
            messages: {
                TextRemark: {
                    required: "要求填写备注"
                }
            }
        });
    });

</script>

</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>库存调整</strong></b></td>
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
                  <asp:Label ID="LBpro_code" runat="server" Text=""></asp:Label>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  所在仓库：</td>
              <td width="86%">
                  <asp:Label ID="LBwarehouse_name" runat="server" Text=""></asp:Label>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  修改备注：</td>
              <td width="86%">
                  <asp:TextBox ID="TextRemark" runat="server"></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  商品库存：</td>
              <td width="86%">
              <table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC" id="mytable">
             <tr bgcolor="#FFFFFF"><td>条码</td><td>规格</td><td>型号</td><td>当前库存</td></tr>
             <asp:Repeater ID="StockList" runat="server">
              <ItemTemplate>  
              <tr bgcolor="#FFFFFF"><td><%#Eval("pro_txm")%></td><td><%#Eval("pro_spec")%></td><td><%#Eval("pro_model")%></td><td><input type="hidden" name="stock_id" value="<%#Eval("stock_id")%>"/><input type="text" name="kc_nums" value="<%#Convert.ToDouble(Eval("kc_nums"))%>" class="width4" onclick="select(this)"/></td></tr>
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
