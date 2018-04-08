<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellGoods.aspx.cs" Inherits="Warehousing.Cashier.SellGoods" %>

<html>
<head>
    <title>��������</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link href="../css/global.css" rel="stylesheet" type="text/css" />
    <link href="../css/right.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
    <style type="text/css">
        #mainbox td{height:30px;line-height:20px;}
    </style>
    <script type="text/javascript">
    $(function () {
        $("#product_sn").focus();
    });

    function change_quantity(rec_id, spec_id, input, orig) {
        var subtotal_span = $('#item' + rec_id + '_subtotal');
        var amount_span = $('#cart_amount');

        //�ݴ�Ϊ�ֲ���������������û���������п������ǰ��ֵ��һ�µ�����
        var _v = input.value;

        if (_v < 1 || isNaN(_v)) {
            alert("�Ƿ���������");
            $(input).val($(input).attr('orig'));
            return false
        }
        $.get('SellGoods.aspx?act=update&trace_id=<%=trace_id %>&rec_id=' + rec_id + '&quantity=' + _v + "&d=" + new Date().getTime(), function (result) {
            if (result != "0") {
                //���³ɹ�

                var count = 0;
                for (var i = 0; i < parseInt($("input[name='quantity']").length); i++) {
                    count += parseInt($("input[name='quantity']").get(i).value);
                }
                $("#total_goods").html(count)
                thisHtml = $("#price_" + rec_id).html() * _v;
                subtotal_span.html(thisHtml);
                $("#total_money").html(result);
            }
            else {
                //����ʧ��
                alert("��ƷֱӪ���ۼ�δ���û����ݴ�������");
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
                    <b><strong style="font-size: 18px;">��������</strong></b>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#FFFFFF">
                    <table width="100%" cellpadding="4" id="mainbox">
                    <form method="get" action="SellGoods.aspx" name="form_txm" id="form_txm" onsubmit="if (form_txm.product_sn.value==''){alert('����������');return false;}">
                        <tr>
                            <td width="14%">
                                ��Ʒ����:
                            </td>
   
                            <td width="86%">
                            <input type="hidden" name="act" value="add" />
                               <input type="text" name="product_sn" id="product_sn" style="width: 238px; height: 30px; line-height: 30px"
                                    maxlength="20" /><input type="submit" value="�ύ" />
                                (<font color="red">֧��ɨ��</font>) 
                            </td>
                        </tr>
                    </form>
                        <tr>
                            <td colspan="2">
                                ��ѡ��Ʒ
                                <table width="100%" border="1" id="mytable">
                                    <tr>
                                        <td colspan="9" style="text-align:right">
                                        <asp:Repeater ID="HangList" runat="server" >
                                        <HeaderTemplate>>>��ǰ����:</HeaderTemplate>   
                                   <ItemTemplate>
                                            <a href="SellGoods.aspx?trace_id=<%#Eval("trace_id")%>">����<%#Container.ItemIndex+1%> </a>
                                   </ItemTemplate>
                                     </asp:Repeater>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            ��Ʒ����
                                        </td>
                                        <td>
                                            ��Ʒ����
                                        </td>
                                        <td>
                                            ԭ��
                                        </td>
                                        <td>
                                            ����
                                        </td>
                                        <td>
                                            ʵ�ۼ�
                                        </td>
                                        <td>
                                            ����
                                        </td>
                                        <td>
                                            С��
                                        </td>
                                        
                                        <td>
                                        </td>
                                    </tr>
                                 <asp:Repeater ID="GoodsList" runat="server" >
     <ItemTemplate>
                                    <tr align="center">
                                        <td>
                                            <%#Eval("goods_name")%>
                                            <br />
                                            [<%#Eval("txm")%>]
                                        </td>
                                        <td>
                                           [<%#Eval("specification")%>]
                                        </td>
                                        <td>
                                           <span id="init_price_<%#Eval("rec_id")%>"><%#Eval("price")%> </span>
                                        </td>
                                        <td>
                                           <span id="price_<%#Eval("rec_id")%>"><%#Eval("price")%> </span>
                                        </td>
                                        <td>
                                           <span id="true_price_<%#Eval("rec_id")%>"><%#Eval("price")%> </span>
                                        </td>
                                        <td>
                                            <input name="quantity" type="text" style="text-align:center;height:30px;" maxlength="6" value="<%#Eval("quantity")%>" orig="<%#Eval("quantity")%>"
                                                             changed="<%#Eval("quantity")%>" onkeyup="change_quantity(<%#Eval("rec_id")%>, <%#Eval("spec_id")%>, this);" /> 
                                        </td>
                                        <td id="item<%#Eval("rec_id")%>_subtotal">
                                           <%#Eval("sales")%> 
                                        </td>
                                        <td>
                                           <a href="SellGoods.aspx?act=del&rec_id=<%#Eval("rec_id")%>" onclick="return confirm('ȷ���Ƴ�����Ʒ��');">�Ƴ�</a>
                                        </td>
                                    </tr>
                                     </ItemTemplate>
                                     </asp:Repeater>
                                    <tr>
                                        <td colspan="9" style="text-align:left">
                                         <label id="cart_amount" style="padding-right:50px;"> 
                                          �ϼ�: <span style="color:red;font-size:16px;" id="total_goods"><%=total_goods %></span>��Ʒ + 
                                          <span style="color:red;font-size:16px;" id="total_money"><%=total_money %></span>Ԫ 
                                          </label>
                                          <input type="button" value="���ڽ���" onclick="location.href='CashierCollect.aspx?trace_id=<%=trace_id%>'" />
                                          <%if (trace_id == 0)
                                           { %>
                                          <input type="button" value="��ʱ����" onclick="location.href='SellGoods.aspx?act=hang'" />
                                          <%}
                                            else
                                          {%>
                                          <input type="button" value="�ص���ǰ" onclick="location.href='SellGoods.aspx'" />
                                          <%} %>
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