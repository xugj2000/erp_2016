<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CashierCollect.aspx.cs" Inherits="Warehousing.Cashier.CashierCollect" %>

<html><head><title>人员管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<script type="text/javascript">
    $(function () {
        jQuery.validator.addMethod("telphoneValid", function (value, element) {
            var tel = /^1[34578]{1}\d{9}$/;
            if (value=="") return true;
            return tel.test(value) || this.optional(element);
        }, "请输入正确的手机号码");
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
					max : <%=all_sales%>
                },
                DDPaymentName: {
                    required: true
                },
                TextLoginName: {
                    telphoneValid: true
                },
                TextLoginName2: {
                    equalTo: '#TextLoginName'
                }
            },
            messages: {
                TextRealMoney: {
                    required: '实收金额不能为空',
					number     :'实收金额要求为数值',
					min : '实收金额有误',
					max : '实收金额不能大于<%=all_sales%>'
                },
                DDPaymentName: {
                    required: '请选择付款方式'
                },
                TextLoginName: {
                    telphoneValid: '会员标识要求为手机号'
                },
                TextLoginName2: {
                    equalTo: '两次输入不一致'
                }
            }
        });

        $("#TextLoginName").change(function () {
            var usercode = $("#TextLoginName").val();
            if (usercode == "") 
            {
            $("#user_info_area").html("");
            return;
            }
            $.get("/Handler/getUserInfo.ashx?d=" + new Date().getTime(), { usercode: usercode }, function (result) {
                if (result == "0") {
                   $("#user_info_area").html("当前会员不存在，结算后会生成同名新会员！");
                }
                else
                {
                 var ss = result.split("\t");
                 $("#user_info_area").html("会员存在，手机号"+ss[2]+"，当前积分："+ss[4]);
                }
            });
        });

    });
</script>
</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center" colspan=2><b><strong>收银确认</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">

          <tr>
              <td>
                  应收金额：</td>
              <td>
              <%=all_sales%>
              </td>
          </tr>
            <tr>
              <td>
                  实收金额：</td>
              <td>
              <asp:TextBox ID="TextRealMoney" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
            <tr>
              <td>
                  收款备注：</td>
              <td>
               <asp:TextBox ID="TextBox1" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  导购员</td>
              <td>
                  <asp:DropDownList ID="GuideList" runat="server">
                  <asp:ListItem Text="无导购" Value="0"></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td>
                  付款方式</td>
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
              <td width="14%">
                  会员标识：</td>
              <td width="86%">
                 <asp:TextBox ID="TextLoginName" runat="server" Width="238px"></asp:TextBox>(暂只支持手机号)
               </td>
          </tr>
          <tr>
              <td width="14%">
                  再次输入：</td>
              <td width="86%">
                 <asp:TextBox ID="TextLoginName2" runat="server" Width="238px"></asp:TextBox>(重复输入上面的会员标识)
               </td>
          </tr>
          <tr>
              <td>
                  会员信息：</td>
              <td>
              <span id="user_info_area"></span>
              </td>
          </tr>
          <tr>
              <td width="14%">
                  会员密码：</td>
              <td width="86%">
                 <asp:TextBox ID="TextLoginPwd" runat="server" Width="80px" TextMode="Password" MaxLength=6></asp:TextBox>(6位数字支付密码)暂时忽略！！
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
