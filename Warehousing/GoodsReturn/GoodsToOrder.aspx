<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsToOrder.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsToOrder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ʒ¼��</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script src="../js/js.js"></script>
    </head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>������������</strong></div>
<form id="myform" runat="server">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="0" style="margin-left:5px;">
  	  <tr>
        <td>��������</td>
        <td>
            <asp:TextBox ID="txtAgentId" runat="server" MaxLength="30"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtAgentId" Display="Dynamic" ErrorMessage="����������Ϊ��"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator1" runat="server" Display="Dynamic" 
                ErrorMessage="�����Ҫ��Ϊ��ֵ" MaximumValue="999999999" MinimumValue="0" 
                Type="Double" ControlToValidate="txtAgentId"></asp:RangeValidator>
              </td>
      </tr>
      
      <tr>
        <td>�ջ��ˣ� </td>
        <td>
            <asp:TextBox ID="txtReceiver" runat="server" MaxLength="50"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtReceiver" ErrorMessage="�ջ��˲���Ϊ��" Display="Dynamic"></asp:RequiredFieldValidator>
              </td>
      </tr>
      <tr>
        <td>�ͻ�����</td>
        <td>
                     ʡ<asp:TextBox ID="txtProvince" runat="server" Width="91px" MaxLength="30"></asp:TextBox>,
            ��<asp:TextBox ID="txtCity" runat="server" Width="91px" MaxLength="30"></asp:TextBox>,
            ����<asp:TextBox ID="txtTown" runat="server" Width="91px" MaxLength="30"></asp:TextBox></td>
      </tr>
      <tr>
        <td>�ͻ���ַ��</td>
        <td>

            <asp:TextBox ID="txtAddress" runat="server" Width="320px" MaxLength="100"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="txtAddress" Display="Dynamic" ErrorMessage="�ͻ���ַ����Ϊ��"></asp:RequiredFieldValidator>
              </td>
      </tr>
      <tr>
        <td>��ϵ�绰��</td>
        <td>
            <asp:TextBox ID="txtTel" runat="server" MaxLength="30"></asp:TextBox>
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
            <td width="38%" bgcolor="#F6F6F6">��Ʒ����</td>
            <td width="12%" bgcolor="#F6F6F6">��Ʒ����</td>
            <td width="15%" bgcolor="#F6F6F6">��Ʒ����</td>
            <td width="30%" bgcolor="#F6F6F6">����ԭ��</td>
            
            <td width="3%" bgcolor="#F6F6F6">&nbsp;</td>
          </tr>
            <asp:Repeater ID="OrderDetail" runat="server">
            <ItemTemplate>
            
          <tr>
            <td bgcolor="#FFFFFF"><a href="javascript:openWin('GoodsDetail.aspx?id=<%#Eval("ID")%>',600,400)"><%#Eval("ProductName")%></a><%#Warehousing.Business.GoodsReturnHelper.checkIsChange(Eval("ChangeFlag"))%></td>
            <td bgcolor="#FFFFFF"><%#Eval("ProductCount")%></td>
            <td bgcolor="#FFFFFF"><%#Eval("ProductTxm")%></td>
            <td bgcolor="#FFFFFF"><%#Eval("ReturnReson")%></td>
            <td bgcolor="#FFFFFF">&nbsp;</td>
            <td bgcolor="#FFFFFF">&nbsp;</td>
          </tr>
          </ItemTemplate>
            </asp:Repeater>
        </table>            </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>
            <asp:Button ID="Button1" runat="server" Text="ȷ���ύ" onclick="Button1_Click" />
        </td>
      </tr>
  </table>
  </p>
</form>
</body>
</html>