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
print_page_width=50
if request.Cookies("warehouse_id")=4 then
print_page_width=150
end if

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
	eSql="exec DirectOrderPost '"&dingdans&"','"&session("LoginName")&"'"
	''response.Write(eSql)
	''response.End()
	conn.execute(eSql) 
	session("PrintOk")=""
else
response.write "..."
end if
end if
 
%>
<html>
<head><title>直营订单打印</title>
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
 
 sql="select * from Direct_OrderMain where  dingdan in ('"&str_dingdan&"')"
 	    ''sql="select IsFreightDelyPay,Group_Lable,fapiao_title,liushuihao,dingdan,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '商城订单' when xiaofeifangshi=1 then '调换货订单' when xiaofeifangshi=3 then '分销中心代下订单' when xiaofeifangshi=4 then '分销中心提货订单' end,dingdan_leixing=case when dingdan_type=3 then '升级订单' when dingdan_type=2 then '二次进货' else '注册订单' end, shouhuo_username,shouhuoname,username,userid,sale_userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(16),actiondate,120) as actiondate,shopxp_shfs,zhifufangshi,zhuangtai,liuyan,fapiao,convert(varchar(16),fapiao_date,120) as fapiao_date,fuwu_userid,fenxiao_userid,is_givecard,feiyong,TapeColor,other_info from order_agent_main where dingdan in ('"&str_dingdan&"') and shopxp_shfs<>23 and shopxp_shfs<>27  and shopxp_shfs<>29 order by Group_Lable asc"
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,conn,1,1
		'response.Write sql
		while not rs.EOF 
		PCount=0
		dd=trim(rs("dingdan"))
		liushuihao=rs("liushuihao")
	''	if liushuihao="" or isnull(liushuihao) then
	''	response.write "<script>alert('操作异常,请重新进行选择打印操作!');wondow.close();</script>"
	''	response.end
	''	end if
        seller_name=rs("seller_name")
		shopxp_shfs=rs("shopxp_shfs")
		dingdan_userid=rs("user_name")
		fksj=rs("fksj")
		if isdate(fksj) then fksj=formatdatetime(fksj,2)
		fhsj=rs("fhsj")
		if isdate(fhsj) then fhsj=formatdatetime(fhsj,2)
		shouhuoname=rs("shouhuoname")
		usertel=rs("usertel")
		province=rs("province")
		city=rs("city")
		xian=rs("xian")
		shopxp_shdz=rs("shdz")
		liuyan=rs("liuyan")
		payMethod=rs("zhifufangshi")
		fapiao_title=rs("fapiao_title") 
		IsFreightDelyPay=rs("IsFreightDelyPay")
		feiyong=rs("freight")
        supplierid=rs("supplierid")
        post_city=""
        if supplierid="1" then
        post_city="银川"
        else
        post_city="广州"
        end if
		  %>
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	<td valign="top" nowrap>
	<table width="750" border="1" cellpadding="0" align=center cellspacing="1">
    <tr>
        <td width=100 align="left" valign="top" nowrap height=52><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
        <td align="center" nowrap class="bigtitle">ERP2016网售订单商品清单</td>
        <td style="text-align:right; width=200"><img height=50 src="/OneBarCode.aspx?code=<%=lcase(dd)%>" style="margin:2px;margin-right:5px;" /></td>
              
    </tr>
    </table>
		 <%
		 rows=rows+110
		 %>
<table width="750" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
	<tr bgcolor="#CECFCE" >
	  <td width="14%" align="center"  height=25>流水号</td>
	  <td width="20%" align="center">订单号</td>
	  <td width="12%" align="center">下单ID</td>
	<td  align="center">付款时间</td>
	<td align="center">打单时间</td>
	<td width="12%" align="center">收货方式</td>
	</tr>
        <tr align="center">
          <td height=25><%=liushuihao%></td>
          <td ><%=trim(dd)%></td>
		  <td ><%=dingdan_userid%></td>
		  <td align="center"><%=fksj%></td>
          <td ><%=fhsj%></td>
          <td >快递</td>
        </tr>
		 <%
		 rows=rows+25*2
		 %> 
        <tr >
			<td colspan="6" align="center">		  
		  		<table width="100%"   align="center" cellpadding="0" cellspacing="1">
			<%
			  
		  	set rs_p=server.CreateObject("adodb.recordset")
			sql="select * from Direct_OrderDetail  where dingdan='"&dd&"' order by shopxpptname desc" 
			rs_p.open sql,conn
			if not rs_p.eof then
			 %>
			   
			     <tr align="center"  height=25>
					<td  nowrap width="41">序号</td>
					<td  nowrap>商品名称</td>
					<td  nowrap width="88">规格</td>
                    <td  nowrap width="55">单价</td>
					<td  nowrap width="74">数量</td>
					<td  nowrap width="51">单位</td>
					<td  nowrap>TXM</td>
				  </tr>
			<%
						rows=rows+25
						n=n+1
						i=1
				n=1
				b=""
				zongji=0
				PCount=0
				do while not rs_p.eof
			%>
		  <tr align="center">
		  	<td  height=25><%=i%></td>
			<td   style='padding-left:5px;' align="left"  >
				<span style="font-weight:900;"><%=rs_p("huojiahao")%>.</span><%=trim(rs_p("shopxpptname"))%></span>			</td>
			<td align="left" style="padding-left:5px;"  >
				<%=rs_p("p_size")%>			</td>
            <td nowrap  ><%=rs_p("voucher")%></td>
			<td><%=rs_p("productcount")%></td>
			<td nowrap   ><%=rs_p("unit")%></td>
			<td  ><%=rs_p("txm") %></td>
			
		  </tr>
		  <%
			zongji=cdbl(rs_p("zonger"))+zongji
			i=i+1 			
			'加上此行的行高
			If Len(rs_p("shopxpptname"))>25 Then 
				rows=rows+25*2
			Else 
				rows=rows+25
			End If 
			PCount=PCount+rs_p("productcount")
			rs_p.movenext
			loop
			%>
  		<tr>
    		<td colspan="7" height=25 align=right>
    		<% response.write "商品总额："&zongji&"元"
				response.Write ",邮费："&feiyong&"元"
				 %></td></tr>
		<%
			rows=rows+25
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
          <td   class="shdz"><%=trim(usertel)%></td>
          <td class="shdz" align="left">&nbsp;商品数量</td>
          <td class="shdz" align="center"><%=PCount%></td>
        </tr>
        <tr >
          <td height="40" colspan="6" class="shdz" >&nbsp;&nbsp;收货地址:<%=trim(province)%><%=trim(city)%><%=trim(xian)%><%=trim(shopxp_shdz)%>
		  </td>
          </tr>
		  
		<%rows=rows+80
		 if liuyan<>"" then %>
		<tr >
          <td height="40" colspan="6" class="shdz">&nbsp;&nbsp;留言：<%=liuyan%>		  </td>
		</tr>
		<%
			rows=rows+40
			end if
		%>
        <tr align="center">
          <td height="30">商家名称</td>
          <td  colspan="2" ><%=seller_name%>(<%=post_city%>)</td>
          <td>售后电话</td>
          <td  colspan="2">400 867 9900</td>
          </tr>
      </table>
	  	 <%
		 rows=rows+40
		 %>  
         <table width=750 align=center><tr><td>
		  <div align=right height=25 style="margin-top:5px"><span class="urlcss">ERP2016(www.999000.cn)业务监督电话：4008679900  感谢您的支持！</span></div> 
		  <div align=right height=10>&nbsp;</div>  
		   </td></tr>
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
		LODOP.PRINT_INIT("订单未发货"); 
		LODOP.SET_PRINT_PAGESIZE(1,2400,iPageHighs,"");
		LODOP.ADD_PRINT_HTM(20,<%=print_page_width %>,720,iPageHigh,strFormHtml); 
		LODOP.SET_PRINT_STYLEA(1,"Horient",1);
	};
	 
</script>
<iframe id="fanliiframe" name="fanliiframe"  src="SendPrintToWeb.aspx" scrolling=no width="1" height="1" marginWidth=0 marginHeight=0 frameborder=0 border=0 style="display:none"></iframe>

</body>
</html>