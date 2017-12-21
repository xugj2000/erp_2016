<!--#include file="../conn.asp"-->
<!--#include file="../inc/TXM.asp"-->
<!--#include file="../inc/commonfunction.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<%
''call GetPageUrlpower("OrderPrint/DirectOrderWillList.asp")'取得父级页面的所有权限

''call CheckPageEdit()'检查当前页面是否有页面读取权限
%>
<%

dim action,dingdans,username,PrintOk
dim payMethod
Dim rows  '行高
action=request.QueryString("action")

dingdans=trim(request("dingdan"))
dingdans=replace(dingdans," ","")
rows=0
if dingdans="" or isnull(dingdans) then
	response.Write("<script>alert('你没有选择订单');window.close();</script>")
	response.End()
end if
isPosted=trim(request("isPosted"))

if isPosted="no" then
PrintOk=request.form("PrintOk")	
if cstr(PrintOk)=cstr(session("PrintOk")) then ''用form值与session值比较防刷新
	eSql="exec ReturnOrderPost '"&dingdans&"','"&session("LoginName")&"'"
	''response.Write(eSql)
	''response.End()
	''conn.execute(eSql) 
	session("PrintOk")=""
else
response.write "..."
end if
end if
 
%>
<html>
<head><title>返货订单打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
 
<style type="text/css" id="print"> 
td
{
font-size:12px;
} 
.dot
{
}

  .fxpt{
	font-size: 14px;
	text-decoration: none; 
}

 .bigtitle {
	font-size: 18px;
	text-decoration: none;
	font-weight: bold; 
}

.shdz {
	font-size: 16px;
	text-decoration: none;
	font-weight: bold; 
}

  .urlcss { 
	font-size: 12px;
	 
}
.STYLE1 {font-size: 16px}
</style> 
</head>

<BODY>
 

<script language="javascript" src="../js/CheckActivX.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
  <param name="License" value="845515150585010011211256128900">
</object>
<script language="javascript" type="text/javascript">
	var LODOP=document.getElementById("LODOP");//这行语句是为了符合DTD规范
	CheckLodop();
</script>
<div class="only_print_view"><table width="1000" border="0" align="center" cellpadding="5">
  <tr>
    <td><input type="button" id="btnPrint" value="打印预览" onClick="OrderPreview()">
<input type="button"  value="直接打印" onClick="OrderPrint()"  id="directPrint"></td>
  </tr>
</table>


</div>


<!-- lodop打印区域开始#################################################################### -->
<div id="view" width="100%">
<%
arry=split(dingdans,",")
for j=0 to ubound(arry)
	str_dingdan=str_dingdan+arry(j)+"','"
next
str_dingdan=left(str_dingdan,len(str_dingdan)-3)
if dingdans="" then
response.write "请选择订单号"
response.end
end if
 
 sql="select * from TB_GoodsReturnOrder where  OrderId in ('"&str_dingdan&"')"
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,conn,1,1
		'response.Write sql
		while not rs.EOF 
		PCount=0
		dd=trim(rs("OrderId"))
		liushuihao=rs("liushuihao")
		if liushuihao="" or isnull(liushuihao) then
		''response.write "<script>alert('操作异常,请重新进行选择打印操作!');wondow.close();</script>"
		''response.end
		end if
		dingdan_userid=rs("AgentId")
		fksj=rs("AddTime")
		if isdate(fksj) then fksj=formatdatetime(fksj,2)
		fhsj=rs("DeliverTime")
		if isdate(fhsj) then fhsj=formatdatetime(fhsj,2)
		shouhuoname=rs("ReveivedName")
		usertel=rs("UserTel")
		province=rs("province")
		city=rs("city")
		xian=rs("xian")
		shopxp_shdz=rs("PostAddress")
		  %>
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	<td valign="top" nowrap>
		  <table width="100%" border="1" cellpadding="0" cellspacing="1">
           
            <tr>
              <td width="24%" align="left" valign="top" nowrap height=52><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
              <td width="76%" align="center" nowrap class="bigtitle">电商网返货订单商品清单&nbsp;&nbsp;</td>
            </tr>
             <tr>
              <td colspan="2" align="left" valign="top" nowrap  height=52><span style="width:50px;"></span><%=dragcode(haiwaocde(lcase(dd)))%></td>
            </tr>
          </table>

		 <%
		 rows=rows+110
		 %>
<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
	<tr bgcolor="#CECFCE" >
	  <td width="14%" align="center"  height=25>流水号</td>
	  <td width="20%" align="center">订单号</td>
	  <td width="12%" align="center">下单ID</td>
	<td width="15%" align="center">下单时间</td>
	<td width="13%" align="center">打单时间</td>
	<td width="12%" align="center">&nbsp;</td>
	 
	<td width="14%" align="center">&nbsp;</td>
	</tr>
        <tr align="center">
          <td height=25><%=liushuihao%></td>
          <td ><a href="#"><%=trim(dd)%></a></td>
		  <td ><%=dingdan_userid%></td>
		  <td align="center"><%=fksj%></td>
          <td ><%=fhsj%></td>
          <td ></td>
          <td ></td>
        </tr>
		 <%
		 rows=rows+25*2
		 %> 
        <tr >
			<td colspan="7" align="center">		  
		  		<table width="100%"   align="center" cellpadding="0" cellspacing="1"     style="word-break:break-all;">
			<%
			  
		  	set rs_p=server.CreateObject("adodb.recordset")
			sql="select * from TB_GoodsReturn  where ReturnOrderId='"&dd&"' and ChangeFlag>=0 order by ID desc"
			rs_p.open sql,conn
			if not rs_p.eof then
			 %>
			   
			     <tr align="center"  height=25>
					<td  nowrap   width="41">序号</td>
					<td  nowrap    width="373">商品名称</td>
					<td  nowrap   width="74">数量</td>
				  </tr>

			<%
						rows=rows+25
						n=n+1
						i=1
				n=1
				b=""
				zongji=0
				zongjifen=0
				PCount=0
				
				do while not rs_p.eof
			%>
		  <tr align="center">
		  	<td  height=25><%=i%></td>
			<td><%=trim(rs_p("ProductName"))%></td>
			<td><%=rs_p("ProductCount")%></td>
		  </tr>
		  <%
			i=i+1 			
			'加上此行的行高
			If Len(rs_p("ProductName"))>25 Then 
				rows=rows+25*2
			Else 
				rows=rows+25
			End If 
			PCount=PCount+rs_p("ProductCount")
			rs_p.movenext
			loop
			end if
			rs_p.close
			set rs_p=nothing
 		%>
		</table>			</td>
        </tr>

        <tr  align="center">
          <td height="40" align="left" class="shdz"  >&nbsp;&nbsp;收货人:</td>
		  <td height="40" class="shdz" colspan="1"><%=trim(shouhuoname)%></td>
          <td   class="shdz">联系方式:</td>
          <td   class="shdz" colspan="2"><%=trim(usertel)%></td>
          <td class="shdz" align="left">&nbsp;商品数量</td>
          <td class="shdz" align="center"><%=PCount%></td>
        </tr>
        <tr >
          <td height="40" colspan="7" class="shdz" >&nbsp;&nbsp;收货地址:<%=trim(province)%><%=trim(city)%><%=trim(xian)%><%=trim(shopxp_shdz)%>
		  </td>
          </tr>
		  
		<%rows=rows+80
		 if liuyan<>"" then %>
		<tr >
          <td height="40" colspan="7" class="shdz">&nbsp;&nbsp;留言：<%=liuyan%>		  </td>
		</tr>
		<%
			rows=rows+40
			end if
		%>
      </table>
		  <div align=right height=25 style="margin-top:5px"><span class="urlcss">电商网业务监督电话：0371-69138058  感谢您的支持！</span></div> 
		  <div align=right height=10>&nbsp;</div>  
		   
		   <%
			 rows=rows+50
			 %>
	  </td>
	</tr>
</table>
 		 
<%
    rs.movenext
    wend
conn.close
Set conn=Nothing 
%>
 

</div>
<!-- lodop打印区域开始#################################################################### -->


 <script language="javascript" type="text/javascript"> 
 	
	function OrderPrint() 
	{		
		CreateFormPage();
		LODOP.PRINT();	
	};               	
	function OrderPreview()
	{		
		CreateFormPage();
		LODOP.PREVIEW();
	};
	function CreateFormPage()
	{
		 
		var strBodyStyle="<style>"+document.getElementById("print").innerHTML+"</style>";
		var strFormHtml=strBodyStyle+"<body>"+document.getElementById("view").innerHTML+"</body>";	
		//var iPageHigh=document.getElementById("view").scrollHeight;
		var iPageHigh=<%=rows%>;
		//iPageHigh=iPageHigh+60;//加上公共信息
		iPageHighs=iPageHigh/96*254;//折算成毫米(单位0.1mm) (这里px是绝对值长度单位：96px/in)
		LODOP.PRINT_INIT("电商网返货订单打印"); 
		LODOP.SET_PRINT_PAGESIZE(1,2300,iPageHighs,"");
		LODOP.ADD_PRINT_HTM(0,0,750,iPageHigh,strFormHtml); 
		LODOP.SET_PRINT_STYLEA(2,"Horient",2);
	};
	<%if isPosted="no" then%>window.opener.location.reload();<%end if%>
</script>


</body>
</html>
