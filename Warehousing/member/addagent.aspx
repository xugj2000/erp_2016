<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addagent.aspx.cs" Inherits="Warehousing.member.addagent" %>

<html><head><title>加盟管理</title>
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
                TextAgent_name: {
                    required: true,
                    minlength: 2,
                    maxlength: 20,
                }
            },
            messages: {
                TextAgent_name: {
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
<td  align="center"><b><strong>加盟管理</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  加盟名称：</td>
              <td width="86%">
              <asp:TextBox ID="TextAgent_name" runat="server" Width="238px" MaxLength=50></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td>
                  加盟备注：</td>
              <td>
              <asp:TextBox ID="TextAgent_remark" runat="server" Width="238px" MaxLength=100></asp:TextBox>
              </td>
          </tr>
         
                    <tr>
              <td width="14%">
                  是否锁定：</td>
              <td width="86%">
                  是<input type="radio" name="IsLock" value="1"<%if (IsLock=="1"){Response.Write(" checked");} %>/> &nbsp;&nbsp;否<input type="radio" name="IsLock" value="0"<%if (IsLock!="1"){Response.Write(" checked");} %>/></td>
          </tr>
                    <tr>
              <td width="14%" color=red>
              温馨提示 ：
                  </td>
              <td width="86%" style="color:red">
                 此处加盟为参与分仓共享ERP性质，如果普通加盟拿货，请直接加会员后走加盟供货渠道！</td>
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
