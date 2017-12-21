<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkingDetail.aspx.cs" Inherits="Warehousing.Production.WorkingDetail" %>

<html>
<head>
    <title>模板管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link href="../css/global.css" rel="stylesheet" type="text/css" />
    <link href="../css/right.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
    <script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
    <style type="text/css">
        .editor
        {
            margin: 0px 22px 0px 125px;
        }
        .width2, .width3, .width4, .width6
        {
            height: 30px;
            line-height: 30px;
            padding-left: 2px;
            border: solid 1px #CCC;
            border-bottom: solid 1px #666;
        }
        .width2
        {
            width: 60px;
            margin: 0px;
        }
        .width3
        {
            width: 80px;
            margin: 0px;
        }
        .width4
        {
            width: 40px;
            margin: 0px;
            text-align: center;
        }
        .width6
        {
            width: 120px;
            margin: 0px;
        }
        .add_link
        {
            color: red;
            margin: 4px;
            display: block;
        }
        .delete_btn
        {
            display: block;
            float: left;
            margin-left: 5px;
            width: 10px;
            height: 10px;
            overflow: hidden;
            cursor: pointer;
            background: url(/images/ico.gif) 0 -634px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <div id="div1">
        <table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC"
            class="tableBorder">
            <tr bgcolor="#FFFFFF">
                <td align="center">
                    <b><strong style="font-size: 18px;">工单详情</strong></b>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#FFFFFF">
                    <table width="100%" cellpadding="4" class="style1">
                        <tr>
                            <td width="14%">
                                加工厂：
                            </td>
                  <td width="86%">
                   <asp:DropDownList ID="factory_id" runat="server" Enabled=false>
                  </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                原料仓库：
                            </td>
                            <td>
                                <span>
                                    <asp:DropDownList ID="from_warehouse_id" runat="server" Enabled=false>
                                    </asp:DropDownList>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                工厂负责人：
                            </td>
                            <td>
                                <asp:TextBox ID="factory_manager" runat="server" Width="238px" ReadOnly></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                我方负责人：
                            </td>
                            <td>
                                <asp:TextBox ID="our_manager" runat="server" Width="238px" ReadOnly></asp:TextBox>
                            </td>
                        </tr>
                       <tr>
                          <td>
                              开始生产日期：</td>
                          <td>
                          <asp:TextBox ID="start_date" runat="server" Width="238px" ReadOnly></asp:TextBox>
                          </td>
                      </tr>
                      <tr>
                          <td>
                              预计交货日期：</td>
                          <td>
                          <asp:TextBox ID="end_date" runat="server" Width="238px" ReadOnly></asp:TextBox>
                          </td>
                       </tr>
                        <tr>
                            <td>
                                加工备注:
                            </td>
                            <td>
                                <asp:TextBox ID="work_remark" runat="server" Width="238px" ReadOnly></asp:TextBox>
                            </td>
                        </tr>
                        

                        <tr>
                            <td colspan="2">
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
                                        
                                        <td>
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
                                        <td>
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                    <td colspan=8>
                                    <table width="80%" style="float:right;line-height:12px;" cellpadding="0">
                                    <tr style="background:#EEE">
                                    <td style="height:20px;">原料名称</td> <td width=150>原料货号</td><td width=150>规格</td><td width=150>型号</td> <td>单位数量</td> <td>所需数量</td> <td>实际数量</td>
                                    </tr>
                                    <asp:Repeater runat="server" ID="MaterialList">
           <ItemTemplate>
                                    <tr>
                                    <td style="height:20px;"><%#Eval("pro_name")%></td> <td><%#Eval("pro_code")%></td><td><%#Eval("pro_spec")%></td><td><%#Eval("pro_model")%></td> <td><%#Eval("pro_nums")%></td>
                                   <td><%#Eval("need_num")%></td>
                                    <td><%#Eval("pro_real_nums")%></td>
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
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="style2">
                                
                            </td>
                            <td>
                            
                                
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td height="30" align="right">
                    <asp:HiddenField ID="work_status_old" runat="server" />
                    <asp:DropDownList ID="work_status" runat="server">
                   <asp:ListItem Value="">选择处理</asp:ListItem>
                  </asp:DropDownList>

<asp:Button ID="Button1" runat="server" Text=" 审 核 " onclick="Button1_Click" />
                </td>
            </tr>
        </table>
    </div>
    </form>
    </div>
</body>
</html>
