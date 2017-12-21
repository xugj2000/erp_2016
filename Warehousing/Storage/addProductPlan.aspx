<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProductPlan.aspx.cs" Inherits="Warehousing.Storage.addProductPlan" %>
<html><head><title>��Ʒ�ɹ��ƻ�</title>
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
                    required: '��Ӧ�̲���Ϊ��'
                },
                sm_type: {
                    required: '��ѡ���������'
                },
                sm_tax: {
                    required: '˰�ʲ���Ϊ��',
                    number: '˰��Ҫ��Ϊ��ֵ',
                    min: '˰�ʲ���С��0',
                    max: '˰����߲��ܳ���0.2'
                },
                sm_date: {
                    required: '�ջ����ڲ���Ϊ��'
                },
                sm_operator: {
                    required: '�ɹ���Ա����Ϊ��'
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
                //alert(kw + "�˲�Ʒ�ݲ����ڿ��У�����~");
                // return;
            }
        });
    }


    //$("input[name='p_baseprice'],input[name='p_baseprice_tax']").change(function ()
     function feeInput(thisobj) {
        if ($("#sm_tax").val() == "") {
            alert("����ȷ��˰��");
            $(thisobj).val(0);
            $("#sm_tax").focus();
            return;
        }
        var sm_tax = 0;
        try {
            sm_tax = parseFloat($("#sm_tax").val());
        }
        catch (e) {
            alert("˰������");
            $("#sm_tax").focus();
            return;
        }
        if (sm_tax > 0.2) {
            alert("˰�ʲ��ܸ߹�0.2");
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
<td  align="center"><b><strong>��Ʒ�ɹ��ƻ�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  ��Ӧ�����ƣ�</td>
              <td width="86%">
                  <asp:DropDownList ID="sm_supplierid" runat="server">
                  <asp:ListItem Text="��ѡ��Ӧ��" Value=""></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td width="14%">
                  �ɹ����ͣ�</td>
              <td width="86%">
                  <asp:DropDownList ID="sm_type" runat="server">
                  <asp:ListItem Text="ѡ������" Value=""></asp:ListItem>
                  <asp:ListItem Text="��ͨ�ɹ�" Value="1"></asp:ListItem>
                  <asp:ListItem Text="�����ɹ�" Value="2"></asp:ListItem>
                  </asp:DropDownList>
               </td>
          </tr>
          <tr>
              <td>
                  ˰�ʣ�</td>
              <td>
              <asp:TextBox ID="sm_tax" runat="server" Width="238px" MaxLength="5"></asp:TextBox> ������0��1���С��
         </td>
          </tr>
          <%if (id > 0)
            {%>
          <tr>
              <td>
                   �ɹ��ƻ����ţ�</td>
              <td>
              <%=liushuihao %>  <input type=hidden value="<%=sm_tax_old %>" name="sm_tax_old" />
              </td>
          </tr>
          <%} %>
          <tr>
              <td>
                  �ƻ��������ڣ�</td>
              <td>
              <asp:TextBox ID="sm_date" runat="server" Width="238px" ReadOnly  onClick="return Calendar('sm_date','');"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  ����Ա������</td>
              <td>
              <asp:TextBox ID="sm_operator" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                 �ƻ���ע:��</td>
              <td>
              <asp:TextBox ID="sm_remark" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <%if (id == 0)
            { %>
                    <tr>
              <td colspan=2>
                  ��Ʒ�嵥
<table width="100%" border="1" id="mytable" border=1>
  <tr>
    <td colspan="12">��Ʒ�嵥</td>
  </tr>
  <tr align="center">
    <td>����</td>
  	<td>����</td>
    <td>���</td>
    <td>Ʒ��</td>
    <td>��λ</td>
    <td>���</td>
    <td>�ͺ�</td>
    <td>����</td>
    <td>��˰��</td>
    <td>��˰��</td>
	<td>���ۼ�</td>
	<td></td>
  </tr>
  <tr align="center">
    <td><input name="p_txm" type="text" class="text width6" onblur="txmInput(this);" /></td>
  	<td><input name="p_name" type="text" class="text width6" readonly/></td>
    <td><input name="p_serial" type="text" class="text width3" readonly/></td>
    <td><input name="p_brand" type="text" class="text width4" value="WQii" readonly/></td>
    <td><input name="p_unit" type="text" class="text width4" value="��" readonly/></td>
    <td><input name="p_spec" type="text" class="text width2" readonly/></td>
    <td><input name="p_model" type="text" class="text width2" readonly/></td>
	<td><input name="p_quantity" type="text" class="text width7"/></td>
    <td><input name="p_baseprice" type="text" class="text width7" value="0" onclick="select(this)" onchange="feeInput(this);"/></td>
    <td><input name="p_baseprice_tax" type="text" class="text width7" value="0" onclick="select(this)" onchange="feeInput(this);"/></td>
	<td><input name="p_price" type="text" class="text width4" readonly/></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();" style="display:none"></span></td>
  </tr>
</table>

<a href="javascript:;" id="add_one" style="color:red;margin:4px;font-size:16px;display:block">����µ���Ʒ</a>

<a href="javascript:;" id="copy_one" style="color:red;margin:4px;font-size:16px;display:none;">�����Ͽ���Ʒ</a>
                  </td>
          </tr>
          <%} %>
          <tr>
              <td class="style2">&nbsp;
<asp:Button ID="Button2" runat="server" Text="" OnClientClick="return false;" style="width:1px;background:white;border:none"/>
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" �� �� " onclick="Button1_Click" />

                                (ͬһ�����һ�����ţ�һ���ͺŶ�Ӧһ������)
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
    <td><input name="p_unit" type="text" class="text width4" value="��" readonly/></td>
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
