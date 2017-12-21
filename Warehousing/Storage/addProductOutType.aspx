<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addProductOutType.aspx.cs" Inherits="Warehousing.Storage.addProductOutType" %>

<html>
<head>
    <title>��Ʒ����</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link href="../css/global.css" rel="stylesheet" type="text/css" />
    <link href="../css/right.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
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
                    sm_type: {
                        required: true
                    }
                },
                messages: {
                    sm_type: {
                        required: '��ѡ���������'
                    }
                }
            });

        });
    </script>
    <style type="text/css">
        .style1
        {
            height: 36px;
        }
        .style2
        {
            height: 39px;
        }
        .style3
        {
            height: 86px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="div1">
        <table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC"
            class="tableBorder">
            <tr bgcolor="#FFFFFF">
                <td align="center">
                    <b><strong style="font-size: 18px;">��Ʒ����</strong></b>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#FFFFFF">
                    <table width="100%" cellpadding="4" class="style1">
                        <tr>
                            <td width="14%" class="style3" style="text-align:center">
                                ѡ��������ͣ�
                                <asp:DropDownList ID="sm_type" runat="server" AutoPostBack="False">
                                    <asp:ListItem Text="��������" Value=""></asp:ListItem>
                                    <asp:ListItem Text="������" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="�˻�����" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="ά�޷���" Value="7"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:center">
                                <asp:Button ID="Button1" runat="server" Text=" ��һ�� " OnClick="Button1_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td height="30" align="right">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    </form>
    
    </div>
</body>
</html>
