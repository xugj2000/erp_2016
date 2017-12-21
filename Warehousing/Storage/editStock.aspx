<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editStock.aspx.cs" Inherits="Warehousing.Storage.editStock" %>
<html><head><title>库存管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
#Textkc_nums{height:30px;width:120px;text-align:center;line-height:30px;border:solid 1px #CCC;border-bottom:solid 1px #666}
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
                Textkc_nums: {
                    required: true
                }
            },
            messages: {
                Textkc_nums: {
                    required: '库存不能为空'
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
<td  align="center"><b><strong>商品管理</strong></b></td>
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
                  商品条码：</td>
              <td width="86%">
                  <asp:Label ID="LBpro_txm" runat="server" Text="Label"></asp:Label>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  商品库存：</td>
              <td width="86%">
              <asp:TextBox ID="Textkc_nums" runat="server" MaxLength=50></asp:TextBox>
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
				
<div id="oneline" style="display:none">
  <tr align="center">
    <td><input type=hidden name="pro_id" value='0' /><input name="pro_txm" type="text" class="text width6" onblur="txmInput(this);" /></td>
    <td><input name="pro_spec" type="text" class="text width6" /></td>
    <td><input name="pro_model" type="text" class="text width6" /></td>
	<td><input name="pro_outprice" type="text" class="text width6" /></td>
	<td><input name="pro_inprice" type="text" class="text width6" /></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
</div>	

</body>
</html>
