<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProductPlan.aspx.cs" Inherits="Warehousing.Storage.addProductPlan" %>
<html><head><title>商品采购计划</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
.editor { margin:0px 22px 0px 125px; }
.width2,.width3,.width4,.width6{height:30px;line-height:30px;padding-left:2px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width2{width:60px;margin:0px;}
.width3{width:80px;margin:0px;}
.width4{width:40px;margin:0px;text-align:center;}
.width7{width:40px;height:30px;margin:0px;text-align:center;line-height:30px;border:solid 1px red;}
.width6{width:110px;margin:0px;}
.add_link{color:red;margin:4px;display:block}
.delete_btn { display: block; float: left; margin-left: 5px; width: 10px; height: 10px; overflow: hidden; cursor: pointer; background: url(/images/ico.gif) 0 -634px; }
</style>
<script type="text/javascript">
    $(function () {
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
                sm_type: {
                    required: true
                },
                sm_tax: {
                    required: true,
                    number: true,
                    min: 0,
                    max: 0.2
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
                sm_type: {
                    required: '请选择入库类型'
                },
                sm_tax: {
                    required: '税率不能为空',
                    number: '税率要求为数值',
                    min: '税率不能小于0',
                    max: '税率最高不能超出0.2'
                },
                sm_date: {
                    required: '收货日期不能为空'
                },
                sm_operator: {
                    required: '采购单员不能为空'
                }
            }
        });
    });
      function txmInput(thisobj) {
        var kw = $(thisobj).val();
        if (kw == "") return;
        $.get("/Handler/getInfoByCode.ashx?d="+ new Date().getTime(), { q: kw }, function (result) {
            var obj = $(thisobj).parent().parent();
           // alert(result);
            if (result != "0") {
                var ss = result.split(",");
                obj.find("input[name='p_name']").val(ss[0]);
                obj.find("input[name='p_serial']").val(ss[1]);
                obj.find("input[name='p_spec']").val(ss[2]);
                obj.find("input[name='p_model']").val(ss[3]);
                // obj.find("input[name='p_brand']").val(ss[4]);
                //obj.find("input[name='p_unit']").val(ss[5]);
                obj.find("input[name='p_price']").val(ss[6]);
                obj.find("input[name='p_baseprice']").val(ss[7]);
                var last = $("#mytable").find('tr:last-child');
                thisindex = $("#mytable").find('tr').index(obj);
                lastindex = $("#mytable").find('tr').index(last);
                if (thisindex == lastindex) {
                    $("#add_one").click();
                }
            }
            else {
                //alert(kw + "此产品暂不存在库中！请检查~");
                // return;
            }
        });
    }


    //$("input[name='p_baseprice'],input[name='p_baseprice_tax']").change(function ()
     function feeInput(thisobj) {
        if ($("#sm_tax").val() == "") {
            alert("请先确定税率");
            $(thisobj).val(0);
            $("#sm_tax").focus();
            return;
        }
        var sm_tax = 0;
        try {
            sm_tax = parseFloat($("#sm_tax").val());
        }
        catch (e) {
            alert("税率有误");
            $("#sm_tax").focus();
            return;
        }
        if (sm_tax > 0.2) {
            alert("税率不能高过0.2");
            $("#sm_tax").focus();
            return;
        }
        var pname = $(thisobj).attr("name");
        if (pname == "p_baseprice") {
            $(thisobj).parent().parent().find("input[name='p_baseprice_tax']").val(($(thisobj).val() * (1 + sm_tax)).toFixed(4));
        }
        else {
            $(thisobj).parent().parent().find("input[name='p_baseprice']").val(($(thisobj).val() / (1 + sm_tax)).toFixed(4));
        }
    }  

</script>
</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品采购计划</strong></b></td>
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
              </td>
          </tr>
          <tr>
              <td width="14%">
                  采购类型：</td>
              <td width="86%">
                  <asp:DropDownList ID="sm_type" runat="server">
                  <asp:ListItem Text="选择类型" Value=""></asp:ListItem>
                  <asp:ListItem Text="普通采购" Value="1"></asp:ListItem>
                  <asp:ListItem Text="补货采购" Value="2"></asp:ListItem>
                  </asp:DropDownList>
               </td>
          </tr>
          <tr>
              <td>
                  税率：</td>
              <td>
              <asp:TextBox ID="sm_tax" runat="server" Width="238px" MaxLength="5"></asp:TextBox> 请输入0到1间的小数
         </td>
          </tr>
          <%if (id > 0)
            {%>
          <tr>
              <td>
                   采购计划单号：</td>
              <td>
              <%=liushuihao %>  <input type=hidden value="<%=sm_tax_old %>" name="sm_tax_old" />
              </td>
          </tr>
          <%} %>
          <tr>
              <td>
                  计划到货日期：</td>
              <td>
              <asp:TextBox ID="sm_date" runat="server" Width="238px" ReadOnly  onClick="return Calendar('sm_date','');"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  跟单员姓名：</td>
              <td>
              <asp:TextBox ID="sm_operator" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                 计划备注:：</td>
              <td>
              <asp:TextBox ID="sm_remark" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <%if (id == 0)
            { %>
                    <tr>
              <td colspan=2>
                  商品清单
<table width="100%" border="1" id="mytable" border=1>
  <tr>
    <td colspan="12">商品清单</td>
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
    <td>无税价</td>
    <td>带税价</td>
	<td>零售价</td>
	<td></td>
  </tr>
  <tr align="center">
    <td><input name="p_txm" type="text" class="text width6" onblur="txmInput(this);" /></td>
  	<td><input name="p_name" type="text" class="text width6" readonly/></td>
    <td><input name="p_serial" type="text" class="text width3" readonly/></td>
    <td><input name="p_brand" type="text" class="text width4" value="WQii" readonly/></td>
    <td><input name="p_unit" type="text" class="text width4" value="件" readonly/></td>
    <td><input name="p_spec" type="text" class="text width2" readonly/></td>
    <td><input name="p_model" type="text" class="text width2" readonly/></td>
	<td><input name="p_quantity" type="text" class="text width7"/></td>
    <td><input name="p_baseprice" type="text" class="text width7" value="0" onclick="select(this)" onchange="feeInput(this);"/></td>
    <td><input name="p_baseprice_tax" type="text" class="text width7" value="0" onclick="select(this)" onchange="feeInput(this);"/></td>
	<td><input name="p_price" type="text" class="text width4" readonly/></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();" style="display:none"></span></td>
  </tr>
</table>

<a href="javascript:;" id="add_one" style="color:red;margin:4px;font-size:16px;display:block">添加新的商品</a>

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
    <td><input name="p_txm" type="text" class="text width6" onblur="txmInput(this);" /></td>
  	<td><input name="p_name" type="text" class="text width6" readonly/></td>
    <td><input name="p_serial" type="text" class="text width3" readonly/></td>
    <td><input name="p_brand" type="text" class="text width4" value="WQii" readonly/></td>
    <td><input name="p_unit" type="text" class="text width4" value="件" readonly/></td>
    <td><input name="p_spec" type="text" class="text width2" readonly/></td>
    <td><input name="p_model" type="text" class="text width2" readonly/></td>
	<td><input name="p_quantity" type="text" class="text width7"/></td>
    <td><input name="p_baseprice" type="text" class="text width7" value="0" onclick="select(this)" onchange="feeInput(this);"/></td>
    <td><input name="p_baseprice_tax" type="text" class="text width7" value="0" onclick="select(this)" onchange="feeInput(this);"/></td>
	<td><input name="p_price" type="text" class="text width4" readonly/></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
</tbody></table>
</body>
</html>
