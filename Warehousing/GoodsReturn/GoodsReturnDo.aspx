<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsReturnDo.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsReturnDo" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ʒ¼��</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
    <style type="text/css">
        .style1
        {
            height: 16px;
        }
    </style>
</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>������Ʒ¼��</strong></div>
<script>
function checkForm()
{
if (myform.doStatus.value=="")
{
//alert("��ѡ����ʽ!");
//return false;
}
return confirm('ȷ����Ĵ�����?');
}
</script>
<form id="myform" runat="server" onsubmit="return checkForm();">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="0" style="margin-left:5px;">
  	  <tr>
        <td width="97" class="style1">����������</td>
        <td width="663" class="style1"><%=DingDan%></td>
      </tr>
      <tr>
        <td>��������</td>
        <td><%=AgentId%></td>
      </tr>
      <tr>
        <td>��Ʒ���ƣ�</td>
        <td><%=ProductName%></td>
      </tr>
      <tr>
        <td>��Ʒ���룺</td>
        <td><%=ProductTxm%>
        </td>
      </tr>
      
      <tr>
        <td>���������� </td>
        <td><%=ProductCount%>
        </td>
      </tr>
      <tr>
        <td>����ʱ�䣺</td>
        <td><%=ReturnTime%>
        </td>
      </tr>
      <tr>
        <td>����ԭ��</td>
        <td><%=ReturnReson%>
        </td>
      </tr>
      <tr>
        <td>�����ˣ�</td>
        <td><%=ReceivedOpter%>
        </td>
      </tr>
      <tr>
        <td>¼���ˣ�</td>
        <td><%=Operator%>
        </td>
      </tr>
      <tr>
        <td>��ǰ״̬��</td>
        <td><%=Warehousing.Business.GoodsReturnHelper.getStutusText(Status)%>
        </td>
      </tr>
      <tr>
      <td>������</td>
      <td>
      <asp:Repeater ID="GoodsList" runat="server">
      <HeaderTemplate>
      <table width="432" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">

	      <tr>
      <td bgcolor="#FFFFFF">&nbsp;</td>
      <td bgcolor="#FFFFFF">��Ʒ����</td>
      <td bgcolor="#FFFFFF" align="center">����</td>
      <td align="center" bgcolor="#FFFFFF">����</td>
    </tr>
      </HeaderTemplate>
     <ItemTemplate>
    <tr>
      <td width="6%" bgcolor="#FFFFFF"><%#Container.ItemIndex+1%></td>
      <td width="42%" bgcolor="#FFFFFF"><%#Eval("ProductName")%></td>
      <td  align="center" bgcolor="#FFFFFF"><%#Eval("ProductCount")%></td>
      <td  align="center"bgcolor="#FFFFFF"><%#Eval("ProductTxm")%></td>
      </tr>
        </ItemTemplate>
     <FooterTemplate>
     </table>
     </FooterTemplate>
     </asp:Repeater>
      </td>
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
            <asp:Button ID="Button1" runat="server" Text="ȷ���ύ" onclick="Button1_Click" />
        &nbsp;<input id="Button2" type="button" value=" �� �� " onclick="history.back();" /></td>
      </tr>
  </table>
</form>
</body>
</html>