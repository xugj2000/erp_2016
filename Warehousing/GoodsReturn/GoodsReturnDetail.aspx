<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsReturnDetail.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsReturnDetail" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ʒ¼��</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script src="../js/js.js"></script>
    </head>
    <script>
function checkForm()
{
if (myform.doStatus.value=="")
{
alert("��ѡ����ʽ!");
return false;
}
}
</script>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>������������</strong></div>
<form id="myform" runat="server">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="0" style="margin-left:5px;">
  	  <tr>
        <td>���������ţ�</td>
        <td><%= OrderId %></td>
      </tr>
      
  	  <tr>
        <td>��������</td>
        <td>
            <asp:Label ID="txtAgentId" runat="server" Text=""></asp:Label>
              </td>
      </tr>
      
      <tr>
        <td>�ջ��ˣ� </td>
        <td>
            <asp:TextBox ID="txtReceiver" runat="server"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtReceiver" ErrorMessage="�ջ��˲���Ϊ��" Display="Dynamic"></asp:RequiredFieldValidator>
              </td>
      </tr>
      <tr>
        <td>�ͻ�����</td>
        <td>
                     ʡ<asp:TextBox ID="txtProvince" runat="server" Width="91px"></asp:TextBox>,
            ��<asp:TextBox ID="txtCity" runat="server" Width="91px"></asp:TextBox>,
            ����<asp:TextBox ID="txtTown" runat="server" Width="91px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>�ͻ���ַ��</td>
        <td>

            <asp:TextBox ID="txtAddress" runat="server" Width="320px"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="txtAddress" Display="Dynamic" ErrorMessage="�ͻ���ַ����Ϊ��"></asp:RequiredFieldValidator>
              </td>
      </tr>
      <tr>
        <td>��ϵ�绰��</td>
        <td>
            <asp:TextBox ID="txtTel" runat="server"></asp:TextBox>
              </td>
      </tr>
      <tr>
        <td>������ע��</td>
        <td>
           <asp:TextBox ID="txtRemark" runat="server" Height="71px" TextMode="MultiLine" 
                Width="322px"></asp:TextBox>
              </td>
      </tr>
      <tr>
        <td>��Ʒ���飺</td>
        <td><table width="98%" border="0" cellpadding="3" cellspacing="1" bgcolor="#F6F6F6">
          <tr>
            <td width="34%" bgcolor="#F6F6F6">��Ʒ����</td>
            <td width="15%" bgcolor="#F6F6F6">��Ʒ����</td>
            <td width="11%" bgcolor="#F6F6F6">��Ʒ����</td>
            <td width="40%" bgcolor="#F6F6F6">����ԭ��</td>
          </tr>
            <asp:Repeater ID="OrderDetail" runat="server">
            <ItemTemplate>
            
          <tr>
            <td bgcolor="#FFFFFF"><a href="javascript:openWin('GoodsDetail.aspx?id=<%#Eval("ID")%>',600,400)"><%#Eval("ProductName")%></a><%#Warehousing.Business.GoodsReturnHelper.checkIsChange(Eval("ChangeFlag"))%></td>
            <td bgcolor="#FFFFFF"><%#Eval("ProductTxm")%></td>
            <td bgcolor="#FFFFFF"><%#Eval("ProductCount")%></td>
            <td bgcolor="#FFFFFF"><%#Eval("ReturnReson")%></td>
            </tr>
          </ItemTemplate>
            </asp:Repeater>
        </table>            </td>
      </tr>
            <tr>
        <td>����״̬��</td>
        <td><%=Warehousing.Business.GoodsReturnHelper.getOrderStutusText(Status)%></td>
      </tr>
            <tr>
        <td>����</td>
        <td><input type="hidden" value="<%=Status%>" name="oldStatus"/>
            <asp:DropDownList ID="doStatus" runat="server">
            <asp:ListItem Value="">��ѡ��</asp:ListItem>
            </asp:DropDownList>
        <font color=red>*</font>
        </td>
      </tr>
             <tr>
        <td>����ע</td>
        <td><textarea name="doRemark" cols="50" rows="4" style="height:60px;width:400px;"></textarea>
        </td>
      </tr>
            <tr>
        <td>�������</td>
        <td>
            <asp:Repeater ID="rpRemarkList" runat="server">
            <ItemTemplate>
            <%#Eval("addtime")%>,<%#Eval("operator")%>,<%#Eval("dowhat")%><br />
            </ItemTemplate>
            </asp:Repeater>
              </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>
            <asp:Button ID="Button1" runat="server" Text="ȷ���ύ" onclick="Button1_Click" OnClientClick="return checkForm();" />
        </td>
      </tr>
  </table>
  </p>
</form>
</body>
</html>
