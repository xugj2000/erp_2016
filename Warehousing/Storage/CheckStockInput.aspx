<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckStockInput.aspx.cs" Inherits="Warehousing.Storage.CheckStockInput" %>

<html><head><title>盘点录入</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
.editor { margin:0px 22px 0px 125px; }
.width2,.width3,.width4,.width6{height:30px;line-height:30px;padding-left:2px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width2{width:60px;margin:0px;}
.width3{width:80px;margin:0px;}
.width4{width:40px;margin:0px;text-align:center;}
.width6{width:120px;margin:0px;}
.add_link{color:red;margin:4px;display:block}
.delete_btn { display: block; float: left; margin-left: 5px; width: 10px; height: 10px; overflow: hidden; cursor: pointer; background: url(/images/ico.gif) 0 -634px; }
</style>
<script type="text/javascript">
    $(function () {

        $('#form1').validate({
            errorLabelContainer: $('#warning'),
            invalidHandler: function (form, validator) {
                var errors = validator.numberOfInvalids();
                if (errors) {
                    $('#warning').show();
                }
                else {
                    $('#warning').hide();
                }
            },
            rules: {
                remark: {
                    required: true
                }
            },
            messages: {
                remark: {
                    required: '库存详情不能为空'
                }
            }
        });

    });

</script>
</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>详情录入</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <%if (id > 0)
            {%>
          <tr>
              <td>
                  所属单号：</td>
              <td>
              <%=liushuihao %>
              </td>
          </tr>
          <%} %>
          <tr>
              <td>
                  盘点区别码：</td>
              <td>
              <asp:TextBox ID="AreaCode" runat="server" Width="238px" MaxLength=6></asp:TextBox>用于区分开不同区域或工作人员
              </td>
          </tr>
          <tr>
              <td>
                  库存详情：</td>
              <td>
              <asp:TextBox ID="remark" runat="server" Width="427px" Height="300px" 
                      TextMode="MultiLine"></asp:TextBox>
                  <br /> <br />
                  可用盘点枪直接上传，数据要求格式:<br />
                  每行&quot;条码,数量&quot;的形式(条码与数量间以半角逗号或制表符分开)<br />
                  6948043411725,10<br />
                  B716811005031,20<br />
              </td>
          </tr>
          <tr>
              <td class="style2">&nbsp;
                  <asp:Button ID="Button2" runat="server" Text="" OnClientClick="return false;" style="width:1px;background:white;border:none"/>
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" 提 交 " onclick="Button1_Click" OnClientClick="return confirm('确认提交?');" />
                            </td>
            </tr>
          </table>
	
</td>
  </tr>          
<tr bgcolor="#FFFFFF" > 
<td height="30"  align="right">&nbsp;</td>
</tr>
</table>
</div>
				

</form>
</body>
</html>
