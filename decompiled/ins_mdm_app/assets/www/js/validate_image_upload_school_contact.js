var db;
var latitude = 0;
var longitude = 0;

var imageData;
var mobile = localStorage.getItem("profile_mobile_no");

let image = [];
var divid;

var imageCount = 1;
var maxImageCount = 3;

document.addEventListener("deviceready", onDeviceReady, false);
function onDeviceReady(){
	checkAvailability();
	//navigator.geolocation.getCurrentPosition(onSuccess, onError);
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

/* function addPicture() {
	if(imageCount<maxImageCount){

		imageCount++
		const uploadContainer = document.getElementById('camera-1');
		const uploadDivId = 'camera-'+imageCount; // ID for the div to add/remove
		const newDiv = document.createElement('div');
			newDiv.id = uploadDivId;
			newDiv.innerHTML = `
				<span class="camera_heading"><strong>Picture `+imageCount+`</strong></span>
					<div>
						<!-- <img id="Image`+imageCount+`" onclick="capturePhotoEdit(this.id);" src="images/img-load.jpg" class="img-responsive"> -->
						<img id="Image`+imageCount+`" onclick="capturePhoto(this.id);" src="images/img-load.jpg" class="img-responsive">
					</div>
			`;
        uploadContainer.appendChild(newDiv);
		document.getElementById('deletePicture').style.display='block';
		if(imageCount==maxImageCount){
			document.getElementById('addPicture').style.display='none';
		}
	}
	
}

function deletePictures(){
	const photoUploadDiv = document.getElementById('camera-'+imageCount);
	photoUploadDiv.remove();
	imageCount--;
	if(imageCount<maxImageCount){
		document.getElementById('addPicture').style.display='block';
	}
	if(imageCount==1){
		document.getElementById('deletePicture').style.display='none';
	}
} */


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
        sourceType: Camera.PictureSourceType.CAMERA, // Open the device's camera
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


function validate_school_contact(){
	for(var i=1;i<=maxImageCount;i++){
		if($("#Image"+i).attr('src')=='images/img-load.jpg'){
			alert("Please Capture Image"+i);
			return false;
		}
	}
	if(latitude== 0 || longitude == 0){
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
	for(var i=1;i<=maxImageCount;i++){
		try{
			var image_path=(document.getElementById('Image'+i).src);
			image[i]=await getFileContentAsBase64(image_path);
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

	console.log(image);
	console.log(latitude+'**************'+longitude);

	$("#preloader").fadeIn();	
	    $.ajax({
          type: "POST",
		  url: "https://pmposhan.wb.gov.in/Inspection_Apps/Mdm/insert_daily_school_image",
          data:{
	        authuser:'16288adbe9a7cb4baeb0f0d8df7ba4bb',
            authpassword:'001b6d7734d59c236d8eef95842f254e',
	        mobile_no:localStorage.getItem("phno"),
			school_code_fk:localStorage.getItem('school_code_fk'),
			block_code_fk:localStorage.getItem('block_code_fk'),
			circle_code_fk:localStorage.getItem('circle_code_fk'),
			subdiv_code_fk:localStorage.getItem('subdiv_code_fk'),
			district_code_fk:localStorage.getItem('district_code_fk'),
			image_1:image[1],
			image_2:image[2],
			image_3:image[3],
			latitude:latitude,
			longitude:longitude

	      },
        dataType:"JSON",
        success: function(result)
       {
  		console.log(JSON.stringify(result));
        console.log("=====================");

		if(result.status==1){
			alert(result.msg);
		}
		else if(result.status==2){
			alert(result.msg);
		}
		else if(result.status==3){
			alert(result.msg);
		}
		else{
			alert("Somethig Went Wrong, Please Try Again Later");
		}
	    $("#preloader").fadeOut();				
       },
	   error: function(){
		alert("Network Error! Please Try Again Later");
		$("#preloader").fadeOut();
      }
      });


	
}