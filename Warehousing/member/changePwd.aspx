<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="changePwd.aspx.cs" Inherits="Warehousing.member.changePwd" %>
<html><head><title>��Ա����</title>
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
        }, "��������ȷ���ֻ�����");
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
                 TextOldPwd: {
                    required: true
                },
                TextNewPwd: {
                    required: true,
                    minlength: 6,
                    maxlength: 16
                },
                TextNewPwd2: {
                    equalTo: '#TextNewPwd'
                }
            },
            messages: {
                TextOldPwd: {
                    required: '�����벻��Ϊ��'
                },
                TextNewPwd: {
                    required: '�����벻��Ϊ��',
                    minlength: '����������6λ�ַ�',
                    maxlength: '���������16λ�ַ�'
                },
                TextNewPwd2: {
                    equalTo: 'ȷ�����벻һ��'
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
<td  align="center"><b><strong>�޸�����</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td>
                  ԭ��½���룺</td>
              <td>
              <asp:TextBox ID="TextOldPwd" runat="server" Width="238px" TextMode="Password" 
                      MaxLength="16"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  �µ�½���룺</td>
              <td>
              <asp:TextBox ID="TextNewPwd" runat="server" Width="238px" TextMode="Password" 
                      MaxLength="16"></asp:TextBox>
              </td>
          <tr>
              <td>
                  ȷ�������룺</td>
              <td>
              <asp:TextBox ID="TextNewPwd2" runat="server" Width="238px" TextMode="Password" 
                      MaxLength="16"></asp:TextBox>
              </td>
          </tr>
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
				

</body>
</html>