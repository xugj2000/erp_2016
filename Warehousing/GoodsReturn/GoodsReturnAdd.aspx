<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsReturnAdd.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsReturnAdd" EnableViewState="false" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ʒ����</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>������Ʒ¼��</strong></div>
<form id="myform" runat="server">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="5" style="margin-left:5px;">
      
      <tr>

        <td>����ID��</td>
        <td><asp:TextBox ID="txtAgentId" runat="server" Width="96px"></asp:TextBox></td>
		        <td>���������ţ� </td>
        <td>
            <asp:TextBox ID="txtOrderId" runat="server" Width="127px"></asp:TextBox>        </td>
        <td><asp:Button ID="Button1" runat="server" Text="��������" OnClick="Button1_Click" /></td>
        <td>
            <asp:Button ID="Button2" runat="server" Text="ֱ��¼��" onclick="Button2_Click" />
              </td>
      </tr>
  </table>
  </p>
  <p>
  <table width="780" border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#EEEEEE">
    <tr>
    <td width="15%">������</td>
    <td width="15%">����ʱ��</td>
      <td width="10%">����ID</td>
      <td width="11%">�ռ���</td>
      <td width="36%">�ռ��˵�ַ</td>
      <td width="8%">&nbsp;</td>
    </tr>
      <asp:Repeater ID="OrderList" runat="server" onitemdatabound="OrderList_ItemDataBound" >
     <ItemTemplate>
    <tr>
      <td><%#Eval("dingdan")%></td>
      <td><%#Eval("fhsj")%></td>
      <td><%#Eval("userid")%></td>
      <td><%#Eval("shouhuoname")%></td>
      <td><%#Eval("province")%>-<%#Eval("city")%>-<%#Eval("xian")%>-<%#Eval("shopxp_shdz")%></td>
      <td>
          <input id="Button1" type="button" value="����" onclick="location.href='GoodsReturnAddNext.aspx?type=<%=type%>&orderid=<%#Eval("dingdan")%>'" /></td>
      </tr>

    <tr>
      <td colspan="6"><table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
        <tr>
          <td bgcolor="#F6F6F6">���</td>
          <td bgcolor="#F6F6F6">��Ʒ����</td>
          <td bgcolor="#F6F6F6">��������</td>
          <td bgcolor="#F6F6F6">��Ʒ��λ</td>
          <td bgcolor="#F6F6F6">�� ʽ</td>
          <td bgcolor="#F6F6F6">��Ʒ���</td>
          <td bgcolor="#F6F6F6">��ʽ���</td>
        </tr>
          <asp:Repeater ID="OrderDetail" runat="server">
         <ItemTemplate>
                <tr>
				<td bgcolor="#FFFFFF"><%#Eval("sortid")%></td>
          <td bgcolor="#FFFFFF"><%#Eval("shopxpptname")%></td>
          <td bgcolor="#FFFFFF"><%#Eval("productcount")%></td>
          <td bgcolor="#FFFFFF"><%#Eval("productdanwei")%></td>
          
          <td bgcolor="#FFFFFF"><%#Eval("p_size")%></td>
          <td bgcolor="#FFFFFF"><%#Eval("shopxpptid")%></td>
          <td bgcolor="#FFFFFF"><%#Eval("shopxp_yangshiid")%></td>
        </tr>
        </ItemTemplate>
         </asp:Repeater>
      </table></td>
    </tr>
        </ItemTemplate>
     </asp:Repeater>
    <tr>
      <td colspan="6"><webdiyer:aspnetpager ID="Pager" FirstPageText="[��ҳ]" LastPageText="[ĩҳ]" NextPageText="[��һҳ]" PrevPageText="[��һҳ]"
                    ShowCustomInfoSection="Left" 
                CustomInfoHTML="ÿҳ[%PageSize%]��  ��[%CurrentPageIndex%]ҳ/��[%PageCount%]ҳ" 
                runat="server" PageSize="20" 
              EnableUrlRewriting="True" UrlPaging="True" UrlRewritePattern="GoodsReturnAdd.aspx?page={0}">
          </webdiyer:aspnetpager></td>
    </tr>
  </table>
  </p>
</form>
</body>
</html>
