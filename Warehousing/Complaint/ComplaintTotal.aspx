<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComplaintTotal.aspx.cs" Inherits="Warehousing.Complaint.ComplaintTotal"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ʒ����</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script src="../js/jquery.js"></script>
<script src="../js/tjsetday.js"></script>
</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>
    �ͻ�Ͷ��ͳ��</strong></div>
<form id="myform" runat="server" action="ComplaintTotal.aspx">
  <p>
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="5" style="margin-left:5px;">
      
      <tr>

        <td>�����Ų�ѯ
          <asp:TextBox ID="txtOperator" runat="server" Width="80px"></asp:TextBox>&nbsp;
        ʱ�䣺��<asp:TextBox ID="txtAddTime" runat="server"  MaxLength="10"  
                onClick="return Calendar('txtAddTime','');" Width="80px"></asp:TextBox>
        ��<asp:TextBox ID="txtEndTime" runat="server"  MaxLength="10"  
                onClick="return Calendar('txtEndTime','');" Width="80px"></asp:TextBox>
             <asp:Button ID="Button1" runat="server" Text="ͳ��" onclick="Button1_Click"/></td>
      </tr>
  </table>
  
  <table width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#EEEEEE">
    <tr><td bgcolor="#F6F6F6">���</td>
      <td bgcolor="#F6F6F6">����</td>
      <td width="23%" align="center" bgcolor="#F6F6F6">�ȴ�����</td>
      <td width="21%" align="center" bgcolor="#F6F6F6">���ڴ���</td>
      <td width="21%" align="center" bgcolor="#F6F6F6">�Ѵ���</td>
    </tr>
      <asp:Repeater ID="GoodsList" runat="server">
     <ItemTemplate>
    <tr>
      <td width="11%"><%#Container.ItemIndex+1%></td>
      <td width="24%"><%#Eval("typeName")%></td>
            <td align="center"><%#Eval("count1")%></td>
      <td align="center"><%#Eval("count2")%></td>
      <td align="center"><%#Eval("count3")%></td>
      </tr>
        </ItemTemplate>
     </asp:Repeater>
  </table>
  </p>
</form>
</body>
</html>
