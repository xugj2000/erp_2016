<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsChange.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsChange" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ʒ����</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
        <style type="text/css">
            .style1
            {
                width: 17%;
            }
            .style2
            {
                width: 7%;
            }
            .style3
            {
                width: 53px;
            }
            .style4
            {
                width: 121px;
            }
            .style5
            {
                width: 146px;
            }
        </style>
</head>
<script>
function checkform()
{
if (myform.txtChangePname.value=="")
{
alert("��Ʒ���Ʋ���Ϊ��");
myform.txtChangePname.focus();
return false;
}

if (myform.txtChangeNum.value=="")
{
alert("��Ʒ��������Ϊ��");
myform.txtChangeNum.focus();
return false;
}
if (isNaN(myform.txtChangeNum.value))
{
alert("��Ʒ����Ҫ��Ϊ��ֵ");
return false;
}
}

</script>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>������Ʒ�б�</strong></div>
    <form id="myform" runat="server">
  <p>
  
  <table width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#EEEEEE">
    <tr><td bgcolor="#F6F6F6">&nbsp;</td>
      <td bgcolor="#F6F6F6" class="style1">��Ʒ��</td>
      <td width="7%" bgcolor="#F6F6F6" class="style2">����</td>
      <td width="26%" bgcolor="#F6F6F6">������</td>
      <td width="19%" bgcolor="#F6F6F6">&nbsp;</td>
    </tr>
      <asp:Repeater ID="GoodsList" runat="server" onitemcommand="GoodsList_ItemCommand">
     <ItemTemplate>
    <tr>
      <td width="6%"><%#Container.ItemIndex+1%></td>
      <td width="42%"><%#Eval("ProductName")%></td>
      <td align="center"><%#Eval("ProductCount")%></td>
      <td><%#Eval("ProductTxm")%></td>
      <td>
          <asp:Button ID="Button1" runat="server" Text="�޸�" CommandName="change" CommandArgument='<%#Eval("ID")%>'/>
          <asp:Button ID="Button2" runat="server" Text="ɾ��" CommandName="del" CommandArgument='<%#Eval("ID")%>' OnClientClick="return confirm('ȷ��ɾ����');"/> 
          </td>
      </tr>
        </ItemTemplate>
     </asp:Repeater>
  </table>
  <br />
  <table width="780" border="0" align="center" cellpadding="0">
    <tr>
      <td height="26" colspan="7">������Ʒ�༭</td>
    </tr>
    <tr>
      <td height="26" class="style3">����Ʒ</td>
      <td class="style4">
          <asp:TextBox ID="txtChangePname" runat="server"></asp:TextBox>                </td>
      <td>����</td>
      <td class="style5">
          <asp:TextBox ID="txtChangeTxt" runat="server"></asp:TextBox>                </td>
      <td>����</td>
      <td>
          <asp:TextBox ID="txtChangeNum" runat="server" MaxLength="5"></asp:TextBox>
                  <asp:HiddenField ID="txtChangePid" runat="server" />
                  </td>
      <td>
          <asp:Button ID="Button3" runat="server" Text="�ύ" onclick="Button3_Click" OnClientClick="return checkform();"/>
                  </td>
    </tr>
  </table>
  </p>
</form>
</body>
</html>