<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addproductinother.aspx.cs" Inherits="Warehousing.Storage.addproductinother" %>

<html><head><title>��Ա����</title>
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
            lastrow = " <tr align=\"center\">" + $("#mytable").find('tr:last-child').html() + "</tr>";
            $("#mytable").find('tr:last-child').after(lastrow);
            $("#mytable").find('tr:last-child').find('span').css("display", "block");
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
                sm_supplier: {
                    required: '��Ӧ�̲���Ϊ��'
                },
                sm_type: {
                    required: '��ѡ���������'
                },
                sm_sn: {
                    required: '����ⵥ�Ų���Ϊ��'
                },
                sm_date: {
                    required: '�ջ����ڲ���Ϊ��'
                },
                sm_operator: {
                    required: '�����Ա����Ϊ��'
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
<td  align="center"><b><strong>��Ʒ����</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  ��Ӧ�����ƣ�</td>
              <td width="86%">
              <asp:TextBox ID="sm_supplier" runat="server" Width="238px"></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  ������ͣ�</td>
              <td width="86%">
              

                  <asp:DropDownList ID="sm_type" runat="server">
                  <asp:ListItem Text="�������" Value=""></asp:ListItem>
                  <asp:ListItem Text="�������" Value="1"></asp:ListItem>
                  <asp:ListItem Text="�������" Value="2"></asp:ListItem>
                  </asp:DropDownList>
              

               </td>
          </tr>
          <tr>
              <td>
                  ����ⵥ�ţ�</td>
              <td>
              <asp:TextBox ID="sm_sn" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  �������ڣ�</td>
              <td>
              <asp:TextBox ID="sm_date" runat="server" Width="238px" ReadOnly  onClick="return Calendar('sm_date','');"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  �ջ�Ա������</td>
              <td>
              <asp:TextBox ID="sm_operator" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  ����ⱸע:��</td>
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
    <td colspan="10">��Ʒ�嵥</td>
  </tr>
  <tr align="center">
  	<td>����</td>
    <td>���</td>
    <td>Ʒ��</td>
    <td>��λ</td>
    <td>���</td>
    <td>�ͺ�</td>
    <td>����</td>
	<td>�ɹ���</td>
	<td>���ۼ�</td>
	<td></td>
  </tr>
  <tr align="center">
  	<td><input name="p_name" type="text" class="text width6" /></td>
    <td><input name="p_serial" type="text" class="text width3" /></td>
    <td><input name="p_brand" type="text" class="text width3" /></td>
    <td><input name="p_unit" type="text" class="text width2" /></td>
    <td><input name="p_spec" type="text" class="text width2" /></td>
    <td><input name="p_model" type="text" class="text width2" /></td>
	<td><input name="p_quantity" type="text" class="text width4" /></td>
	<td><input name="p_price" type="text" class="text width4" /></td>
	<td><input name="p_baseprice" type="text" class="text width4" /></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();" style="display:none"></span></td>
  </tr>
</table>

<a href="javascript:;" id="add_one" style="color:red;margin:4px;font-size:16px;display:block">����µ���Ʒ</a>

<a href="javascript:;" id="copy_one" style="color:red;margin:4px;font-size:16px;display:block">�����Ͽ���Ʒ</a>
                  </td>
          </tr>
          <%} %>
          <tr>
              <td class="style2">&nbsp;
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" �� �� " onclick="Button1_Click" />
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
</body>
</html>
