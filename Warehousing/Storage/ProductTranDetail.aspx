<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductTranDetail.aspx.cs" Inherits="Warehousing.Storage.ProductTranDetail" %>
<html><head><title>�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
.width2,.width3,.width4,.width6{height:30px;line-height:30px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width2{width:60px;margin:0px;}
.width3{width:80px;margin:0px;}
.width4{width:40px;margin:0px;text-align:center;}
.width6{width:120px;margin:0px;}
.add_link{color:red;margin:4px;display:block}
</style>
<script type="text/javascript">
    $(function () {
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
                Text_sm_date: {
                    required: true
                },
                Text_sm_operator: {
                    required: true
                },
                sm_status: {
                    range: [1, 2]
                }
            },
            messages: {
                Text_sm_date: {
                    required: '�ջ����ڲ���Ϊ��'
                },
                Text_sm_operator: {
                    required: '�ɹ���Ա����Ϊ��'
                },
                sm_status: {
                    range: '��ѡ�������'
                }
            }
        });

    });

</script>
</head>
<body>
<form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ʒ����</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  �������ͣ�</td>
              <td width="86%">
              <%=Warehousing.Business.StorageHelper.getTypeText(sm_type)%>
               </td>
          </tr>
          <tr>
              <td>
                  �����ֿ⣺</td>
              <td>
              
              <%=Warehousing.Business.StorageHelper.getWarehouseName(warehouse_id_from)%>

               <%if (warehouse_id_to > 0) {Response.Write("<font color=red>������:</font>"+Warehousing.Business.StorageHelper.getWarehouseName(warehouse_id_to)); }%>

              </td>
          </tr>
          <tr>
              <td>
                  ���ⵥ�ţ�</td>
              <td>
              <%=sm_sn%>
              </td>
          </tr>
          <tr>
              <td>
                  �������ڣ�</td>
              <td>
              <%=sm_date %>
              </td>
          </tr>
          <tr>
              <td>
                  ����ʱ�䣺</td>
              <td>
              <%=sm_date %>
              </td>
          </tr>
          <tr>
              <td>
                  �ջ�Ա������</td>
              <td>
              <%=sm_operator %>
              </td>
          </tr>
          <tr>
              <td>
                  ����ⱸע:��</td>
              <td>
              <%=sm_remark%>
              </td>
          </tr>
                    <tr>
              <td colspan=2>
<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC" id="mytable">
  <tr bgcolor="#FFFFFF" align="center">
    <td colspan="11">��Ʒ�嵥</td>
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
    <td>���</td>
	<td>���ۼ�</td>
  </tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
  <tr bgcolor="#FFFFFF" align="center">
    <td><input type=hidden name="p_id" value='<%#Eval("p_id")%>' /><%#Eval("p_txm")%></td>
  	<td><%#Eval("p_name")%></td>
    <td><%#Eval("p_serial")%></td>
    <td><%#Eval("p_brand")%></td>
    <td><%#Eval("p_unit")%></td>
    <td><%#Eval("p_spec")%></td>
    <td><%#Eval("p_model")%></td>
	<td><%#Eval("p_quantity")%></td>
    <td><%#Eval("p_box")%></td>
	<td><%#Eval("p_price")%></td>
  </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="11" align=center>
			</td>
		  </tr>
	</table>
                  </td>
          </tr>
          <tr>
              <td>
                  �������ڣ�</td>
              <td>
              <asp:TextBox ID="Text_sm_date" runat="server" Width="238px" ReadOnly  onClick="return Calendar('Text_sm_date','');"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  �ջ�Ա������</td>
              <td>
              <asp:TextBox ID="Text_sm_operator" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  ��ⱸע:��</td>
              <td>
              <asp:TextBox ID="Text_sm_remark" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
<tr bgcolor="#FFFFFF"<%if (current_sm_status==1){Response.Write("style='display:none;'");} %>> 
<td height="30"  align="left" colspan=2>

                  <asp:DropDownList ID="sm_status" runat="server">
                  <asp:ListItem Text="�ȴ����" Value="3"></asp:ListItem>
                  <asp:ListItem Text="�������ͨ��" Value="1"></asp:ListItem>
                  <asp:ListItem Text="�������ܾ�" Value="2"></asp:ListItem>
                  </asp:DropDownList>
<asp:Button ID="Button1" runat="server" Text=" �� �� " onclick="Button1_Click" />
</td>
</tr>
          </table>
	
</td>
  </tr>          
</table>
</div>
</form>
</body>
</html>
