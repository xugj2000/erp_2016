<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="productinone_other.aspx.cs" Inherits="Warehousing.Storage.productinone_other" %>

<html><head><title>商品入库记录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
.editor { margin:0px 22px 0px 125px; }
.width2,.width3,.width4,.width6{height:30px;line-height:30px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width2{width:60px;margin:0px;}
.width3{width:80px;margin:0px;}
.width4{width:40px;margin:0px;text-align:center;}
.width6{width:120px;margin:0px;}
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
            //alert(lastrow);
        });
        $("#copy_one").click(function () {
            var lastrow;
            lastrow = "  <tr bgcolor=\"#FFFFFF\" align=\"center\">" + $("#mytable").find('tr:last-child').html() + "</tr>";
            $("#mytable").find('tr:last-child').after(lastrow);
            $("#mytable").find('tr:last-child').find('span').css("display", "block");
            $("#mytable").find('tr:last-child').find("input[name=\"p_id\"]").val("0");
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
                sm_supplier: {
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
                sm_supplier: {
                    required: '供应商不能为空'
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
<td  align="center"><b><strong>商品入库记录</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC" id="mytable">
  <tr>
    <td colspan="10">商品清单</td>
  </tr>
  <tr align="center">
  	<td>名称</td>
    <td>款号</td>
    <td>品牌</td>
    <td>单位</td>
    <td>规格</td>
    <td>型号</td>
    <td>数量</td>
	<td>采购价</td>
	<td>零售价</td>
	<td></td>
  </tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
  <tr bgcolor="#FFFFFF" align="center">
  	<td><input type=hidden name="p_id" value='<%#Eval("p_id")%>' /> <input name="p_name" type="text" class="text width6" value='<%#Eval("p_name")%>' /></td>
    <td><input name="p_serial" type="text" class="text width3" value='<%#Eval("p_serial")%>' /></td>
    <td><input name="p_brand" type="text" class="text width3" value='<%#Eval("p_brand")%>' /></td>
    <td><input name="p_unit" type="text" class="text width2" value='<%#Eval("p_unit")%>' /></td>
    <td><input name="p_spec" type="text" class="text width2" value='<%#Eval("p_spec")%>' /></td>
    <td><input name="p_model" type="text" class="text width2" value='<%#Eval("p_model")%>' /></td>
    <td><input name="p_quantity" type="text" class="text width4" value='<%#Eval("p_quantity")%>' /></td>
	<td><input name="p_price" type="text" class="text width4" value='<%#Eval("p_price")%>' /></td>
	<td><input name="p_baseprice" type="text" class="text width4" value='<%#Eval("p_baseprice")%>' /></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
          </ItemTemplate>
          </asp:Repeater>
	</table>
<a href="javascript:;" id="add_one" style="color:red;margin:4px;display:block">添加新的商品</a>
<a href="javascript:;" id="copy_one" style="color:red;margin:4px;display:block">复制上款商品</a>
</td>
  </tr>          
<tr bgcolor="#FFFFFF" > 
<td height="30"  align="right">
<input type=hidden value="<%=p_id_old%>" name="old_p_id" />
<asp:Button ID="Button1" runat="server" Text=" 提 交 " onclick="Button1_Click" />
</td>
</tr>
</table>
</div>
				
<div id="oneline" style="display:none">
  <tr bgcolor="#FFFFFF" align="center">
  	<td><input name="p_name" type="text" class="text width6" /></td>
    <td><input name="p_serial" type="text" class="text width3" /></td>
    <td><input name="p_brand" type="text" class="text width3" /></td>
    <td><input name="p_unit" type="text" class="text width2" /></td>
    <td><input name="p_spec" type="text" class="text width2" /></td>
    <td><input name="p_model" type="text" class="text width2" /></td>
	<td><input name="p_quantity" type="text" class="text width4" /></td>
	<td><input name="p_price" type="text" class="text width4" /></td>
	<td><input name="p_baseprice" type="text" class="text width4" /></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
</div>	
</form>
</body>
</html>
