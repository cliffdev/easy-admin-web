
function sayHello(){
	//alert('hello world');
	openUrl('index.html');
}
function openUrl(url){
	$('#win').window({    
	    width:600,    
	    height:400, 
	    href:url,
	    modal:true   
	});  
}