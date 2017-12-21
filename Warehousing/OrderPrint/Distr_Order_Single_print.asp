<!--#include file="../conn.asp"-->
<!--#include file="../inc/TXM.asp"-->
<!--#include file="../Inc/commonfunction.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<%
''call GetPageUrlpower("fenxiao/fenxiao_dingdan_yifahuo.asp")'取得父级页面的所有权限

''call CheckPageRead()'检查当前页面是否有页面读取权限
%>
<%
Dim dingdan
Dim rows	'打印区域的行高
rows=0
dingdan=trim(request("dingdan"))

if dingdan="" or isnull(dingdan) then
	response.Write("<script>alert('你没有选择订单');window.close();</script>")
	response.End()
end if
 
%>
<html>
<head>
<title>分销中心普通订单打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
 

<style type="text/css" id="print"> 
td
{
font-size:12px;
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
<div class="only_print_view">

<table width="1000" border="0" align="center" cellpadding="5">
  <tr>
    <td><input type="button" id="btnPrint" value="打印预览" onClick="OrderPreview()">
<input type="button"  value="直接打印" onClick="OrderPrint()"  id="directPrint"></td>
  </tr>
</table>
</div>


<!-- lodop打印区域开始#################################################################### -->

<div id="view" style="width:100%;">
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top" nowrap>
		<%
	set rss=server.CreateObject("adodb.recordset")
	sqls="select liushuihao,dingdan,province,city,xian,fenxiao_type,dingdan_leixing=case when dingdan_type=1 then '首批进货' else '二次补货'end, shouhuoname,username,userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(10),actiondate,120) as actiondate,shopxp_shfs,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,zhifufangshi,zhuangtai,liuyan,feiyong,tapecolor,IsFreightDelyPay,wuliu_id from Order_Distribution_Main where dingdan ='"&dingdan&"'"
	rss.open sqls,conn  
	
	if rss.eof And rss.bof then
		Response.Write "<p align='center' class='contents'> 对不起，您选择的状态目前还没有订单！</p>"
	else
		dd=trim(rss("dingdan"))
		liushuihao=rss("liushuihao")
		ename=rss("username")
		shouhuoname=rss("shouhuoname")
		userids=rss("userid")
		dingdan_leixing=rss("dingdan_leixing")
		shopxp_shfs=rss("shopxp_shfs")
		dingdan_userid=rss("userid")
		fksj=rss("fksj")
		shopxp_shiname=rss("shopxp_shiname")
		usertel=rss("usertel")
		province=rss("province")
		city=rss("city")
		xian=rss("xian")
		shopxp_shdz=rss("shopxp_shdz")
		liuyan=rss("liuyan")
		feiyong=rss("feiyong")
		fenxiao_type=rss("fenxiao_type")
		tapecolor=rss("tapecolor")
		sel_wuliugongshi=rss("sel_wuliugongshi")
		
		select case fenxiao_type
		case "3"
			fenxiao_type="社区服务店"
		case else
			fenxiao_type="分销中心"
		end select
		%>
          <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" height=110>
            <tr >
              <td width="19%" align="left" valign="top" nowrap><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
              <td width="20%" align="center" valign="middle" nowrap><span class="fxpt">中华生活网－服务天下人！ <br>
                全球最大的生活用品分销平台！<br>
                http://www.369518.com</span></td>
              <td width="40%" align="center" nowrap ><span class="bigtitle">中华生活网分销中心订单</span></td>
            </tr>
            <tr >
              <td colspan="3" align="left" valign="top" nowrap><span style="width:50px;"></span><%=dragcode(haiwaocde(lcase(dd)))%></td>
            </tr>
          </table>

		  <%
			'设置上面总行数的行高为110px
			rows=rows+110
		  %>
          <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" >
            <tr bgcolor="#CECFCE" height=25>
              <td width="15%" align="center" nowrap >流水号</td>
              <td width="18%" align="center" nowrap>订单号</td>
              <td width="13%" align="center" nowrap>下单ID</td>
              <td width="13%" align="center" nowrap>付款时间</td>
              <td width="13%" align="center" nowrap>收货方式</td>
              <td width="14%" align="center" nowrap>进货身份</td>
              <td width="14%" align="center" nowrap>进货类型</td>
            </tr>
            <tr  height=25>
              <td align="center" nowrap id="liushuihao_<%=trim(dd)%>"><%=liushuihao%></td>
              <td align="center"><a href="javascript:;" onClick="javascript:window.open('fenxiao_viewdingdan_new.asp?dan=<%=dd%>&shouhuoname=<%=shouhuoname%>&ename=<%=username%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=dd%></a></td>
              <td align="center"><%=userids%></td>
              <td align="center"><%=fksj%></td>
              <td align="center"><%=shfs(shopxp_shfs)%></td>
              <td align="center"><%=fenxiao_type%></td>
              <td align="center"><%=dingdan_leixing%></td>
            </tr>
		 

		<%
		'设置上面行数的行高为50px
		rows=rows+50
		%>
            <tr  >
              <td colspan="7" align="center" id="heit">
			  	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0"   >
			  <%
			  set rs_c=server.CreateObject("adodb.recordset")
			  rs_c.open "select distinct(Storage_name) from Order_Distribution_ProDetail where dingdan='"&dd&"' ",conn,1,1
			  if not rs_c.eof and not rs_c.bof then
			  	maxc=rs_c.recordcount
			  end if
			  rs_c.close
			  set rs_c=nothing
		  	set rs_p=server.CreateObject("adodb.recordset")
			sql="select sa.shopxpptid,sa.productdanwei,sa.shopxpptname,sa.huojiahao,sa.other_info,sa.zonger,sa.productcount,sa.JiFen,sa.p_size as style,sa.StorageSortId,sa.Storage_name,sa.txm from Order_Distribution_ProDetail as sa  where sa.dingdan='"&dd&"' order by sa.StorageSortId asc,sa.huojiahao asc,sa.shopxpptname asc" 
			rs_p.open sql,conn,1,1
			if not rs_p.eof then
				zongpv=0
				zongji=0
				bochu=0
				i=1
				n=1
				b=""
				AllScore=0 ''总积分
				do while not rs_p.eof
				AllScore=AllScore+rs_p("JiFen")*rs_p("productcount")
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
			<tr  align="center" height=25 >
				<td colspan="7" style='padding-left:30px; height:25px;' align="left" nowrap><span style="float:left;"><b><%=Storage_name%></b> -- <%=dd%>  -- <%=userids%> -- 收货人：<%=shouhuoname%>  --  <%=maxc&"-"&n%></span><%if Storage_name="洗化区" then %><span style=" text-align:right;float:left;"><span style="width:40px;"></span>A11-A20配货人：<span style="width:40px;"></span></span><span style=" text-align:right;float:left;">A01-A10配货人：<span style="width:40px;"></span></span><%else%><span style="text-align:right;float:left;">配货人：<span style="width:40px;"></span></span><%end if%></td>
			  </tr>
			    <tr align="center"  height=25>
					<td width="85">序号</td>
					<td width="338">商品名称</td>
					<td width="270">商品规格</td>
					<td width="151">订购数量</td>
					<td width="67" nowrap>单位</td>
					 <td  nowrap  class="dot" width="108">TXM</td>
					<td width="79" nowrap>商品编号</td>
				  </tr>
			<%
				'加上此2行的行高
				rows=rows+25*2
				b=StorageSortId
				i=1
				n=n+1
			end if
			%>
		  <tr  align="center" height=25>
		  	<td><%=i%></td>
			<td nowrap style='padding-left:5px;' align="left"><%=rs_p("huojiahao")%>.<%=trim(rs_p("shopxpptname"))%></td>
			<td align="left" style="padding-left:5px;">
				<%=rs_p("style")%>
				<span style="padding-left:5px;">
			  	<% if not isnull(rs_p("other_info")) and rs_p("other_info")<>"" then response.Write "-- "&rs_p("other_info"):rows=rows+25  end if%>
				</span>
			</td>
			<td><%=rs_p("productcount")%></td>
			<td nowrap><%=rs_p("productdanwei")%></td>
			<td><%=rs_p("txm")%></td>
			<td nowrap><%=rs_p("shopxpptid")%></td>
		  </tr>
		  <%
			zongji=rs_p("zonger")+zongji
			i=i+1
			'加上此行的行高
			rows=rows+26
			rs_p.movenext
			Loop
			


			set rs_give=server.CreateObject("adodb.recordset")
			rs_give.open "select shopxpptid,huojiahao,shopxpptname,productdanwei,productcount,p_size,other_info,shopxp_yangshiid,txm from Order_present_distribution where dingdan='"&dd&"' order by shopxpptname desc",conn,1,1
			if not(rs_give.eof and rs_give.bof) then
		%>
		<tr align="center"  height=25>
    		<td colspan="7" style='padding-left:30px; height:25px;' align="left"><span style="float:left;"><strong>赠品</strong> -- <%=dd%>  --  <%=userids%> -- 收货人：<%=shouhuoname%></span><span style="padding-right:150px; text-align:right;float:right;">配货人：</span></td>
  		</tr>
		<%
			'加上此行的行高
			rows=rows+30
		%>
  		<tr align="center"  height=25>
			<td colspan="2" >赠品名称</td>
			<td width="270">赠品规格</td>
			<td width="151">赠送数量</td>
			<td width="67" nowrap>单位</td>
			<td >TXM</td>
			<td width="79" nowrap>赠品编号</td>
		</tr>
		<%
			'加上此行的行高
			rows=rows+25
  			do while not rs_give.eof
				danwei=rs_give("productdanwei")
				if danwei="" or isnull(danwei) then
					danwei="<font color='#FFFFFF'>&nbsp;</font>"
				end if
  		%>
  		<tr  align="center" height=25>
			<td nowrap style='padding-left:5px;' align="left" colspan="2"><%=rs_give("huojiahao")%>.<%=trim(rs_give("shopxpptname"))%></td>
			<td align="left" style="padding-left:5px;">
				<%=rs_give("p_size")%>
				<span style="padding-left:5px;">
		  		<%if not isnull(rs_give("other_info")) and rs_give("other_info")<>"" then response.Write "-- "&rs_give("other_info"):rows=rows+25  end if %>
				</span>
			</td>
			<td><%=rs_give("productcount")%></td>
			<td nowrap><%=danwei%></td>
			<td><%=rs_give("txm")%></td>
			<td nowrap><%=rs_give("shopxpptid")%></td>
		</tr>
	  	<%
			'加上此行的行高
			rows=rows+25
			rs_give.movenext
			if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			set rs_give=nothing
	  	%>
  		<tr  height=25>
    		<td colspan="7"><div align="right">订单总额：<%=zongji%>元<%if AllScore>0 then response.write ",积分："&AllScore%> ,费用：<%=feiyong%>元　</div></td>
  		</tr>
		<%
			'加上此行的行高
			rows=rows+25
			end if
			rs_p.close
			set rs_p=nothing
 		%>
                </table>
			  </td>
            </tr>
            <tr   style="font-size:18px; text-align:center;" height=35>
              <td   class="shdz">收货人：</td>
			  <td class="shdz"><%=shouhuoname%></td>
			  <td class="shdz">联系方式：</td>
              <td colspan="2" align="left" class="shdz"><%=usertel%></td>
			  <td class="shdz">胶带颜色：</td>
			  <td class="shdz"><%=tapecolor%></td>
            </tr>
			<%
			'加上此行的行高
			rows=rows+35
			if liuyan<>"" then 
			%>
            <tr  >
              <td  height="30" colspan="7"  >
			   
			  <!-- 此处&nbsp;不能使用一个，否则在打印出来的时候，后面的字显示不出来 -->
			  <span class="shdz">&nbsp;&nbsp;备注:<%=liuyan%></span>
			  </td>
            </tr>
			<%
			'加上此行的行高
			rows=rows+35
			end If
			%>
            <tr>
              <td height="30" colspan="7"  ><span class="shdz">&nbsp;&nbsp;收货地址：<%=province%><%=city%><%=xian%><%=shopxp_shdz%>&nbsp;&nbsp;<%=shfs(shopxp_shfs) %>:&nbsp;<%=sel_wuliugongshi%>
			  
			  <%if rss("wuliu_id")<>"0" then response.write GetFieldValue(conn,"wuliu_gongshi","wuliu_name","id="&rss("wuliu_id")) %>
			  <%if rss("IsFreightDelyPay")<>0 then
                    response.Write "&nbsp;运费付款方式：<font color='red'>到付</font>"
                end if
             %></span></td>
            </tr>
            <tr  style="font-size:18px; text-align:center;" height=35>
              <td >验货人：</td>
              <td height="30" >&nbsp;</td>
              <td height="30" >验货时间：</td>
              <td height="30" >&nbsp;</td>
              <td colspan="3">总箱数：共<span style="width:50px;"></span>件，清单在第<span style="width:30px;"></span>件</td>
            </tr>
          </table> 
          <div align=right><span class="urlcss">产品售后：0371－66236936  感谢您的支持！</span> </div>
          <% 
			'加上此2行的行高
			rows=rows+35*6
			end if
			rss.close
			set rss=nothing
		%>
        </td>
      </tr>
  </table>
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
		//var iPageHigh=document.getElementById("view").offsetHeight; 
		var iPageHigh=<%=rows%>;   
		iPageHighs=iPageHigh/96*254;//折算成毫米(单位0.1mm) (这里px是绝对值长度单位：96px/in)
		LODOP.PRINT_INIT("分销订单已发货"); 
		//alert(iPageHighs);
		LODOP.SET_PRINT_PAGESIZE(1,2300,iPageHighs,"");
		LODOP.ADD_PRINT_HTM(0,0,750,iPageHigh,strFormHtml); 
		LODOP.SET_PRINT_STYLEA(1,"Horient",2);

		
	};
	 
</script>
</body>
</html>
