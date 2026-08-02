var flag;
var set_timer = setInterval(function(){
 checkConnection();
}, 10000);

function checkConnection() {	
    var networkState = navigator.connection.type;
    var states = {};
    states[Connection.UNKNOWN]  = 'Unknown connection';
    states[Connection.ETHERNET] = 'Ethernet connection';
    states[Connection.WIFI]     = 'WiFi connection';
    states[Connection.CELL_2G]  = 'Cell 2G connection';
    states[Connection.CELL_3G]  = 'Cell 3G connection';
    states[Connection.CELL_4G]  = 'Cell 4G connection';
    states[Connection.CELL]     = 'Cell generic connection';
    states[Connection.NONE]     = 'No network connection';

    if ((states[networkState]) == states[Connection.NONE])
	{
			nonet_toast();
	}
	else
	{
			redirect_page();	
	}
}
function nonet_toast(){
	flag = 0;
	window.plugins.toast.showWithOptions(
         {
            message: "No Internet Connection",
            duration: "1500", // which is 2000 ms. "long" is 4000. Or specify the nr of ms yourself.
            position: "bottom",
            addPixelsY: -40,  // added a negative value to move it up a bit (default 0)
			 styling: {
				 
			 }
         }
           );
	flag++;
	
}
function redirect_page(){
	if(flag==1)
	{
	window.plugins.toast.showWithOptions(
         {
            message: "Back Online",
            duration: "1500", // which is 2000 ms. "long" is 4000. Or specify the nr of ms yourself.
            position: "bottom",
            addPixelsY: -40,  // added a negative value to move it up a bit (default 0)
			styling: {
				backgroundColor: '#28cc19',
				textColor: '#fffefe', 
			 }
         }
           );
		location.reload();
	}
	flag++;
}
/*setInterval(function(){	
	$.ajax({
				url: "http://www.pbssd.gov.in/api/pbssd/pbssd_app_update",
				type : 'POST',
				data:{
				authuser:"16288adbe9a7cb4baeb0f0d8df7ba4bb",
				authpassword:"001b6d7734d59c236d8eef95842f254e",
	            device_uuid:device.uuid,
				version_no:"v1.0"				
				},
				dataType:"json",
				success : function(data) {
				if(data.app_status=="ok")
				{
				}
				if(data.app_status=="notok")				
				{
				alert(data.app_msg);
				//window.location.href = "http://164.100.161.30/homeinspection/app/update_apk.html";	
				}
				}
				});	
	
}, 9000);*/




