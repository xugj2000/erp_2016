<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductInDetail.aspx.cs" Inherits="Warehousing.Storage.ProductInDetail" %>

<html><head><title>������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
.width2,.width3,.width4,.width6{height:30px;line-height:30px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width2{width:60px;margin:0px;}
.width3{width:80px;margin:0px;}
.width4{width:40px;margin:0px;text-align:center;}
.width6{width:120px;margin:0px;}
.add_link{color:red;margin:4px;display:block}
</style>

<style type="text/css" id="print"> 
td
{
font-size:14px;height:14px;line-height:14px;
} 
 .bigtitle {
	font-size: 18px;
	text-decoration: none;
	font-weight: bold; 
}
</style> 

<script language="javascript" src="/print/CheckActivX.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
  <param name="License" value="845515150585010011211256128900">
</object>
<script language="javascript" type="text/javascript">
    var LODOP = document.getElementById("LODOP"); //���������Ϊ�˷���DTD�淶
    CheckLodop();
</script>

</head>
<body>
<form id="form1" runat="server">
<div id="div1">

<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ʒ����</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF" cellpadding="5" style="text-align:left">
<div class="only_print_view"><input type="button" id="btnPrint" value=" ��ӡԤ�� " onClick="OrderPreview()">
<input type="button"  value=" ֱ�Ӵ�ӡ " onClick="OrderPrint()"  id="directPrint">
<input type="button"  value=" �� �� " onClick="history.back();"  id="returnButton">
</div>
</td></tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<div id="view" style="width:800px;margin:0 auto;text-align:center">	
      <table width="100%" cellpadding="4" class="style1">
       <tr>
    <td colspan="2" style="font-size:20px;text-align:center;font-weight:bold;height:40px;">����嵥
    </td>
  </tr>
                    <tr>
              <td colspan=2>
<table width="100%" bgcolor="#FFFFFF" id="mytable" border="1" align="center" cellpadding="5" cellspacing="0">
  <tr bgcolor="#FFFFFF" align="center">
    <td colspan="11" style="text-align:left">
    ������ͣ� <%=Warehousing.Business.StorageHelper.getTypeText(sm_type)%>
    <%if (sm_supplierid>0){ %> ��Ӧ�����ƣ� <%=Warehousing.Business.StorageHelper.getSupplierName(sm_supplierid)%><%} %>
     <%if (warehouse_id_from>0){ %>�����ֿ⣺��<%=Warehousing.Business.StorageHelper.getWarehouseName(warehouse_id_from)%> �� <%=Warehousing.Business.StorageHelper.getWarehouseName(warehouse_id)%><%} %>
    ��ⵥ�ţ�<%=sm_sn%>
    �������ڣ�<%=sm_date %>

    </td>
  </tr>
  <tr>
     <td>&nbsp;</td>
    <td>����</td>
  	<td>����</td>
    <td>���</td>
    <td>��λ</td>
    <td>��ɫ</td>
    <td>�ͺ�</td>
    <td>����</td>
	<td>����</td>
    <td>���</td>
    <td>��λ</td>
    
  </tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
  <tr bgcolor="#FFFFFF" align="center">
   <td style="height:20px;"><%# Container.ItemIndex + 1%> </td>
    <td><input type=hidden name="p_id" value='<%#Eval("p_id")%>' /><%#Eval("p_txm")%></td>
  	<td><%#Warehousing.Business.PublicHelper.subStr(Convert.ToString(Eval("p_name")),6)%></td>
    <td><%#Eval("p_serial")%></td>
    <td><%#Eval("p_unit")%></td>
    <td><%#Warehousing.Business.PublicHelper.subStr(Convert.ToString(Eval("p_spec")),4)%></td>
    <td><%#Warehousing.Business.PublicHelper.subStr(Convert.ToString(Eval("p_model")), 4)%></td>
	<td><%#Convert.ToDouble(Eval("p_quantity"))%></td>
	<td><%#Convert.ToDouble(Eval("p_price"))%></td>
    <td><%#Convert.ToDouble(Eval("p_price")) * Convert.ToDouble(Eval("p_quantity"))%></td>
    <td><%#Eval("shelf_no")%>&nbsp;</td>
  </tr>
          </ItemTemplate>
          </asp:Repeater>
 <tr>
  <td style="height:20px;text-align:right" colspan=7> ��Ʒ�ϼ�</td>
	<td align=center><%=all_num%></td>
    <td align=center>&nbsp;</td>
    <td align=center><%=all_price%></td>
    <td align=center>&nbsp;</td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center">
    <td colspan="11" style="text-align:left">
    �Ʊ�ʱ��:<%=sm_time%> 
    ����ˣ�<span style="display:inline-block;width:70px;">&nbsp;</span> 
    �ջ�Ա��<span style="display:inline-block;width:70px;"><%=sm_operator %></span> 
    �ջ�ǩ�գ� <span style="display:inline-block;width:70px;">&nbsp;</span> 
    
    ��ע:<%=sm_remark%>
    </td>
  </tr>
	</table>
                  </td>
          </tr>
<tr bgcolor="#FFFFFF"<%if (current_sm_status>0){Response.Write("style='display:none;'");} %>> 
<td height="30"  align="left" colspan=2>

                  <asp:DropDownList ID="sm_status" runat="server">
                  <asp:ListItem Text="�ȴ����" Value="0"></asp:ListItem>
                  <asp:ListItem Text="ͨ��" Value="1"></asp:ListItem>
                  <asp:ListItem Text="����" Value="2"></asp:ListItem>
                  </asp:DropDownList>

<asp:Button ID="Button1" runat="server" Text=" �� �� " onclick="Button1_Click" />
</td>
</tr>
          </table>
	</div>
</form>


 <script language="javascript" type="text/javascript"> 
 	
	function OrderPrint() {		

		CreateFormPage();
		LODOP.PRINT();	
	};               	
	function OrderPreview() {
	   
		CreateFormPage();
		LODOP.PREVIEW();
	};
	function CreateFormPage() {
	    
	    var strBodyStyle = "<style>" + document.getElementById("print").innerHTML + "</style>";
	    
		var strFormHtml=strBodyStyle+"<body>"+document.getElementById("view").innerHTML+"</body>";	
		//var iPageHigh=document.getElementById("view").scrollHeight;
		var iPageHigh=200;
		//iPageHigh=iPageHigh+20*<%=MemberList.Items.Count%>;//���Ϲ�����Ϣ
        iPageHigh=iPageHigh+30*<%=MemberList.Items.Count%>;//���Ϲ�����Ϣ
		iPageHighs=iPageHigh/96*254;//����ɺ���(��λ0.1mm) (����px�Ǿ���ֵ���ȵ�λ��96px/in)
		LODOP.PRINT_INIT("���ⵥ��ӡ"); 
        LODOP.SET_PRINT_STYLE("PenStyle",0);//�����������0--ʵ�� 1--������ 2--���� 3--�㻮�� 4--˫�㻮�� ȱʡֵ��0��
        LODOP.SET_PRINT_STYLE("PenWidth",2);//��λ��(��ӡ)���أ�ȱʡֵ��1����ʵ�ߵ�������Ҳ��0
		LODOP.SET_PRINT_PAGESIZE(1,2400,iPageHighs,""); 
		LODOP.ADD_PRINT_HTM(20,<%=print_page_width %>,800,iPageHigh,strFormHtml); //�ĸ���ֵ�ֱ��ʾTop,Left,Width,Height
		LODOP.SET_PRINT_STYLEA(1,"Horient",1);
	};
</script>	

</body>
</html>
