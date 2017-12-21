<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsPosition.aspx.cs" Inherits="Warehousing.Storage.GoodsPosition" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��λ������</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
    <style type="text/css">
        .style1
        {
            width: 77px;
        }
        .style2
        {
            width: 77px;
            height: 15px;
        }
        .style3
        {
            height: 15px;
            width: 210px;
        }
        .style4
        {
            height: 17px;
        }
        .bigbtn
        {
        	width:75px;
        	height:30px;
        	font-weight :bolder ;
        	}
        .style5
        {
            width: 210px;
        }
    </style>
    <script type ="text/javascript" >
        function savepro(obj)
        {
            var ckbox = obj;
            var stylehid = document .getElementById("savestyleid");
            if (obj.checked==true)//���ѡ����
            {                
                if(stylehid.value == null || stylehid.value == "")
                {
                    stylehid .value += obj.id.substring(2,obj.id.length)
                }
                else
                {
                    var inarr = new Array ();//����洢�Ѵ���id������
                    var arrstr = stylehid.value;  //ȡ��hid�е��ַ���
                    inarr = arrstr.split(","); //��������                
                    inarr .push(obj.id.substring(2,obj.id.length));//����������������
                    stylehid.value = inarr.join(",");
                }
            }
            else
            {
                var arrstr = stylehid.value;                
                var myarr =  new Array ();
                var thisstr = obj.id.substring(2,obj.id.length);
                myarr = arrstr .split(",");
                var newarr = new Array ();                   
                for (var i = 0 ;i<myarr.length; i++)
                {
                    if (myarr[i] != thisstr)
                    {                       
                        newarr .push (myarr[i]);
                    }
                }
                stylehid.value = newarr.join(",");
            }            
        }
    </script>
</head>
<body>
<form id="myform" runat="server">
<asp:panel runat="server" ID="panelStep1">
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>
    ��Ʒ�������</strong></div>

  <table border="0" cellspacing="0" cellpadding="5" style="margin-left:5px;">
      
      <tr>
        <td class="style1">��Ʒ���룺 </td>
        <td width="200">
            <asp:TextBox ID="txtTxm" runat="server"></asp:TextBox>
        </td>
      </tr>
      
      <tr>
        <td class="style1">��Ʒ���ƣ�</td>
        <td width="200">
            <asp:TextBox ID="ProductNameStr" runat="server"></asp:TextBox>
            
        </td>
      </tr>
      <tr>
          <td class="style1">
              &nbsp;</td>
          <td>
              <asp:Button ID="Button1" runat="server" CssClass="bigbtn" onclick="Button1_Click" Text="��һ��" />
              
          </td>
      </tr>
    </table>
     </asp:panel> 
     
  <asp:Panel runat ="server" ID ="FindList" Width="100%" Visible ="false">
  <div style="width:100%">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <asp:Button ID="Button5" runat="server" CssClass="bigbtn" onclick="Button3_Click" Text="��һ��" /></div>  
  <div style="width:100%;" align="center" >
  <asp:Repeater ID ="FindShowList" runat ="server" >
  <HeaderTemplate >
  <table width="700" border="1" align="center" cellpadding="2" cellspacing="1" bordercolor="#EEEEEE" style="text-align:center;">
      <tr>
          <td width="50">
              ѡ��</td>
          <td width="150">
              ��ʽId</td>
          <td width="300">
              ��Ʒ����</td>
          <td width="100">
              ����ͺ�</td>
          <td width="150">
              ������</td>
      </tr>      
  </HeaderTemplate>
  <ItemTemplate>
     <%#(Eval("LocalId")).ToString() == "EmptyNull" ? "<tr title=\"����Ʒ��δ���ڻ�λ��\">":"<tr style=\"background-color :#b36d61;\" title=\"����Ʒ�Ѵ��ڻ�λ�ţ�"+Eval("LocalId")+"\">"%> 
      
          <td>
              <input id="Cb<%# Eval("id")%>" type="checkbox" onclick="savepro(this);" /></td>
          <td>
              <%# Eval("id")%></td>
          <td>
              <%# Eval("shopxpptname")%></td>
          <td>
              <%# Eval("p_size")%></td>
          <td>
              <%# Eval("txm")%></td>
      </tr>
  </ItemTemplate>
  <FooterTemplate>  
      </table>      
  </FooterTemplate>
  </asp:Repeater></div>
  <div style="width:100%">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <asp:Button ID="Button3" runat="server" CssClass="bigbtn" onclick="Button3_Click" Text="��һ��" /></div>     
  </asp:Panel>    
  
  <div style="width:100%;">
  <asp:Panel runat ="server" ID ="CheckList" Width="100%" Visible ="false">
  <asp:Repeater ID ="CheckRp" runat ="server" >
  <HeaderTemplate >
  <table width="100%" border="1" align="left" cellpadding="0" cellspacing="1" bordercolor="#EEEEEE" style="font-size:12px;color:Gray;text-align:center;">
      <tr>
          <td width="20%">
              ��ʽId</td>
          <td width="30%">
              ��Ʒ����</td>
          <td width="20%">
              ����ͺ�</td>
          <td width="30%">
              ������</td>
      </tr>      
  </HeaderTemplate>
  <ItemTemplate>
      <tr>
          <td>
              <%# Eval("id")%></td>
          <td>
              <%# Eval("shopxpptname")%></td>
          <td>
              <%# Eval("p_size")%></td>
          <td>
              <%# Eval("txm")%></td>
      </tr>
  </ItemTemplate>
  <FooterTemplate>  
      </table>      
  </FooterTemplate>
  </asp:Repeater>
  </asp:Panel>
  </div>
  <div style="width:100%;">
  <asp:panel runat="server" ID="forList" Width ="800px" Visible ="false">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ��λ�ţ�<asp:TextBox ID="HuoWeiHao" runat="server"></asp:TextBox>
          <asp:Button ID="Button4" runat="server" CssClass="bigbtn" onclick="Button2_Click" Text="ȷ��" />
 </asp:panel></div>
    
  <asp:panel runat="server" ID="panStep2">
  <div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>
    ��λ������</strong></div>

  <table border="0" cellspacing="0" cellpadding="5" style="margin-left:5px;">
      <tr>
        <td>��Ʒ���ƣ�</td>
        <td class="style5">
            <asp:Label ID="lbProductName" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>��Ʒ�ͺţ�</td>
        <td class="style5">
            <asp:Label ID="lbStyleName" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      
      <tr>
        <td class="style2">��λ�ţ� </td>
        <td class="style3">
            <asp:TextBox ID="txtLocalId" runat="server"></asp:TextBox>
            
        </td>
      </tr>
      <tr>
          <td class="style1">&nbsp;
        </td>
          <td class="style5">
              <asp:Button ID="Button2" runat="server"  CssClass="bigbtn" Text="ȷ��" onclick="Button2_Click"/>
              <input type="hidden" value="<%=styleId%>" name="styleid" />
          </td>
      </tr>
    </table>
  </asp:panel>
  
  <table width="700" border="1" align="center" cellspacing="1" bordercolor="#EEEEEE">
  <tr>
    <td height="24" colspan="5" bgcolor="#F3F3F3"><strong>���¼�������</strong></td>
  </tr>
  <tr>
    <td width="86" class="style4">�����</td>
    <td width="227" class="style4">��Ʒ����</td>
    <td width="92" class="style4">��Ʒ�ͺ�</td>
    <td width="125" class="style4">��λ��</td>
    <td width="142" class="style4">¼��ʱ��</td>
  </tr>
      <asp:Repeater ID="lastList" runat="server">
     <ItemTemplate>
  <tr><td><%#Eval("txm")%></td>
    <td><a href="http://vpn.369518.com/ProductManage/productshow.asp?id=<%#Eval("shopxpptid")%>" target="_blank"><%#Eval("shopxpptname")%></a></td>
    <td><%#Eval("p_size")%></td>
    <td><%#Eval("LocalId")%></td>
    <td><%#Eval("AddTime")%></td>
  </tr>
  </ItemTemplate>
   </asp:Repeater>
  </table>  
  <input id="savestyleid" type="hidden" runat ="server" />
</form>
</body>
</html>
