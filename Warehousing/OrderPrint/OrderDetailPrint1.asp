<!--#include file="../conn.asp"-->
<!--#include file="../inc/TXM.asp"-->
<!--#include file="../inc/commonfunction.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<%
''call GetPageUrlpower("OrderPrint/Agent_Order_Detail_list.asp")'取得父级页面的所有权限

''call CheckPageEdit()'检查当前页面是否有页面读取权限
%>
<%
dim LoginName
LoginName=session("trueName")
dim action,dingdans,username
Dim rows  '行高
action=request.QueryString("action")
IDs=request.form("id")
if IDs="" or isnull(IDs) then
	response.Write("<script>alert('你没有选择订单');window.close();</script>")
	response.End()
end if

str="select BigType,OrderSn from DeliverGoodsOrder where id in ("&IDs&")"

dingdangs_agent="0"
dingdangs_dist="0"
set rsorder=conn.execute(str)
while not rsorder.eof
if rsorder("BigType")="0" then
dingdangs_agent=dingdangs_agent+","&rsorder("OrderSn")
elseif rsorder("BigType")="1" then
dingdangs_dist=dingdangs_dist+","&rsorder("OrderSn")
end if
rsorder.movenext
wend
rsorder.close
set rsorder=nothing

rows=0

if dingdangs_agent<>"0" then
	''conn.execute(" exec AgentOrderPost '"&dingdangs_agent&"','"&LoginName&"',1 ") 
elseif dingdangs_dist<>"0" then
	''conn.execute(" exec DistributionOrderPost '"&dingdangs_dist&"','"&LoginName&"',0 ")
end if
 
%>
<html>
<head><title>订单打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
<style type="text/css" id="print"> 
td
{
font-size:12px;
} 
.dot
{
	
	border-bottom-style:dashed;border-bottom-width:1px;border-bottom-color:#ececec;
	border-right-style:dashed;border-right-width:1px;border-right-color:#ececec;
	border-left-style:dashed;border-left-width:1px;border-left-color:#ececec;
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
if IDs<>"" then
 
		
		sql="select Id,BigType,LiuShuiHao,OrderSn,LogisticsCompany,Province,City,County,BuyType,OrderType, UserName,UserId,ReceiveName,PostAddress,UserTel,CONVERT (varchar(16),PayTime,120) as PayTime,ReceiveMethod,PayMethod,OrderStatus,Message,InvoiceFlag,PostMoney,ByDistributionId,TapeColor,IsFreightDelyPay,SuggestFreight from DeliverGoodsOrder where ReceiveMethod not in (23,27,25,29) and IsPay=1 and ID in ("&IDs&")"
		
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,conn,1,1
		'response.Write sql
		do while not rs.EOF 
		PCount=0
		dd=trim(rs("OrderSn"))
		liushuihao=rs("LiuShuiHao")
		dd=trim(rs("OrderSn"))
		UserName=rs("UserName")
		BigType=rs("BigType")
		BigTypeText=GetBigTypeName(rs("BigType"))
		BuyTypeName=GetConsumptionMethodText(rs("BuyType"))
		OrderType=rs("OrderType")
		OrderTypeName=GetDingdanTypeText(rs("OrderType"))
		ReceiveMethod=rs("ReceiveMethod")
		UserId=rs("userid")
		PayTime=rs("PayTime")
		ReceiveName=rs("ReceiveName")
		UserTel=rs("UserTel")
		Province=rs("Province")
		City=rs("City")
		County=rs("County")
		PostAddress=rs("PostAddress")
		LogisticsCompany=rs("LogisticsCompany")
		Message=rs("Message")
		InvoiceFlag=rs("InvoiceFlag")
		PostMoney=rs("PostMoney")
		ByDistributionId=rs("ByDistributionId")
		TapeColor=rs("TapeColor")
		ReceiveName=trim(rs("ReceiveName"))
		
		''fapiao_title=rs("fapiao_title") 
		
		''is_givecard=rs("is_givecard")

		select case is_givecard
		case "1"
			is_givecard="分销中心已发卡"
		case "2"
			is_givecard="升级订单已发卡"
		case else
			is_givecard="需要发卡"
		end select
		  %>
		  <table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	<td valign="top" nowrap>
		  <table width="100%" border="1" cellpadding="0" cellspacing="1">
           
            <tr>
              <td width="19%" align="left" valign="top" nowrap height=52><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
              <td width="41%" align="center" valign="middle" nowrap><span class="fxpt">花的少，买的多！</span></td>
<td width="40%" align="center" nowrap class="bigtitle">电商网代理订单&nbsp;&nbsp;<%''=rs("Group_Lable") %></td>
            </tr>
             <tr>
              <td colspan="3" align="left" valign="top" nowrap  height=52><span style="width:50px;"></span><%=dragcode(haiwaocde(lcase(dd)))%></td>
            </tr>
          </table>
<%
select case BigType
case "0":
call dispPrintDetail_Agent(dd)
case "1":
call dispPrintDetail_Dist(dd)
end select
%>



		  <div align=right height=25><span class="urlcss">产品售后：0371－66236936  感谢您的支持！</span></div> 
		  <div align=right height=10>&nbsp;</div>  
		   
		   <%
			 rows=rows+40
			 %>
		   
	  </td>
	</tr>
</table>
 
<%
    rs.movenext
    loop
end if
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
		LODOP.PRINT_INIT("代理未发货"); 
		LODOP.SET_PRINT_PAGESIZE(1,2300,iPageHighs,"");
		LODOP.ADD_PRINT_HTM(0,0,750,iPageHigh,strFormHtml); 
		LODOP.SET_PRINT_STYLEA(1,"Horient",2);

		
	};
	 
</script>
<%sub dispPrintDetail_Agent(dingdan)%>
		 <%
		 rows=rows+110
		 %>
<table width="800" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
	<tr bgcolor="#CECFCE" >
	  <td width="10%" align="center"  height=25>流水号</td>
	  <td width="15%" align="center">订单号</td>
	  <td width="7%" align="center">下单ID</td>
	<td width="12%" align="center">订单类型</td>
	<td width="8%" align="center">消费方式</td>
	<td width="14%" align="center">付款时间</td>
	<td width="10%" align="center">收货方式</td>
	 
	</tr>
        <tr align="center">
          <td height=25><%=liushuihao%></td>
          <td ><a href="javascript:;" onClick="javascript:window.open('order_agent_view.asp?dan=<%=dd%>&shopxp_shfs=<%=shopxp_shfs%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(dd)%></a></td>
		  <td ><%=UserId%></td>
		  <td align="center"><%=OrderTypeName%></td>
          <td ><%=BuyTypeName%></td>
          <td ><%=PayTime%></td>
          <td ><%=shfs(ReceiveMethod)%></td>
		  
        </tr>
		 <%
		 rows=rows+25*2
		 %> 
        <tr >
			<td colspan="7" align="center">		  
		  		<table width="100%"   align="center" cellpadding="0" cellspacing="1" class="dot"    style="word-break:break-all;">
			<%
			 set rs_c=server.CreateObject("adodb.recordset")
			  rs_c.open "select distinct(Storage_name) from order_agent_prodetail where dingdan='"&dd&"' and userid='"&dingdan_userid&"' ",conn
			  if not rs_c.eof and not rs_c.bof then
			  	maxc=rs_c.recordcount
			  end if
			  rs_c.close
			  set rs_c=nothing
			  
		  	set rs_p=server.CreateObject("adodb.recordset")
			sql="select shopxpptid,productdanwei,shopxpptname,shopxp_yangshiid,huojiahao,other_info,zonger,jifen,bochu,productcount,danjia,p_size,StorageSortId,Storage_name,txm from order_agent_prodetail  where dingdan='"&dd&"' and userid='"&dingdan_userid&"' order by StorageSortId asc,huojiahao asc,shopxpptname asc" 
			rs_p.open sql,conn
			if not rs_p.eof then
				 
				
				bochu=0
				i=1
				n=1
				b=""
					zongji=0
				zongjifen=0
				
				do while not rs_p.eof
					if rs_p("StorageSortId")="" or isnull(rs_p("StorageSortId")) then
						StorageSortId=0
					else
						StorageSortId=rs_p("StorageSortId")
					end if
					if rs_p("Storage_name")="" or isnull(rs_p("Storage_name")) then
						Storage_name="未分区"
					else
						Storage_name=trim(rs_p("Storage_name"))
					end if
					if b<>StorageSortId then
			%>
			<tr align="center">
			<td colspan="7" align="left" height="30" style="padding-bottom:12px;" class="dot" >
				<span style="width:100%; border-bottom:1px dashed #CCCCCC;"></span>
			</td>
			</tr>
			<tr align="center">
				<td colspan="7" style='padding-left:30px; height:25px;' align="left"  class="dot" ><span style="float:left;"><b><%=Storage_name%></b> -- <%=dd%> -- <%=dingdan_userid%> -- 收货人：<%=ReceiveName%> --  <%=maxc&"-"&n%></span><%if Storage_name="洗化区" then %><span style="padding-right:120px; text-align:right;float:right;">A11-A20配货人：</span><br/><span style="padding-right:120px; text-align:right;float:right;">A01-A10配货人：</span><%else%><span style="padding-right:150px; text-align:right;float:right;">配货人：</span><%end if%></td>
			  </tr>

			   <%
			 rows=rows+30*2
			 %>
			   
			     <tr align="center"  height=25>
					<td  nowrap  class=dot width="36">序号</td>
					<td  nowrap  class=dot  width="350">商品名称</td>
					<td  nowrap  class=dot width="105">规格</td>
					<td  nowrap  class=dot width="30">数量</td>
					<td  nowrap  class=dot width="24">单位</td>
					<td  nowrap  class="dot" width="90">TXM</td>
					<td  nowrap  class=dot width="45">编号</td>
				  </tr>

			<%
						b=StorageSortId
						rows=rows+25
						n=n+1
						i=1
					end if
			%>
		  <tr align="center">
		  	<td class="dot" height=25><%=i%></td>
			<td   style='padding-left:5px;' align="left" class="dot" >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="right"  width="54"><span style="font-weight:900;"><%=rs_p("huojiahao")%>.</span></td>
					<td><span><%=trim(rs_p("shopxpptname"))%></span></td>
				  </tr>
				</table>
			</td>
			<td align="left" style="padding-left:5px;" class="dot" >
				<%=rs_p("p_size")%>
				
			</td>
			
			<td  class="dot" ><%=rs_p("productcount")%></td>
			<td nowrap  class="dot" ><%=rs_p("productdanwei")%></td>
			<td class="dot" ><%=rs_p("txm") %></td>
			<td nowrap class="dot" ><%=rs_p("shopxpptid")%></td>
		  </tr>
		  <%
			zongji=rs_p("zonger")+zongji
			zongjifen=rs_p("jifen")*rs_p("productcount")+zongjifen
			
			bochu=rs_p("bochu")*rs_p("productcount")+bochu
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
			set rs_give=server.CreateObject("adodb.recordset")
			rs_give.open "select shopxpptid,huojiahao,shopxpptname,productdanwei,productcount,p_size,other_info,shopxp_yangshiid,txm from Order_present_Agent where dingdan='"&dd&"' order by shopxpptname desc",conn
			if not(rs_give.eof and rs_give.bof) then
		%>
		<tr align="center">
			<td colspan="7" align="left" height="30" style="padding-bottom:12px;"  class="dot" >
				<span style="width:100%; border-bottom:1px dashed #CCCCCC;"></span>
			</td>
		</tr>
		<tr align="center">
    		<td colspan="7" style='padding-left:30px; height:25px;' align="left" class="dot" ><span style="float:left;"><strong>赠品区</strong> -- <%=dd%> -- <%=UserId%> -- 收货人：<%=ReceiveName%></span><span style="padding-right:150px; text-align:right;float:right;">配货人：</span></td>
  		</tr>
  		<tr align="center">
			<td  nowrap   class=dot>序号</td>
			<td  nowrap   class=dot>名称</td>
			<td     class=dot>规格</td>
			<td  nowrap   class=dot>数量</td>
			<td  nowrap  class=dot>单位</td>
			<td  nowrap  class="dot" >TXM</td>
			<td  nowrap  class=dot>编号</td>
		</tr>

		<%
			rows=rows+80
			i=1
  			do while not rs_give.eof
  		%>
  		<tr align="center">
			<td  class=dot><%=i%></td>
			<td  style='padding-left:5px;' align="left"  class="dot" >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="right" width="54"><span style="font-weight:900;"><%=rs_give("huojiahao")%>.</span></td>
					<td><span><%=trim(rs_give("shopxpptname"))%></span></td>
				  </tr>
				</table>
			</td>
			<td align="left" style="padding-left:5px;" class="dot" >
				<%=rs_give("p_size")%>
			
			</td>
			<td class="dot" ><%=rs_give("productcount")%></td>
			<td  class="dot" ><%=rs_give("productdanwei")%></td>
			<td class="dot" ><%=rs_give("txm") %></td>
			<td  class="dot" ><%=rs_give("shopxpptid")%></td>
		</tr>
	  	<%
			'加上此行的行高
			If Len(rs_give("shopxpptname"))>25 Then 
				rows=rows+25*2
			Else 
				rows=rows+25
			End If 
			PCount=PCount+rs_give("productcount")
			rs_give.movenext
			if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			'set rs_give=nothing
	  	%>
  		<tr>
    		<td colspan="7" height=25 align=right>
    		
    		 
    		<%
				 if zongjifen=0 then 
				    response.write "订单总额："&zongji&"元"
				else
				    response.write "订单总额："&formatN(zongji)&"元,积分："&zongjifen
				end if
				
				
				    if rs("IsFreightDelyPay")=1 then
				        response.Write ""
				    else
				        response.Write ",费用："&PostMoney&"元"
				    end if
				 %>　</td>
  		</tr>
		<%
			rows=rows+25
			end if
			rs_p.close
			set rs_p=nothing
 		%>
		</table>
			</td>
        </tr>
        <%
			Set rs_give=server.CreateObject("adodb.recordset")
            rs_give.open "select ticket_id,ticket_num,userid,recevie_id from Ticket_Order where dingdan='"&dd&"'",conn
			if not(rs_give.eof and rs_give.bof) then
         %>
        <tr align="center">
    		<td colspan="7" style='padding-left:30px; height:25px;' align="left" class="dot" ><span style="float:left;"><strong>门票区</strong></span><span style="padding-right:150px; text-align:right;float:right;">配货人：</span></td>
  		</tr>
  		<tr align="center">
  		    <td   height=25  class="dot" >序号</td>
			<td   height=25  class="dot"  colspan ="2">名称</td>
			<td  nowrap class="dot" >商品单位</td>
			<td  class="dot" >数量</td>
			<td  class="dot" >规格</td>
			<td  class="dot" >编号</td>
		</tr>
		<%
		    ticket_i=1
		    do while not rs_give.eof
		   
		 %>
		 <tr  align="center">
		    <td><%=ticket_i %></td>
            <td nowrap style='padding-left:5px;'  class="dot" >新闻发布会门票</td>
            <td nowrap class="dot" >张</td>
            <td class="dot" ><%=rs_give("ticket_num")%></td>
            <td class="dot" >标准</td>
            <td class="dot" ><%=rs_give("ticket_id")%></td>
		 </tr>
		 <%		
				rows=rows+25
		        rs_give.movenext
		        ticket_i=ticket_i+1
			    if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			set rs_give=nothing
		  %>
		<% if Message<>"" then %>
		<tr >
          <td height="40" colspan="7" class="shdz">&nbsp;&nbsp;留言：<%=Message%>
		  </td>
		</tr>
		<%
			rows=rows+40
			end if
			if OrderType="注册订单" then
		%>
        <tr >
          <td height="40" colspan="7" class="shdz">&nbsp;&nbsp;备注：<%
		  	response.write is_givecard&"  总广告费："&formatN(bochu)
		   	if bochu>=3000 then response.write "  开授权书"
		  %>
		  </td>
		</tr>
		<%
			rows=rows+40
			end if
		%>
		<tr >
          <td height="40" colspan="5" class="shdz">&nbsp;&nbsp;下单人姓名:<%=trim(UserName)%>&nbsp;
              <%if not isnull(UserId) and UserId<>"0" then%>
              服务店：
              <%

			  sql="select did,username from tiaoxingma.dbo.e_user where userid='"&UserId&"'"
			  set rsd=server.CreateObject("adodb.recordset")
			  rsd.open sql,conn,3
			  if not(rsd.eof and rsd.bof) then
			  if rsd("did")="0" then
			    response.write "后台激活"
			  else
			    response.write rsd("did")&" 服务店主姓名："&rsd("username")
			  end If
			  end if
			  rsd.close
			  Set rsd=Nothing 
			  rows=rows+40
			  %>
              <%end if%>
		  </td>
		  <td colspan="2" class="shdz">
            <%
                if rs("IsFreightDelyPay")=0 then
                    response.Write ""
                else
                    response.Write "运费付款方式：<font color='red'>到付</font>"
                end if
             %>
          </td>
		</tr>
        <tr  align="center">
          <td height="40" class="shdz"  >收货人:</td>
		  <td height="40" class="shdz" colspan="1"><%=trim(ReceiveName)%></td>
          <td   class="shdz">联系方式:</td>
          <td   class="shdz" colspan="2"><%=trim(UserTel)%></td>
          <td   colspan="2" class="shdz" align="left">&nbsp;&nbsp;<%if fapiao="1" and fapiao_title<>"" then response.write "发票抬头:"&fapiao_title%></td>
  </tr>
        <tr >
          <td height="40" colspan="7" class="shdz" >&nbsp;&nbsp;收货地址:<%=trim(Province)%><%=trim(City)%><%=trim(County)%><%=trim(PostAddress)%></td>
  </tr>

        <tr >
          <td height="40" colspan="5" class="shdz" >&nbsp;&nbsp;胶带颜色:<%=TapeColor%></td>
          <td align="right" class="shdz">商品数量：</td>
          <td class="shdz"><%=PCount %></td>
  </tr>


        <tr align="center">
          <td height="30">验货人：</td>
          <td  colspan="1" >&nbsp;</td>
          <td  >验货时间：</td>
          <td colspan="1">&nbsp;</td>
          <td  colspan="3"><span>总箱数：共<span style="width:30px;"></span>件，清单在第<span style="width:30px;"></span>件</span></td>
  </tr>
</table>
	  	<%
		 rows=rows+40*5
		 %>
<%end sub%>

<%sub dispPrintDetail_Dist(dingdan)%>
		    <%
			'设置上面总行数的行高为110px
			rows=rows+110
		  %>
<table width="800" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
            <tr bgcolor="#CECFCE" height=30>
              <td width="15%" align="center" nowrap>流水号</td>
              <td width="18%" align="center" nowrap>订单号</td>
              <td width="13%" align="center" nowrap>下单ID</td>
              <td width="13%" align="center" nowrap>付款时间</td>
              <td width="13%" align="center" nowrap>收货方式</td>
              <td width="14%" align="center" nowrap>进货身份</td>
              <td width="14%" align="center" nowrap>进货类型</td>
            </tr>
            <tr  height=30 >
              <td align="center" nowrap id="liushuihao_<%=trim(dd)%>"><%=liushuihao%></td>
              <td align="center"><a href="javascript:;" onClick="javascript:window.open('fenxiao_viewdingdan_new.asp?dan=<%=dd%>&ReceiveName=<%=ReceiveName%>&ename=<%=username%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=dd%></a></td>
              <td align="center"><%=UserId%></td>
              <td align="center"><%=PayTime%></td>
              <td align="center"><%=shfs(ReceiveMethod)%></td>
              <td align="center"><%=BuyTypeName%></td>
              <td align="center"><%=OrderTypeName%></td>
            </tr>
			 

		<%
		'设置上面总行数的行高为50px
		rows=rows+30*2
		%>
            <tr  >
              <td colspan="7" align="center" id="heit_<%=j%>">
			  	<table width="98%"   align="center" cellpadding="0" cellspacing="0" class=dot  style="word-break:break-all;">
			  <%
			  set rs_c=server.CreateObject("adodb.recordset")
			  rs_c.open "select distinct(Storage_name) from Order_Distribution_ProDetail where dingdan='"&dd&"' ",conn
			  if not rs_c.eof and not rs_c.bof then
			  	maxc=rs_c.recordcount
			  end if
			  rs_c.close
			  set rs_c=nothing
		  	set rs_p=server.CreateObject("adodb.recordset")
			sql="select sa.shopxpptid,sa.productdanwei,sa.shopxpptname,sa.huojiahao,sa.other_info,sa.zonger,sa.productcount,sa.p_size as style,sa.StorageSortId,sa.Storage_name,txm from Order_Distribution_ProDetail as sa  where sa.dingdan='"&dd&"' order by sa.StorageSortId asc,sa.huojiahao asc,sa.shopxpptname asc" 
			rs_p.open sql,conn
			if not rs_p.eof then
				zongpv=0
				zongji=0
				bochu=0
				i=1
				n=1
				b=""
				do while not rs_p.eof
					if rs_p("StorageSortId")="" or isnull(rs_p("StorageSortId")) then
						StorageSortId=0
					else
						StorageSortId=rs_p("StorageSortId")
					end if
					if rs_p("Storage_name")="" or isnull(rs_p("Storage_name")) then
						Storage_name="未分区"
					else
						Storage_name=trim(rs_p("Storage_name"))
					end if
					if b<>StorageSortId then
			%>
			<tr  align="center"  height=25>
				<td colspan="6" style='padding-left:30px; height:25px;' align="left"  class=dot><span style="float:left;"><b><%=Storage_name%></b> -- <%=dd%>  -- <%=userids%> -- 收货人：<%=ReceiveName%>  --  <%=maxc&"-"&n%></span><%if Storage_name="洗化区" then %><span style="padding-right:120px; text-align:right;float:right;">A11-A20配货人：</span><span style="padding-right:120px; text-align:right;float:right;">A01-A10配货人：</span><%else%><span style="padding-right:150px; text-align:right;float:right;">配货人：</span><%end if%></td>
			  </tr >
			    
				   <tr align="center"  height=25>
					<td  nowrap  class=dot width="36">序号</td>
					<td  nowrap  class=dot  width="350">商品名称</td>
					<td  nowrap  class=dot width="105">规格</td>
					<td  nowrap  class=dot width="30">数量</td>
					<td  nowrap  class=dot width="24">单位</td>
					<td  nowrap  class="dot" width="90">TXM</td>
					<td  nowrap  class=dot width="45">编号</td>
				  </tr>
			<%
						'加上此2行的行高
						rows=rows+25*2
						b=StorageSortId
						i=1
						n=n+1
					end if
			%>
		  <tr  align="center"  height=25>
		  	<td  class=dot><%=i%></td>
			<td  style='padding-left:5px;' align="left"  class=dot>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="right"  width="54"><span style="font-weight:900;"><%=rs_p("huojiahao")%>.</span></td>
					<td><span><%=trim(rs_p("shopxpptname"))%></span></td>
				  </tr>
				</table>
		 
			</td>
			<td align="left" style="padding-left:5px;"  class=dot>
				<%=rs_p("style")%>
				
			</td>
			
			<td  class=dot><%=rs_p("productcount")%></td>
			<td  class=dot><%=rs_p("productdanwei")%></td>
			<td  class=dot><%=rs_p("txm")%></td>
			<td  class=dot><%=rs_p("shopxpptid")%></td>
		  </tr>
		  <%
			zongji=rs_p("zonger")+zongji
			i=i+1
			'加上此行的行高
			If Len(rs_p("shopxpptname"))>30 Then 
				rows=rows+25*2
			Else 
				rows=rows+25
			End If 
			PCount=PCount+rs_p("productcount")
			rs_p.movenext
			Loop
			

			set rs_give=server.CreateObject("adodb.recordset")
			rs_give.open "select shopxpptid,huojiahao,shopxpptname,productdanwei,productcount,p_size,other_info,shopxp_yangshiid,txm from Order_present_distribution where dingdan='"&dd&"' order by shopxpptname desc",conn,1,1
			if not(rs_give.eof and rs_give.bof) then
		%>
		<tr align="center"  height=25>
    		<td colspan="6" style='padding-left:30px; height:25px;' align="left"><span style="float:left;"><strong>赠品</strong> -- <%=dd%>  --  <%=userids%> -- 收货人：<%=ReceiveName%></span><span style="padding-right:150px; text-align:right;float:right;">配货人：</span></td>
  		</tr>
  		<tr align="center"  height=25>
			<td nowrap   class=dot>序号</td>
			<td  nowrap  class=dot>名称</td>
			<td  nowrap class=dot>规格</td>
			<td nowrap class=dot>数量</td>
			<td  nowrap  class=dot>单位</td>
			<td  nowrap  class="dot" >TXM</td>
			<td  nowrap  class=dot>编号</td>
		</tr>
		<%
			'加上此2行的行高
			rows=rows+25*2
			i=1
  			do while not rs_give.eof
				danwei=rs_give("productdanwei")
				if danwei="" or isnull(danwei) then
					danwei="<font color='#FFFFFF'>&nbsp;</font>"
				end if
  		%>
  		<tr  align="center" height=25>
			<td  class=dot><%=i%></td>
			<td  style='padding-left:5px;' align="left" class=dot>
			
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="right" width="54"><span style="font-weight:900;"><%=rs_give("huojiahao")%>.</span></td>
					<td><span><%=trim(rs_give("shopxpptname"))%></span></td>
				  </tr>
				</table>
			</td>
			<td align="left" style="padding-left:5px;"  class=dot>
				<%=rs_give("p_size")%>
				
			</td>
			
			<td  class=dot><%=rs_give("productcount")%></td>
			<td nowrap  class=dot><%=danwei%></td>
			<td  class=dot><%=rs_give("txm")%></td>
			<td nowrap  class=dot><%=rs_give("shopxpptid")%></td>
		</tr>
	  	<%
			'加上此行的行高
			If Len(rs_give("shopxpptname"))>25 Then 
				rows=rows+25*2
			Else 
				rows=rows+25
			End If 
			PCount=PCount+rs_give("productcount")
			rs_give.movenext
			i=i+1
			if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			'set rs_give=nothing
	  	%>
  		<tr  height=30>
    		<td colspan="6"  class=dot><div align="right">
				<%if is_tiaohuan=1 then response.write "<span style='font-weight:900;color:red;'>"&other_info&"</span>&nbsp;&nbsp;&nbsp;&nbsp;"%>订单总额：<%=zongji%>元＋费用：<%=PostMoney%>元　</div></td>
  		</tr>
		<%
			'加上此行的行高
			rows=rows+30
			end if
			rs_p.close
			set rs_p=nothing
 		%>
                </table>
			  </td>
            </tr>
             <%
			 set rs_give=conn.execute("select ticket_id,ticket_num,userid,recevie_id from Ticket_Order where dingdan='"&dd&"'")
			if not(rs_give.eof and rs_give.bof) then
         %>
        <tr align="center">
    		<td colspan="7" style='padding-left:30px; height:25px;' align="left" class="dot" ><span style="float:left;"><strong>门票区</strong></span><span style="padding-right:150px; text-align:right;float:right;">配货人：</span></td>
  		</tr>
  		<tr align="center">
  		    <td   height=25  class="dot" >序号</td>
			<td   height=25  class="dot"  colspan ="2">名称</td>
			<td  nowrap class="dot" >商品单位</td>
			<td  class="dot" >数量</td>
			<td  class="dot" >规格</td>
			<td  class="dot" >编号</td>
		</tr>
		<%
		    ticket_i=1
		    do while not rs_give.eof
		   
		 %>
		 <tr  align="center">
		    <td ><%=ticket_i %></td>
            <td   class="dot"  colspan ="2">新闻发布会门票</td>
            <td nowrap class="dot" >张</td>
            <td class="dot" ><%=rs_give("ticket_num")%></td>
            <td class="dot" >标准</td>
            <td class="dot"><%=rs_give("ticket_id")%></td>
		 </tr>
		 <%
		        rs_give.movenext
		        ticket_i=ticket_i+1
			    if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			set rs_give=nothing
		  %>
          <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
            <td height="30" class="shdz">下单人：<%=UserName%></td>
            <td align="right" nowrap class="shdz">收货人：<%=ReceiveName%></td>
            <td align="right" class="shdz">联系方式:</td>
            <td align="center" class="shdz"><%=UserTel%></td>
            <td align="right" class="shdz">胶带颜色:</td>
            <td align="center" class="shdz"><%=TapeColor%></td>
          </tr>
            <% if ReceiveMethod=25 then  %>
            <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
            <td height="30" class="shdz">拼单人:</td>
            <td height="30" class="shdz"><%=ReceiveName%></td>
            <td class="shdz" nowrap>拼单代理号：</td>
            <td colspan="5" align="left" class="shdz"><%=shouhuo_userid%></td>
          </tr>
            <% end if%>
            <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="5" class="shdz" >&nbsp;&nbsp;收货地址:<%=Province%><%=City%><%=County%><%=PostAddress%>
                <%if OrderType="代销订单" then %>
                <strong style="font-size :13px;">(非<%=fenxiao_type %>本地址)</strong>
                <%end if %>
                &nbsp;&nbsp;<%=shfs(ReceiveMethod) %>:&nbsp;<%=LogisticsCompany %></td>
                <td align="right" class="shdz">商品数量：</td>
                <td class="shdz"><%=PCount %></td>
          </tr>
           <%
		   '加上此2行的行高
			rows=rows+40*2
		   if Message>"" then 
		   %>
            <tr  >
			<!-- 此处&nbsp;不能使用一个，否则在打印出来的时候，后面的字显示不出来 -->
              <td height="40" colspan="7"  ><span class="shdz">&nbsp;&nbsp;&nbsp;&nbsp;备注:<%=Message%></span></td>
            </tr>
			<%
				'加上此行的行高
				rows=rows+40
			end If
			%>
            <tr  style="font-size:18px; text-align:center;" >
              <td >验货人：</td>
              <td height="30" >&nbsp;</td>
              <td height="30" >验货时间：</td>
              <td>&nbsp;</td>
              <td colspan="3">总箱数：共<span style="width:50px;"></span>件，清单在第<span style="width:30px;"></span>件</td>
            </tr>
</table>
<%end sub%>
</body>
</html>
