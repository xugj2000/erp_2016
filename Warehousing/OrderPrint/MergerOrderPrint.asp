<!--#include file="../conn.asp"-->
<!--#include file="../inc/TXM.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<%
''call GetPageUrlpower("OrderPrint/AgentMergerOrder.asp")'取得父级页面的所有权限

''call CheckPageEdit()'检查当前页面是否有页面读取权限
%>
<%

dim action,dingdans,username
Dim rows  '行高
action=request.QueryString("action")
dingdans=trim(request("dingdan"))
dingdans=replace(dingdans," ","")
rows=0
if dingdans="" or isnull(dingdans) then
	response.Write("<script>alert('你没有选择订单');window.close();</script>")
	response.End()
end if

PrintOk=request.form("PrintOk")
if cstr(PrintOk)=cstr(session("PrintOk")) then ''用form值与session值比较防刷新
	conn.execute(" exec AgentOrderPost '"&dingdans&"','"&session("trueName")&"',1 ")
	session("PrintOk")=""
else
response.write "..."
end if	
%>
<html>
<head><title>代理拼单打印</title>
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
<div class="only_print_view"><table width="1000" border="0" align="center" cellpadding="0">
  <tr>
    <td height="36"><input type="button" id="btnPrint" value="打印预览" onClick="OrderPreview()">&nbsp;
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
	if str_dingdan<>"" then
 	    sql="select IsFreightDelyPay,Group_Lable,fapiao_title,liushuihao,dingdan,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '商城订单' when xiaofeifangshi=1 then '调换货订单' when xiaofeifangshi=3 then '分销中心代下订单' when xiaofeifangshi=4 then '分销中心提货订单' end,dingdan_leixing=case when dingdan_type=3 then '升级订单' when dingdan_type=2 then '二次进货' else '注册订单' end, shouhuo_username,shouhuoname,username,userid,sale_userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(16),actiondate,120) as actiondate,shopxp_shfs,zhifufangshi,zhuangtai,liuyan,fapiao,convert(varchar(16),fapiao_date,120) as fapiao_date,fuwu_userid,fenxiao_userid,is_givecard,feiyong,TapeColor from order_agent_main where dingdan in ('"&str_dingdan&"') and shopxp_shfs=25 order by Group_Lable asc"
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,conn,1,1
		'response.Write sql
		do while not rs.EOF 
		PCount=0
		dd=trim(rs("dingdan"))
		liushuihao=rs("liushuihao")
		ename=rs("username")
		xiaofeifangshi=rs("xiaofeifangshi")
		dingdan_leixing=rs("dingdan_leixing")
		shopxp_shfs=rs("shopxp_shfs")
		dingdan_userid=rs("userid")
		fksj=rs("fksj")
		shopxp_shiname=rs("shopxp_shiname")
		shouhuoname=rs("shouhuoname")
		usertel=rs("usertel")
		province=rs("province")
		city=rs("city")
		xian=rs("xian")
		shopxp_shdz=rs("shopxp_shdz")
		sel_wuliugongshi=rs("sel_wuliugongshi")
		liuyan=rs("liuyan")
		
		fapiao_title=rs("fapiao_title")
		
		is_givecard=rs("is_givecard")
		feiyong=rs("feiyong")
		TapeColor=rs("TapeColor")
		select case is_givecard
		case "1"
			is_givecard="分销中心已发卡"
		case "2"
			is_givecard="升级订单已发卡"
		case else
			is_givecard="需要发卡"
		end select
		if shouhuoname="" or isnull(shouhuoname) then
			shouhuoname=trim(rs("shouhuoname"))
		end if
		  %>
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	<td valign="top" nowrap>
		  <table width="100%" border="1" cellpadding="0" cellspacing="1">
           
            <tr>
              <td width="19%" align="left" valign="top" nowrap height=52><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
              <td width="41%" align="center" valign="middle" nowrap><span class="fxpt">花的少，买的多！</span></td>
<td width="40%" align="center" nowrap class="bigtitle">电商网代理拼单&nbsp;&nbsp;<%=rs("Group_Lable") %></td>
            </tr>
             <tr>
              <td colspan="3" align="left" valign="top" nowrap  height=52><span style="width:50px;"></span><%=dragcode(haiwaocde(lcase(dd)))%></td>
            </tr>
          </table>
		 <%
		 rows=rows+110
		 %>
	    <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
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
          <td ><a href="javascript:;" onClick="javascript:window.open('../order_info/order_agent_view.asp?dan=<%=dd%>&shopxp_shfs=<%=shopxp_shfs%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(dd)%></a></td>
		  <td ><%=dingdan_userid%></td>
		  <td align="center"><%=dingdan_leixing%></td>
          <td ><%=xiaofeifangshi%></td>
          <td ><%=fksj%></td>
          <td ><%=shfs(shopxp_shfs)%></td>
		  
        </tr>
		 <%
		 rows=rows+25*2
		 %> 
        <tr >
			<td colspan="7" align="center">		  
		  		<table width="95%"   align="center" cellpadding="0" cellspacing="1" class="dot"  >
			<%
			 set rs_c=server.CreateObject("adodb.recordset")
			  rs_c.open "select distinct(Storage_name) from order_agent_prodetail where dingdan='"&dd&"' and userid='"&dingdan_userid&"' ",conn
			  if not rs_c.eof and not rs_c.bof then
			  	maxc=rs_c.recordcount
			  end if
			  rs_c.close
			  set rs_c=nothing
			  
		  	set rs_p=server.CreateObject("adodb.recordset")
			sql="select shopxpptid,productdanwei,shopxpptname,shopxp_yangshiid,huojiahao,other_info,zonger,bochu,productcount,danjia,p_size,StorageSortId,Storage_name,txm from order_agent_prodetail  where dingdan='"&dd&"' and userid='"&dingdan_userid&"' order by StorageSortId asc,huojiahao asc,shopxpptname asc" 
			rs_p.open sql,conn
			if not rs_p.eof then
				 
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
			<tr align="center">
			<td colspan="7" align="left" height="30" style="padding-bottom:12px;" class="dot" >
				<span style="width:100%; border-bottom:1px dashed #CCCCCC;"></span>
			</td>
			</tr>
			<tr align="center">
				<td colspan="7" style='padding-left:30px; height:25px;' align="left"  class="dot" ><span style="float:left;"><b><%=Storage_name%></b> -- <%=dd%> -- <%=dingdan_userid%> -- 收货人：<%=shouhuoname%> --  <%=maxc&"-"&n%></span><%if Storage_name="洗化区" then %><span style="padding-right:120px; text-align:right;float:right;">A11-A20配货人：</span><br/><span style="padding-right:120px; text-align:right;float:right;">A01-A10配货人：</span><%else%><span style="padding-right:150px; text-align:right;float:right;">配货人：</span><%end if%></td>
			  </tr>

			   <%
			 rows=rows+30*2
			 %>
			    <tr align="center">
					<td width="7%" class="dot" height=25>序号</td>
					<td width="22%" class="dot" >商品名称</td>
					<td width="20%" class="dot" >商品规格</td>
					<td width="13%" class="dot" >TXM</td>
					<td width="13%" class="dot" >订购数量</td>
					<td width="10%" class="dot" >商品单位</td>
					<td width="15%" class="dot" >商品编号</td>
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
			<td nowrap style='padding-left:5px;' align="left" class="dot" ><%=rs_p("huojiahao")%>.<%=trim(rs_p("shopxpptname"))%></td>
			<td align="left" style="padding-left:5px;" class="dot" >
				<%=rs_p("p_size")%>
				<span style="padding-left:5px;">
			  	<% if not isnull(rs_p("other_info")) and rs_p("other_info")<>"" then response.Write "-- "&rs_p("other_info"):rows=rows+25  end if%>
				</span>
			</td>
			<td class="dot" ><%=rs_p("txm") %></td>
			<td class="dot" ><%=rs_p("productcount")%></td>
			<td nowrap  class="dot" ><%=rs_p("productdanwei")%></td>
			<td nowrap class="dot" ><%=rs_p("shopxpptid")%></td>
		  </tr>
		  <%
			 
			zongji=rs_p("zonger")+zongji
			bochu=rs_p("bochu")+bochu
			i=i+1
			rows=rows+25
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
    		<td colspan="7" style='padding-left:30px; height:25px;' align="left" class="dot" ><span style="float:left;"><strong>赠品区</strong> -- <%=dd%> -- <%=dingdan_userid%> -- 收货人：<%=shouhuoname%></span><span style="padding-right:150px; text-align:right;float:right;">配货人：</span></td>
  		</tr>
  		<tr align="center">
			<td width="25%" colspan="2" height=25  class="dot" >赠品名称</td>
			<td width="20%" class="dot" >赠品规格</td>
			<td width="16%" class="dot" >TXM</td>
			<td width="13%" class="dot" >赠品数量</td>
			<td width="10%" nowrap class="dot" >赠品单位</td>
			<td width="16%" nowrap class="dot" >赠品编号</td>
		</tr>

		<%
			rows=rows+80
  			do while not rs_give.eof
  		%>
  		<tr align="center">
			<td nowrap style='padding-left:5px;' align="left" colspan="2" class="dot" ><%=rs_give("huojiahao")%>.<%=trim(rs_give("shopxpptname"))%></td>
			<td align="left" style="padding-left:5px;" class="dot" >
				<%=rs_give("p_size")%>
				<span style="padding-left:5px;">
		  		<%if not isnull(rs_give("other_info")) and rs_give("other_info")<>"" then response.Write "-- "&rs_give("other_info"):rows=rows+25  end if %>
				</span>
			</td>
			<td class="dot" ><%=rs_give("txm") %></td>
			<td class="dot" ><%=rs_give("productcount")%></td>
			<td nowrap class="dot" ><%=rs_give("productdanwei")%></td>
			<td nowrap class="dot" ><%=rs_give("shopxpptid")%></td>
		</tr>
	  	<%
			rows=rows+25
			PCount=PCount+rs_give("productcount")
			rs_give.movenext
			if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			'set rs_give=nothing
	  	%>
  		<tr>
    		<td colspan="7" height=25 align=right>订单总额：<%=zongji%>元<%
				    if rs("IsFreightDelyPay")=1 then
				        response.Write ""
				    else
				        response.Write "＋费用："&feiyong&"元"
				    end if
				 %></td>
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
            rs_give.open "select ticket_id,ticket_num,userid,recevie_id from Ticket_Order where dingdan='"&dd&"'",conn
			if not(rs_give.eof and rs_give.bof) then
         %>
        <tr align="center">
    		<td colspan="6" style='padding-left:30px; height:25px;' align="left" class="dot" ><span style="float:left;"><strong>门票区</strong></span><span style="padding-right:150px; text-align:right;float:right;">配货人：</span></td>
  		</tr>
  		<tr align="center">
  		    <td width="25%"  height=25  class="dot" >序号</td>
			<td width="25%"  height=25  class="dot" >商品名称</td>
			<td width="10%" nowrap class="dot" >商品单位</td>
			<td width="13%" class="dot" >订购数量</td>
			<td width="13%" class="dot" >规格</td>
			<td width="13%" class="dot" >门票编号</td>
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
		        rs_give.movenext
		        ticket_i=ticket_i+1
			    if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			set rs_give=nothing
		  %>
		<% if liuyan<>"" then %>
		<tr >
          <td height="40" colspan="7" class="shdz">&nbsp;&nbsp;留言：<%=liuyan%>
		  </td>
		</tr>
		<%
			rows=rows+40
			end if
			if dingdan_leixing="注册订单" then
		%>
        <tr >
          <td height="40" colspan="5" class="shdz">&nbsp;&nbsp;备注：<%
		  	response.write is_givecard&"  总广告费："&bochu
		   	if bochu>=3000 then response.write "  开授权书"
		  %>
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
		<%
			rows=rows+40
			end if
		%>
		<tr >
          <td height="40" colspan="7" class="shdz">&nbsp;&nbsp;下单人姓名:<%=trim(shopxp_shiname)%>&nbsp;
              <%if not isnull(dingdan_userid) and dingdan_userid<>0 then%>
              服务店：
              <%

			  sql="select did,username from tiaoxingma.dbo.e_user where userid='"&dingdan_userid&"'"
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
		</tr>
        <tr  align="center">
          <td height="40" class="shdz"  >收货人:</td>
		  <td height="40" class="shdz" colspan="1"><%=trim(shouhuoname)%></td>
          <td class="shdz">联系方式:</td>
          <td class="shdz" colspan="2"><%=trim(usertel)%></td>
          <td colspan="2" class="shdz" align="left">&nbsp;&nbsp;<%if fapiao="1" and fapiao_title<>"" then response.write "发票抬头:"&fapiao_title%></td>
		</tr>
        <tr >
          <td height="40" colspan="7" class="shdz" >&nbsp;&nbsp;收货地址:<%=trim(province)%><%=trim(city)%><%=trim(xian)%><%=trim(shopxp_shdz)%></td>
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
</body>
</html>