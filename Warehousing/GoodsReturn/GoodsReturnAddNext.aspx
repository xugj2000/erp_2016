<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsReturnAddNext.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsReturnAddNext" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>返货商品录入</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
<script src="../js/jquery.js"></script>
<SCRIPT>
//读取memo，以ajax方式读取可以加快页面打开速度
function getAgentinfo(agentid) 
{	 
	$.ajax
	({
		url:"../handler/getAgentInfo.ashx?nocache=" + Math.random(),
		type:"get",
		data:"agentid="+agentid,
		dataType:"json",
		success:function(jsonStr){
			var obj=eval(jsonStr);
			$("#txtUserName").val(obj.shouhuoname);
			$("#txtProvince").val(obj.province);
			$("#txtCity").val(obj.city);
			$("#txtTown").val(obj.xian);
			$("#txtAddress").val(obj.shopxp_shdz);
			$("#txtUserTel").val(obj.usertel);
			} 
	});  
}
</script>
    <style type="text/css">
        .style1
        {
            height: 14px;
        }
        .style3
        {
            height: 16px;
        }
    </style>
</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>返货商品录入</strong></div>
<form id="myform" runat="server">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="0" 
      style="margin-left:5px; height: 529px;">
  	  <tr>
        <td width="97" class="style1">所属订单：</td>
        <td width="663" class="style1">
        <asp:TextBox ID="txtOrderId" runat="server"  MaxLength="50"></asp:TextBox>若不知可不填写
              </td>
      </tr>
      <tr>
        <td>所属代理：</td>
        <td>
            <asp:TextBox ID="txtAgentid" runat="server"  MaxLength="50"></asp:TextBox>若代理不知,请填0
              <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ControlToValidate="txtAgentid" Display="Dynamic" ErrorMessage="请正确填写代理号"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator2" runat="server" 
                ControlToValidate="txtAgentid" ErrorMessage="请正确填写代理号" 
                MaximumValue="9999999999" MinimumValue="0" Type="Double"></asp:RangeValidator>
              </td>
      </tr>
      <tr>
        <td>商品名称：        <td>
            <asp:TextBox ID="txtProductName" runat="server" Width="254px" MaxLength="100"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtProductName" ErrorMessage="商品名称不能为空"></asp:RequiredFieldValidator>
        </td>
      </tr>
      <tr>
        <td>商品条码：</td>
        <td>
            <asp:TextBox ID="txtProductTxm" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      
      <tr>
        <td>返货数量： </td>
        <td>
            <asp:TextBox ID="txtProductCount" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtProductCount" Display="Dynamic" ErrorMessage="返货数量不能为空"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator1" runat="server" 
                ControlToValidate="txtProductCount" Display="Dynamic" ErrorMessage="返货数量有误" 
                MaximumValue="10000" MinimumValue="1" Type="Integer"></asp:RangeValidator>
        </td>
      </tr>
      <tr>
        <td>返货时间：</td>
        <td>
            <asp:TextBox ID="txtReturnTime" runat="server"  MaxLength="50"  onClick="return Calendar('txtReturnTime','');"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>返货原因：</td>
        <td>
            <asp:TextBox ID="txtReturnReson" runat="server" Width="233px"></asp:TextBox>
            
            <asp:DropDownList ID="ddreson" runat="server"></asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td>姓名：        <td>
            <asp:TextBox ID="txtUserName" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>电话：</td>
        <td>
            <asp:TextBox ID="txtUserTel" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>区域：</td>
        <td>
            <asp:TextBox ID="txtProvince" runat="server"  MaxLength="30" Width="80px"></asp:TextBox>省&nbsp; &nbsp;  
            <asp:TextBox ID="txtCity" runat="server"  MaxLength="30" Width="80px"></asp:TextBox>市&nbsp; &nbsp; 
            <asp:TextBox ID="txtTown" runat="server"  MaxLength="30" Width="80px"></asp:TextBox>县 <br />
             详细地址：<asp:TextBox ID="txtAddress" runat="server"  MaxLength="50" Width="300px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="style3">运费：</td>
        <td class="style3">
            <asp:TextBox ID="txtPostFee" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>接收备注：</td>
        <td>
            <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Width="240px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>接收人：        <td>
            <asp:TextBox ID="txtReceivedOpter" runat="server" MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="txtReceivedOpter" ErrorMessage="接收人不能为空"></asp:RequiredFieldValidator>
        </td>
      </tr>
      <tr>
        <td></td>
        <td>
            <asp:HiddenField ID="fromUrl" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="确认提交" onclick="Button1_Click" />
        </td>
      </tr>
  </table>
  </p>
</form>
</body>
</html>
