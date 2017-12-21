<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProductOut.aspx.cs"
    Inherits="Warehousing.Storage.addProductOut" EnableEventValidation="false" %>

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
            if ($("#sm_type").val() == "") {
                alert("请选择出库类型再扫码操作！");
                return;
            }
            var kw = $("#gettxm").val();
            if (kw == "") return;
            var txm = $("#mytable input[name='p_txm']");
            var findflag = 0;
            var txmcount = 0;
            txm.each(function (index,value) {
                       // alert(txm.eq(index).val());
            //alert($(this).val());
                if ($(this).val().toUpperCase() == kw.toUpperCase()) {

                    //if ($("#getbox").val() == $("#mytable input[name='p_box']").eq(index).val()) {
                        quantityobj = $("#mytable input[name='p_quantity']").eq(index);
                        my_kc_nums = parseInt($("#mytable input[name='kc_nums']").eq(index).val());
                        if (my_kc_nums > -1 && my_kc_nums < (parseInt(quantityobj.val()) + 1)) {
                            alert("当前仓库中本产品库存不足！");
                        }
                        else {
                            quantityobj.val(parseInt(quantityobj.val()) + 1);
                        }
                        findflag = 1;
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                        return false
                    //}
                };
            });
            //alert(findflag);
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
                sm_type: {
                    required: true
                },
                 <%if (need_supplier==1) {%>
                sm_supplierid: {
                    required: true
                },
                <%} %>
                sm_date: {
                    required: true
                },
                sm_operator: {
                    required: true
                }
            },
            messages: {
                sm_type: {
                    required: '请选择出库类型'
                },
                <%if (need_supplier==1) {%>
                sm_supplierid: {
                    required: '供应商不能为空'
                },
                <%} %>
                sm_date: {
                    required: '收货日期不能为空'
                },
                sm_operator: {
                    required: '出出库员不能为空'
                }
            }
        });

        <%if (id==0&&int_outType==10) {%>
          getRelateActive();
         <%} %>


    function checkquantity(thisobj) {
        var this_quantity = parseInt($(thisobj).val());
        if (this_quantity < 0) {
            alert("库存不能为负");
            return;
        }
        var obj = $(thisobj).parent().parent();
        var p_txm = obj.find("input[name='p_txm']").val();
        //alert(p_txm);
        var warehouse_id = form1.from_warehouse_id.value;
        $.get("/Handler/getSkuByCode.ashx?d=" + new Date().getTime(), { q: p_txm, wid: warehouse_id }, function (result) {
            if (result != "0") {
                var ss = result.split("\t");
                if (this_quantity > parseInt(ss[7])) {
                    alert("库存不足,最多" + ss[7]);
                    obj.find("input[name='p_quantity']").val(ss[7])
                }
            }
        })
    }
         <%if (int_outType==10) {%>
        function getRelateActive() {
            var wid0 = form1.from_warehouse_id.value;//接受调货仓
            if (wid0 == "") {
                return;
            }
            var wid22 = form1.to_warehouse_id.value; //发起申请仓
            if (wid22 == "") {
                return;
            }
          //alert(wid22);
            $.get("/Handler/getActBySupplierId.ashx?d=" + new Date().getTime(), {type:"tiaohuo", wid: wid0, wid2: wid22 }, function (result) {
                //alert(result);
                var optionStr = "<option value=\"\">请选择</option>";
                if (result != "0") {
                    // alert(result);
                    var ss = result.split(";");
                    var dd;s
                    for (var i = 0; i < ss.length; i++) {
                        if (ss[i] != "") {
                            dd = ss[i].split(",");
                            optionStr += "<option value=\"" + dd[0] + "\">" + dd + "</option>";
                        }
                    }
                    $("#relateActive").html(optionStr);

                }
                else {
                    $("#relateActive").html(optionStr);
                }
            });
        }
        <%} %>
    function txmInputNew(thisobj) {
        var kw = $(thisobj).val();
        if (kw == "") return;
        var warehouse_id = $("#from_warehouse_id").val();
       var url="/Handler/getSkuByCode.ashx?d=" + new Date().getTime();
       //alert(url);
        $.get(url,{ q: kw, wid: warehouse_id },function (result) {
        //alert(result);
            var obj = $(thisobj).parent().parent();
            
            if (result != "0") {
               //alert(result);
                var ss = result.split("\t");
                obj.find("input[name='p_name']").val(ss[0]);
                obj.find("input[name='p_serial']").val(ss[1]);
                obj.find("input[name='p_spec']").val(ss[2]);
                obj.find("input[name='p_model']").val(ss[3]);
                obj.find("input[name='p_brand']").val(ss[4]);
                obj.find("input[name='p_unit']").val(ss[5]);
                <%if (int_outType==12) { //批发出库%>
                obj.find("input[name='p_price']").val(ss[6]);
                <%} else if (int_outType==13) { //加盟供货%>
                obj.find("input[name='p_price']").val(ss[10]);
                 <%} else if (int_outType==5||int_outType==7) { //返厂%>
                obj.find("input[name='p_price']").val(ss[11]);
                <%}else{ //其它按直营零售价算%>
                 obj.find("input[name='p_price']").val(ss[9]);
                <%} %>
                obj.find("input[name='kc_nums']").val(ss[7]);
                obj.find("input[name='shelf_no']").val(ss[8]);
                if (ss[7] <= 0) {
                    alert(kw + "此产品当前库存不足，不可出库");
                    $(thisobj).parent().parent().remove();
                    $("#gettxm").val("");
                    $("#gettxm").focus();
                }
                obj.find("input[name='p_box']").val($("#getbox").val());
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
    <%if (need_consumer==1)
  {%>
        $("#TextLoginName").change(function () {
            var usercode = $("#TextLoginName").val();
            if (usercode == "") 
            {
            $("#user_info_area").html("");
            return;
            }
            $.get("/Handler/getUserInfo.ashx?d=" + new Date().getTime(), { usercode: encodeURI(usercode) }, function (result) {
                if (result == "0") {
                   $("#user_info_area").html("当前客户不存在，结算后会生成同名新客户会员！");
                }
                else
                {

                 var ss = result.split("\t");
                 $("#user_info_area").html("客户存在，姓名:"+ss[1]+"，手机号"+ss[2]+"，当前积分："+ss[4]);
                }
            });
        });
        <%} %>
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
                    <b><strong style="font-size: 18px;">商品出库</strong></b>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#FFFFFF">
                    <table width="100%" cellpadding="4" class="style1">
                        <tr>
                            <td width="14%">
                                出库类型：
                            </td>
                            <td width="86%">
                                <asp:DropDownList ID="sm_type" runat="server" AutoPostBack="False">
                                </asp:DropDownList>
                                <asp:Label ID="Label_agent_info" runat="server" Text="(缺损退货等使用库间调货)" Visible="false"
                                    ForeColor="Navy"></asp:Label>
                               <label ID="relateActiveDiv" runat="server" Style="display: none;">关联申请单</label> 
                                <asp:DropDownList ID="relateActive" runat="server" AutoPostBack="false" Style="display: none;">
                                    <asp:ListItem Text="请选择" Value=""></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                操作仓库：
                            </td>
                            <td>
                                <span>
                                    <asp:DropDownList ID="from_warehouse_id" runat="server">
                                    </asp:DropDownList>
                                </span><span>
                                    <asp:DropDownList ID="to_warehouse_id" runat="server" Style="display: none;">
                                    </asp:DropDownList>
                                </span>
                            </td>
                        </tr>
<%if (need_supplier == 1)
  { //%>
                      <tr>
                          <td width="14%">
                              供应商名称：</td>
                          <td width="86%">
                              <asp:DropDownList ID="sm_supplierid" runat="server">
                              <asp:ListItem Text="请选择供应商" Value=""></asp:ListItem>
                              </asp:DropDownList>
                          </td>
                      </tr>
<%} %>
                        <%if (id > 0)
                          {%>
                        <tr>
                            <td>
                                出库单号：
                            </td>
                            <td>
                                <%=liushuihao %>
                            </td>
                        </tr>
                        <%} %>
<%if (need_consumer==1)
  {%>
          <tr>
              <td width="14%">
                  客户标识：</td>
              <td width="86%">
                 <asp:TextBox ID="TextLoginName" runat="server" Width="238px"></asp:TextBox>(客户登记会员名)
               </td>
          </tr>
          <tr>
              <td width="14%">
                  再次输入：</td>
              <td width="86%">
                 <asp:TextBox ID="TextLoginName2" runat="server" Width="238px"></asp:TextBox>(重复输入上面的客户标识)
               </td>
          </tr>
          <tr>
              <td>
                  会员信息：</td>
              <td>
              <span id="user_info_area"></span>
              </td>
          </tr>
<%} %>
                        <tr>
                            <td>
                                出货日期：
                            </td>
                            <td>
                                <asp:TextBox ID="sm_date" runat="server" Width="238px" ReadOnly onClick="return Calendar('sm_date','');"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                出货人姓名：
                            </td>
                            <td>
                                <asp:TextBox ID="sm_operator" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                出库备注:：
                            </td>
                            <td>
                                <asp:TextBox ID="sm_remark" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <%if (id == 0)
                          { %>
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
                                            箱号
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
                                                        onblur="checkquantity(this);" /><input type="hidden" value="-1" name="kc_nums" />
                                                </td>
                                                <td>
                                                    <input name="p_box" type="text" class="text width4" value='<%#Eval("p_box")%>' />
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
                                    <tr align="center">
                                        <td>
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
                                            <input name="p_quantity" type="text" class="text width4" maxlength="6" onblur="checkquantity(this);" /><input
                                                type="hidden" value="0" name="kc_nums" />
                                        </td>
                                        <td>
                                            <input name="p_box" type="text" class="text width4" maxlength="6" />
                                        </td>
                                        <td>
                                            <input name="shelf_no" type="text" class="text width4" readonly />
                                        </td>
                                        <td>
                                            <input name="p_price" type="text" class="text width4"/>
                                        </td>
                                        <td>
                                            <span class="delete_btn" onclick="$(this).parent().parent().remove();"></span>
                                        </td>
                                    </tr>
                                </table>
                                <a href="javascript:;" id="add_one" style="color: red; margin: 4px; font-size: 16px;
                                    display: none">添加新的商品</a>
                            </td>
                        </tr>
                        <%} %>
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
    <table style="display: none">
        <tbody id="oneline">
            <tr align="center">
                <td>
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
                    <input name="p_unit" type="text" class="text width4" readonly />
                </td>
                <td>
                    <input name="p_spec" type="text" class="text width2" readonly />
                </td>
                <td>
                    <input name="p_model" type="text" class="text width2" readonly />
                </td>
                <td>
                    <input name="p_quantity" type="text" class="text width4" maxlength="6" value="1"
                        onblur="checkquantity(this);" /><input type="hidden" value="0" name="kc_nums" />
                </td>
                <td>
                    <input name="p_box" type="text" class="text width4" maxlength="6" />
                </td>
                <td>
                    <input name="shelf_no" type="text" class="text width4" readonly />
                </td>
                <td>
                    <input name="p_price" type="text" class="text width4"/>
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
