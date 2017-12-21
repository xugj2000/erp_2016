<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellReturnOk.aspx.cs" Inherits="Warehousing.Cashier.SellReturnOk" %>

<html><head><title>收银管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
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
                TextRealMoney: {
                    required: true,
					number     : true,
					min : 0,
					max : <%=all_sales%>,
                },
                TextReturnNote: {
                    required: true
                },
                DDPaymentName: {
                    required: true
                }
            },
            messages: {
                TextRealMoney: {
                    required: '实收金额不能为空',
					number     :'实收金额要求为数值',
					min : '实退金额有误',
					max : '实退金额不能大于<%=all_sales%>',
                },
                TextReturnNote: {
                    required: '退款备注不能为空'
                },
                DDPaymentName: {
                    required: '请选择退款方式'
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
<td  align="center" colspan=2><b><strong>退款确认</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">

          <tr>
              <td>
                  应退金额：</td>
              <td>
              <%=all_sales%>
              </td>
          </tr>
            <tr>
              <td>
                  实退金额：</td>
              <td>
              <asp:TextBox ID="TextRealMoney" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
            <tr>
              <td>
                  退款备注：</td>
              <td>
               <asp:TextBox ID="TextReturnNote" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  退款方式</td>
              <td>
                  <asp:DropDownList ID="DDPaymentName" runat="server">
                  <asp:ListItem Text="请选择" Value=""></asp:ListItem>
                  <asp:ListItem Text="现金" Value="现金"></asp:ListItem>
                  <asp:ListItem Text="银行卡" Value="银行卡"></asp:ListItem>
                  <asp:ListItem Text="支付宝" Value="支付宝"></asp:ListItem>
                  <asp:ListItem Text="微支付" Value="微支付"></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td class="style2">&nbsp;
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" 提 交 " onclick="Button1_Click" />

                                <input type="button" value=" 返 回 " onclick="location.href='SellGoods.aspx?trace_id=<%=trace_id %>'" />
                            </td>
            </tr>
          </table>
	
</td>
<td valign=top>
          <table width=100% cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#EEEEEE"><td>商品名称</td><td width=80>属性</td><td width=60>条码</td><td width=40>价格</td><td width=30>数量</td><td>小计</td></tr>
          <asp:Repeater runat="server" ID="GoodsList">
           <ItemTemplate>
          <tr bgcolor="#FFFFFF"><td><%#Eval("goods_name")%></td><td><%#Eval("specification")%></td><td><%#Eval("txm")%></td><td><%#Eval("price")%></td><td><%#Eval("quantity")%></td>
          <td><%#Convert.ToDouble(Eval("price")) * Convert.ToInt32(Eval("quantity"))%>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
          </table>
</td>
  </tr>          
<tr bgcolor="#FFFFFF" > 
<td height="30"  align="right" colspan=2>&nbsp;</td>
</tr>
</table>
</div>
				

</form>
