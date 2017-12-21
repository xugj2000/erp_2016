<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkingConfirm.aspx.cs" Inherits="Warehousing.Production.WorkingConfirm" %>
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
        function change_quantity(wp_id, input, orig) {
           
        }
    </script>
</head>
<body>
 <form id="form1" runat="server">
        <table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC"
            class="tableBorder">
            <tr bgcolor="#FFFFFF">
                <td align="center">
                    <b><strong style="font-size: 18px;">原料确认</strong></b>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#FFFFFF">
                    <table width="100%" cellpadding="4" id="mainbox">
                        <tr>
                            <td colspan="2">
                                待工产品
                                <table width="100%" border="1" id="mytable">
                                    <tr align="center">
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
                                            数量
                                        </td>
                                        <td>
                                            小计
                                        </td>
                                    </tr>
                                 <asp:Repeater ID="GoodsList" runat="server"  OnItemDataBound="OrderList_ItemDataBound">
     <ItemTemplate>
                                    <tr align="center">
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
                                        <td><%#Eval("quantity")%>
                                            
                                        </td>
                                        <td id="item<%#Eval("wm_id")%>_subtotal">
                                           <%#Eval("all_out_cost")%> 
                                        </td>
                                    </tr>
                                    <tr>
                                    <td colspan=7>
                                    <table width="80%" style="float:right;line-height:12px;" cellpadding="0">
                                    <tr>
                                    <td>原料名称</td> <td>原料货号</td> <td>单位数量</td> <td>所需数量</td><td>实际数量</td>
                                    </tr>
                                    <asp:Repeater runat="server" ID="MaterialList">
           <ItemTemplate>
                                    <tr>
                                    <td style="height:16px;"><%#Eval("pro_name")%></td>
                                     <td><%#Eval("pro_code")%></td>
                                   <td><%#Eval("pro_nums")%></td>
                                    <td><%#Eval("need_num")%></td>
                                   <td>
                                   <input type="hidden" name="wp_id" value='<%#Eval("wp_id")%>' />
                                   <input name="quantity" type="text" style="text-align:center;height:30px;" maxlength="6" value="<%#Eval("pro_real_nums")%>" orig="<%#Eval("pro_real_nums")%>"
                                                             changed="<%#Eval("pro_real_nums")%>" onkeyup="change_quantity(<%#Eval("wp_id")%>, this);" /> 

                                                             </td>
                                    </tr>
                                    </ItemTemplate>
          </asp:Repeater>
                                    </table>
                                    </td>
                                    </tr>
                                    <tr>
                                    <td colspan=8 style="height:3px;background:#EEE">
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
                                           <input type="button" value=" 上一步 " onclick="location.href='WorkingCart.Aspx?work_id=<%=work_id %>'" />
                                           &nbsp;&nbsp;
                                            <asp:Button ID="Button1" runat="server" Text=" 下一步 " onclick="Button1_Click" />
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
        </form>
</body>
</html>
