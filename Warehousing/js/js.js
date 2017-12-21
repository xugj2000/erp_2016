function CheckAll(form)  {
	for (var i=0;i<form.elements.length;i++)
	{
		var e = form.elements[i];
		if (e.name != 'chkall'&&e.type=="checkbox")
		{
			e.checked = form.chkall.checked;
		}
	}
}

//获得CheckBox的值,多个为逗号隔开字串

function getCheckBoxValues(name){ 
var values = ""; 
var cbs = document.getElementsByName(name); 
var i;   
if (null == cbs) return values;   
if (null == cbs.length){ 
  if(cbs.checked) { 
  values = cbs.value; 
  } 
  return values; 
}     
var count = 0 ;  
for(i = 0; i<cbs.length; i++){ 
if(cbs[i].checked){ 
values=values==""? cbs[i].value:values+","+cbs[i].value; 
} 
} 
return values; 
} 


function openWin(src,w,h){
	var l,t
	l=(screen.width-w)/2
	t=(screen.height-h)/2
	window.open(src,'newwindow','height='+h+',width='+w+',top='+t+',left='+l+',toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
}
