<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="Warehousing.User.AddUser" %>

<html><head><title>会员管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<script type="text/javascript">
    $(function () {
        jQuery.validator.addMethod("telphoneValid", function (value, element) {
            var tel = /^1[34578]{1}\d{9}$/;
            return tel.test(value) || this.optional(element);
        }, "请输入正确的手机号码");
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
                TextUser_name: {
                    required: true,
                    minlength: 4,
                    maxlength: 20
                },
                TextTrue_name: {
                    required: true
                },
                TextUser_Mobile: {
                    telphoneValid: true
                }
            },
            messages: {
                TextUser_name: {
                    required: '会员名称不能为空',
                    minlength: '会员名称最少4位字符',
                    maxlength: '会员名称最多20位字符'
                },
                TextTrue_name: {
                    required: '会员姓名不能为空',
                },
                TextUser_Mobile: {
                    telphoneValid: '请输入正确的手机号'
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
<td  align="center"><b><strong>会员管理</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  会员名：</td>
              <td width="86%">
              <asp:TextBox ID="TextUser_name" runat="server" Width="238px" MaxLength=30></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  会员密码：</td>
              <td width="86%">
              <asp:TextBox ID="TextUser_Pwd" runat="server" Width="238px" TextMode="Password"></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td>
                  会员姓名：</td>
              <td>
              <asp:TextBox ID="TextTrue_name" runat="server" Width="238px" MaxLength=30></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  会员手机：</td>
              <td>
              <asp:TextBox ID="TextUser_Mobile" runat="server" Width="238px" MaxLength=11></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  会员级别：</td>
              <td>
                               <asp:DropDownList ID="DDUser_Level" runat="server" AutoPostBack="false">
                  <asp:ListItem Text="请选择" Value=""></asp:ListItem>
                  <asp:ListItem Text="普通会员" Value="0"></asp:ListItem>
                  <asp:ListItem Text="一级批发商" Value="1"></asp:ListItem>
                  <asp:ListItem Text="二级批发商" Value="2"></asp:ListItem>
                  <asp:ListItem Text="加盟商" Value="9"></asp:ListItem>
                  </asp:DropDownList>
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
