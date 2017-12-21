<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Warehousing.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>多彩ERP - 管理中心登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="css.css">
<script language=javascript> 
<!--
    function SetFocus() {
        if (document.form1.UserName.value == "")
            document.form1.UserName.focus();
        else
            document.form1.UserName.select();
    }
    function CheckForm() {
        if (document.form1.UserName.value == "") {
            alert("请输入员工工号！");
            document.form1.UserName.focus();
            return false;
        }
        if (document.form1.Password.value == "") {
            alert("请输入密码！");
            document.form1.Password.focus();
            return false;
        }
        if (document.form1.s.value.length < 4) {
            alert("验证码输入错误！");
            document.form1.s.focus();
            return false;
        }
    }

//-->
</script>
<style type="text/css"> 
<!--
BODY
{
	FONT-FAMILY: "宋体";
	FONT-SIZE: 9pt;
	text-decoration: none;
	line-height: 150%;
	background-color:#d6dff7;	
text-decoration: none;
SCROLLBAR-FACE-COLOR: #799ae1; MARGIN: 0px; FONT: 12px 宋体; SCROLLBAR-HIGHLIGHT-COLOR: #799ae1; SCROLLBAR-SHADOW-COLOR: #799ae1; SCROLLBAR-3DLIGHT-COLOR: #799ae1; SCROLLBAR-ARROW-COLOR: #ffffff; SCROLLBAR-TRACK-COLOR: #aabfec; SCROLLBAR-DARKSHADOW-COLOR: #799ae1
}
from{
display:inline;
}
TD
{
	FONT-FAMILY: "宋体";
	FONT-SIZE: 9pt;
}
Input
{
	FONT-SIZE: 9pt;
	HEIGHT: 20px;
}
Button
{
	FONT-SIZE: 9pt;
	HEIGHT: 20px; 
}
Select
{
	FONT-SIZE: 9pt;
	HEIGHT: 20px;
}
A
{
	TEXT-DECORATION: none;
	color: #000000;

}
A:hover
{
	COLOR: #428EFF;
	text-decoration: underline;

}
.title
{
	background:url(Images/topbg.gif);
}
.border
{
	border: 1px solid #003399;
}
.tdbg{
	background:#E4EDF9;
	line-height: 120%;
}
.topbg
{
	background:url(Images/topbg.gif);
	color: #FFFFFF;

}
.bgcolor {
	background-color: #d6dff7;
}
.bbgcolor{
background-color: #FFFFFF;
}


.style1 {color: #000000}
.table{
border:#999999 solid 1px;
margin-top:100px;
}
#warp {
  position: absolute;
  width:1031px;
  height:387px;
  left:50%;
  top:50%;
  margin-left:-525px;
  margin-top:-192px;
  background-image:url(images/indexbj.jpg);
}
-->
</style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return CheckForm();">
<table width="332" height="242" border="0" align="center" cellpadding="0" cellspacing="0" background="images/login.jpg" class="table" >
    <tr> 
      <td width="344" background="Images/entry2.gif"> <table width="100%" border="0" cellspacing="8" cellpadding="0" align="center">
          <tr align="center"> 
            <td height="38" colspan="2" class="style1">&nbsp;</td>
          </tr>
          <tr> 
            <td align="right"><span class="style1">操作工号：</span></td>
            <td><input name="UserName"  type="text"  id="UserName" maxlength="20" style="width:160px;border-style:solid;border-width:1;padding-left:4;padding-right:4;padding-top:1;padding-bottom:1" onMouseOver="this.style.background='#D6DFF7';" onMouseOut="this.style.background='#FFFFFF'" onFocus="this.select(); "></td>
          </tr>
          <tr> 
            <td align="right"><span class="style1">操作密码：</span></td>
            <td><input name="Password"  type="password" maxlength="40" style="width:160px;border-style:solid;border-width:1;padding-left:4;padding-right:4;padding-top:1;padding-bottom:1" onMouseOver="this.style.background='#D6DFF7';" onMouseOut="this.style.background='#FFFFFF'" onFocus="this.select(); "></td>
          </tr>
          <tr> 
            <td align="right"><span class="style1">验 证 码：</span></td>
            <td><input name="s" id="s" style="border-style:solid;border-width:1;padding-left:4;padding-right:4;padding-top:1;padding-bottom:1" onFocus="this.select(); " onMouseOver="this.style.background='#D6DFF7';" onMouseOut="this.style.background='#FFFFFF'" size="6" maxlength="4">
               <img src="CheckCode.aspx" onClick="this.src='CheckCode.aspx?date='+( new Date().getTime().toString(36));"></td>
          </tr>
          <tr> 
            <td colspan="2"> <div align="center"> 
                <asp:Button ID="Button1" runat="server" Text=" 登录 " onclick="Button1_Click" />
                &nbsp; 
                <input name="reset" type="reset"  id="reset" value=" 清 除 " >
                <br>
              </div></td>
          </tr>
        </table></td>
    </tr>
    <tr><td height="3"></td></tr>
  </table>
    </form>
    <script language="JavaScript" type="text/JavaScript">
        SetFocus(); 
</script>
</body>
</html>
