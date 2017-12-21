<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsPosition.aspx.cs" Inherits="Warehousing.Storage.GoodsPosition" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>货位号输入</title>
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
            if (obj.checked==true)//如果选择了
            {                
                if(stylehid.value == null || stylehid.value == "")
                {
                    stylehid .value += obj.id.substring(2,obj.id.length)
                }
                else
                {
                    var inarr = new Array ();//定义存储已存在id的数组
                    var arrstr = stylehid.value;  //取出hid中的字符串
                    inarr = arrstr.split(","); //插入数组                
                    inarr .push(obj.id.substring(2,obj.id.length));//新添加项填进数组中
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
    商品条码检索</strong></div>

  <table border="0" cellspacing="0" cellpadding="5" style="margin-left:5px;">
      
      <tr>
        <td class="style1">商品条码： </td>
        <td width="200">
            <asp:TextBox ID="txtTxm" runat="server"></asp:TextBox>
        </td>
      </tr>
      
      <tr>
        <td class="style1">商品名称：</td>
        <td width="200">
            <asp:TextBox ID="ProductNameStr" runat="server"></asp:TextBox>
            
        </td>
      </tr>
      <tr>
          <td class="style1">
              &nbsp;</td>
          <td>
              <asp:Button ID="Button1" runat="server" CssClass="bigbtn" onclick="Button1_Click" Text="下一步" />
              
          </td>
      </tr>
    </table>
     </asp:panel> 
     
  <asp:Panel runat ="server" ID ="FindList" Width="100%" Visible ="false">
  <div style="width:100%">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <asp:Button ID="Button5" runat="server" CssClass="bigbtn" onclick="Button3_Click" Text="下一步" /></div>  
  <div style="width:100%;" align="center" >
  <asp:Repeater ID ="FindShowList" runat ="server" >
  <HeaderTemplate >
  <table width="700" border="1" align="center" cellpadding="2" cellspacing="1" bordercolor="#EEEEEE" style="text-align:center;">
      <tr>
          <td width="50">
              选择</td>
          <td width="150">
              样式Id</td>
          <td width="300">
              商品名称</td>
          <td width="100">
              规格型号</td>
          <td width="150">
              条形码</td>
      </tr>      
  </HeaderTemplate>
  <ItemTemplate>
     <%#(Eval("LocalId")).ToString() == "EmptyNull" ? "<tr title=\"该商品尚未存在货位号\">":"<tr style=\"background-color :#b36d61;\" title=\"该商品已存在货位号："+Eval("LocalId")+"\">"%> 
      
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
  <asp:Button ID="Button3" runat="server" CssClass="bigbtn" onclick="Button3_Click" Text="下一步" /></div>     
  </asp:Panel>    
  
  <div style="width:100%;">
  <asp:Panel runat ="server" ID ="CheckList" Width="100%" Visible ="false">
  <asp:Repeater ID ="CheckRp" runat ="server" >
  <HeaderTemplate >
  <table width="100%" border="1" align="left" cellpadding="0" cellspacing="1" bordercolor="#EEEEEE" style="font-size:12px;color:Gray;text-align:center;">
      <tr>
          <td width="20%">
              样式Id</td>
          <td width="30%">
              商品名称</td>
          <td width="20%">
              规格型号</td>
          <td width="30%">
              条形码</td>
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
          货位号：<asp:TextBox ID="HuoWeiHao" runat="server"></asp:TextBox>
          <asp:Button ID="Button4" runat="server" CssClass="bigbtn" onclick="Button2_Click" Text="确定" />
 </asp:panel></div>
    
  <asp:panel runat="server" ID="panStep2">
  <div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>
    货位号输入</strong></div>

  <table border="0" cellspacing="0" cellpadding="5" style="margin-left:5px;">
      <tr>
        <td>商品名称：</td>
        <td class="style5">
            <asp:Label ID="lbProductName" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>商品型号：</td>
        <td class="style5">
            <asp:Label ID="lbStyleName" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      
      <tr>
        <td class="style2">货位号： </td>
        <td class="style3">
            <asp:TextBox ID="txtLocalId" runat="server"></asp:TextBox>
            
        </td>
      </tr>
      <tr>
          <td class="style1">&nbsp;
        </td>
          <td class="style5">
              <asp:Button ID="Button2" runat="server"  CssClass="bigbtn" Text="确定" onclick="Button2_Click"/>
              <input type="hidden" value="<%=styleId%>" name="styleid" />
          </td>
      </tr>
    </table>
  </asp:panel>
  
  <table width="700" border="1" align="center" cellspacing="1" bordercolor="#EEEEEE">
  <tr>
    <td height="24" colspan="5" bgcolor="#F3F3F3"><strong>最近录入的条码</strong></td>
  </tr>
  <tr>
    <td width="86" class="style4">条码号</td>
    <td width="227" class="style4">商品名称</td>
    <td width="92" class="style4">商品型号</td>
    <td width="125" class="style4">货位号</td>
    <td width="142" class="style4">录入时间</td>
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
