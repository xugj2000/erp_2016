<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addTemplate.aspx.cs" Inherits="Warehousing.Production.addTemplate" %>

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
    <script type="text/javascript">
        $(function () {
            $("#pro_code").change(function () {
                var kw = $("#pro_code").val();
                if (kw == "") return;
                $.get("/Handler/checkCode.ashx?d=" + new Date().getTime(), { q: kw }, function (result) {
                    if (result == "0") {
                        alert("��Ʒ���Ų����ڣ����ڲɹ�������������ö�Ӧ��Ʒ��");
                        $("#pro_code").val("");
                        $("#pro_code").focus();
                    }
                });
            });

            $("#gettxm").blur(function () {
                var kw = $("#gettxm").val();
                if (kw == "") return;
                var txm = $("#mytable input[name='p_txm']");
                var findflag = 0;
                var txmcount = 0;
                txm.each(function (index) {
                    if ($(this).val() == kw) {
                        quantityobj = $("#mytable input[name='p_quantity']").eq(index);
                        quantityobj.val(parseInt(quantityobj.val()) + 1);
                        findflag = 1;
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                        return false
                    };
                });
                if (findflag == 0) {
                    var onerow;
                    var lastrow;
                    if ($("#mytable input[name='p_txm']").eq(0).val() != "") {
                        onerow = $("#oneline").html();
                        //lastrow=$("#mytable").find('tr:last-child').html();
                        $("#mytable").find('tr:last-child').after(onerow);
                    }
                    $("#mytable").find('tr:last-child').find("input[name='p_quantity']").val("1");
                    $("#mytable").find('tr:last-child').find("input[name='p_txm']").val(kw);
                    txmInputNew($("#mytable").find('tr:last-child').find("input[name='p_txm']"));
                }
            });
            $("#add_one").click(function () {
                var onerow;
                var lastrow;
                onerow = $("#oneline").html();
                //lastrow=$("#mytable").find('tr:last-child').html();
                $("#mytable").find('tr:last-child').after(onerow);
                $("#mytable").find('tr:last-child').find("input[name='p_txm']").focus();
                //alert(lastrow);
            });

            $(".delete_btn").click(function () {
                var lastrow;
                $(this).parent().parent().remove();
            });

            $("#from_warehouse_id,#to_warehouse_id").change(function () {
                getRelateActive();
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
                    factory_id: {
                        required: true
                    },
                    pro_name: {
                        required: true
                    },
                    pro_code: {
                        required: true
                    },
                    do_cost: {
                        required: true,
                        number: true,
                        min: 0
                    },
                    other_cost: {
                        number: true,
                        min: 0
                    }
                },
                messages: {
                    factory_id: {
                        required: '��ѡ��ӹ���'
                    },
                    pro_name: {
                        required: '��Ʒ���Ʋ���Ϊ��'
                    },
                    pro_code: {
                        required: '��Ʒ���Ų���Ϊ��'
                    },
                    do_cost: {
                        required: '�ӹ����ò���Ϊ��',
                        number: '�ӹ�����ӦΪ����',
                        min: '�ӹ���������'
                    },
                    other_cost: {
                        number: '������������ӦΪ����',
                        min: '����������������'
                    }
                }
            });

            function checkquantity(thisobj) {
                var this_quantity = parseInt($(thisobj).val());
                if (this_quantity < 0) {
                    alert("��治��Ϊ��");
                    return;
                }
            }

            function txmInputNew(thisobj) {
                var kw = $(thisobj).val();
                if (kw == "") return;
                var warehouse_id = $("#from_warehouse_id").val();
                var url = "/Handler/getInfoByCode.ashx?d=" + new Date().getTime();
                //alert(url);
                $.get(url, { q: kw }, function (result) {
                    //alert(result);
                    var obj = $(thisobj).parent().parent();

                    if (result != "0") {

                        var ss = result.split(",");
                        obj.find("input[name='p_name']").val(ss[0]);
                        obj.find("input[name='p_serial']").val(ss[1]);
                        obj.find("input[name='p_spec']").val(ss[2]);
                        obj.find("input[name='p_model']").val(ss[3]);
                        obj.find("input[name='p_brand']").val(ss[4]);
                        obj.find("input[name='p_unit']").val(ss[5]);
                        obj.find("input[name='p_price']").val(ss[7]);
                        var last = $("#mytable").find('tr:last-child');
                        thisindex = $("#mytable").find('tr').index(obj);
                        lastindex = $("#mytable").find('tr').index(last);
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                    }
                    else {
                        alert(kw + "�˲�Ʒ�ݲ����ڿ��У�����~");
                        $(thisobj).parent().parent().remove();
                        $("#gettxm").val("");
                        $("#gettxm").focus();
                        // return;
                    }
                });
            }

        });



    </script>
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
                   <asp:DropDownList ID="factory_id" runat="server">
                  <asp:ListItem Text="��ѡ��ƥ�乤��" Value=""></asp:ListItem>
                  </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ��Ʒ���ƣ�
                            </td>
                            <td>
                                <asp:TextBox ID="pro_name" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ��Ʒ���ţ�
                            </td>
                            <td>
                                <asp:TextBox ID="pro_code" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                �����ӹ����ã�
                            </td>
                            <td>
                                <asp:TextBox ID="do_cost" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                �����������ã�
                            </td>
                            <td>
                                <asp:TextBox ID="other_cost" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ģ�屸ע:��
                            </td>
                            <td>
                                <asp:TextBox ID="remark" runat="server" Width="238px"></asp:TextBox>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                ɨ��¼��ԭ��:
                            </td>
                            <td>
                                <input type="text" name="gettxm" id="gettxm" style="width: 238px; height: 30px; line-height: 30px"
                                    maxlength="20" />
                                (<font color="red">���ڴ���������</font>)
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
                                                <input type=hidden name="p_id" value='<%#Eval("id")%>' />
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
                                                        onblur="checkquantity(this);" />
                                                </td>
                                                <td>
                                                    <input name="p_price" type="text" class="text width2" value='<%#Eval("pro_inprice")%>'
                                                        readonly />
                                                </td>
                                                <td>
                                                    <span class="delete_btn" onclick="$(this).parent().parent().remove();"></span>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <%if (id == 0)
                          { %>
                                    <tr align="center">
                                        <td><input type=hidden name="p_id" value='0' />
                                            <input name="p_txm" type="text" class="text width6" onchange="txmInput(this);" readonly />
                                        </td>
                                        <td>
                                            <input name="p_name" type="text" class="text width6" readonly />
                                        </td>
                                        <td>
                                            <input name="p_serial" type="text" class="text width3" readonly />
                                        </td>
                                        <td>
                                            <input name="p_brand" type="text" class="text width4" readonly />
                                        </td>
                                        <td>
                                            <input name="p_unit" type="text" class="text width4"  readonly />
                                        </td>
                                        <td>
                                            <input name="p_spec" type="text" class="text width2" readonly />
                                        </td>
                                        <td>
                                            <input name="p_model" type="text" class="text width2" readonly />
                                        </td>
                                        <td>
                                            <input name="p_quantity" type="text" class="text width4" maxlength="6" onblur="checkquantity(this);" />
                                        </td>
                                        <td>
                                            <input name="p_price" type="text" class="text width2" readonly />
                                        </td>
                                        <td>
                                            <span class="delete_btn" onclick="$(this).parent().parent().remove();"></span>
                                        </td>
                                    </tr>
                                    <%} %>
                                </table>
                                <a href="javascript:;" id="add_one" style="color: red; margin: 4px; font-size: 16px;
                                    display: none">����µ���Ʒ</a>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="style2">
                                &nbsp;
                                <asp:Button ID="Button2" runat="server" Text="" OnClientClick="return false;" Style="width: 1px;
                                    background: white; border: none" />
                            </td>
                            <td>
                            <input type=hidden value="<%=p_id_old%>" name="old_p_id" />
                                <asp:Button ID="Button1" runat="server" Text=" �� �� " OnClick="Button1_Click" />
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
    <table style="display: none">
        <tbody id="oneline">
            <tr align="center">
                <td><input type=hidden name="p_id" value='0' />
                    <input name="p_txm" type="text" class="text width6" onchange="txmInput(this);" readonly />
                </td>
                <td>
                    <input name="p_name" type="text" class="text width6" readonly />
                </td>
                <td>
                    <input name="p_serial" type="text" class="text width3" readonly />
                </td>
                <td>
                    <input name="p_brand" type="text" class="text width4"  readonly />
                </td>
                <td>
                    <input name="p_unit" type="text" class="text width4"  readonly />
                </td>
                <td>
                    <input name="p_spec" type="text" class="text width2" readonly />
                </td>
                <td>
                    <input name="p_model" type="text" class="text width2" readonly />
                </td>
                <td>
                    <input name="p_quantity" type="text" class="text width4" maxlength="6" value="1"
                        onblur="checkquantity(this);" />
                </td>
                <td>
                    <input name="p_price" type="text" class="text width2" readonly />
                </td>
                <td>
                    <span class="delete_btn" onclick="$(this).parent().parent().remove();"></span>
                </td>
            </tr>
        </tbody>
    </table>
    </div>
</body>
</html>
