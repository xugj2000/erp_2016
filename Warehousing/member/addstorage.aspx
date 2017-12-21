<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addstorage.aspx.cs" Inherits="Warehousing.member.addstorage" %>

<html><head><title>人员管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
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
                Textwarehouse_name: {
                    required: true,
                    minlength: 2,
                    maxlength: 20,
                }
            },
            messages: {
                Textwarehouse_name: {
                    required: '名称不能为空',
                    minlength: '名称最少2位字符',
                    maxlength: '名称最多20位字符'
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
<td  align="center"><b><strong>仓库管理</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  仓库名称：</td>
              <td width="86%">
              <asp:TextBox ID="Textwarehouse_name" runat="server" Width="238px" MaxLength=50></asp:TextBox>
              
               </td>
          </tr>
          <%if (my_warehouse_id == 0) {%>
                    <tr>
              <td width="14%">
                  支持采购：</td>
              <td width="86%">
                  是<input type="radio" name="IsCaigou" value="1"<%if (IsCaigou==1){Response.Write(" checked");} %>/> &nbsp;&nbsp;否<input type="radio" name="IsCaigou" value="0"<%if (IsCaigou!=1){Response.Write(" checked");} %>/></td>
          </tr>
          <tr>
              <td width="14%">
                  是否主仓：</td>
              <td width="86%">
                  是<input type="radio" name="IsManage" value="1"<%if (IsManage==1){Response.Write(" checked");} %>/> &nbsp;&nbsp;否<input type="radio" name="IsManage" value="0"<%if (IsManage!=1){Response.Write(" checked");} %>/></td>
          </tr>
          <%} %>
          <tr>
              <td>
                  加盟区域：</td>
              <td>
         <asp:DropDownList ID="DDAgent_id" runat="server">
          <asp:ListItem Value="">选择加盟点</asp:ListItem>
        </asp:DropDownList> 
        <asp:Label
                  ID="LabelAgent" runat="server" Text=""></asp:Label>
         
              </td>
          </tr>
          <tr>
              <td>
                  仓库地址：</td>
              <td>
              <asp:TextBox ID="Textwarehouse_address" runat="server" Width="238px" MaxLength=100></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  联系电话：</td>
              <td>
              <asp:TextBox ID="Textwarehouse_tel" runat="server" Width="238px" MaxLength=100></asp:TextBox>
              </td>
          </tr>
                    <tr>
              <td width="14%">
                  是否锁定：</td>
              <td width="86%">
                  是<input type="radio" name="IsLock" value="1"<%if (IsLock=="1"){Response.Write(" checked");} %>/> &nbsp;&nbsp;否<input type="radio" name="IsLock" value="0"<%if (IsLock!="1"){Response.Write(" checked");} %>/></td>
          </tr>
          <tr>
              <td class="style2">&nbsp;
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" 提 交 " onclick="Button1_Click" />
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
				

</body>
</html>
