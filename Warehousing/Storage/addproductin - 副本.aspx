<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addproductin.aspx.cs" Inherits="Warehousing.Storage.addproductin" %>
<html><head><title>人员管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<script type='text/javascript' src='/js/autocomplete/jquery.autocomplete.js'></script>
<link rel="stylesheet" type="text/css" href="/js/autocomplete/jquery.autocomplete.css" />
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
        $("input[name='p_serial']").autocomplete("/Handler/getSkuByCode.ashx", {
            extraParams: { c: function () { return $("input[name='p_serial']").val() } },
            width: 320,
            minChars:8,
            max: 10,
            highlight: false,
            multiple: true,
            multipleSeparator: " ",
            scroll: true,
            scrollHeight: 300,
            formatItem: function (data, i, max) {//格式化列表中的条目 row:条目对象,i:当前条目数,max:总条目数
                data = "" + data;
                return data;
            },
            formatMatch: function (data, i, max) {//配合formatItem使用，作用在于，由于使用了formatItem，所以条目中的内容有所改变，而我们要匹配的是原始的数据，所以用formatMatch做一个调整，使之匹配原始数据
                data = "" + data;
                return data;
            },
            formatResult: function (data) {//定义最终返回的数据，比如我们还是要返回原始数据，而不是formatItem过的数据
                data = "" + data;
                return $.trim(data);
            }
        });

        $("input[name='p_spec']").autocomplete("/Handler/getSkuByCode.ashx", {
            extraParams: { c: function () { return $("input[name='p_spec']").parent().parent().find("input[name='p_serial']").val(); }, s: function () { return encodeURIComponent($("input[name='p_spec']").val()); } },
            width: 320,
            max: 10,
            highlight: false,
            multiple: true,
            multipleSeparator: " ",
            scroll: true,
            scrollHeight: 300,
            formatItem: function (data, i, max) {//格式化列表中的条目 row:条目对象,i:当前条目数,max:总条目数
                data = "" + data;
                return data;
            },
            formatMatch: function (data, i, max) {//配合formatItem使用，作用在于，由于使用了formatItem，所以条目中的内容有所改变，而我们要匹配的是原始的数据，所以用formatMatch做一个调整，使之匹配原始数据
                data = "" + data;
                return data;
            },
            formatResult: function (data) {//定义最终返回的数据，比如我们还是要返回原始数据，而不是formatItem过的数据
                data = "" + data;
                return $.trim(data.split("\t")[1]); ;
            }
        });


        $("input[name='p_model']").autocomplete("/Handler/getSkuByCode.ashx", {
            extraParams: { c: function () { return $("input[name='p_model']").parent().parent().find("input[name='p_serial']").val(); }, s: function () { return encodeURIComponent($("input[name='p_model']").parent().parent().find("input[name='p_spec']").val()); }, m: function () { return $("input[name='p_model']").val(); } },
            width: 320,
            max: 10,
            highlight: false,
            multiple: true,
            multipleSeparator: " ",
            scroll: true,
            scrollHeight: 300,
            formatItem: function (data, i, max) {//格式化列表中的条目 row:条目对象,i:当前条目数,max:总条目数
                data = "" + data;
                return data;
            },
            formatMatch: function (data, i, max) {//配合formatItem使用，作用在于，由于使用了formatItem，所以条目中的内容有所改变，而我们要匹配的是原始的数据，所以用formatMatch做一个调整，使之匹配原始数据
                data = "" + data;
                return data;
            },
            formatResult: function (data) {//定义最终返回的数据，比如我们还是要返回原始数据，而不是formatItem过的数据
                data = "" + data;
                return $.trim(data.split("\t")[2]);
            }
        });

        $("#add_one").click(function () {
            var onerow;
            var lastrow;
            onerow = $("#oneline").html();
            //lastrow=$("#mytable").find('tr:last-child').html();
            $("#mytable").find('tr:last-child').after(onerow);
            //alert(lastrow);
        });
        $("#copy_one").click(function () {
            var lastrow;
            lastrow = " <tr align=\"center\">" + $("#mytable").find('tr:last-child').html() + "</tr>";
            $("#mytable").find('tr:last-child').after(lastrow);
            $("#mytable").find('tr:last-child').find('span').css("display", "block");
        });

        /*
        var data = "the People's Republic of China".split(" ");
        $("input[name='p_serial']").autocomplete(data, { minChars: 0 }).result(function (event, data, formatted) {
            alert(data);
        });
        */


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
                sm_sn: {
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
                sm_type: {
                    required: '请选择入库类型'
                },
                sm_sn: {
                    required: '出入库单号不能为空'
                },
                sm_date: {
                    required: '收货日期不能为空'
                },
                sm_operator: {
                    required: '出入库员不能为空'
                }
            }
        });


    });

</script>
</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="800" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品管理</strong></b></td>
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
                  入库类型：</td>
              <td width="86%">
              

                  <asp:DropDownList ID="sm_type" runat="server">
                  <asp:ListItem Text="入库类型" Value=""></asp:ListItem>
                  <asp:ListItem Text="进货入库" Value="1"></asp:ListItem>
                  <asp:ListItem Text="其它入库" Value="2"></asp:ListItem>
                  </asp:DropDownList>
              

               </td>
          </tr>
          <tr>
              <td>
                  出入库单号：</td>
              <td>
              <asp:TextBox ID="sm_sn" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
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
                  出入库备注:：</td>
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
    <td colspan="10">商品清单</td>
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
	<td>零售价</td>
	<td>采购价</td>
	<td></td>
  </tr>
  <tr align="center">
    <td><input name="p_txm" type="text" class="text width6" /></td>
  	<td><input name="p_name" type="text" class="text width6" /></td>
    <td><input name="p_serial" type="text" class="text width3" /></td>
    <td><input name="p_brand" type="text" class="text width4" value="WQii" /></td>
    <td><input name="p_unit" type="text" class="text width4" value="件" /></td>
    <td><input name="p_spec" type="text" class="text width2" /></td>
    <td><input name="p_model" type="text" class="text width2" /></td>
	<td><input name="p_quantity" type="text" class="text width4" /></td>
	<td><input name="p_price" type="text" class="text width4" /></td>
	<td><input name="p_baseprice" type="text" class="text width4" /></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();" style="display:none"></span></td>
  </tr>
</table>

<a href="javascript:;" id="add_one" style="color:red;margin:4px;font-size:16px;display:block">添加新的商品</a>

<a href="javascript:;" id="copy_one" style="color:red;margin:4px;font-size:16px;display:block">复制上款商品</a>
                  </td>
          </tr>
          <%} %>
          <tr>
              <td class="style2">&nbsp;
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
<div id="oneline" style="display:none">
  <tr align="center">
     <td><input name="p_txm" type="text" class="text width6" /></td>
  	<td><input name="p_name" type="text" class="text width6" /></td>
    <td><input name="p_serial" type="text" class="text width3" /></td>
    <td><input name="p_brand" type="text" class="text width4" value="WQii" /></td>
    <td><input name="p_unit" type="text" class="text width4" value="件" /></td>
    <td><input name="p_spec" type="text" class="text width2" /></td>
    <td><input name="p_model" type="text" class="text width2" /></td>
	<td><input name="p_quantity" type="text" class="text width4" /></td>
	<td><input name="p_price" type="text" class="text width4" /></td>
	<td><input name="p_baseprice" type="text" class="text width4" /></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
</div>	
</body>
</html>
