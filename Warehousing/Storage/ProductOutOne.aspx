<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductOutOne.aspx.cs" Inherits="Warehousing.Storage.ProductOutOne" %>
<html><head><title>商品出库记录</title>
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
            $("#mytable").find('tr:last-child').find("input[name='p_txm']").focus();
            //alert(lastrow);
        });

        $(".delete_btn").click(function () {
            var lastrow;
            $(this).parent().parent().remove();
        });
    });

    function checkquantity(thisobj) {
        var this_quantity = parseInt($(thisobj).val());
        if (this_quantity < 0) {
            alert("库存不能为负");
            return;
        }
        var obj = $(thisobj).parent().parent();
        var p_txm = obj.find("input[name='p_txm']").val();
        //alert(p_txm);
        var warehouse_id = <%=warehouse_id %>;
        $.get("/Handler/getSkuByCode.ashx?d=" + new Date().getTime(), { q: p_txm, wid: warehouse_id }, function (result) {
            if (result != "0") {
                var ss = result.split("\t");
                if (this_quantity > parseInt(ss[7])) {
                    alert("库存不足,最多" + ss[7]);
                    obj.find("input[name='p_quantity']").val(ss[7])
                }
            }
        }
            )
    }

    function txmInput(thisobj) {
        var kw = $(thisobj).val();
        if (kw == "") return;
        var warehouse_id = <%=warehouse_id %>;
        $.get("/Handler/getSkuByCode.ashx?d=" + new Date().getTime(), { q: kw, wid: warehouse_id }, function (result) {
            var obj = $(thisobj).parent().parent();
            if (result != "0") {
                var ss = result.split("\t");
                obj.find("input[name='p_name']").val(ss[0]);
                obj.find("input[name='p_serial']").val(ss[1]);
                obj.find("input[name='p_spec']").val(ss[2]);
                obj.find("input[name='p_model']").val(ss[3]);
                // obj.find("input[name='p_brand']").val(ss[4]);
                //obj.find("input[name='p_unit']").val(ss[5]);
                obj.find("input[name='p_price']").val(ss[6]);
                var last = $("#mytable").find('tr:last-child');
                thisindex = $("#mytable").find('tr').index(obj);
                lastindex = $("#mytable").find('tr').index(last);
                if (thisindex == lastindex) {
                    $("#add_one").click();
                }
                return;
            }
            else {
                alert("此产品暂不存在库中！请检查~");
                $(thisobj).focus();
            }
        });
    }
</script>

</head>
<body>
<form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品出库记录</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC" id="mytable">
  <tr>
    <td colspan="11">商品清单</td>
  </tr>
  <tr align="center">
    <td>条码</td>
  	<td>名称</td>
    <td>款号</td>
    <td>品牌</td>
    <td>单位</td>
    <td>颜色</td>
    <td>型号</td>
    <td>数量</td>
    <td>箱号</td>
	<td>零售价</td>
	<td></td>
  </tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
  <tr bgcolor="#FFFFFF" align="center">
    <td><input type=hidden name="p_id" value='<%#Eval("p_id")%>' /><input name="p_txm" type="text" class="text width6" value='<%#Eval("p_txm")%>' onblur="txmInput(this);" readonly/></td>
  	<td><input name="p_name" type="text" class="text width6" value='<%#Eval("p_name")%>' readonly/></td>
    <td><input name="p_serial" type="text" class="text width3" value='<%#Eval("p_serial")%>' readonly/></td>
    <td><input name="p_brand" type="text" class="text width4" value='<%#Eval("p_brand")%>' readonly/></td>
    <td><input name="p_unit" type="text" class="text width4" value='<%#Eval("p_unit")%>' readonly/></td>
    <td><input name="p_spec" type="text" class="text width2" value='<%#Eval("p_spec")%>' readonly/></td>
    <td><input name="p_model" type="text" class="text width2" value='<%#Eval("p_model")%>' readonly/></td>
    <td><input name="p_quantity" type="text" class="text width4" value='<%#Convert.ToDouble(Eval("p_quantity"))%>' maxlength="6"  onblur="checkquantity(this);"/></td>
    <td><input name="p_box" type="text" class="text width4" value='<%#Eval("p_box")%>' maxlength="6"/></td>
	<td><input name="p_price" type="text" class="text width2" value='<%#Eval("p_price")%>'/></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
          </ItemTemplate>
          </asp:Repeater>
	</table>
 <div style="text-align:left;">
<a href="javascript:;" id="add_one" style="color:red;margin:4px;display:block;width:150px;font-size:16px;">添加新的商品</a>
</div>
</td>
  </tr>          
<tr bgcolor="#FFFFFF" > 
<td height="30"  align="right">
<asp:Button ID="Button2" runat="server" Text="" OnClientClick="return false;" style="width:1px;background:white;border:none"/>
<input type=hidden value="<%=p_id_old%>" name="old_p_id" />
<asp:Button ID="Button1" runat="server" Text=" 提 交 " onclick="Button1_Click" />
</td>
</tr>
</table>
</div>
				

</form>
<table style="display:none">
<tbody id="oneline">
  <tr bgcolor="#FFFFFF" align="center">
    <td><input type=hidden name="p_id" value='0' /><input name="p_txm" type="text" class="text width6" onblur="txmInput(this);"/></td>
  	<td><input name="p_name" type="text" class="text width6" readonly/></td>
    <td><input name="p_serial" type="text" class="text width3" readonly /></td>
    <td><input name="p_brand" type="text" class="text width4" value="WQii" readonly /></td>
    <td><input name="p_unit" type="text" class="text width4" value="件" readonly /></td>
    <td><input name="p_spec" type="text" class="text width2" readonly /></td>
    <td><input name="p_model" type="text" class="text width2" readonly /></td>
	<td><input name="p_quantity" type="text" class="text width4"  maxlength="6" onblur="checkquantity(this);"/></td>
	<td><input name="p_box" type="text" class="text width4"  maxlength="6"/></td>
	<td><input name="p_price" type="text" class="text width2"/></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
</tbody></table>

</body>
</html>
