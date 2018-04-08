<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductReturn.aspx.cs" Inherits="Warehousing.Storage.ProductReturn" %>

<html>
<head>
    <title>产品出库</title>
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
        td{height:24px;}
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
            $("#gettxm").blur(function () {
                var kw = $("#gettxm").val();
                if (kw == "") return;
                var txm = $("#mytable input[name='p_txm']");
                var findflag = 0;
                var txmcount = 0;
                txm.each(function (index) {
                    if ($(this).val() == kw) {
                        quantityobj = $("#mytable input[name='p_quantity']").eq(index);
                        <%if (return_id>0) {%>
                        init_quantity = parseFloat($("#mytable input[name='init_quantity']").eq(index).val());
                        if (init_quantity < (parseFloat(quantityobj.val()) + 1)) {
                            alert("退货数量超出本单涉及商品数量！");
                        }
                        else {
                            quantityobj.val(parseFloat(quantityobj.val()) + 1);
                        }
                        <%}else{ %>
                            quantityobj.val(parseFloat(quantityobj.val()) + 1);
                        <%} %>
                        findflag = 1;
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                        return false
                    };
                });
                <%if (return_id==0) {%>
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
                <%} %>
            });


            $(".delete_btn").click(function () {
                var lastrow;
                $(this).parent().parent().remove();
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
                    sm_date: {
                        required: true
                    },
                    sm_operator: {
                        required: true
                    }
                },
                messages: {
                    sm_date: {
                        required: '退货日期不能为空'
                    },
                    sm_operator: {
                        required: '收货员不能为空'
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
            $.get("/Handler/getUserInfo.ashx?d=" + new Date().getTime(), { usercode: encodeURI(usercode) }, function (result) {
                if (result == "0") {
                   $("#user_info_area").html("当前客户不存在，不可退货！");
                   alert("当前客户不存在，不可退货！");
                }
                else
                {

                 var ss = result.split("\t");
                 $("#user_info_area").html("客户存在，姓名:"+ss[1]+"，手机号"+ss[2]+"，当前积分："+ss[4]);
                }
            });
        });

            function txmInputNew(thisobj) {
                var p_txm = $(thisobj).val();
                if (p_txm == "") return;
                var warehouse_id = form1.to_warehouse_id.value;
                $.get("/Handler/getInfoByCode.ashx?d=" + new Date().getTime(), { q: p_txm, wid: warehouse_id }, function (result) {
                    var obj = $(thisobj).parent().parent();
                    //alert(result);
                    if (result != "0") {
                        var ss = result.split(",");
                        obj.find("input[name='p_name']").val(ss[0]);
                        obj.find("input[name='p_serial']").val(ss[1]);
                        obj.find("input[name='p_spec']").val(ss[2]);
                        obj.find("input[name='p_model']").val(ss[3]);
                        obj.find("input[name='p_brand']").val(ss[4]);
                        obj.find("input[name='p_unit']").val(ss[5]);
                        obj.find("input[name='p_price']").val(ss[6]);
                        //obj.find("input[name='p_baseprice']").val(ss[7]);
                        obj.find("input[name='shelf_no']").val(ss[8]);
                        var last = $("#mytable").find('tr:last-child');
                        thisindex = $("#mytable").find('tr').index(obj);
                        lastindex = $("#mytable").find('tr').index(last);
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                    }
                    else {
                        alert(p_txm + "此产品暂不存在库中！请检查~");
                        $(thisobj).parent().parent().remove();
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                        // return;
                    }
                });
            }

        });

        function checkquantity(thisobj, init_quantity) {
            //alert("hi");
            var this_quantity = parseFloat($(thisobj).val());
            if (this_quantity < 0) {
                alert("退货数量不能为负");
                return;
            }
            if (this_quantity > parseFloat(init_quantity)) {
                alert("退货数量超出本单涉及商品数量");
                return;
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="div1">
        <table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC"
            class="tableBorder">
            <tr bgcolor="#FFFFFF">
                <td align="center">
                    <b><strong style="font-size: 18px;">商品退货</strong></b>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#FFFFFF">
                    <table width="100%" cellpadding="4" class="style1">
                        <tr>
                            <td width="14%">
                                入库类型：
                            </td>
                            <td width="86%">
                                <asp:DropDownList ID="sm_type" runat="server" AutoPostBack="False">
                                </asp:DropDownList>
                               关联出库单:<label ID="relateActiveDiv" runat="server"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                操作仓库：
                            </td>
                            <td>
                                <span>
                                    <asp:DropDownList ID="to_warehouse_id" runat="server">
                                    </asp:DropDownList>
                                </span>
                            </td>
                        </tr>
          <tr>
              <td width="14%">
                  客户标识：</td>
              <td width="86%">
                 <asp:TextBox ID="TextLoginName" runat="server" Width="238px"></asp:TextBox>
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
                            <td>
                                退货日期：
                            </td>
                            <td>
                                <asp:TextBox ID="sm_date" runat="server" Width="238px" ReadOnly onClick="return Calendar('sm_date','');"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                收货人姓名：
                            </td>
                            <td>
                                <asp:TextBox ID="sm_operator" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                退货备注:：
                            </td>
                            <td>
                                <asp:TextBox ID="sm_remark" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                扫码录入:
                            </td>
                            <td>
                                <input type="text" name="gettxm" id="gettxm" style="width: 238px; height: 30px; line-height: 30px"
                                    maxlength="20" />
                                (<font color="red">请在此输入条码</font>) 
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                商品清单
                                <table width="100%" border="1" id="mytable" border="1">
                                    <tr>
                                        <td colspan="12">
                                            商品清单
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
                                            仓位
                                        </td>
                                        <td>
                                            价格
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <asp:Repeater ID="MemberList" runat="server">
                                        <ItemTemplate>
                                            <tr align="center">
                                                <td>
                                                    <input name="p_txm" type="text" class="text width6" value='<%#Eval("p_txm")%>' onchange="txmInput(this);"
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_name" type="text" class="text width6" value='<%#Eval("p_name")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_serial" type="text" class="text width3" value='<%#Eval("p_serial")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_brand" type="text" class="text width4" value='<%#Eval("p_brand")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_unit" type="text" class="text width4" value='<%#Eval("p_unit")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_spec" type="text" class="text width2" value='<%#Eval("p_spec")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_model" type="text" class="text width2" value='<%#Eval("p_model")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_quantity" type="text" class="text width4" value='<%#Eval("p_quantity")%>'
                                                        onblur="checkquantity(this,<%#Eval("p_quantity")%>);" style="border:1px solid red" /><input type="hidden" value="<%#Eval("p_quantity")%>" name="init_quantity" />
                                                </td>
                                                <td>
                                                    <input name="shelf_no" type="text" class="text width4" value='<%#Eval("shelf_no")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_price" type="text" class="text width4" value='<%#Eval("p_price")%>'
                                                        />
                                                </td>
                                                <td>
                                                    <span class="delete_btn" onclick="$(this).parent().parent().remove();"></span>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2">
                                &nbsp;
                                <asp:Button ID="Button2" runat="server" Text="" OnClientClick="return false;" Style="width: 1px;
                                    background: white; border: none" />
                            </td>
                            <td>
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
    <table style="display:none">
<tbody id="oneline">
  <tr align="center">
    <td><input name="p_txm" type="text" data="" class="text width6" onchange="txmInput(this);" /></td>
  	<td><input name="p_name" type="text" class="text width6" readonly/></td>
    <td><input name="p_serial" type="text" class="text width3" readonly/></td>
    <td><input name="p_brand" type="text" class="text width4" readonly/></td>
    <td><input name="p_unit" type="text" class="text width4"  readonly/></td>
    <td><input name="p_spec" type="text" class="text width2" readonly/></td>
    <td><input name="p_model" type="text" class="text width2" readonly/></td>
	<td><input name="p_quantity" type="text" class="text width4" value=0/></td>
      <td><input name="shelf_no" type="text" class="text width4"/></td>
	<td><input name="p_price" type="text" class="text width4"/></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
</tbody></table>
</body>
</html>
