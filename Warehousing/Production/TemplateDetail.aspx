<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TemplateDetail.aspx.cs" Inherits="Warehousing.Production.TemplateDetail" %>

<html>
<head>
    <title>ģ�����</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link href="../css/global.css" rel="stylesheet" type="text/css" />
    <link href="../css/right.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
    <script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
    <style type="text/css">
        .editor
        {
            margin: 0px 22px 0px 125px;
        }
        .width2, .width3, .width4, .width6
        {
            height: 30px;
            line-height: 30px;
            padding-left: 2px;
            border: solid 1px #CCC;
            border-bottom: solid 1px #666;
        }
        .width2
        {
            width: 60px;
            margin: 0px;
        }
        .width3
        {
            width: 80px;
            margin: 0px;
        }
        .width4
        {
            width: 40px;
            margin: 0px;
            text-align: center;
        }
        .width6
        {
            width: 120px;
            margin: 0px;
        }
        .add_link
        {
            color: red;
            margin: 4px;
            display: block;
        }
        .delete_btn
        {
            display: block;
            float: left;
            margin-left: 5px;
            width: 10px;
            height: 10px;
            overflow: hidden;
            cursor: pointer;
            background: url(/images/ico.gif) 0 -634px;
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
                    <b><strong style="font-size: 18px;">�ӹ�ģ��</strong></b>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#FFFFFF">
                    <table width="100%" cellpadding="4" class="style1">
                        <tr>
                            <td width="14%">
                                ƥ�乤����
                            </td>
                  <td width="86%">
                   <asp:DropDownList ID="factory_id" runat="server" Enabled=false>
                  </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ��Ʒ���ƣ�
                            </td>
                            <td>
                                <asp:TextBox ID="pro_name" runat="server" Width="238px" ReadOnly></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ��Ʒ���ţ�
                            </td>
                            <td>
                                <asp:TextBox ID="pro_code" runat="server" Width="238px" ReadOnly></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                �����ӹ����ã�
                            </td>
                            <td>
                                <asp:TextBox ID="do_cost" runat="server" Width="238px" ReadOnly></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                �����������ã�
                            </td>
                            <td>
                                <asp:TextBox ID="other_cost" runat="server" Width="238px" ReadOnly></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ģ�屸ע:��
                            </td>
                            <td>
                                <asp:TextBox ID="remark" runat="server" Width="238px" ReadOnly></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                ԭ���嵥
                                <table width="100%" border="1" id="mytable" border="1">
                                    <tr>
                                        <td colspan="11">
                                            ԭ���嵥
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            ����
                                        </td>
                                        <td>
                                            ����
                                        </td>
                                        <td>
                                            ���
                                        </td>
                                        <td>
                                            Ʒ��
                                        </td>
                                        <td>
                                            ��λ
                                        </td>
                                        <td>
                                            ���
                                        </td>
                                        <td>
                                            �ͺ�
                                        </td>
                                        <td>
                                            ����
                                        </td>
                                        <td>
                                            ���ۼ�
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <asp:Repeater ID="MemberList" runat="server">
                                        <ItemTemplate>
                                            <tr align="center">
                                                <td>
                                                    <input name="p_txm" type="text" class="text width6" value='<%#Eval("pro_txm")%>' onchange="txmInput(this);"
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_name" type="text" class="text width6" value='<%#Eval("pro_name")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_serial" type="text" class="text width3" value='<%#Eval("pro_code")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_brand" type="text" class="text width4" value='<%#Eval("pro_brand")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_unit" type="text" class="text width4" value='<%#Eval("pro_unit")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_spec" type="text" class="text width2" value='<%#Eval("pro_spec")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_model" type="text" class="text width2" value='<%#Eval("pro_model")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_quantity" type="text" class="text width4" value='<%#Eval("pro_nums")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <input name="p_price" type="text" class="text width2" value='<%#Eval("pro_inprice")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                 
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
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
