<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addTemplate.aspx.cs" Inherits="Warehousing.Production.addTemplate" %>

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
    <script type="text/javascript">
        $(function () {
            $("#pro_code").change(function () {
                var kw = $("#pro_code").val();
                if (kw == "") return;
                $.get("/Handler/checkCode.ashx?d=" + new Date().getTime(), { q: kw }, function (result) {
                    if (result == "0") {
                        alert("产品货号不存在，请在采购管理先添加配置对应商品！");
                        $("#pro_code").val("");
                        $("#pro_code").focus();
                    }
                });
            });

            $("#gettxm").blur(function () {
                var kw = $("#gettxm").val();
                if (kw == "") return;
                var txm = $("#mytable input[name='p_txm']");
                var findflag = 0;
                var txmcount = 0;
                txm.each(function (index) {
                    if ($(this).val() == kw) {
                        quantityobj = $("#mytable input[name='p_quantity']").eq(index);
                        quantityobj.val(parseInt(quantityobj.val()) + 1);
                        findflag = 1;
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                        return false
                    };
                });
                if (findflag == 0) {
                    var onerow;
                    var lastrow;
                    if ($("#mytable input[name='p_txm']").eq(0).val() != "") {
                        onerow = $("#oneline").html();
                        //lastrow=$("#mytable").find('tr:last-child').html();
                        $("#mytable").find('tr:last-child').after(onerow);
                    }
                    $("#mytable").find('tr:last-child').find("input[name='p_quantity']").val("1");
                    $("#mytable").find('tr:last-child').find("input[name='p_txm']").val(kw);
                    txmInputNew($("#mytable").find('tr:last-child').find("input[name='p_txm']"));
                }
            });
            $("#add_one").click(function () {
                var onerow;
                var lastrow;
                onerow = $("#oneline").html();
                //lastrow=$("#mytable").find('tr:last-child').html();
                $("#mytable").find('tr:last-child').after(onerow);
                $("#mytable").find('tr:last-child').find("input[name='p_txm']").focus();
                //alert(lastrow);
            });

            $(".delete_btn").click(function () {
                var lastrow;
                $(this).parent().parent().remove();
            });

            $("#from_warehouse_id,#to_warehouse_id").change(function () {
                getRelateActive();
            });

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
                    factory_id: {
                        required: true
                    },
                    pro_name: {
                        required: true
                    },
                    pro_code: {
                        required: true
                    },
                    do_cost: {
                        required: true,
                        number: true,
                        min: 0
                    },
                    other_cost: {
                        number: true,
                        min: 0
                    }
                },
                messages: {
                    factory_id: {
                        required: '请选择加工厂'
                    },
                    pro_name: {
                        required: '产品名称不能为空'
                    },
                    pro_code: {
                        required: '产品货号不能为空'
                    },
                    do_cost: {
                        required: '加工费用不能为空',
                        number: '加工费用应为数字',
                        min: '加工费用有误'
                    },
                    other_cost: {
                        number: '单件其它费用应为数字',
                        min: '单件其它费用有误'
                    }
                }
            });

            function checkquantity(thisobj) {
                var this_quantity = parseInt($(thisobj).val());
                if (this_quantity < 0) {
                    alert("库存不能为负");
                    return;
                }
            }

            function txmInputNew(thisobj) {
                var kw = $(thisobj).val();
                if (kw == "") return;
                var warehouse_id = $("#from_warehouse_id").val();
                var url = "/Handler/getInfoByCode.ashx?d=" + new Date().getTime();
                //alert(url);
                $.get(url, { q: kw }, function (result) {
                    //alert(result);
                    var obj = $(thisobj).parent().parent();

                    if (result != "0") {

                        var ss = result.split(",");
                        obj.find("input[name='p_name']").val(ss[0]);
                        obj.find("input[name='p_serial']").val(ss[1]);
                        obj.find("input[name='p_spec']").val(ss[2]);
                        obj.find("input[name='p_model']").val(ss[3]);
                        obj.find("input[name='p_brand']").val(ss[4]);
                        obj.find("input[name='p_unit']").val(ss[5]);
                        obj.find("input[name='p_price']").val(ss[7]);
                        var last = $("#mytable").find('tr:last-child');
                        thisindex = $("#mytable").find('tr').index(obj);
                        lastindex = $("#mytable").find('tr').index(last);
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                    }
                    else {
                        alert(kw + "此产品暂不存在库中！请检查~");
                        $(thisobj).parent().parent().remove();
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                        // return;
                    }
                });
            }

        });



    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="div1">
        <table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC"
            class="tableBorder">
            <tr bgcolor="#FFFFFF">
                <td align="center">
                    <b><strong style="font-size: 18px;">加工模板</strong></b>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#FFFFFF">
                    <table width="100%" cellpadding="4" class="style1">
                        <tr>
                            <td width="14%">
                                匹配工厂：
                            </td>
                  <td width="86%">
                   <asp:DropDownList ID="factory_id" runat="server">
                  <asp:ListItem Text="请选择匹配工厂" Value=""></asp:ListItem>
                  </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                产品名称：
                            </td>
                            <td>
                                <asp:TextBox ID="pro_name" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                产品货号：
                            </td>
                            <td>
                                <asp:TextBox ID="pro_code" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                单件加工费用：
                            </td>
                            <td>
                                <asp:TextBox ID="do_cost" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                单件其它费用：
                            </td>
                            <td>
                                <asp:TextBox ID="other_cost" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                模板备注:：
                            </td>
                            <td>
                                <asp:TextBox ID="remark" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                扫码录入原料:
                            </td>
                            <td>
                                <input type="text" name="gettxm" id="gettxm" style="width: 238px; height: 30px; line-height: 30px"
                                    maxlength="20" />
                                (<font color="red">请在此输入条码</font>)
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                原料清单
                                <table width="100%" border="1" id="mytable" border="1">
                                    <tr>
                                        <td colspan="11">
                                            原料清单
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            条码
                                        </td>
                                        <td>
                                            名称
                                        </td>
                                        <td>
                                            款号
                                        </td>
                                        <td>
                                            品牌
                                        </td>
                                        <td>
                                            单位
                                        </td>
                                        <td>
                                            规格
                                        </td>
                                        <td>
                                            型号
                                        </td>
                                        <td>
                                            数量
                                        </td>
                                        <td>
                                            零售价
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <asp:Repeater ID="MemberList" runat="server">
                                        <ItemTemplate>
                                            <tr align="center">
                                                <td>
                                                <input type=hidden name="p_id" value='<%#Eval("id")%>' />
                                                    <input name="p_txm" type="text" class="text width6" value='<%#Eval("pro_txm")%>' onchange="txmInput(this);"
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_name" type="text" class="text width6" value='<%#Eval("pro_name")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_serial" type="text" class="text width3" value='<%#Eval("pro_code")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_brand" type="text" class="text width4" value='<%#Eval("pro_brand")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_unit" type="text" class="text width4" value='<%#Eval("pro_unit")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_spec" type="text" class="text width2" value='<%#Eval("pro_spec")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_model" type="text" class="text width2" value='<%#Eval("pro_model")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_quantity" type="text" class="text width4" value='<%#Eval("pro_nums")%>'
                                                        onblur="checkquantity(this);" />
                                                </td>
                                                <td>
                                                    <input name="p_price" type="text" class="text width2" value='<%#Eval("pro_inprice")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <span class="delete_btn" onclick="$(this).parent().parent().remove();"></span>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <%if (id == 0)
                          { %>
                                    <tr align="center">
                                        <td><input type=hidden name="p_id" value='0' />
                                            <input name="p_txm" type="text" class="text width6" onchange="txmInput(this);" readonly />
                                        </td>
                                        <td>
                                            <input name="p_name" type="text" class="text width6" readonly />
                                        </td>
                                        <td>
                                            <input name="p_serial" type="text" class="text width3" readonly />
                                        </td>
                                        <td>
                                            <input name="p_brand" type="text" class="text width4" readonly />
                                        </td>
                                        <td>
                                            <input name="p_unit" type="text" class="text width4"  readonly />
                                        </td>
                                        <td>
                                            <input name="p_spec" type="text" class="text width2" readonly />
                                        </td>
                                        <td>
                                            <input name="p_model" type="text" class="text width2" readonly />
                                        </td>
                                        <td>
                                            <input name="p_quantity" type="text" class="text width4" maxlength="6" onblur="checkquantity(this);" />
                                        </td>
                                        <td>
                                            <input name="p_price" type="text" class="text width2" readonly />
                                        </td>
                                        <td>
                                            <span class="delete_btn" onclick="$(this).parent().parent().remove();"></span>
                                        </td>
                                    </tr>
                                    <%} %>
                                </table>
                                <a href="javascript:;" id="add_one" style="color: red; margin: 4px; font-size: 16px;
                                    display: none">添加新的商品</a>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="style2">
                                &nbsp;
                                <asp:Button ID="Button2" runat="server" Text="" OnClientClick="return false;" Style="width: 1px;
                                    background: white; border: none" />
                            </td>
                            <td>
                            <input type=hidden value="<%=p_id_old%>" name="old_p_id" />
                                <asp:Button ID="Button1" runat="server" Text=" 提 交 " OnClick="Button1_Click" />
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
    </div>
    </form>
    <table style="display: none">
        <tbody id="oneline">
            <tr align="center">
                <td><input type=hidden name="p_id" value='0' />
                    <input name="p_txm" type="text" class="text width6" onchange="txmInput(this);" readonly />
                </td>
                <td>
                    <input name="p_name" type="text" class="text width6" readonly />
                </td>
                <td>
                    <input name="p_serial" type="text" class="text width3" readonly />
                </td>
                <td>
                    <input name="p_brand" type="text" class="text width4"  readonly />
                </td>
                <td>
                    <input name="p_unit" type="text" class="text width4"  readonly />
                </td>
                <td>
                    <input name="p_spec" type="text" class="text width2" readonly />
                </td>
                <td>
                    <input name="p_model" type="text" class="text width2" readonly />
                </td>
                <td>
                    <input name="p_quantity" type="text" class="text width4" maxlength="6" value="1"
                        onblur="checkquantity(this);" />
                </td>
                <td>
                    <input name="p_price" type="text" class="text width2" readonly />
                </td>
                <td>
                    <span class="delete_btn" onclick="$(this).parent().parent().remove();"></span>
                </td>
            </tr>
        </tbody>
    </table>
    </div>
</body>
</html>
