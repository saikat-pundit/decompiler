var db;
var latitude = 0;
var longitude = 0;
var SchoolCode = localStorage.getItem("School_Code");
var SchName = localStorage.getItem("School_Name");
var imageData;
var mobile = localStorage.getItem("profile_mobile_no");
var p_details;
var up_details;
var p_present;
var up_present;
var record;
var other_cause;
var mdmr;
var STOCKR;
var CookingCost;
var HONORARIUM;
var dailysms;
var DRINKWATER;
var TOILETS;
var HYGIENE;
var manpower;
var Committee;

let image = [];
var image1='';
var image2='';
var image3='';
var image4='';
var image5='';
var divid;

document.addEventListener("deviceready", onDeviceReady, false);
function onDeviceReady(){
	checkAvailability();
	//navigator.geolocation.getCurrentPosition(onSuccess, onError);
	db = window.sqlitePlugin.openDatabase({name:"MDMSupervisor.db", location: 'default'});

	db.transaction(function(tx) {
	//tx.executeSql('DROP TABLE IF EXISTS SupervisorInspectionForm;');   
   	tx.executeSql('CREATE TABLE IF NOT EXISTS SupervisorInspectionForm(inspection_id_f INTEGER PRIMARY KEY,state_code,supervisor_phone_no,district_code,district_name,circle_code,block_code,block_name,school_code,school_name,management,primary_details,upper_primary_details,primary_att,upper_primary_att,visiting_date,visiting_date_db,mdm_avail,not_running,not_running_cause,other_cause,drinking_water,toilet,manpower,committee,cooking_cost,honorarium,rice_stock,hygiene,daily_sms,remarks,latitude,longitude,enter_by_stake,image1,image2,image3,image4,image5)');
	}, function(error) {
	//alert("table not created");
	}, function() {
	//alert("table created successfully");
	});

	db.transaction(function(tx) {
	tx.executeSql('SELECT * FROM SupervisorInspectionForm WHERE Supervisor_Phone_No = ?',[mobile],
		function(tx,rs){
			//alert(rs.rows.length);
			record = rs.rows.length;
			//alert(record);
		},function(tx, error) {
	    	  alert('SELECT error: ' + error.message);
	   	});
	});

}

function checkAvailability(){
	cordova.plugins.diagnostic.isGpsLocationAvailable(function(available){
		console.log("GPS location is " + (available ? "available" : "not available"));
		if(!available){
			//gps=0;
			checkAuthorization();
		}else{
			//gps = 1;
			console.log("GPS location is ready to use");
			navigator.geolocation.getCurrentPosition(onSuccess, onError);
		}
	}, function(error){
		console.error("The following error occurred: "+error);
	});
}

function onSuccess(position){
	latitude = position.coords.latitude;
	longitude = position.coords.longitude;
}
function onError(error) {
		alert('code: '    + error.code    + '\n' +
				'message: ' + error.message + '\n');
}

function checkAuthorization(){
	cordova.plugins.diagnostic.isLocationAuthorized(function(authorized){
		console.log("Location is " + (authorized ? "authorized" : "unauthorized"));
		if(authorized){
			checkDeviceSetting();
		}else{
			cordova.plugins.diagnostic.requestLocationAuthorization(function(status){
				switch(status){
					case cordova.plugins.diagnostic.permissionStatus.GRANTED:
						console.log("Permission granted");
						checkDeviceSetting();
						break;
					case cordova.plugins.diagnostic.permissionStatus.DENIED:
						console.log("Permission denied");
						// User denied permission
						break;
					case cordova.plugins.diagnostic.permissionStatus.DENIED_ALWAYS:
						console.log("Permission permanently denied");
						// User denied permission permanently
						break;
				}
			}, function(error){
				console.error(error);
			});
		}
	}, function(error){
		console.error("The following error occurred: "+error);
	});
}

function checkDeviceSetting(){
	cordova.plugins.diagnostic.isGpsLocationEnabled(function(enabled){
		console.log("GPS location setting is " + (enabled ? "enabled" : "disabled"));
		if(!enabled){
			cordova.plugins.locationAccuracy.request(function (success){
				console.log("Successfully requested high accuracy location mode: "+success.message);
			}, function onRequestFailure(error){
				console.error("Accuracy request failed: error code="+error.code+"; error message="+error.message);
				if(error.code !== cordova.plugins.locationAccuracy.ERROR_USER_DISAGREED){
					if(confirm("Failed to automatically set Location Mode to 'High Accuracy'. Would you like to switch to the Location Settings page and do this manually?")){
						cordova.plugins.diagnostic.switchToLocationSettings();
					}
				}
			}, cordova.plugins.locationAccuracy.REQUEST_PRIORITY_HIGH_ACCURACY);
		}
	}, function(error){
		console.error("The following error occurred: "+error);
	});
}


/* function capturePhotoEdit(a) {
	 divid=a;
      navigator.camera.getPicture(onPhotoDataSuccess, onFail, { 
      	quality: 30, 
		allowEdit: false,
		targetWidth: 1024,
		targetHeight: 1024,
		destinationType: Camera.DestinationType.DATA_URL,
		enableHighAccuracy: true,
		encodingType: Camera.EncodingType.JPG,
		correctOrientation: true
	});
}
function onPhotoDataSuccess(imageData) {
			//alert(imageData);
			var Image = document.getElementById(divid);
			Image.style.display = 'block';
			//Image.src = "data:image/jpeg;base64," + imageData;
			Image.src = imageData;
}
function onFail(message) {
			alert('Failed because: ' + message);
} */


function capturePhoto(id){
	divid=id;

	var cameraOptions = {
        quality: 30, // Image quality (0-100)
        destinationType: Camera.DestinationType.FILE_URI,
        sourceType: Camera.PictureSourceType.PHOTOLIBRARY, // Open the device's camera
        encodingType: Camera.EncodingType.JPEG, // Image encoding type
        mediaType: Camera.MediaType.PICTURE, // Capture a picture
		targetWidth: 1024,
		targetHeight: 1024,
        allowEdit: false, // Allow editing after capture
        correctOrientation: true // Correct image orientation
    };

    navigator.camera.getPicture(onCameraSuccess, onCameraFail, cameraOptions);

	function onCameraSuccess(imageUri) {
		var elem = document.getElementById(divid);
		elem.src = imageUri;
	}

	function onCameraFail(message) {
		alert('Failed because: ' + message);
	}

}


function validate_supervisor(){
	p_details = (document.getElementById('primary').innerText==''?'0':document.getElementById('primary').innerText);
	up_details = (document.getElementById('upper_primary').innerText==''?'0':document.getElementById('upper_primary').innerText);

	if($("#mdm_running").is(":checked")){
		mdmr = 0;
	}
	else{
		mdmr = 1;
	}

	if ($('#StockR_check').is(":checked")){
		STOCKR = 0;
	}
	else{
		STOCKR = 1;
	}

	if ($('#cooking_cost').is(":checked")){
		CookingCost = 0;
	}
	else{
		CookingCost = 1;
	}
	
	if ($('#Honor_check').is(":checked")){
		HONORARIUM = 0;
	}
	else{
		HONORARIUM = 1;
	}
	
	if ($('#daily_sms').is(":checked")){
		dailysms = 0;
	}
	else{
		dailysms = 1;
	}
	
	if ($('#drinking_water').is(":checked")){
		DRINKWATER = 0;
	}
	else{
		DRINKWATER = 1;		
	}
	
	if ($('#toilet_urinal').is(":checked")){
		TOILETS = 0;
	}
	else{
		TOILETS = 1;
	}
	
	if ($('#proper_hygiene').is(":checked")){
		HYGIENE = 0;
	}
	else{
		HYGIENE = 1;
	}
	
	if ($('#man_power').is(":checked")){
		manpower = 0;
	}
	else{
		manpower = 1;
	}
	
	if ($('#mdm_committee').is(":checked")){
		Committee = 0;
	}
	else{
		Committee = 1;
	}
	//alert(local_date_db);
	//alert(local_date_new);
	/* if(local_date_db=='' || local_date_db==null || local_date_new=='' || local_date_new==null){
		alert("Visiting date not found. Please restart the App and try again.");
		return false;
	}
	else */ 
	if(mdmr == 1 && primary!='' && $("#primary_present").val()==''){
		alert("Please insert number of MDM takers for Primary students");
		$("#collapse3").collapse('show');
		$("#primary_present").focus();
		return false;
	}
	else if(mdmr == 1 && primary!='' && upper_primary=='' && $("#primary_present").val()==0){
		alert("Number of MDM takers for Primary students can not be 0");
		$("#collapse3").collapse('show');
		$("#primary_present").focus();
		return false;
	}
	else if(mdmr == 1 && upper_primary!='' && $("#upper_primary_present").val()==''){
		alert("Please insert number of MDM takers for Upper Primary students");
		$("#collapse3").collapse('show');
		$("#upper_primary_present").focus();
		return false;
	}
	else if(mdmr == 1 && primary=='' && upper_primary!='' && $("#upper_primary_present").val()==0){
		alert("Number of MDM takers for Upper Primary students can not be 0");
		$("#collapse3").collapse('show');
		$("#upper_primary_present").focus();
		return false;
	}
	else if(mdmr == 1 && primary!='' && upper_primary!='' && $("#primary_present").val()==0 && $("#upper_primary_present").val()==0){
		alert("Number of MDM takers for Primary & Upper Primary students both can not be 0, if MDM running.");
		$("#collapse3").collapse('show');
		$("#upper_primary_present").focus();
		return false;
	}
	else if(mdmr == 1 && $("#primary_present").val()>primary){
		alert("Number of MDM takers for Primary students can not be more than "+primary+".");
		$("#collapse3").collapse('show');
		$("#primary_present").focus();
		return false;
	}
	else if(mdmr == 1 && $("#upper_primary_present").val()>upper_primary){
		alert("Number of MDM takers for Upper Primary students can not be more than "+upper_primary+".");
		$("#collapse3").collapse('show');
		$("#upper_primary_present").focus();
		return false;
	}
	else if(mdmr == 0 && $("#not_running").val()==0){
		alert("Please select the MDM not running cause");
		return false;
	}
	else if (mdmr == 0 && $("#not_running").val()==6 && $("#other_cause").val()==''){
		alert("Please specify the other cause");
		$("#collapse3").collapse('show');
		$("#other_cause").focus();
		return false;
	}
	/*else if($("#cooking_cost").val()==''){
		alert("Missing Information");
		$("#collapse3").collapse('show');
		$("#cooking_cost").focus();
		return false;
	}*/
	else if($("#Remarks1").val() == ''){
		alert("Please provide Remarks");
		$("#collapse3").collapse('show');
		$("#Remarks1").focus();
		return false;
	}
	else if($("#Image1").attr('src')=='images/img-load.jpg' && $("#Image2").attr('src')=='images/img-load.jpg' && $("#Image3").attr('src')=='images/img-load.jpg' && $("#Image4").attr('src')=='images/img-load.jpg' && $("#Image5").attr('src')=='images/img-load.jpg')
	{
		alert("Please Capture atleast one image");
		$("#collapse4").collapse('show');
		return false;
		
	}
	else if(latitude== 0 || longitude == 0){
		alert("Please turn on the gps on your device");
		checkAvailability();
		return false;
	}
//////////////////////////////////////////////////////////////////////////////
	
	else{

		base64imageconversion();


	}

}

async function base64imageconversion(){
	for(i=1;i<=5;i++){
		try{
			var image_path=(document.getElementById('Image'+i).src);
			if(image_path!='images/img-load.jpg'){
				image[i]=await getFileContentAsBase64(image_path);
			}
			else{
				image[i]='';
			}
		}catch(error){
			console.error("Error reading file:", error);
		}
	}

	after_validation();
}

function getFileContentAsBase64(filePath) {
	return new Promise((resolve,reject)=>{
		window.resolveLocalFileSystemURL(filePath, function(fileEntry){
			fileEntry.file(function(file) {
				var reader = new FileReader();
				reader.onloadend = function(e) {
					var content = this.result;
					resolve(content); // The Base64 data URL
				};
				reader.onerror = function(e) {
					console.error("Error reading file:", e);
					reject(e); // Indicate failure
				};
				reader.readAsDataURL(file); // Read the file as a data URL
			},reject);
		},reject);
	});
}

function after_validation(){
	other_cause = ($('#other_cause').val()==''?'NA':$('#other_cause').val());

	var dc = localStorage.getItem("district_code");
	var dn = $("#dname").text();
	var cc = localStorage.getItem("circle_code");
	var bn = $("#bname").text();
	var bc = (localStorage.getItem("block_code"));
	var phone = localStorage.getItem("profile_mobile_no");
	var sc = localStorage.getItem("state_code");
	var school_code = localStorage.getItem("School_Code");
	var school_name = localStorage.getItem("School_Name");
	var mngmt = $("#management").text();
	var stake = localStorage.getItem("stake_level_code");
	var p_att = parseInt($("#primary_present").val());
	var up_att = parseInt($("#upper_primary_present").val());
	var mdm_avail = mdmr;
	var not_running = $("#not_running").val();
	var not_running_cause = document.getElementById("not_running").options[document.getElementById("not_running").selectedIndex].text;
	var cooking_cost = CookingCost;
	var daily_sms = dailysms;
	var man_power = manpower;
	var committee = Committee;
	var REMARKS = $("#Remarks1").val();
	
	/* var image1 = ($("#Image1").attr('src')=='images/img-load.jpg'? '':$("#Image1").attr('src'));
	//alert(image1);
	var image2 = ($("#Image2").attr('src')=='images/img-load.jpg'?'':$("#Image2").attr('src')); 
	//alert(image2);
	var image3 = ($("#Image3").attr('src')=='images/img-load.jpg'?'':$("#Image3").attr('src'));
	//alert(image3);
	var image4 = ($("#Image4").attr('src')=='images/img-load.jpg'?'':$("#Image4").attr('src'));
	//alert(image4);
	var image5 = ($("#Image5").attr('src')=='images/img-load.jpg'?'':$("#Image5").attr('src')); */
	//alert(image5);

	var image1 = image[1];
	//alert(image1);
	var image2 = image[2]; 
	//alert(image2);
	var image3 = image[3];
	//alert(image3);
	var image4 = image[4];
	//alert(image4);
	var image5 = image[5];
	//alert(image5);


	///////////////////////////////////////////////////////////////////////////////

	/////////////////////////////////////LOCAL_DB//////////////////////////////////////////

	if(record<5){
		$("#preloader").fadeIn();
		db.transaction(function(tx) {
				//var sqlite = "";
				tx.executeSql('INSERT INTO SupervisorInspectionForm(state_code,supervisor_phone_no,district_code,district_name,circle_code,block_code,block_name,school_code,school_name,management,primary_details,upper_primary_details,primary_att,upper_primary_att,visiting_date,visiting_date_db,mdm_avail,not_running,not_running_cause,other_cause,drinking_water,toilet,manpower,committee,cooking_cost,honorarium,rice_stock,hygiene,daily_sms,remarks,latitude,longitude,enter_by_stake,image1,image2,image3,image4,image5) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', [sc,phone,dc,dn,cc,bc,bn,school_code,school_name,mngmt,p_details,up_details,p_att,up_att,local_date_new,local_date_db,mdm_avail,not_running,not_running_cause,other_cause,DRINKWATER,TOILETS,man_power,committee,cooking_cost,HONORARIUM,STOCKR,HYGIENE,daily_sms,REMARKS,latitude,longitude,stake,image1,image2,image3,image4,image5]);
				/*tx.executeSql('INSERT INTO SupervisorInspectionPhotograph(Supervisor_Phone_No,School_Code,School_Name,Date,Image1,Image2,Image3,Image4,Image5) VALUES (?,?,?,?,?,?,?,?,?)', [mobile,SchoolCode,SchName,provided_date,image1,image2,image3,image4,image5]);*/
		}, function(tx,error) {
		$("#preloader").fadeOut();
		var myJSON = JSON.stringify(error);
		//console.log(sqlite);
		alert('SELECT error: ' + myJSON);
		
		alert("UN-Succesfully submitted into local Database");
		return true;
		}, function(tx,result) {
		$("#preloader").fadeOut();	
			alert("Succesfully submitted into local Database");
			window.location = "Offline_History.html";

		});

	}
	else{
		//alert(record);
		alert("Offline Record List is Full please Sync.");
		return false;
	}
}
