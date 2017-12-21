		var j=-1;
		var temp_str;
		var inputField;
		var $=function(node){
			return document.getElementById(node);
		}
		var $$=function(node){
			return document.getElementsByTagName(node);
		}
		function ajax_keyword(){
			var xmlhttp;
			try{
				xmlhttp=new XMLHttpRequest();
				}
			catch(e){
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
			xmlhttp.onreadystatechange=function(){
			if (xmlhttp.readyState==4){
				if (xmlhttp.status==200){
					var data=xmlhttp.responseText;
					$("suggest").innerHTML=data;
					j=-1;
					}
				}
			}
			xmlhttp.open("post", "result.asp", true);
			xmlhttp.setRequestHeader('Content-type','application/x-www-form-urlencoded');
			xmlhttp.send("keyword="+escape($("keyword").value));
		}
		function keyupdeal(e){
			var keyc;
			if(window.event){
				keyc=e.keyCode;
				}
			else if(e.which){
				keyc=e.which;
				}
			if(keyc!=40 && keyc!=38){
				ajax_keyword();
				temp_str=$("keyword").value;
			}
			}

		function set_style(num){
			for(var i=0;i<$$("li").length;i++){
				var li_node=$$("li")[i];
				li_node.className="";
			}
			if(j>=0 && j<$$("li").length){
				var i_node=$$("li")[j];
				$$("li")[j].className="select";
				}
			}
		function mo(nodevalue){
			j=nodevalue;
			set_style(j);
			
		}
		
		function form_auto(){
			if(j>=0 && j<$$("li").length){
				$("keyword").value=$$("li")[j].childNodes[0].nodeValue;
				}
				$("keyword").focus();//选择后获取焦点
		}
		function hide_suggest(){
			var nodes=document.body.childNodes
			for(var i=0;i<nodes.length;i++){
				if(nodes[i]!=$("keyword")){
					$("suggest").innerHTML="";
					}
				}
			}
			
function keydowndeal(e){
			var keyc;
			if(window.event){
				keyc=e.keyCode;
				}
			else if(e.which){
				keyc=e.which;
				}
			if(keyc==40 || keyc==38){
			if(keyc==40){
				if(j<$$("li").length){
					j++;
					if(j>=$$("li").length){
						j=-1;
					}
				}
				if(j>=$$("li").length){
						j=-1;
					}
			}
			if(keyc==38){
				if(j>=0){
					j--;
					if(j<=-1){
						j=$$("li").length;
					}
				}
				else{
					j=$$("li").length-1;
				}
			}
			set_style(j);
			if(j>=0 && j<$$("li").length){
				$("keyword").value=$$("li")[j].childNodes[0].nodeValue;
				}
			else{
				$("keyword").value=temp_str;
				}
			}

		}