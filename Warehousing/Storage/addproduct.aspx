<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addproduct.aspx.cs" Inherits="Warehousing.Storage.addproduct" %>

<html><head><title>��Ա����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<script src="swfupload/swfupload.js" type="text/javascript" language="javascript"></script>
<script src="swfupload/upload.js" type="text/javascript" language="javascript"></script>

<style type="text/css">
.width6{height:30px;line-height:30px;border:solid 1px #CCC;border-bottom:solid 1px #666;width:95px;text-align:center}
.add_link{color:red;margin:4px;display:block}
.hide{display:none}
.delete_btn {display: block; float: left; margin-left: 5px; width: 10px; height: 10px; overflow: hidden; cursor: pointer; background: url(/images/ico.gif) 0 -634px; }
</style>
<script type="text/javascript">
     var swfu;
     $(function () {

         //alert("hi");

         $("#add_one").click(function () {
             var onerow;
             var lastrow;
             onerow = $("#oneline").html();
             //lastrow=$("#mytable").find('tr:last-child').html();
             $("#mytable").find('tr:last-child').after(onerow);
             $("#mytable").find('tr:last-child').find("input[name='p_txm']").focus();
         });
         $("#copy_one").click(function () {
             var lastrow;
             lastrow = " <tr align=\"center\">" + $("#mytable").find('tr:last-child').html() + "</tr>";
             $("#mytable").find('tr:last-child').after(lastrow);
             $("#mytable").find('tr:last-child').find('span').css("display", "block");
             $("#mytable").find('tr:last-child').find("input[name='pro_id']").val("0");
         });
         $(".delete_btn").click(function () {
             var lastrow;
             $(this).parent().parent().remove();
         });
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
                 Textpro_name: {
                     required: true
                 },
                 pro_supplierid: {
                     required: true
                 },
                 dd_type_id: {
                     required: true
                 },
                 Textpro_code: {
                     required: true
                 }
             },
             messages: {
                 Textpro_name: {
                     required: '��Ʒ���Ʋ���Ϊ��'
                 },
                 pro_supplierid: {
                     required: '��Ӧ�̲���Ϊ��'
                 },
                 dd_type_id: {
                     required: '��ѡ�����'
                 },
                 Textpro_code: {
                     required: '��Ʒ��Ų���Ϊ��'
                 }
             }
         });
         
         $("#Textpro_code").change(function () {
             var kw = $("#Textpro_code").val();
             if (kw == "") return;
             $.get("/Handler/checkCode.ashx?d=" + new Date().getTime(), { q: kw }, function (result) {
                 if (result != "0") {
                     if (confirm("ע�⣺�û��Ŷ�Ӧ��Ʒ�Ѵ��ڣ�����ǰ���鿴����Ʒ")) {
                         location.href = "ProductList.aspx?pro_code=" + kw;
                     }
                 }
             });
         });

         swfu = new SWFUpload({
             // ��������
             upload_url: "Upload.ashx?userid=&rnd=" + new Date().getTime(),
             post_params: {
                 "ASPSESSID": "<%=Session.SessionID %>"
             },

             // �ϴ��ļ�����
             file_size_limit: "100 MB",
             //file_types: "*.jpg;*.avi;*.rar;*.mp4",
             file_types: "*.jpg;*.gif",
             file_types_description: "֧���ϴ��ĸ�ʽ",
             file_upload_limit: "0",    // 0��ʾ������ѡ���ļ�������

             // �����¼�				
             file_queue_error_handler: fileQueueError,
             file_dialog_complete_handler: fileDialogComplete,
             upload_progress_handler: uploadProgress,
             upload_error_handler: uploadError,
             upload_success_handler: uploadSuccess,
             upload_complete_handler: uploadComplete,

             // ��ť����
             button_image_url: "images/upload_new.png",
             button_placeholder_id: "spanButtonPlaceholder",
             button_cursor: SWFUpload.CURSOR.HAND,
             button_width: 200,
             button_height: 42,
             //button_text: '<span class="button">ѡ���ļ� <span class="buttonSmall">(��� 100 MB)</span></span>',
             //button_text_style: '.button { font-family: ΢���ź�, sans-serif; font-size: 14pt; } .buttonSmall { font-size: 12pt; }',
             button_text_top_padding: 0,
             button_text_left_padding: 5,

             // Flash����
             flash_url: "swfupload/swfupload.swf",

             // �Ƿ������ԣ�true�ǣ�false��
             debug: false
         });
     });

    function txmInput(thisobj) {
        var kw = $(thisobj).val();
        if (kw == "") return;
        $.get("/Handler/getSkuByCode.ashx?d=" + new Date().getTime(), { q: kw }, function (result) {
            var obj = $(thisobj).parent().parent();
            if (result != "0") {
                var ss = result.split("\t");
                alert("�����Ӧ��Ʒ�Ѵ���");
            }
        });
    }
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
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  ��Ʒ���ƣ�</td>
              <td width="86%">
              <asp:TextBox ID="Textpro_name" runat="server" Width="238px" MaxLength=50></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  ��Ӧ�����ƣ�</td>
              <td width="86%">
                  <asp:DropDownList ID="pro_supplierid" runat="server">
                  <asp:ListItem Text="��ѡ��Ӧ��" Value=""></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td width="14%">
                  ��Ʒ���ࣺ</td>
              <td width="86%">
                  <asp:DropDownList ID="dd_type_id" runat="server">
                  <asp:ListItem Text="��ѡ�����" Value=""></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td>
                  ��Ʒ���ţ�</td>
              <td>
              <asp:TextBox ID="Textpro_code" runat="server" Width="238px" MaxLength=20></asp:TextBox>(Ҫ��һ��һ¼)
              </td>
          </tr>
          <tr>
              <td>
                  ����һ����</td>
              <td>
              <asp:TextBox ID="TextSpec_name_1" runat="server" Width="238px" MaxLength=20></asp:TextBox>(����ɫ\�����,������)
              </td>
          </tr>
          <tr>
              <td>
                  ���Զ�����</td>
              <td>
              <asp:TextBox ID="TextSpec_name_2" runat="server" Width="238px" MaxLength=20></asp:TextBox>(����ɫ\�����,������)
              </td>
          </tr>
          <tr>
              <td style="height:50px;">
                  ͼƬ��<asp:HiddenField ID="pro_image" runat="server" />
              </td>
              <td>
                  <asp:Image ID="pro_image_view" runat="server" Width="120" />
                      <div id="swfu_container" style="margin-top:5px;">
        <div>
        <span id="spanButtonPlaceholder"></span>
        </div>
        </div>
        <div id="mes"></div>
              </td>
          </tr>
          <tr>
              <td>
                  Ʒ�ƣ�</td>
              <td>
              <asp:DropDownList ID="Textpro_brand" runat="server">
                  <asp:ListItem Text="��ѡ��" Value=""></asp:ListItem>
               </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td>
                  ��λ��</td>
              <td>
              <asp:TextBox ID="Textpro_unit" runat="server" Width="238px" MaxLength=10></asp:TextBox>
              </td>
          </tr>
                    <tr>
              <td width="14%">
                  �Ƿ�������</td>
              <td width="86%">
                  ��<input type="radio" name="sys_del" value="1"<%if (sys_del=="1"){Response.Write(" checked");} %>/> &nbsp;&nbsp;��<input type="radio" name="sys_del" value="0"<%if (sys_del!="1"){Response.Write(" checked");} %>/></td>
          </tr>
                    <tr>
              <td colspan=2>
                  ��Ʒ�����ʽ (�������ڴ�д��ĸ������,��������ɴ��ո��-��)
<table width="100%" border="1" id="mytable" border=1>
  <tr>
    <td colspan="10" style="height:20px;">��Ʒ�嵥</td>
  </tr>
  <tr align="center">
    <td style="height:20px;">����</td>
    <td>����һ</td>
    <td>���Զ�</td>
    <td>�г���</td>
	<td>ֱӪ���ۼ�</td>
    <td>����������</td>
    <td>һ��������</td>
    <td>���˽����</td>
	<td>�ɹ���</td>
	<td style="width:30px;"></td>
  </tr>

  <%if (pm_id == 0)
    { %>
  <tr align="center">
    <td><input type=hidden name="pro_id" value='0' /><input name="pro_txm" type="text" class="text width6" onblur="txmInput(this);" value="" /></td>
    <td><input name="pro_spec" type="text" class="text width6" /></td>
    <td><input name="pro_model" type="text" class="text width6" /></td>
    <td><input name="pro_price" type="text" class="text width6" /></td>
	<td><input name="pro_marketprice" type="text" class="text width6" /></td>
    <td><input name="pro_outprice" type="text" class="text width6" /></td>
    <td><input name="pro_outprice_advanced" type="text" class="text width6" /></td>
	<td><input name="pro_settleprice" type="text" class="text width6" /></td>
    <td><input name="pro_inprice" type="text" class="text width6" /></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
  <%} %>
  		<asp:Repeater ID="ProModelList" runat="server">
                           <ItemTemplate>   
  <tr align="center">
    <td><input type=hidden name="pro_id" value='<%#Eval("pro_id")%>' /><input name="pro_txm" type="text" class="text width6"  value='<%#Eval("pro_txm")%>' /></td>
    <td><input name="pro_spec" type="text" class="text width6"  value='<%#Eval("pro_spec")%>' /></td>
    <td><input name="pro_model" type="text" class="text width6"  value='<%#Eval("pro_model")%>' /></td>
    <td><input name="pro_price" type="text" class="text width6"  value='<%#Eval("pro_price")%>' /></td>
    <td><input name="pro_marketprice" type="text" class="text width6"  value='<%#Eval("pro_marketprice")%>' /></td>
	<td><input name="pro_outprice" type="text" class="text width6"  value='<%#Eval("pro_outprice")%>' /></td>
    <td><input name="pro_outprice_advanced" type="text" class="text width6"  value='<%#Eval("pro_outprice_advanced")%>' /></td>
    
    <td><input name="pro_settleprice" type="text" class="text width6"  value='<%#Eval("pro_settleprice")%>' /></td>
	<td><input name="pro_inprice" type="text" class="text width6"  value='<%#Eval("pro_inprice")%>' /></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
            </ItemTemplate>
          </asp:Repeater>
</table>

<a href="javascript:;" id="add_one" style="color:red;margin:4px;font-size:16px;display:block">����µ���Ʒ</a>

<a href="javascript:;" id="copy_one" style="color:red;margin:4px;font-size:16px;display:block">�����Ͽ���Ʒ</a>
                  </td>
          </tr>
          <tr>
              <td class="style2">
              <asp:Button ID="Button2" runat="server" Text="" OnClientClick="return false;" style="width:1px;background:white;border:none"/>
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" �� �� " onclick="Button1_Click" />
                             <input type=hidden value="<%=fromUrl%>" name="fromUrl" />
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
				
<table style="display:none">
<tbody id="oneline">
  <tr align="center">
    <td><input type=hidden name="pro_id" value='0' /><input name="pro_txm" type="text" class="text width6" onblur="txmInput(this);" /></td>
    <td><input name="pro_spec" type="text" class="text width6" /></td>
    <td><input name="pro_model" type="text" class="text width6" /></td>
    <td><input name="pro_price" type="text" class="text width6" /></td>
    <td><input name="pro_marketprice" type="text" class="text width6" /></td>
	<td><input name="pro_outprice" type="text" class="text width6" /></td>
     <td><input name="pro_outprice_advanced" type="text" class="text width6" /></td>
    <td><input name="pro_settleprice" type="text" class="text width6" /></td>
	<td><input name="pro_inprice" type="text" class="text width6" /></td>
	<td><span class="delete_btn" onclick="$(this).parent().parent().remove();"></span></td>
  </tr>
</tbody></table>

</body>
</html>
