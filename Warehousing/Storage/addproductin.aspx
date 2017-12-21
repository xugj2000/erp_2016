<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addproductin.aspx.cs" Inherits="Warehousing.Storage.addproductin" EnableEventValidation="false"%>
<html><head><title>商品入库</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<link href="../css/jquery.editable-select.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.editable-select.js"></script>

<style type="text/css">
.editor { margin:0px 22px 0px 125px; }
.width2,.width3,.width4,.width6{height:30px;line-height:30px;padding-left:2px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width2{width:60px;margin:0px;}
.width3{width:80px;margin:0px;}
.width4{width:40px;margin:0px;text-align:center;}
.width6{width:120px;margin:0px;}
.add_link{color:red;margin:4px;display:block}
.delete_btn { display: block; float: left; margin-left: 5px; width: 10px; height: 10px; overflow: hidden; cursor: pointer; background: url(/images/ico.gif) 0 -634px; }
</style>
<script type="text/javascript">
    $(function () {
    <%if (id==0) {%>
        getRelateActive();
     <%} %>
      //  $("input[name='p_quantity']").blur(function () {
     //       alert(1);
      //  });

        $("#gettxm").blur(function () {
            var kw = $("#gettxm").val();
            if (kw == "") return;
            var txm = $("#mytable input[name='p_txm']");
            var findflag = 0;
            var txmcount = 0;
            txm.each(function (index) {
            //alert($(this).val() );
            //alert(kw);
                if ($(this).val().toUpperCase() == kw.toUpperCase()) {
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
        });

        $(".delete_btn").click(function () {
            var lastrow;
            $(this).parent().parent().remove();
        });

        $("#sm_supplierid,#warehouse_id").change(function () {
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
                sm_supplierid: {
                    required: true
                },
                relateActive: {
                   // required: true
                },
                sm_type: {
                    required: true
                },
                sm_date: {
                    required: true
                },
                sm_operator: {
                    required: true
                }
            },
            messages: {
                sm_supplierid: {
                    required: '供应商不能为空'
                },
                relateActive: {
                   // required: '请选择关联采购单'
                },
                sm_type: {
                    required: '请选择入库类型'
                },
                sm_date: {
                    required: '收货日期不能为空'
                },
                sm_operator: {
                    required: '出入库员不能为空'
                }
            }
        });

        function txmInputNew(thisobj) {
            var p_txm = $(thisobj).val();
            if (p_txm == "") return;
            var select_supplierid=$("#sm_supplierid").val();
            if (select_supplierid=="")
            {
                alert("请选择供应商");
                $(thisobj).parent().parent().remove();
                $("#gettxm").val("");
                $("#sm_supplierid").focus();
                return;
            }
            var warehouse_id = form1.warehouse_id.value;
            $.get("/Handler/getInfoByCode.ashx?d=" + new Date().getTime(), { q: p_txm, wid: warehouse_id }, function (result) {
                var obj = $(thisobj).parent().parent();
                if (result != "0") {
                    var ss = result.split(",");
                    var supplier_id=parseInt(ss[11]);
                    if (supplier_id!=select_supplierid)
                    {
                        alert("入库商品非所选供应商产品!");
                        $(thisobj).parent().parent().remove();
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                        return;
                    }
                    obj.find("input[name='p_name']").val(ss[0]);
                    obj.find("input[name='p_serial']").val(ss[1]);
                    obj.find("input[name='p_spec']").val(ss[2]);
                    obj.find("input[name='p_model']").val(ss[3]);
                    obj.find("input[name='p_brand']").val(ss[4]);
                    obj.find("input[name='p_unit']").val(ss[5]);
                    obj.find("input[name='p_price']").val(ss[7]);
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

        function getRelateActive() {
            var sid = form1.sm_supplierid.value;
            if (sid == "") {
                return;
            }
            
            var warehouse_id = form1.warehouse_id.value;
            if (warehouse_id == "") {
                return;
            }
            $.get("/Handler/getActBySupplierId.ashx?d=" + new Date().getTime(), { type:"caigou",sid: sid, wid: warehouse_id }, function (result) {
           // alert(result);
                var optionStr = "<option value=\"\">请选择</option>";
                if (result != "0") {
                   
                    var ss = result.split(";");
                    var dd;
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

    });
</script>
</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong style="font-size:18px;">商品入库</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  供应商名称：</td>
              <td width="86%">
                  <asp:DropDownList ID="sm_supplierid" runat="server">
                  <asp:ListItem Text="请选择供应商" Value=""></asp:ListItem>
                  </asp:DropDownList>

                  关联采购单&nbsp;
                 <asp:DropDownList ID="relateActive" runat="server" AutoPostBack="false">
                  <asp:ListItem Text="请选择" Value=""></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td>
                  操作仓库：</td>
              <td>
                 <span> <asp:DropDownList ID="warehouse_id" runat="server">
                  </asp:DropDownList></span>
              </td>
          </tr>
          <tr>
              <td width="14%">
                  入库类型：</td>
              <td width="86%">
                  <asp:DropDownList ID="sm_type" runat="server">
                  <asp:ListItem Text="入库类型" Value=""></asp:ListItem>
                  <asp:ListItem Text="采购入库" Value="1"></asp:ListItem>
                  <asp:ListItem Text="修补返库" Value="2"></asp:ListItem>
                  </asp:DropDownList>
               </td>
          </tr>
          <%if (id > 0)
            {%>
          <tr>
              <td>
                  入库单号：</td>
              <td>
              <%=liushuihao %>
              </td>
          </tr>
          <%} %>
          <tr>
              <td>
                  到货日期：</td>
              <td>
              <asp:TextBox ID="sm_date" runat="server" Width="238px" ReadOnly  onClick="return Calendar('sm_date','');"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  收货员姓名：</td>
              <td>
              <asp:TextBox ID="sm_operator" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  入库备注:</td>
              <td>
              <asp:TextBox ID="sm_remark" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <%if (id == 0)
            { %>
          <tr>
              <td>
                  扫码录入:</td>
              <td>
              <input type=text name="gettxm" id="gettxm" style="width:238px;height:30px;line-height:30px"/>
              (<font color=red>请在此输入条码</font>)
              </td>
          </tr>
          
                    <tr>
              <td colspan=2>
                  商品清单
<table width="100%" border="1" id="mytable" border=1>
  <tr>
    <td colspan="11">商品清单</td>
  </tr>
  <tr align="center">
    <td>条码</td>
  	<td>名称</td>
    <td>款号</td>
    <td>品牌</td>
    <td>单位</td>
    <td>规格</td>
    <td>型号</td>
    <td>数量</td>
	<td>价格</td>
    <td>仓位</td>
	<td></td>
  </tr>
</table>

<a href="javascript:;" id="add_one" style="color:red;margin:4px;font-size:16px;display:none;">添加新的商品</a>

<a href="javascript:;" id="copy_one" style="color:red;margin:4px;font-size:16px;display:none;">复制上款商品</a>
                  </td>
          </tr>
          <%} %>
          <tr>
              <td class="style2">&nbsp;
<asp:Button ID="Button2" runat="server" Text="" OnClientClick="return false;" style="width:1px;background:white;border:none"/>
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" 提 交 " onclick="Button1_Click" />

                                (同一个规格一个货号，一种型号对应一个条码)
                            </td>
            </tr>
          </table>
	
</td>
  </tr>          
<tr bgcolor="#FFFFFF" > 
<td height="30"  align="right">&nbsp;</td>
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
	<td><input name="p_price" type="text" class="text width4"/></td>
    <td><input name="shelf_no" type="text" class="text width2"/></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
</tbody></table>
<script type="text/javascript">
/*
    $('#sm_supplierid').editableSelect({
        bg_iframe: true,

        case_sensitive: false,
        items_then_scroll: 10,
        isFilter: false
    }); 
*/
	</script>
</body>
</html>
