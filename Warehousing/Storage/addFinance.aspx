<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addFinance.aspx.cs" Inherits="Warehousing.Storage.addFinance" %>

<html><head><title>入入库付款管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<style>
.inputbox{width:150px;height:24px;}
</style>
<script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
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
                Textpay_money: {
                    required: true,
                    number:true
                },
                Textpay_date: {
                    required: true
                },
                Textpay_worker: {
                    required: true
                },
                Textreceive_worker: {
                    required: true
                }
            },
            messages: {
                Textpay_money: {
                    required: '金额不能为空',
                    number:'金额要求为数值'
                },
                Textpay_date: {
                    required: '侍款日期不能为空'
                },
                Textpay_worker: {
                    required: '付款人不能为空'
                },
                Textreceive_worker: {
                    required: '收款人不能为空'
                }
            }
        });

    })

</script>
</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="400" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>支付款管理</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td>
                  付款日期：</td>
              <td>
              <asp:TextBox ID="Textpay_date" runat="server" CssClass="inputbox" MaxLength=100 ReadOnly  onClick="return Calendar('Textpay_date','');"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td width="25%">
                  付款金额：</td>
              <td>
              <asp:TextBox ID="Textpay_money" runat="server" CssClass="inputbox" MaxLength=10></asp:TextBox>
               </td>
          </tr>

          <tr>
              <td>
                  付款人：</td>
              <td>
              <asp:TextBox ID="Textpay_worker" runat="server"  CssClass="inputbox" MaxLength=100></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  收款人：</td>
              <td>
              <asp:TextBox ID="Textreceive_worker" runat="server"  CssClass="inputbox" MaxLength=100></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  款项备注:</td>
              <td>
              <asp:TextBox ID="Textremark" runat="server"  CssClass="inputbox"></asp:TextBox>
              </td>
          </tr>
                    <tr>
              <td width="14%">
                  是否作废：</td>
              <td width="86%">
                  是<input type="radio" name="IsCancel" value="1"<%if (IsCancel=="1"){Response.Write(" checked");} %>/> &nbsp;&nbsp;否<input type="radio" name="IsCancel" value="0"<%if (IsCancel!="1"){Response.Write(" checked");} %>/></td>
          </tr>
          <tr>
              <td class="style2">&nbsp;
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" 提 交 " CssClass="inputbox" onclick="Button1_Click" />
                            </td>
            </tr>
          </table>
	
</td>
  </tr>          
</table>
<br />
<br />
</div>
				

</form>
				

</body>
</html>
