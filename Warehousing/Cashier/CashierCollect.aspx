<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CashierCollect.aspx.cs" Inherits="Warehousing.Cashier.CashierCollect" %>

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
            if (value=="") return true;
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
                TextRealMoney: {
                    required: true,
					number     : true,
					min : 0,
					max : <%=all_sales%>
                },
                DDPaymentName: {
                    required: true
                },
                TextLoginName: {
                    telphoneValid: true
                },
                TextLoginName2: {
                    equalTo: '#TextLoginName'
                }
            },
            messages: {
                TextRealMoney: {
                    required: 'ʵ�ս���Ϊ��',
					number     :'ʵ�ս��Ҫ��Ϊ��ֵ',
					min : 'ʵ�ս������',
					max : 'ʵ�ս��ܴ���<%=all_sales%>'
                },
                DDPaymentName: {
                    required: '��ѡ�񸶿ʽ'
                },
                TextLoginName: {
                    telphoneValid: '��Ա��ʶҪ��Ϊ�ֻ���'
                },
                TextLoginName2: {
                    equalTo: '�������벻һ��'
                }
            }
        });

        $("#TextLoginName").change(function () {
            var usercode = $("#TextLoginName").val();
            if (usercode == "") 
            {
            $("#user_info_area").html("");
            return;
            }
            $.get("/Handler/getUserInfo.ashx?d=" + new Date().getTime(), { usercode: usercode }, function (result) {
                if (result == "0") {
                   $("#user_info_area").html("��ǰ��Ա�����ڣ�����������ͬ���»�Ա��");
                }
                else
                {
                 var ss = result.split("\t");
                 $("#user_info_area").html("��Ա���ڣ��ֻ���"+ss[2]+"����ǰ���֣�"+ss[4]);
                }
            });
        });

    });
</script>
</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center" colspan=2><b><strong>����ȷ��</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">

          <tr>
              <td>
                  Ӧ�ս�</td>
              <td>
              <%=all_sales%>
              </td>
          </tr>
            <tr>
              <td>
                  ʵ�ս�</td>
              <td>
              <asp:TextBox ID="TextRealMoney" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
            <tr>
              <td>
                  �տע��</td>
              <td>
               <asp:TextBox ID="TextBox1" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  ����Ա</td>
              <td>
                  <asp:DropDownList ID="GuideList" runat="server">
                  <asp:ListItem Text="�޵���" Value="0"></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td>
                  ���ʽ</td>
              <td>
                  <asp:DropDownList ID="DDPaymentName" runat="server">
                  <asp:ListItem Text="��ѡ��" Value=""></asp:ListItem>
                  <asp:ListItem Text="�ֽ�" Value="�ֽ�"></asp:ListItem>
                  <asp:ListItem Text="���п�" Value="���п�"></asp:ListItem>
                  <asp:ListItem Text="֧����" Value="֧����"></asp:ListItem>
                  <asp:ListItem Text="΢֧��" Value="΢֧��"></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td width="14%">
                  ��Ա��ʶ��</td>
              <td width="86%">
                 <asp:TextBox ID="TextLoginName" runat="server" Width="238px"></asp:TextBox>(��ֻ֧���ֻ���)
               </td>
          </tr>
          <tr>
              <td width="14%">
                  �ٴ����룺</td>
              <td width="86%">
                 <asp:TextBox ID="TextLoginName2" runat="server" Width="238px"></asp:TextBox>(�ظ���������Ļ�Ա��ʶ)
               </td>
          </tr>
          <tr>
              <td>
                  ��Ա��Ϣ��</td>
              <td>
              <span id="user_info_area"></span>
              </td>
          </tr>
          <tr>
              <td width="14%">
                  ��Ա���룺</td>
              <td width="86%">
                 <asp:TextBox ID="TextLoginPwd" runat="server" Width="80px" TextMode="Password" MaxLength=6></asp:TextBox>(6λ����֧������)��ʱ���ԣ���
               </td>
          </tr>
          <tr>
              <td class="style2">&nbsp;
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" �� �� " onclick="Button1_Click" />

                                <input type="button" value=" �� �� " onclick="location.href='SellGoods.aspx?trace_id=<%=trace_id %>'" />
                            </td>
            </tr>
          </table>
	
</td>
<td valign=top>
          <table width=100% cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#EEEEEE"><td>��Ʒ����</td><td width=80>����</td><td width=60>����</td><td width=40>�۸�</td><td width=30>����</td><td>С��</td></tr>
          <asp:Repeater runat="server" ID="GoodsList">
           <ItemTemplate>
          <tr bgcolor="#FFFFFF"><td><%#Eval("goods_name")%></td><td><%#Eval("specification")%></td><td><%#Eval("txm")%></td><td><%#Eval("price")%></td><td><%#Eval("quantity")%></td>
          <td><%#Convert.ToDouble(Eval("price")) * Convert.ToInt32(Eval("quantity"))%>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
          </table>
</td>
  </tr>          
<tr bgcolor="#FFFFFF" > 
<td height="30"  align="right" colspan=2>&nbsp;</td>
</tr>
</table>
</div>
				

</form>
