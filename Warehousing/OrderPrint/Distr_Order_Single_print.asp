<!--#include file="../conn.asp"-->
<!--#include file="../inc/TXM.asp"-->
<!--#include file="../Inc/commonfunction.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<%
''call GetPageUrlpower("fenxiao/fenxiao_dingdan_yifahuo.asp")'ȡ�ø���ҳ�������Ȩ��

''call CheckPageRead()'��鵱ǰҳ���Ƿ���ҳ���ȡȨ��
%>
<%
Dim dingdan
Dim rows	'��ӡ������и�
rows=0
dingdan=trim(request("dingdan"))

if dingdan="" or isnull(dingdan) then
	response.Write("<script>alert('��û��ѡ�񶩵�');window.close();</script>")
	response.End()
end if
 
%>
<html>
<head>
<title>����������ͨ������ӡ</title>
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
	var LODOP=document.getElementById("LODOP");//���������Ϊ�˷���DTD�淶
	CheckLodop();
</script>
<div class="only_print_view">

<table width="1000" border="0" align="center" cellpadding="5">
  <tr>
    <td><input type="button" id="btnPrint" value="��ӡԤ��" onClick="OrderPreview()">
<input type="button"  value="ֱ�Ӵ�ӡ" onClick="OrderPrint()"  id="directPrint"></td>
  </tr>
</table>
</div>


<!-- lodop��ӡ����ʼ#################################################################### -->

<div id="view" style="width:100%;">
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top" nowrap>
		<%
	set rss=server.CreateObject("adodb.recordset")
	sqls="select liushuihao,dingdan,province,city,xian,fenxiao_type,dingdan_leixing=case when dingdan_type=1 then '��������' else '���β���'end, shouhuoname,username,userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(10),actiondate,120) as actiondate,shopxp_shfs,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,zhifufangshi,zhuangtai,liuyan,feiyong,tapecolor,IsFreightDelyPay,wuliu_id from Order_Distribution_Main where dingdan ='"&dingdan&"'"
	rss.open sqls,conn  
	
	if rss.eof And rss.bof then
		Response.Write "<p align='center' class='contents'> �Բ�����ѡ���״̬Ŀǰ��û�ж�����</p>"
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
			fenxiao_type="���������"
		case else
			fenxiao_type="��������"
		end select
		%>
          <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" height=110>
            <tr >
              <td width="19%" align="left" valign="top" nowrap><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
              <td width="20%" align="center" valign="middle" nowrap><span class="fxpt">�л������������������ˣ� <br>
                ȫ������������Ʒ����ƽ̨��<br>
                http://www.369518.com</span></td>
              <td width="40%" align="center" nowrap ><span class="bigtitle">�л��������������Ķ���</span></td>
            </tr>
            <tr >
              <td colspan="3" align="left" valign="top" nowrap><span style="width:50px;"></span><%=dragcode(haiwaocde(lcase(dd)))%></td>
            </tr>
          </table>

		  <%
			'�����������������и�Ϊ110px
			rows=rows+110
		  %>
          <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" >
            <tr bgcolor="#CECFCE" height=25>
              <td width="15%" align="center" nowrap >��ˮ��</td>
              <td width="18%" align="center" nowrap>������</td>
              <td width="13%" align="center" nowrap>�µ�ID</td>
              <td width="13%" align="center" nowrap>����ʱ��</td>
              <td width="13%" align="center" nowrap>�ջ���ʽ</td>
              <td width="14%" align="center" nowrap>�������</td>
              <td width="14%" align="center" nowrap>��������</td>
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
		'���������������и�Ϊ50px
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
				AllScore=0 ''�ܻ���
				do while not rs_p.eof
				AllScore=AllScore+rs_p("JiFen")*rs_p("productcount")
					if rs_p("StorageSortId")="" or isnull(rs_p("StorageSortId")) then
						StorageSortId=0
					else
						StorageSortId=rs_p("StorageSortId")
					end if
					if rs_p("Storage_name")="" or isnull(rs_p("Storage_name")) then
						Storage_name="δ����"
					else
						Storage_name=trim(rs_p("Storage_name"))
					end if
					if b<>StorageSortId then
			%>
			<tr  align="center" height=25 >
				<td colspan="7" style='padding-left:30px; height:25px;' align="left" nowrap><span style="float:left;"><b><%=Storage_name%></b> -- <%=dd%>  -- <%=userids%> -- �ջ��ˣ�<%=shouhuoname%>  --  <%=maxc&"-"&n%></span><%if Storage_name="ϴ����" then %><span style=" text-align:right;float:left;"><span style="width:40px;"></span>A11-A20����ˣ�<span style="width:40px;"></span></span><span style=" text-align:right;float:left;">A01-A10����ˣ�<span style="width:40px;"></span></span><%else%><span style="text-align:right;float:left;">����ˣ�<span style="width:40px;"></span></span><%end if%></td>
			  </tr>
			    <tr align="center"  height=25>
					<td width="85">���</td>
					<td width="338">��Ʒ����</td>
					<td width="270">��Ʒ���</td>
					<td width="151">��������</td>
					<td width="67" nowrap>��λ</td>
					 <td  nowrap  class="dot" width="108">TXM</td>
					<td width="79" nowrap>��Ʒ���</td>
				  </tr>
			<%
				'���ϴ�2�е��и�
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
			'���ϴ��е��и�
			rows=rows+26
			rs_p.movenext
			Loop
			


			set rs_give=server.CreateObject("adodb.recordset")
			rs_give.open "select shopxpptid,huojiahao,shopxpptname,productdanwei,productcount,p_size,other_info,shopxp_yangshiid,txm from Order_present_distribution where dingdan='"&dd&"' order by shopxpptname desc",conn,1,1
			if not(rs_give.eof and rs_give.bof) then
		%>
		<tr align="center"  height=25>
    		<td colspan="7" style='padding-left:30px; height:25px;' align="left"><span style="float:left;"><strong>��Ʒ</strong> -- <%=dd%>  --  <%=userids%> -- �ջ��ˣ�<%=shouhuoname%></span><span style="padding-right:150px; text-align:right;float:right;">����ˣ�</span></td>
  		</tr>
		<%
			'���ϴ��е��и�
			rows=rows+30
		%>
  		<tr align="center"  height=25>
			<td colspan="2" >��Ʒ����</td>
			<td width="270">��Ʒ���</td>
			<td width="151">��������</td>
			<td width="67" nowrap>��λ</td>
			<td >TXM</td>
			<td width="79" nowrap>��Ʒ���</td>
		</tr>
		<%
			'���ϴ��е��и�
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
			'���ϴ��е��и�
			rows=rows+25
			rs_give.movenext
			if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			set rs_give=nothing
	  	%>
  		<tr  height=25>
    		<td colspan="7"><div align="right">�����ܶ<%=zongji%>Ԫ<%if AllScore>0 then response.write ",���֣�"&AllScore%> ,���ã�<%=feiyong%>Ԫ��</div></td>
  		</tr>
		<%
			'���ϴ��е��и�
			rows=rows+25
			end if
			rs_p.close
			set rs_p=nothing
 		%>
                </table>
			  </td>
            </tr>
            <tr   style="font-size:18px; text-align:center;" height=35>
              <td   class="shdz">�ջ��ˣ�</td>
			  <td class="shdz"><%=shouhuoname%></td>
			  <td class="shdz">��ϵ��ʽ��</td>
              <td colspan="2" align="left" class="shdz"><%=usertel%></td>
			  <td class="shdz">������ɫ��</td>
			  <td class="shdz"><%=tapecolor%></td>
            </tr>
			<%
			'���ϴ��е��и�
			rows=rows+35
			if liuyan<>"" then 
			%>
            <tr  >
              <td  height="30" colspan="7"  >
			   
			  <!-- �˴�&nbsp;����ʹ��һ���������ڴ�ӡ������ʱ�򣬺��������ʾ������ -->
			  <span class="shdz">&nbsp;&nbsp;��ע:<%=liuyan%></span>
			  </td>
            </tr>
			<%
			'���ϴ��е��и�
			rows=rows+35
			end If
			%>
            <tr>
              <td height="30" colspan="7"  ><span class="shdz">&nbsp;&nbsp;�ջ���ַ��<%=province%><%=city%><%=xian%><%=shopxp_shdz%>&nbsp;&nbsp;<%=shfs(shopxp_shfs) %>:&nbsp;<%=sel_wuliugongshi%>
			  
			  <%if rss("wuliu_id")<>"0" then response.write GetFieldValue(conn,"wuliu_gongshi","wuliu_name","id="&rss("wuliu_id")) %>
			  <%if rss("IsFreightDelyPay")<>0 then
                    response.Write "&nbsp;�˷Ѹ��ʽ��<font color='red'>����</font>"
                end if
             %></span></td>
            </tr>
            <tr  style="font-size:18px; text-align:center;" height=35>
              <td >����ˣ�</td>
              <td height="30" >&nbsp;</td>
              <td height="30" >���ʱ�䣺</td>
              <td height="30" >&nbsp;</td>
              <td colspan="3">����������<span style="width:50px;"></span>�����嵥�ڵ�<span style="width:30px;"></span>��</td>
            </tr>
          </table> 
          <div align=right><span class="urlcss">��Ʒ�ۺ�0371��66236936  ��л����֧�֣�</span> </div>
          <% 
			'���ϴ�2�е��и�
			rows=rows+35*6
			end if
			rss.close
			set rss=nothing
		%>
        </td>
      </tr>
  </table>
</div>
  <!-- lodop��ӡ����ʼ#################################################################### -->


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
		iPageHighs=iPageHigh/96*254;//����ɺ���(��λ0.1mm) (����px�Ǿ���ֵ���ȵ�λ��96px/in)
		LODOP.PRINT_INIT("���������ѷ���"); 
		//alert(iPageHighs);
		LODOP.SET_PRINT_PAGESIZE(1,2300,iPageHighs,"");
		LODOP.ADD_PRINT_HTM(0,0,750,iPageHigh,strFormHtml); 
		LODOP.SET_PRINT_STYLEA(1,"Horient",2);

		
	};
	 
</script>
</body>
</html>
