<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkingCart.aspx.cs" Inherits="Warehousing.Production.WorkingCart" %>
<html>
<head>
    <title>收银中心</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link href="../css/global.css" rel="stylesheet" type="text/css" />
    <link href="../css/right.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
    <style type="text/css">
        #mainbox td{height:30px;line-height:20px;}
    </style>
    <script type="text/javascript">
        function change_quantity(wm_id, spec_id, input, orig) {
            var subtotal_span = $('#item' + wm_id + '_subtotal');
            var amount_span = $('#cart_amount');

            //暂存为局部变量，否则如果用户输入过快有可能造成前后值不一致的问题
            var _v = input.value;

            if (_v < 1 || isNaN(_v)) {
                alert("非法数字输入");
                $(input).val($(input).attr('orig'));
                return false
            }
            $.get('WorkingCart.Aspx?act=update&wm_id=' + wm_id + '&quantity=' + _v + "&d=" + new Date().getTime(), function (result) {
                if (result != "0") {
                    //更新成功

                    var count = 0;
                    for (var i = 0; i < parseInt($("input[name='quantity']").length); i++) {
                        count += parseInt($("input[name='quantity']").get(i).value);
                    }
                    $("#total_goods").html(count)
                    thisHtml = $("#price_" + wm_id).html() * _v;
                    subtotal_span.html(thisHtml);
                    var ss = result.split(",");
                    $("#total_money").html(ss[0]);
                    $("#total_other_cost").html(ss[1]);
                }
                else {
                    //更新失败
                    alert(result.msg);
                    $(input).val($(input).attr('changed'));
                }
            });
        }
    </script>
</head>
<body>
        <table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC"
            class="tableBorder">
            <tr bgcolor="#FFFFFF">
                <td align="center">
                    <b><strong style="font-size: 18px;">加工预选</strong></b>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#FFFFFF">
                    <table width="100%" cellpadding="4" id="mainbox">
                        <tr>
                            <td colspan="2">
                                预选产品<%if (factory_num > 1)
                                      { %>(<font color=red style="font-size:16px;">请注意：预选加工模板中涉及<%=factory_num %>匹配工厂模板，若是不可跨工厂复用请调整!</font>)<%} %>
                                <table width="100%" border="1" id="mytable">
                                    <tr align="center">
                                                                            <td>
                                           匹配工厂
                                        </td>
                                        <td>
                                            商品名称
                                        </td>
                                        <td>
                                            货号
                                        </td>
                                        <td>
                                            原料费用
                                        </td>
                                        <td>
                                            加工费用
                                        </td>
                                        <td>
                                            其它费用
                                        </td>
                                        <td>
                                            加工数量
                                        </td>
                                        <td>
                                            小计
                                        </td>
                                        
                                        <td>
                                        </td>
                                    </tr>
                                 <asp:Repeater ID="GoodsList" runat="server"  OnItemDataBound="OrderList_ItemDataBound">
     <ItemTemplate>
                                    <tr align="center">
                                        <td>
                                            <%#Warehousing.Business.ProductionHelper.getFactoryName(Convert.ToInt32(Eval("factory_id")))%>
                                        </td>
                                        <td>
                                            <%#Eval("pro_name")%>
                                        </td>
                                        <td>
                                           <%#Eval("pro_code")%>
                                        </td>
                                        <td>
                                           <span id="init_price_<%#Eval("wm_id")%>">* </span>
                                        </td>
                                        <td>
                                           <span id="price_<%#Eval("wm_id")%>"><%#Eval("do_cost")%> </span>
                                        </td>
                                        <td>
                                           <span id="true_price_<%#Eval("wm_id")%>"><%#Eval("other_cost")%> </span>
                                        </td>
                                        <td>
                                            <input name="quantity" type="text" style="text-align:center;height:30px;" maxlength="6" value="<%#Eval("quantity")%>" orig="<%#Eval("quantity")%>"
                                                             changed="<%#Eval("quantity")%>" onkeyup="change_quantity(<%#Eval("wm_id")%>, <%#Eval("wm_id")%>, this);" /> 
                                        </td>
                                        <td id="item<%#Eval("wm_id")%>_subtotal">
                                           <%#Eval("all_out_cost")%> 
                                        </td>
                                        <td>
                                           <a href="WorkingCart.Aspx?act=del&wm_id=<%#Eval("wm_id")%>" onclick="return confirm('确定移除本商品吗');">移除</a>
                                        </td>
                                    </tr>
                                    <tr>
                                    <td colspan=9>
                                    <table width="80%" style="float:right;line-height:12px;" cellpadding="0">
                                    <tr>
                                    <td>原料名称</td> <td width=150>原料货号</td><td width=150>规格</td><td width=150>型号</td> <td>单位数量</td>
                                    </tr>
                                    <asp:Repeater runat="server" ID="MaterialList">
           <ItemTemplate>
                                    <tr>
                                    <td style="height:16px;"><%#Eval("pro_name")%></td> <td><%#Eval("pro_code")%></td><td><%#Eval("pro_spec")%></td><td><%#Eval("pro_model")%></td> <td><%#Eval("pro_nums")%></td>
                                    </tr>
                                    </ItemTemplate>
          </asp:Repeater>
                                    </table>
                                    </td>
                                    </tr>
                                    <tr>
                                    <td colspan=9 style="height:3px;background:#EEE">
                                    </td>
                                    </tr>
                                     </ItemTemplate>
                                     </asp:Repeater>
                                    <tr>
                                        <td colspan="9" style="text-align:left">
                                         <label id="cart_amount" style="padding-right:50px;"> 
                                          合计: <span style="color:red;font-size:16px;" id="total_goods"><%=total_goods %></span>商品 + 
                                          <span style="color:red;font-size:16px;" id="total_money"><%= total_do_cost%></span>元(加工费)  + 
                                          <span style="color:red;font-size:16px;" id="total_other_cost"><%= total_other_cost%></span>元(其它费) 
                                          </label>
                                          <input type="button" value=" 下一步 "  onclick="location.href='WorkingConfirm.Aspx?work_id=<%=work_id %>'" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td height="30" align="right">
                    &nbsp;
                </td>
            </tr>
        </table>
</body>
</html>
