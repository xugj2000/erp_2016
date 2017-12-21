<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="Warehousing.User.AddUser" %>

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
                    required: '��Ա���Ʋ���Ϊ��',
                    minlength: '��Ա��������4λ�ַ�',
                    maxlength: '��Ա�������20λ�ַ�'
                },
                TextTrue_name: {
                    required: '��Ա��������Ϊ��',
                },
                TextUser_Mobile: {
                    telphoneValid: '��������ȷ���ֻ���'
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
<td  align="center"><b><strong>��Ա����</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  ��Ա����</td>
              <td width="86%">
              <asp:TextBox ID="TextUser_name" runat="server" Width="238px" MaxLength=30></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  ��Ա���룺</td>
              <td width="86%">
              <asp:TextBox ID="TextUser_Pwd" runat="server" Width="238px" TextMode="Password"></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td>
                  ��Ա������</td>
              <td>
              <asp:TextBox ID="TextTrue_name" runat="server" Width="238px" MaxLength=30></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  ��Ա�ֻ���</td>
              <td>
              <asp:TextBox ID="TextUser_Mobile" runat="server" Width="238px" MaxLength=11></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  ��Ա����</td>
              <td>
                               <asp:DropDownList ID="DDUser_Level" runat="server" AutoPostBack="false">
                  <asp:ListItem Text="��ѡ��" Value=""></asp:ListItem>
                  <asp:ListItem Text="��ͨ��Ա" Value="0"></asp:ListItem>
                  <asp:ListItem Text="һ��������" Value="1"></asp:ListItem>
                  <asp:ListItem Text="����������" Value="2"></asp:ListItem>
                  <asp:ListItem Text="������" Value="9"></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
         
                    <tr>
              <td width="14%">
                  �Ƿ�������</td>
              <td width="86%">
                  ��<input type="radio" name="IsLock" value="1"<%if (IsLock=="1"){Response.Write(" checked");} %>/> &nbsp;&nbsp;��<input type="radio" name="IsLock" value="0"<%if (IsLock!="1"){Response.Write(" checked");} %>/></td>
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
