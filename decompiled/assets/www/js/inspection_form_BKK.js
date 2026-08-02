var appState = {
    takingPicture: true,
    DataUrl: ""
};

var APP_STORAGE_KEY = "exampleAppState";

var contact_no;
var schcd;
var school_code_pk;
var contact_status;
var enroll_status;
var verify_status; 
var forward_status;
var mdm_used;
var category_code_fk;
var management_code_fk;
var type_code_fk;
var area_code_fk;
var gs_ward_code_fk;
var mapping_gs_status;
var circle_code_fk;
var block_code_fk; 
var block_name;
var block_schcd;
var block_mun_corp_flag;
var circle_name;
var circle_schcd;
var gs_ward_name;
var gs_schcd;
var district_name;
var district_code_fk; 
var district_schcd;
var state_name;
var state_code_fk;
var subdiv_name;
var subdiv_code_fk;
var subdiv_schcd;
var category_name;
var class_list;
var management_name; 
var area_name;
var type_name;   
var contact_code_pk;
var running_y_n;
var not_running_cause;
var pre_primary;
var class_i;
var class_ii;
var class_iii;
var class_iv;
var class_v;
var class_vi;
var class_vii;
var class_viii;
var  coverage_arr_pre_primary;
var coverage_arr_class_i_iv;
var coverage_arr_class_v;
var coverage_arr_class_vi_viii;
var coverage_arr_flag_new;
var mdm_in_charge_name;	
var local_date_new;
var today = new Date(); 
var dd = today.getDate(); 
var mm = today.getMonth()+1;//January is 0! 
var yyyy = today.getFullYear(); 
if(dd<10){dd='0'+dd} 
if(mm<10){mm='0'+mm} 
//local_date_new=(yyyy+'-'+mm+'-'+dd);
//local_date_new=localStorage.getItem("current_date_for_db");
var d = new Date();
var timestamp_local = d.getTime();
var latitude='';
var longitude='';
var totaldata='';
var image0='';
var image='';
var image1='';
var image2='';
var image3='';
var image4='';
var db;

$( document ).ready(function() {
	if(localStorage.getItem("image")!= null){
		document.getElementById('smallImage0').src=localStorage.getItem("image0");
		document.getElementById('smallImage').src=localStorage.getItem("image");
		document.getElementById('smallImage1').src=localStorage.getItem("image1");
		document.getElementById('smallImage2').src=localStorage.getItem("image2");
		document.getElementById('smallImage3').src=localStorage.getItem("image3");
		document.getElementById('smallImage4').src=localStorage.getItem("image4");
	}

	$('input[name=irregularity_found]').change(function(){
	       //alert("yahoo");
		   if($('input[name=irregularity_found]:checked').val()=='1'){
		   $("#checkbox_display_level").show();
		   $("#checkbox_display_data").show();
		   $("#input_irregular_display").show();
		   $("#input_irregular_data").show();	        
		   }
		   else{
		   $("#checkbox_display_level").hide();
		   $("#checkbox_display_data").hide();
		   $("#input_irregular_display").hide();
		   $("#input_irregular_data").hide();
		   }
	    })

	    $('input[name=fire_extinguisher]').change(function(){
	       //alert("yahoo");
			   if($('input[name=fire_extinguisher]:checked').val()=='1'){
			   	$("#fire_extinguisher_working_div").show(); 	        
			   }
			   else{	
			    $("#fire_extinguisher_working_div").hide();
			    $("#fire_extinguisher_valid_no").hide();
					$("#fire_extinguisher_valid_yes").hide();
					$('input[name=fire_extinguisher_working]').prop('checked',false);
			    //$('input[name=fire_extinguisher_required_refilling_replace]').prop('checked',false);
					//$("#fire_extinguisher_valid_upto").val('');
			   }
	    }) 	

	    /*$('input[name=fire_extinguisher_working]').change(function(){
	       //alert("yahoo");
		   if($('input[name=fire_extinguisher_working]:checked').val()=='1'){
		   $("#fire_extinguisher_valid_yes").show();
		   $("#fire_extinguisher_valid_no").hide();
		   $('input[name=fire_extinguisher_required_refilling_replace]').prop('checked',false);        
		   }
		   else{
		   $("#fire_extinguisher_valid_yes").hide();
		   $("#fire_extinguisher_valid_upto").val('');
		   $("#fire_extinguisher_valid_no").show();
		   }
	    })*/

	    $('input[name=own_drinking_water_source]').change(function(){
	       //alert("yahoo");
		   if($('input[name=own_drinking_water_source]:checked').val()=='1'){
		   $('input[name=drinking_water_source_type]').prop('checked',false);
		   $("#own_drinking_water_source_yes").show();
		   $("#own_drinking_water_source_no").hide();
		   }
		   else{
		   $('input[name=own_drinking_water_source_type]').prop('checked',false);
		   $("#own_drinking_water_source_yes").hide();
		   $("#own_drinking_water_source_no").show();
		   }
	    })

	    $('input[name=water_arsenic_contaminated]').change(function(){
	       //alert("yahoo");
		   if($('input[name=water_arsenic_contaminated]:checked').val()=='1'){
		   $("#arsenic_water_yes_div").show();
		   }
		   else{
		   $("#arsenic_water_yes_div").hide();
		   $('input[name=water_treated_arsenic_free]').prop('checked',false);
		   }
	    })

	    $('input[name=toilets_hygienic_usable]').change(function(){
	       //alert("yahoo");
		   if($('input[name=toilets_hygienic_usable]:checked').val()=='1'){
		   $("#dysfunctional_toilets_div").hide();
		   $('#dysfunctional_toilets').val('');
		   $("#gender_specific_toilets_div").hide();
		   $('input[name=one_gender_specific_toilet]').prop('checked',false);
		   }
		   else{
		   $("#dysfunctional_toilets_div").show();
		   $("#gender_specific_toilets_div").show();
		   }
	    })

	    $('input[name=separate_pucca_dining_hall]').change(function(){
	       //alert("yahoo");
		   if($('input[name=separate_pucca_dining_hall]:checked').val()=='1'){
		   	$("#separate_dining_hall_no_div").hide();
		   $('input[name=sufficient_free_space_available]').prop('checked',false);
		   }
		   else{
		   $("#separate_dining_hall_no_div").show();
		   }
	    })

	    $('input[name=meal_tested_before_served]').change(function(){
	       //alert("yahoo");
		   if($('input[name=meal_tested_before_served]:checked').val()=='1'){
		   	$("#meal_tasted_yes_div").show();
		   
		   }
		   else{
		   $("#meal_tasted_yes_div").hide();
		   $('input[name=teacher_tasted]').prop('checked',false);
		   $('input[name=cch_tasted]').prop('checked',false);
		   $('input[name=parents_tasted]').prop('checked',false);
		   $('input[name=other_tasted]').prop('checked',false);
		   }
	    })

	    $('input[name=improvement_required_smooth_functioning]').change(function(){
	       //alert("yahoo");
		   if($('input[name=improvement_required_smooth_functioning]:checked').val()=='1'){
		   	$("#improvement_required_yes_div").show();
		   
		   }
		   else{
		   $("#improvement_required_yes_div").hide();
		   $("#further_improvement").val('');
		   }
	    })
	get_current_date();
    
});
function get_current_date(){
	$("#preloader").fadeIn();
	$.ajax({
		type: "GET",
		//url: "https://mdm.wbsed.gov.in/Inspection_Apps/mdm_inspection_app/mdm/get_current_date",
		//url: "http://192.168.0.238:81/mdmwbsed/Inspection_Apps/mdm_inspection_app/mdm/count_officer_inspection",
		url: "https://pmposhan.wb.gov.in/Inspection_Apps/Mdm/get_current_date",
		data:{
			authuser:'16288adbe9a7cb4baeb0f0d8df7ba4bb',
      		authpassword:'001b6d7734d59c236d8eef95842f254e',
			token:'ba0b38a250289cc85a5ad60ca7712997'			
		},
		dataType:"JSON",
		success:function(result)
		{
			console.log(JSON.stringify(result));
			local_date_new=result.current_date_for_db;
			$("#preloader").fadeOut();			
		},
		complete: function(result)
		{
			school_details();
		}
	});

	
	
}
function school_details()
{	
	$("#preloader").fadeIn();
	$.ajax({
		type: "GET",
		//url: "https://mdm.wbsed.gov.in/Inspection_Apps/mdm_inspection_app/mdm/officer_inspection_count",
		//url: "http://192.168.0.238:81/mdmwbsed/Inspection_Apps/mdm_inspection_app/mdm/count_officer_inspection",
		url: "https://pmposhan.wb.gov.in/Inspection_Apps/Mdm/officer_inspection_count",
		data:{
			authuser:'16288adbe9a7cb4baeb0f0d8df7ba4bb',
      		authpassword:'001b6d7734d59c236d8eef95842f254e',
			token:'ba0b38a250289cc85a5ad60ca7712997',
			mob_no: localStorage.getItem("phno"),
			school_code_fk:localStorage.getItem("school"),
			inspection_date:local_date_new
		},
		dataType:"JSON",
		success:function(result)
		{
			console.log(JSON.stringify(result));
			if(result.Count != 0)
			{
			alert("Inspection of this school is already done by you for today");
			window.location = "district_select.html";
			$("#preloader").fadeOut();
			}
			else
			{
				document.addEventListener('deviceready', ondeviceready, false);
				document.addEventListener('pause', onPause, false);
				//document.addEventListener('resume', onResume, false);
				//document.addEventListener("deviceready", ondeviceready, false);
				
				
			}
			
		}
	});

	


}



document.addEventListener("backbutton", onBackKeyDown, false); 		   
function onBackKeyDown() 
{
	window.history.back();
}
	function ondeviceready(){
	$('#preloader').fadeIn();
	$.ajax({
    type: "GET",
    //url: "https://mdm.wbsed.gov.in/Inspection_Apps/mdm_inspection_app/mdm/token_check_final",
	url: "https://pmposhan.wb.gov.in/Inspection_Apps/Mdm/token_check_final",
    data:{
	authuser:'16288adbe9a7cb4baeb0f0d8df7ba4bb',
	authpassword:'001b6d7734d59c236d8eef95842f254e',
    token:localStorage.getItem("token"),
    phno:localStorage.getItem("phno")
	},
    dataType:"JSON",
    success: function(result)
	   {
		    //alert(JSON.stringify(result));
			 if(result.code=='1')
			 {
				
			//////////////////////////////////////
			
				//db = window.sqlitePlugin.openDatabase({name: 'MdmInspection.db', location: 'default'});
				
			
			}
			////////////////////////////////////////////////////////////////
			else if(result.code=='0')
		  {
		    alert(result.msg);
		  }
	  }
 	})

	//$('#preloader').fadeIn();
	db = window.sqlitePlugin.openDatabase({name: 'MdmInspection.db', location: 'default'});
	db.transaction(function(tx) {
				//tx.executeSql('DROP TABLE IF EXISTS InspectionFormTable;');   
			   tx.executeSql('CREATE TABLE IF NOT EXISTS InspectionFormTable(mobile_no,inspection_date,school_code_fk,data,serving_eating_picture,school_premises_picture,toilets_picture,drinking_water_source_picture,kitchen_picture,other_picture)');
				}, function(error) {
				//alert("table not created");
				}, function() {
				//alert("table created successfully");
				});
	db.transaction(function(tx) {
		tx.executeSql('SELECT * FROM InspectionFormTable WHERE mobile_no = ? AND inspection_date = ? AND school_code_fk = ?',[localStorage.getItem("phno"),local_date_new,localStorage.getItem("school")],function(tx,rs){
			if(rs.rows.length>=1){
				alert("Inspection of this school is already done by you for today, and it stored locally, please look into Draft Inspection Menu.");
				window.location = "district_select.html";
			}
			else
			{
				$.ajax({
					type: "GET",
					//url: "https://mdm.wbsed.gov.in/mdmappv3/Common/get_school_related_data",
					url: "https://pmposhan.wb.gov.in/mdmappv3/Common/get_school_related_data",
					data:{
					token:'ba0b38a250289cc85a5ad60ca7712997',
					school_code_fk:localStorage.getItem("school")
					},
					dataType:"JSON",
					success: function(result)
				   {
						var class_list_json = result.school_arr.class_list;
						$(".label_data #sname").html(result.school_arr.school_name);
						$(".label_data #udise_code").html(result.school_arr.schcd);
						$(".label_data #category_name").html(result.school_arr.category_name);
						$(".label_data #type_name").html(result.school_arr.type_name);
						$(".label_data #management_name").html(result.school_arr.management_name);
						$(".label_data #mdm_in_charge_name1").html(result.contact_arr[0].mdm_in_charge_name);
						$(".label_data #contact_no1").html(result.contact_arr[0].contact_no);
						contact_no=result.contact_arr[0].contact_no
						mdm_in_charge_name=result.contact_arr[0].mdm_in_charge_name;
						schcd=result.school_arr.schcd;
						school_code_pk=result.school_arr.school_code_pk;
						contact_status=result.school_arr.contact_status;
						enroll_status=result.school_arr.enroll_status;
						verify_status=result.school_arr.verify_status; 
						forward_status=result.school_arr.forward_status;
						mdm_used=result.school_arr.mdm_used;
						category_code_fk=result.school_arr.category_code_fk;
						management_code_fk=result.school_arr.management_code_fk;
						type_code_fk=result.school_arr.type_code_fk;
						area_code_fk=result.school_arr.area_code_fk;
						gs_ward_code_fk=result.school_arr.gs_ward_code_fk;
						mapping_gs_status=result.school_arr.mapping_gs_status;
						circle_code_fk=result.school_arr.circle_code_fk;
						block_code_fk=result.school_arr.block_code_fk; 
						block_name=result.school_arr.block_name;
						block_schcd=result.school_arr.block_schcd;
						block_mun_corp_flag=result.school_arr.block_mun_corp_flag;
						circle_name=result.school_arr.circle_name;
						circle_schcd=result.school_arr.circle_schcd;
						gs_ward_name=result.school_arr.gs_ward_name;
						gs_schcd=result.school_arr.gs_schcd;
						district_name=result.school_arr.district_name;
						district_code_fk=result.school_arr.district_code_fk; 
						district_schcd=result.school_arr.district_schcd;
						state_name=result.school_arr.state_name;
						state_code_fk=result.school_arr.state_code_fk;
						subdiv_name=result.school_arr.subdiv_name;
						subdiv_code_fk=result.enroll_arr.subdiv_code_fk;
						subdiv_schcd=result.school_arr.subdiv_schcd;
						category_name=result.school_arr.category_name;
						class_list=result.school_arr.class_list;
						management_name=result.school_arr.management_name; 
						area_name=result.school_arr.area_name;
						type_name=result.school_arr.type_name;
						contact_code_pk=result.contact_arr[0].contact_code_pk;
						pre_primary_applicable_status=result.enroll_arr.pre_primary_applicable_status;
						pre_primary=result.enroll_arr.pre_primary;
						class_i=result.enroll_arr.class_i;
						class_ii=result.enroll_arr.class_ii;
						class_iii=result.enroll_arr.class_iii;
						class_iv=result.enroll_arr.class_iv;
						class_v=result.enroll_arr.class_v;
						class_vi=result.enroll_arr.class_vi;
						class_vii=result.enroll_arr.class_vii;
						class_viii=result.enroll_arr.class_viii;
						if(result.coverage_arr!=null)
						{
							running_y_n=result.coverage_arr.running_y_n;
							not_running_cause=result.coverage_arr.not_running_cause;
							coverage_arr_pre_primary=result.coverage_arr.pre_primary;
							coverage_arr_class_i_iv=result.coverage_arr.class_i_iv;
							coverage_arr_class_v=result.coverage_arr.class_v;
							coverage_arr_class_vi_viii=result.coverage_arr.class_vi_viii;		
						  }				
						var n = class_list_json.search("02");
						if(class_list_json.search("01") != -1 && result.enroll_arr.pre_primary_applicable_status == 1)
						{
							pre_primary_div.style.display = 'block';
							$(".label_data #pre_primary").html(result.enroll_arr.pre_primary);
						}
						if(class_list_json.search("02") != -1)
						{
							Class_i_div.style.display = 'block';
							$(".label_data #class_i").html(result.enroll_arr.class_i);
						}
						if(class_list_json.search("03") != -1)
						{
							Class_ii_div.style.display = 'block';
							$(".label_data #class_ii").html(result.enroll_arr.class_ii);
						}
						if(class_list_json.search("04") != -1)
						{
							Class_iii_div.style.display = 'block';
							$(".label_data #class_iii").html(result.enroll_arr.class_iii);
						}
						if(class_list_json.search("05") != -1)
						{
							Class_iv_div.style.display = 'block';					
							$(".label_data #class_iv").html(result.enroll_arr.class_iv);
						}
						if(class_list_json.search("06") != -1 && result.enroll_arr.class_v_applicable_status == 1)
						{
							Class_v_div.style.display = 'block';	
							$(".label_data #class_v").html(result.enroll_arr.class_v);
						}
						if(class_list_json.search("07") != -1)
						{
							Class_vi_div.style.display = 'block';	
							$(".label_data #class_vi").html(result.enroll_arr.class_vi);
						}
						if(class_list_json.search("08") != -1)
						{
							Class_vii_div.style.display = 'block';	
							$(".label_data #class_vii").html(result.enroll_arr.class_vii);
						}
						if(class_list_json.search("09") != -1)
						{
							Class_viii_div.style.display = 'block';	
							$(".label_data #class_viii").html(result.enroll_arr.class_viii);
							
						}
						if(result.school_arr.category_code_fk!=8 && result.school_arr.category_code_fk!=11)
						{			
							Class_ix_x_Class_xi_xii.style.display = 'block';	
							$('#Class_ix_x').show();
							$('#Class_xi_xii').show();
						}	
						if(result.coverage_arr==null)
						{
								MDM_Availed_not_reported_div.style.display = 'block';	
							$(".label_data #not_reported").html('The selected School not reported');
							$('#mdmflag').val('0');	
						}
						else if(result.coverage_arr.running_y_n==1)
						{
							$('#mdmflag').val('1');
							if (class_list_json.search("01") != -1 && result.enroll_arr.pre_primary_applicable_status == 1) 
							{
								MDM_Availed_Pre_Primary_div.style.display = 'block';	
							$(".label_data #mdm_Pre_Primary").html(result.coverage_arr.pre_primary);
								
								
							}
							if (class_list_json.search("02") != -1 || class_list_json.search("02") !== -1 || class_list_json.search("04") !== -1 || class_list_json.search("05") !== -1) 
							{
							
								MDM_Availed_mdm_Class_i_iv_div.style.display = 'block';	
							$(".label_data #mdm_Class_i_iv").html(result.coverage_arr.class_i_iv);
								
							}
							if (class_list_json.search("06") != -1 && result.enroll_arr.class_v_applicable_status == 1) 
							{
								MDM_Availed_mdm_Class_v_div.style.display = 'block';	
							$(".label_data #mdm_Class_v").html(result.coverage_arr.class_v);
								
							}
							if (class_list_json.search("07") != -1 || class_list_json.search("08") !== -1 || class_list_json.search("09") !== -1) 
							{
			
								MDM_Availed_mdm_Class_vi_viii_div.style.display = 'block';	
							$(".label_data #mdm_Class_vi_viii").html(result.coverage_arr.class_vi_viii);
							}
						}
						else
						{
							MDM_Availed_mdm_cause_div.style.display = 'block';	
							$(".label_data #mdm_cause").html(result.coverage_arr.cause_description);	
						}		
							   //$("#preloader").fadeOut();				
					   },
					error: function(){
					   }
				});
			
				$.ajax({
					type: "GET",
					//url: "https://mdm.wbsed.gov.in/Inspection_Apps/mdm_inspection_app/mdm/get_last_inspected_school_details",
					//url: "http://192.168.0.238:81/mdmwbsed/Inspection_Apps/mdm_inspection_app/mdm/count_officer_inspection",
					url: "https://pmposhan.wb.gov.in/Inspection_Apps/Mdm/get_last_inspected_school_details",
					data:{
						authuser:'16288adbe9a7cb4baeb0f0d8df7ba4bb',
						   authpassword:'001b6d7734d59c236d8eef95842f254e',
						token:'ba0b38a250289cc85a5ad60ca7712997',
						school_code_fk:localStorage.getItem("school")
					},
					dataType:"JSON",
					success:function(response)
					{
						console.log(JSON.stringify(response));
						if(response.Count != 0)
						{
							var inspected_day=response.result.inspection_date.substring(8,10);
							var inspected_month=response.result.inspection_date.substring(5,7);
							var inspected_year=response.result.inspection_date.substring(0,4);
						alert("Inspection Form is filled with last inspection data held on "+inspected_day+'-'+inspected_month+'-'+inspected_year);
			
						$("#regular_teacher").val(response.result.regular_teacher);
						$("#para_teacher").val(response.result.para_teacher);
						$("#contractual_teacher").val(response.result.contractual_teacher);
						if(response.result.own_drinking_water_source==1)
						{
							$("#drinking_water1").prop("checked", true);
							$("#own_drinking_water_source_yes").show();
					   
						}
						else
						{
							$("#drinking_water2").prop("checked", true);
							$("#own_drinking_water_source_no").show();
						}
						if(response.result.own_drinking_water_source_type==1)
						{
							$("#drinking_water_source_yes1").prop("checked", true);
						}
						else if(response.result.own_drinking_water_source_type==2)
						{
							$("#drinking_water_source_yes2").prop("checked", true);
						}
						else if(response.result.own_drinking_water_source_type==3)
						{
							$("#drinking_water_source_yes3").prop("checked", true);
						}
						else if(response.result.own_drinking_water_source_type==4)
						{
							$("#drinking_water_source_yes4").prop("checked", true);
						}
						if(response.result.drinking_water_functional==1)
						{
							$("#drinking_water1").prop("checked", true);
						}
						else
						{
							$("#drinking_water2").prop("checked", true);
						}
						if(response.result.drinking_water_source_type==1)
						{
							$("#drinking_water_source_no1").prop("checked", true);
						}
						else if(response.result.drinking_water_source_type==2)
						{
							$("#drinking_water_source_no2").prop("checked", true);
						}
						else if(response.result.drinking_water_source_type==3)
						{
							$("#drinking_water_source_no3").prop("checked", true);
						}
						if(response.result.drinking_water_functional==1)
						{
							$("#drinking_water_functional1").prop("checked", true);
						}
						else
						{
							$("#drinking_water_functional2").prop("checked", true);
						}
						if(response.result.drinking_water_tested_in_lab==1)
						{
							$("#drinking_water_tasted_lab1").prop("checked", true);
						}
						else
						{
							$("#drinking_water_tasted_lab2").prop("checked", true);
						}
						if(response.result.water_arsenic_contaminated==1)
						{
							$("#arsenic_water1").prop("checked", true);
							$("#arsenic_water_yes_div").show();
							if(response.result.water_treated_arsenic_free==1)
							{
								$("#water_treated_arsenic_free1").prop("checked", true);
							}
							else
							{
								$("#water_treated_arsenic_free2").prop("checked", true);
							}
						}
						else
						{
							$("#arsenic_water2").prop("checked", true);
							$("#arsenic_water_yes_div").hide();
						}
						
						if(response.result.water_unusable_salinity==1)
						{
							$("#water_unusable_salinity1").prop("checked", true);
						}
						else
						{
							$("#water_unusable_salinity2").prop("checked", true);
						}
						if(response.result.functional_water_purifier_available==1)
						{
							$("#water_purifier_available1").prop("checked", true);
						}
						else
						{
							$("#water_purifier_available2").prop("checked", true);
						}
						if(response.result.toilets_urinals_available==1)
						{
							$("#toilet_urinals1").prop("checked", true);
						}
						else
						{
							$("#toilet_urinals2").prop("checked", true);
						}
						if(response.result.toilets_regularly_cleaned==1)
						{
							$("#toilets_regular_clean1").prop("checked", true);
						}
						else
						{
							$("#toilets_regular_clean2").prop("checked", true);
						}
						if(response.result.toilets_separated_boys_girls==1)
						{
							$("#separated_boys_girls1").prop("checked", true);
						}
						else
						{
							$("#separated_boys_girls2").prop("checked", true);
						}
						
						$("#boys_toilet").val(response.result.boys_toilet);
						$("#girls_toilet").val(response.result.girls_toilet);
			
						if(response.result.toilets_hygienic_usable==1)
						{
							$("#toilets_usable1").prop("checked", true);
						}
						else
						{
							$("#toilets_usable2").prop("checked", true);
							$("#dysfunctional_toilets_div").show();
							   $("#gender_specific_toilets_div").show();
							   $("#dysfunctional_toilets").val(response.result.dysfunctional_toilets);
			
							if(response.result.one_gender_specific_toilet_functional==1)
							{
								$("#one_gender_specific_toilet1").prop("checked", true);
							}
							else
							{
								$("#one_gender_specific_toilet2").prop("checked", true);
							}
						}	
						if(response.result.pucca_kitchen==1)
						{
							$("#pakka_kitchen1").prop("checked", true);
						}
						else
						{
							$("#pakka_kitchen2").prop("checked", true);
						}
						if(response.result.kitchen_condition==1)
						{
							$("#kitchen_condition1").prop("checked", true);
						}
						else if(response.result.kitchen_condition==2)
						{
							$("#kitchen_condition2").prop("checked", true);
						}
						else if(response.result.kitchen_condition==3)
						{
							$("#kitchen_condition3").prop("checked", true);
						}
			
						$("#kitchen_construction_year").val(response.result.kitchen_construction_year);
						$("#kitchen_last_repair_year").val(response.result.kitchen_last_repair_year);
			
						if(response.result.kitchen_regularly_cleaned==1)
						{
							$("#kitchen_regularly_cleaned1").prop("checked", true);
						}
						else
						{
							$("#kitchen_regularly_cleaned2").prop("checked", true);
						}
						if(response.result.cooking_utensils_usable==1)
						{
							$("#cooking_utensils_usable1").prop("checked", true);
						}
						else
						{
							$("#cooking_utensils_usable2").prop("checked", true);
						}
			
						$("#cooking_utensils_last_replace_year").val(response.result.cooking_utensils_last_replace_year);
						
						if(response.result.separate_pucca_dining_hall==1)
						{
							$("#separate_dining_hall1").prop("checked", true);
						}
						else
						{
							$("#separate_dining_hall2").prop("checked", true);
						}
						if(response.result.free_space_available_for_dining_hall==1)
						{
							$("#sufficient_free_space_available1").prop("checked", true);
						}
						else
						{
							$("#sufficient_free_space_available2").prop("checked", true);
						} 
						if(response.result.mdm_seating_arrangement==1)
						{
							$("#seating_arrangement_mdm1").prop("checked", true);
						}
						else
						{
							$("#seating_arrangement_mdm2").prop("checked", true);
						}
						if(response.result.school_building_status==1)
						{
							$("#school_building_status1").prop("checked", true);
						}
						else if(response.result.school_building_status==2)
						{
							$("#school_building_status2").prop("checked", true);
						}
						else if(response.result.school_building_status==3)
						{
							$("#school_building_status3").prop("checked", true);
						}
						if(response.result.class_room_furniture_available==1)
						{
							$("#class_room_furniture_available1").prop("checked", true);
						}
						else
						{
							$("#class_room_furniture_available2").prop("checked", true);
						}
			
						$("#functional_class_room_number").val(response.result.functional_class_room_number);
			
						if(response.result.unusable_room_available==1)
						{
							$("#unusable_room1").prop("checked", true);
						}
						else
						{
							$("#unusable_room2").prop("checked", true);
						}
						if(response.result.ramp_available==1)
						{
							$("#ramp_available1").prop("checked", true);
						}
						else
						{
							$("#ramp_available2").prop("checked", true);
						}
						if(response.result.school_electricity_available==1)
						{
							$("#electricity_school1").prop("checked", true);
						}
						else
						{
							$("#electricity_school2").prop("checked", true);
						}
						if(response.result.school_boundary_wall_fencing_available==1)
						{
							$("#boundary_wall_fencing1").prop("checked", true);
						}
						else if(response.result.school_boundary_wall_fencing_available==0)
						{
							$("#boundary_wall_fencing2").prop("checked", true);
						}
						else if(response.result.school_boundary_wall_fencing_available==2)
						{
							$("#boundary_wall_fencing3").prop("checked", true);
						}
						
			/*--------------------------------------------MDM Information---------------------------------------------*/
			
						if(response.result.weekly_menu_board==1)
						{
							$("#weekly_menu_board1").prop("checked", true);
						}
						else
						{
							$("#weekly_menu_board2").prop("checked", true);
						}
						if(response.result.displaying_mdm_logo==1)
						{
							$("#displaying_mdm_logo1").prop("checked", true);
						}
						else
						{
							$("#displaying_mdm_logo2").prop("checked", true);
						}
						if(response.result.fire_extinguisher==1)
						{
							$("#fire_extinguisher1").prop("checked", true);
						}
						else
						{
							$("#fire_extinguisher2").prop("checked", true);
						}
						if(response.result.fire_extinguisher_working==1)
						{
							$("#fire_extinguisher_working1").prop("checked", true);
						}
						else
						{
							$("#fire_extinguisher_working2").prop("checked", true);
						}
						if(response.result.register_food_grain==1)
						{
							$("#register_food_grain1").prop("checked", true);
						}
						else
						{
							$("#register_food_grain2").prop("checked", true);
						}
						if(response.result.one_month_buffer_stock_rice==1)
						{
							$("#one_month_buffer_stock1").prop("checked", true);
						}
						else
						{
							$("#one_month_buffer_stock1").prop("checked", true);
						}
						if(response.result.supplied_rice_quality==1)
						{
							$("#supplier_rice_quality1").prop("checked", true);
						}
						else if(response.result.supplied_rice_quality==2)
						{
							$("#supplier_rice_quality2").prop("checked", true);
						}
						else if(response.result.supplied_rice_quality==3)
						{
							$("#supplier_rice_quality3").prop("checked", true);
						}
						if(response.result.rice_stored_school_properly==1)
						{
							$("#rice_stored_school_properly1").prop("checked", true);
						}
						else
						{
							$("#rice_stored_school_properly2").prop("checked", true);
						}
						if(response.result.receives_cooking_cost_regularly==1)
						{
							$("#receives_cooking_conversion_cost1").prop("checked", true);
						}
						else
						{
							$("#receives_cooking_conversion_cost2").prop("checked", true);
						}
						if(response.result.mdm_cash_book_maintain==1)
						{
							$("#mdm_cash_book1").prop("checked", true);
						}
						else
						{
							$("#mdm_cash_book2").prop("checked", true);
						}
			
						$("#mdm_cash_book_maintained_upto").val(response.result.mdm_cash_book_maintained_upto);
			
						if(response.result.meal_tested_before_served==1)
						{
							$("#meal_tested_half_hour1").prop("checked", true);
							$("#meal_tasted_yes_div").show();
							if(response.result.meal_tasted_teacher==1)
							{
								$("#teacher_tasted1").prop("checked", true);
							}
							else
							{
								$("#teacher_tasted2").prop("checked", true);
							}
							if(response.result.meal_tasted_cch==1)
							{
								$("#cch_tasted1").prop("checked", true);
							}
							else
							{
								$("#cch_tasted2").prop("checked", true);
							}
							if(response.result.meal_tasted_parents==1)
							{
								$("#parents_tasted1").prop("checked", true);
							}
							else
							{
								$("#parents_tasted2").prop("checked", true);
							}
							if(response.result.meal_tasted_other==1)
							{
								$("#other_tasted1").prop("checked", true);
							}
							else
							{
								$("#other_tasted2").prop("checked", true);
							}
						}
						else
						{
							$("#meal_tested_half_hour2").prop("checked", true);
						}
						
						if(response.result.daily_meal_tasting_register_maintained==1)
						{
							$("#meal_tasting_register_maintained1").prop("checked", true);
						}
						else
						{
							$("#meal_tasting_register_maintained2").prop("checked", true);
						}
						if(response.result.separate_bank_ac_mdm==1)
						{
							$("#separate_bank_ac1").prop("checked", true);
						}
						else
						{
							$("#separate_bank_ac2").prop("checked", true);
						}
						if(response.result.cch_honorarium_regular==1)
						{
							$("#regularly_cch_honorarium1").prop("checked", true);
						}
						else
						{
							$("#regularly_cch_honorarium2").prop("checked", true);
						}
						if(response.result.all_cooks_have_bank_ac==1)
						{
							$("#cooks_have_bank_account1").prop("checked", true);
						}
						else
						{
							$("#cooks_have_bank_account2").prop("checked", true);
						}
						if(response.result.cooks_receive_honorarium_through==1)
						{
							$("#cooks_receive_honorarium_through1").prop("checked", true);
						}
						else if(response.result.cooks_receive_honorarium_through==2)
						{
							$("#cooks_receive_honorarium_through2").prop("checked", true);
						}
						else if(response.result.cooks_receive_honorarium_through==3)
						{
							$("#cooks_receive_honorarium_through3").prop("checked", true);
						}
						if(response.result.school_daily_report_sms==1)
						{
							$("#school_daily_report_sms1").prop("checked", true);
						}
						else
						{
							$("#school_daily_report_sms2").prop("checked", true);
						}
						if(response.result.cooking_mode==1)
						{
							$("#cooking_mode1").prop("checked", true);
						}
						else if(response.result.cooking_mode==2)
						{
							$("#cooking_mode2").prop("checked", true);
						}
						else if(response.result.cooking_mode==3)
						{
							$("#cooking_mode3").prop("checked", true);
						}
						else if(response.result.cooking_mode==4)
						{
							$("#cooking_mode4").prop("checked", true);
						}
						if(response.result.cooks_change_dress==1)
						{
							$("#cooks_change_dress1").prop("checked", true);
						}
						else
						{
							$("#cooks_change_dress2").prop("checked", true);
						}
						if(response.result.cooks_use_apron_gloves==1)
						{
							$("#cooks_use_apron_gloves1").prop("checked", true);
						}
						else
						{
							$("#cooks_use_apron_gloves2").prop("checked", true);
						}
						if(response.result.food_grains_washed==1)
						{
							$("#food_grains_washed1").prop("checked", true);
						}
						else
						{
							$("#food_grains_washed2").prop("checked", true);
						}
						if(response.result.kitchen_garden_avalable==1)
						{
							$("#kitchen_garden_available1").prop("checked", true);
						}
						else
						{
							$("#kitchen_garden_available2").prop("checked", true);
						}
						if(response.result.school_received_plate_glasses==1)
						{
							$("#school_received_plate_glasses1").prop("checked", true);
						}
						else
						{
							$("#school_received_plate_glasses2").prop("checked", true);
						}
						if(response.result.hand_wash_practiced==1)
						{
							$("#hand_wash_practiced1").prop("checked", true);
						}
						else
						{
							$("#hand_wash_practiced2").prop("checked", true);
						}
						if(response.result.mdm_served_through_central_kitchen==1)
						{
							$("#served_through_central_kitchen1").prop("checked", true);
						}
						else
						{
							$("#served_through_central_kitchen2").prop("checked", true);
						}
						if(response.result.govt_pr_visited_previous_one_month==1)
						{
							$("#govt_pr_visited_previous_one_month1").prop("checked", true);
						}
						else
						{
							$("#govt_pr_visited_previous_one_month2").prop("checked", true);
						}
						if(response.result.agmark_sealed_oil_used==1)
						{
							$("#agmark_sealed_oil_used1").prop("checked", true);
						}
						else
						{
							$("#agmark_sealed_oil_used2").prop("checked", true);
						}
						if(response.result.branded_packaged_condiments_used==1)
						{
							$("#branded_packaged_condiments_used1").prop("checked", true);
						}
						else
						{
							$("#branded_packaged_condiments_used2").prop("checked", true);
						}
						if(response.result.double_fortified_salt==1)
						{
							$("#double_fortified_salt1").prop("checked", true);
						}
						else
						{
							$("#double_fortified_salt2").prop("checked", true);
						}
						if(response.result.health_checkup_card_maintained_regular==1)
						{
							$("#health_checkup_card_maintained1").prop("checked", true);
						}
						else
						{
							$("#health_checkup_card_maintained2").prop("checked", true);
						}
						if(response.result.bdo_name_phno_display==1)
						{
							$("#bdo_name_phno_display1").prop("checked", true);
						}
						else
						{
							$("#bdo_name_phno_display2").prop("checked", true);
						}
						if(response.result.concerned_si_name_phno_display==1)
						{
							$("#si_name_phno_display1").prop("checked", true);
						}
						else
						{
							$("#si_name_phno_display2").prop("checked", true);
						}
						if(response.result.irregularity_found==1)
						{
							$("#irregularity_found1").prop("checked", true);
							$("#checkbox_display_level").show();
							   $("#checkbox_display_data").show();
							   $("#input_irregular_display").show();
							   $("#input_irregular_data").show();
							   if(response.result.rice_irregularity==1){
							$('#rice_irregularity').prop('checked', true);
							}
							if(response.result.fund_irregularity==1){
								$('#fund_irregularity').prop('checked', true);
							}
							if(response.result.mdm_takers_number_irregularity==1){
								$('#mdm_takers_number_irregularity').prop('checked', true);
							}
							if(response.result.cch_irregularity==1){
								$('#cch_irregularity').prop('checked', true);
							}
							if(response.result.ssm_fund_related_irregularity==1){
								$('#ssm_fund_related_irregularity').prop('checked', true);
							}
							if(response.result.other_irregularity==1){
								$('#other_irregularity').prop('checked', true);
							}
						}
						else
						{
							$("#irregularity_found2").prop("checked", true);
							$("#checkbox_display_level").hide();
							$("#checkbox_display_data").hide();
							$("#input_irregular_display").hide();
							$("#input_irregular_data").hide();
						}
						
						if(response.result.improvement_required_smooth_functioning==1)
						{
							$("#improvement_required_smooth_functioning1").prop("checked", true);
							$("#improvement_required_yes_div").show();
							$("#further_improvement").val(response.result.suggestion_smooth_functioning_mdm);
						}
						else
						{
							$("#improvement_required_smooth_functioning2").prop("checked", true);
						}
			
			
						$("#preloader").fadeOut();
						}
						
					}
				});
			}
		}, function(tx,error){
			alert('Error: ' + error.message);
		});
		$("#preloader").fadeOut();
	});

  geolocation();
  checkAvailability();
	}

	function onPause() {
		console.log("Pause");
        if(appState.takingPicture || appState.DataUrl) {
            window.localStorage.setItem("APP_STORAGE_KEY", JSON.stringify(appState));
			console.log(window.localStorage.getItem("APP_STORAGE_KEY"));
        }
    }

	/* function onResume(event){
        
        var storedState = window.localStorage.getItem(APP_STORAGE_KEY);

        if(storedState) {
            appState = JSON.parse(storedState);
        }

        if(!appState.takingPicture && appState.DataUrl) {
            document.getElementById(localStorage.getItem("image_div_id")).src = appState.DataUrl;
        }
        else if(appState.takingPicture && event.pendingResult) {
            if(event.pendingResult.pluginStatus === "OK") {
                cameraSuccessCallback(event.pendingResult.result);
            } else {
                cameraFailureCallback(event.pendingResult.result);
            }
        }
	} */

	
	function geolocation(){
		//alert("hi1");
	navigator.geolocation.getCurrentPosition(onSuccess, onError);
	}
	function onSuccess(position){
	//alert("hi2");	
	latitude = position.coords.latitude;
	longitude = position.coords.longitude;
	//alert(latitude+""+longitude);	
	 if(latitude != '' && longitude != '')
	{
		tost_msg();
	} 
    }
	function onError(error) {
        alert('code: '    + error.code    + '\n' +
              'message: ' + error.message + '\n');
    }
	function tost_msg(){
	window.plugins.toast.showWithOptions(
         {
            message: "Location Fetched",
            duration: "1500", // which is 2000 ms. "long" is 4000. Or specify the nr of ms yourself.
            position: "bottom",
            addPixelsY: -40,  // added a negative value to move it up a bit (default 0)
			 styling: {
				 
					  }
         });
	}

		function checkAvailability(){
		    cordova.plugins.diagnostic.isGpsLocationAvailable(function(available){
		        console.log("GPS location is " + (available ? "available" : "not available"));
		        if(!available){
		            gps = 0;
		           checkAuthorization();
		        }else{
		            gps = 1;
		            console.log("GPS location is ready to use");
		            geolocation();
		            
		        }
		    }, function(error){
		        console.error("The following error occurred: "+error);
		    });
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
		            	geolocation();
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


function checkLength(len,ele){
      var fieldLength = ele.value.length;
      if(fieldLength <= len){
         
        return true;
      }
      else
      {
        var str = ele.value;
        str = str.substring(0, str.length - 1);
        ele.value = str;
      }
    }





function validate_index(button_index)
{
///////////////////////////////////////Collapse1////////////////////////////////
if($('#regular_teacher').val()==''){
	alert("Please insert the number of Regular Teacher");
	$("#collapse1").collapse('show');
	$('#regular_teacher').focus();
	return false;
}
else if($('#para_teacher').val()==''){
	alert("Please insert the number of Para Teacher");
	$("#collapse1").collapse('show');
	$('#para_teacher').focus();
	return false;
}
else if($('#contractual_teacher').val()==''){
	alert("Please insert the number of Contractual Teacher");
	$("#collapse1").collapse('show');
	$('#contractual_teacher').focus();
	return false;
}


///////////////////////////////////////End of Collapse1////////////////////////////////


///////////////////////////////////////Collapse2////////////////////////////////
else if (!$('input[name=own_drinking_water_source]:checked').val()){
		alert("Select Drinking Water Source");
		$("#collapse2").collapse('show');
		$("input[name=own_drinking_water_source]").focus();       
		}
else if ($("input[name=own_drinking_water_source]:checked").val()==1 && !$('input[name=own_drinking_water_source_type]:checked').val()){
	alert("Please select the type of Drinking Water source");
	$("#collapse2").collapse('show');
	$('input[name=own_drinking_water_source_type]').focus();
	return false;
}
else if ($("input[name=own_drinking_water_source]:checked").val()==0 && !$('input[name=drinking_water_source_type]:checked').val()){
	alert("Please select the type of Drinking Water source");
	$("#collapse2").collapse('show');
	$('input[name=drinking_water_source_type]').focus();
	return false;
}
else if (!$('input[name=drinking_water_functional]:checked').val() ){
		alert("Select Drinking Water Source Is Functional"); 
		$("#collapse2").collapse('show');
		$("input[name=drinking_water_functional]").focus();    
		}
else if (!$('input[name=drinking_water_tested_in_lab]:checked').val() ){
		alert("Select Whether Drinking Water Tested In Lab Or Not");
		$("#collapse2").collapse('show');
		$("input[name=drinking_water_tested_in_lab]").focus();    
		}
else if (!$('input[name=water_arsenic_contaminated]:checked').val() ){
		alert("Select Whether Water Source Identified As Arsenic Contaminated");
		$("#collapse2").collapse('show');
		$("input[name=water_arsenic_contaminated]").focus();    
		}
else if ($("input[name=water_arsenic_contaminated]:checked").val()==1 && !$('input[name=water_treated_arsenic_free]:checked').val()){
	alert("Select whether the water treated to make it arsenic free");
	$("#collapse2").collapse('show');
	$("input[name=water_treated_arsenic_free]").focus();
}
else if (!$('input[name=water_unusable_salinity]:checked').val() ){
		alert("Select Whether Water Unusable Due To Salinity"); 
		$("#collapse2").collapse('show');
		$("input[name=water_unusable_salinity]").focus();    
		}
else if (!$('input[name=functional_water_purifier_available]:checked').val() ){
		alert("Select Whether Water Purifier Is Available"); 
		$("#collapse2").collapse('show');
		$("input[name=functional_water_purifier_available]").focus();    
		}
else if (!$('input[name=toilets_urinals_available]:checked').val() ){
		alert("Select Toilet & Urinals Available");  
		$("#collapse2").collapse('show');
		$("input[name=toilets_urinals_available]").focus();    
		}
else if(!$('input[name=toilets_regularly_cleaned]:checked').val()){
	alert("Select whether toilets are regularly cleaned");
	$("#collapse2").collapse('show');
	$("input[name=toilets_regularly_cleaned]").focus();
}
else if (!$('input[name=toilets_separated_boys_girls]:checked').val() ){
		alert("Select Separated for Boys & Girls");  
		$("#collapse2").collapse('show');
		$("input[name=toilets_separated_boys_girls]").focus();    
		}
else if ($('input[name=boys_toilet]').val() ==''){
		alert("Enter No. of Boys’ toilets");
		$("#collapse2").collapse('show');
		$("input[name=boys_toilet]").focus();     
		}
else if ($('input[name=girls_toilet]').val() ==''){
		alert("Enter No. of Girls’ toilets"); 
		$("#collapse2").collapse('show');
		$("input[name=girls_toilet]").focus();     
		}
else if (!$('input[name=toilets_hygienic_usable]:checked').val() ){
		alert("Select Toilets are hygienic & usable"); 
		$("#collapse2").collapse('show');
		$("input[name=toilets_hygienic_usable]").focus();     
		}
else if ($("input[name=toilets_hygienic_usable]:checked").val()==0 && $('#dysfunctional_toilets').val()==''){
	alert("Enter the number of dysfunctional toilets");
	$("#collapse2").collapse('show');
	$('#dysfunctional_toilets').focus();
	return false;
}
else if ($("input[name=toilets_hygienic_usable]:checked").val()==0 && !$('input[name=one_gender_specific_toilet_functional]:checked').val()){
	alert("Select whether there is at least one gender specificc toilet is functional");
	$("#collapse2").collapse('show');
	$('input[name=one_gender_specific_toilet_functional]').focus();
	return false;
}
else if (!$('input[name=pucca_kitchen]:checked').val()){
		alert("Select Having Pucca Kitchen"); 
		$("#collapse2").collapse('show');
		$("input[name=pucca_kitchen]").focus();   
		}
else if (!$('input[name=kitchen_condition]:checked').val()){
		alert("Select Condition Of Kitchen"); 
		$("#collapse2").collapse('show');
		$("input[name=kitchen_condition]").focus();  
		}
else if ($('input[name=kitchen_construction_year]').val()=='' ){
		alert("Enter Year of Construction"); 
		$("#collapse2").collapse('show');
		$("input[name=kitchen_construction_year]").focus();     
		}
else if ($('input[name=kitchen_last_repair_year]').val()=='' ){
		alert("Enter Year of Last Repair"); 
		$("#collapse2").collapse('show');
		$("input[name=kitchen_last_repair_year]").focus();    
		}
else if (!$('input[name=kitchen_regularly_cleaned]:checked').val() ){
		alert("Select Whether The Kitchen Is Regularly Cleaned");
		$("#collapse2").collapse('show');
		$("input[name=kitchen_regularly_cleaned]").focus();    
		}
else if (!$('input[name=cooking_utensils_usable]:checked').val() ){
		alert("Select Whether The Cooking Utensils Usable");
		$("#collapse2").collapse('show');
		$("input[name=cooking_utensils_usable]").focus();    
		}
else if ($('#cooking_utensils_last_replace_year').val()=='' ){
		alert("Enter the Cooking Utensils Last Replace Year");
		$("#collapse2").collapse('show');
		$('#cooking_utensils_last_replace_year').focus();    
		}
else if (!$('input[name=separate_pucca_dining_hall]:checked').val()){
		alert("Select Whether Separate Pucca Dining Hall Available or not"); 
		$("#collapse2").collapse('show');
		$("input[name=separate_pucca_dining_hall]").focus();    
		}
else if ($('input[name=separate_pucca_dining_hall]:checked').val()==0 && !$('input[name=free_space_available_for_dining_hall]:checked').val()){
		alert("Select Whether Sufficient Free Space is available within premises for construction of Dining Hall or space for vertical extension"); 
		$("#collapse2").collapse('show');
		$("input[name=free_space_available_for_dining_hall]").focus();    
		}
else if (!$('input[name=mdm_seating_arrangement]:checked').val()){
		alert("Select Seating arrangement for MDM"); 
		$("#collapse2").collapse('show');
		$("input[name=mdm_seating_arrangement]").focus();    
		}
else if (!$('input[name=school_building_status]:checked').val()){
		alert("Select status of School Building"); 
		$("#collapse2").collapse('show');
		$("input[name=school_building_status]").focus();    
		}
else if (!$('input[name=class_room_furniture_available]:checked').val()){
		alert("Select whether furniture in the classroom available or not"); 
		$("#collapse2").collapse('show');
		$("input[name=class_room_furniture_available]").focus();    
		}
else if ($('input[name=functional_class_room_number]').val()=='' ){
		alert("Enter No. of functional classrooms"); 
		$("#collapse2").collapse('show');
		$("input[name=functional_class_room_number]").focus();   
		}
else if (!$('input[name=unusable_room_available]:checked').val() ) 
		{
		alert("Select Is There Any Unusable Room"); 
		$("#collapse2").collapse('show');
		$("input[name=unusable_room_available]").focus();    
		}
else if (!$('input[name=ramp_available]:checked').val()){
		alert("Select Whether Ramp Is Available");
		$("#collapse2").collapse('show');
		$("input[name=ramp_available]").focus();      
		}
else if (!$('input[name=school_electricity_available]:checked').val()){
		alert("Select Having electricity in school");
		$("#collapse2").collapse('show');
		$("input[name=school_electricity_available]").focus();    
		}
else if (!$('input[name=school_boundary_wall_fencing_available]:checked').val()){
		alert("Select whether School have Boundary Wall/ Fencing or not");
		$("#collapse2").collapse('show');
		$("input[name=school_boundary_wall_fencing_available]").focus();    
		}


///////////////////////////////////////End of Collapse2////////////////////////////////



////////////////////////////////////
///////////////////////////////////  collapse4
//////////////////////////////////
else if (!$('input[name=weekly_menu_board]:checked').val())
		{
		alert("Select Weekly Menu Board");
		$("#collapse4").collapse('show');
		$("input[name=weekly_menu_board]").focus();   
		}
else if (!$('input[name=displaying_mdm_logo]:checked').val())
		{
		alert("Select Displaying MDM Logo");
		$("#collapse4").collapse('show');
		$("input[name=displaying_mdm_logo]").focus();     
		}
else if (!$('input[name=fire_extinguisher]:checked').val())
		{
		alert("Select Fire Extinguisher");
		$("#collapse4").collapse('show');
		$("input[name=fire_extinguisher]").focus();    
		}
else if ($('input[name=fire_extinguisher]:checked').val()=='1' && !$('input[name=fire_extinguisher_working]:checked').val())
		{
		alert("Select Whether Fire Extinguisher Is In Working Condition");
		$("#collapse4").collapse('show');
		$("input[name=fire_extinguisher_working]").focus();    
		}
/*else if ($('input[name=fire_extinguisher_working]:checked').val()=='1' && $('#fire_extinguisher_valid_upto').val()=='')
		{
		alert("Select Fire Extinguisher Valid Upto Date");
		$("#collapse4").collapse('show');
		$("#fire_extinguisher_valid_upto").focus();    
		}
else if ($('input[name=fire_extinguisher_working]:checked').val()=='0' && !$('input[name=fire_extinguisher_required_refilling_replace]:checked').val())
		{
		alert("Select Fire Extinguisher Requirement");
		$("#collapse4").collapse('show');
		$("input[name=fire_extinguisher_required_refilling_replace]").focus();   
		}*/
else if (!$('input[name=register_food_grain]:checked').val())
		{
		alert("Select Maintaining Proper Register For Food Grain");
		$("#collapse4").collapse('show');
		$("input[name=register_food_grain]").focus();    
		}
else if (!$('input[name=one_month_buffer_stock_rice]:checked').val())
		{
		alert("Select Maintenance of one month’s buffer stock (Rice)"); 
		$("#collapse4").collapse('show');
		$("input[name=one_month_buffer_stock_rice]").focus();   
		}
else if (!$('input[name=supplied_rice_quality]:checked').val())
		{
		alert("Select Quality Of Supplier Rice");
		$("#collapse4").collapse('show');
		$("input[name=supplied_rice_quality]").focus();     
		}
else if (!$('input[name=rice_stored_school_properly]:checked').val())
		{
		alert("Select Whether Rice is stored at school properly(in bin / raised platform)");
		$("#collapse4").collapse('show');
		$("input[name=rice_stored_school_properly]").focus();      
		}
else if (!$('input[name=receives_cooking_cost_regularly]:checked').val())
		{
		alert("Select Whether school receives Cooking Conversion Cost regularly");
		$("#collapse4").collapse('show');
		$("input[name=receives_cooking_cost_regularly]").focus();    
		}
else if (!$('input[name=mdm_cash_book_maintain]:checked').val())
		{
		alert("Select Maintaining MDM Cash Book");
		$("#collapse4").collapse('show');
		$("input[name=mdm_cash_book_maintain]").focus();    
		}
else if ($('input[name=mdm_cash_book_maintained_upto]').val()=='' ) 
		{
		alert("Enter Cash Book Updated Up To (dd/MM/yyyy)"); 
		$("#collapse4").collapse('show');
		$("input[name=mdm_cash_book_maintained_upto]").focus();   
		}
else if (!$('input[name=meal_tested_before_served]:checked').val())
		{
		alert("Select Whether The Cooked Meal Was Tasted at least half an hour before serving");
		$("#collapse4").collapse('show');
		$("input[name=meal_tested_before_served]").focus();   
		}
else if ($('input[name=meal_tested_before_served]:checked').val()==1 && !$('input[name=meal_tasted_teacher]:checked').val())
		{
		alert("Select Whether Meal Tasted by Teacher");
		$("#collapse4").collapse('show');
		$("input[name=meal_tasted_teacher]").focus();    
		}
else if ($('input[name=meal_tested_before_served]:checked').val()==1 && !$('input[name=meal_tasted_cch]:checked').val())
		{
		alert("Select Whether Meal Tasted by CCH");
		$("#collapse4").collapse('show');
		$("input[name=meal_tasted_cch]").focus();    
		}
else if ($('input[name=meal_tested_before_served]:checked').val()==1 && !$('input[name=meal_tasted_parents]:checked').val())
		{
		alert("Select Whether Meal Tasted by Parents");
		$("#collapse4").collapse('show');
		$("input[name=meal_tasted_parents]").focus();   
		}
else if ($('input[name=meal_tested_before_served]:checked').val()==1 && !$('input[name=meal_tasted_other]:checked').val())
		{
		alert("Select Whether Meal Tasted by Others");
		 $("#collapse4").collapse('show');
		$("input[name=meal_tasted_other]").focus();   
		}
else if (!$('input[name=daily_meal_tasting_register_maintained]:checked').val())
		{
		alert("Select Whether daily meal tasting register is maintained");
		$("#collapse4").collapse('show');
		$("input[name=daily_meal_tasting_register_maintained]").focus();    
		}
else if (!$('input[name=separate_bank_ac_mdm]:checked').val())
		{
		alert("Select Having separate bank A/C for MDM");
		$("#collapse4").collapse('show');
		$("input[name=separate_bank_ac_mdm]").focus();    
		}
else if (!$('input[name=cch_honorarium_regular]:checked').val())
		{
		alert("Select Whether Cook Cum Helpers Get Honorarium Regularly");
		$("#collapse4").collapse('show');
		$("input[name=cch_honorarium_regular]").focus();   
		}
else if (!$('input[name=all_cooks_have_bank_ac]:checked').val())
		{
		alert("Select Whether all Cooks have Bank Account");
		$("#collapse4").collapse('show');
		$("input[name=all_cooks_have_bank_ac]").focus();   
		}
else if (!$('input[name=cooks_receive_honorarium_through]:checked').val())
		{
		alert("Select how Cooks receive honorarium through");
		$("#collapse4").collapse('show');
		$("input[name=cooks_receive_honorarium_through]").focus();   
		}
else if (!$('input[name=school_daily_report_sms]:checked').val())
		{
		alert("Select Whether the school sends daily report by SMS");
		$("#collapse4").collapse('show');
		$("input[name=school_daily_report_sms]").focus();   
		}
else if (!$('input[name=cooking_mode]:checked').val())
		{
		alert("Select Mode Of Cooking");
		$("#collapse4").collapse('show');
		$("input[name=cooking_mode]").focus();    
		}
else if (!$('input[name=cooks_change_dress]:checked').val())
		{
		alert("Select Whether Cooks Change Their Dress Before starting work"); 
		$("#collapse4").collapse('show');
		$("input[name=cooks_change_dress]").focus();   
		}
else if (!$('input[name=cooks_use_apron_gloves]:checked').val())
		{
		alert("Select Whether Cooks use Apron / Gloves during cooking");
		$("#collapse4").collapse('show');
		$("input[name=cooks_use_apron_gloves]").focus();    
		}
else if (!$('input[name=food_grains_washed]:checked').val())
		{
		alert("Select Whether food grains is washed properly raw vegetables are washed before & after chopping / Cutting");
		$("#collapse4").collapse('show');
		$("input[name=food_grains_washed]").focus();     
		}
else if (!$('input[name=kitchen_garden_avalable]:checked').val())
		{
		alert("Select Whether Kitchen Garden is available or not");
		$("#collapse4").collapse('show');
		$("input[name=kitchen_garden_avalable]").focus();     
		}
else if (!$('input[name=school_received_plate_glasses]:checked').val())
		{
		alert("Select Whether school received Plate and Glasses");
		$("#collapse4").collapse('show');
		$("input[name=school_received_plate_glasses]").focus();     
		}
else if (!$('input[name=hand_wash_practiced]:checked').val())
		{
		alert("Select Whether Hand wash is practiced before and after MDM");
		$("#collapse4").collapse('show');
		$("input[name=hand_wash_practiced]").focus();    
		}
else if (!$('input[name=mdm_served_through_central_kitchen]:checked').val())
		{
		alert("Select Whether Mid-Day Meal is served through Central Kitchen");
		$("#collapse4").collapse('show');
		$("input[name=mdm_served_through_central_kitchen]").focus();    
		}
else if (!$('input[name=govt_pr_visited_previous_one_month]:checked').val())
		{
		alert("Select Whether any Govt. / PR body officials visited the school during the previous one month");
		$("#collapse4").collapse('show');
		$("input[name=govt_pr_visited_previous_one_month]").focus();    
		}
else if (!$('input[name=agmark_sealed_oil_used]:checked').val())
		{
		alert("Select Whether AGMARK sealed oil is used in MDM cooking");
		$("#collapse4").collapse('show');
		$("input[name=agmark_sealed_oil_used]").focus();   
		}
else if (!$('input[name=branded_packaged_condiments_used]:checked').val())
		{
		alert("Select Whether branded packaged condiments (Mashlapati) are used");
		$("#collapse4").collapse('show');
		$("input[name=branded_packaged_condiments_used]").focus();    
		}
/*else if (!$('input[name=students_wash_hands]:checked').val())
		{
		alert("Select Whether the students wash hands with soap before taking MDM"); 
		$("#collapse4").collapse('show');
		$("input[name=students_wash_hands]").focus();   
		}*/
else if (!$('input[name=double_fortified_salt]:checked').val())
		{
		alert("Select Whether double fortified salt (enriched with iron & iodine)");
		$("#collapse4").collapse('show');
		$("input[name=double_fortified_salt]").focus();    
		}
else if (!$('input[name=health_checkup_card_maintained_regular]:checked').val())
		{
		alert("Select Whether regular health check up is done in the school with maintenance of health card");
		$("#collapse4").collapse('show');
		$("input[name=health_checkup_card_maintained_regular]").focus();    
		}
else if (!$('input[name=bdo_name_phno_display]:checked').val())
		{
		alert("Select Whether Name and Phone number of BDO displaying or not");
		$("#collapse4").collapse('show');
		$("input[name=bdo_name_phno_display]").focus();    
		}
else if (!$('input[name=concerned_si_name_phno_display]:checked').val())
		{
		alert("Select Whether Name and Phone number of concerned SI is displaying or not");
		$("#collapse4").collapse('show');
		$("input[name=concerned_si_name_phno_display]").focus();    
		}

///////////////////////////////////////////////////
////////////////////////////////////////////////
else if (!$('input[name=irregularity_found]:checked').val())
		{
		alert("Select Whether any Irregularity found during inspection");
		$("#collapse5").collapse('show');
		$("input[name=irregularity_found]").focus();	
		}

else if ($('input[name=irregularity_found]:checked').val() == 1 && ((!$('input[name=rice_irregularity]:checked').val()) && (!$('input[name=fund_irregularity]:checked').val()) && (!$('input[name=mdm_takers_number_irregularity]:checked').val()) && (!$('input[name=ssm_fund_related_irregularity]:checked').val()) &&(!$('input[name=cch_irregularity]:checked').val()) && (!$('input[name=other_irregularity]:checked').val()))){
		alert("Select Irregularity Related to");
		$("#collapse5").collapse('show');
		$("input[name=irregularity_found]").focus(); 
}
else if ($('input[name=irregularity_found]:checked').val() == 1 && $('#detail_irregularity').val()==''){
         alert("Enter Irregularity in detail");
         $("#collapse5").collapse('show');   
         $('#detail_irregularity').focus(); 
       }

else if ($('input[name=improvement_suggestion]').val()=='') 
		{
		alert("Enter Suggestion for further improvement");
		$("#collapse5").collapse('show');
		$("input[name=improvement_suggestion]").focus();    
		}
else if (!$('input[name=improvement_required_smooth_functioning]:checked').val())
		{
		alert("Select Is any improvement is required for smooth functioning of MDM");
		$("#collapse5").collapse('show');
		$("input[name=improvement_required_smooth_functioning]").focus();    
		}
else if ($('input[name=improvement_required_smooth_functioning]:checked').val()==1 && $('#suggestion_smooth_functioning_mdm').val()=='')
		{
		alert("Please Mention the Improvement Requirement for smooth functioning of MDM");
		$("#collapse5").collapse('show');
		$("#suggestion_smooth_functioning_mdm").focus();    
		}
else if($("#smallImage0").attr('src')=='images/img-load.jpg')
		{
			alert('Please capture photo Live MDM serving / MDM eating!');
			$("#collapse3").collapse('show');
			$("#smallImage0").focus();
			return false;
		}							
else if($("#smallImage").attr('src')=='images/img-load.jpg')
		{
			alert('Please capture photo School Premises!');
			$("#collapse3").collapse('show');
			$("#smallImage").focus();
			return false;
		}
else if($("#smallImage1").attr('src')=='images/img-load.jpg')
		{
			alert('Please capture photo Toilets!');
			$("#collapse3").collapse('show');
			$("#smallImage1").focus();
			return false;
		}
else if($("#smallImage2").attr('src')=='images/img-load.jpg')
		{
			alert('Please capture photo Drinking water source!');
			$("#collapse3").collapse('show');
			$("#smallImage2").focus();
			return false;
		}
else if($("#smallImage3").attr('src')=='images/img-load.jpg')
		{
			alert('Please capture photo Kitchen!');
			$("#collapse3").collapse('show');
			$("#smallImage3").focus();
			return false;
		}
else if($("#smallImage4").attr('src')=='images/img-load.jpg')
		{
			alert('Please capture photo Others!');
			$("#collapse3").collapse('show');
			$("#smallImage4").focus();
			return false;
		}
else if(latitude=='' || longitude==''){
	alert("Please Turn On GPS/Location of Your Device");
	checkAvailability();
	return false;	
}
else
		{
			//alert("ok");
			var buttonIndex=button_index
			after_validation(buttonIndex);
		}
 //////////////////////////////////////////////////////////////////////     here to last 	
 /////////////////////////////////////////////////////////////////////////////////	
}
  ////////////////////// After validation
  function after_validation(buttonIndex)
  {
			$('#inspection_date').val(local_date_new);			
			$('#latitude').val(latitude);
			$('#longitude').val(longitude);
			$('#state_code_fk').val('1');
			$('#authority_status').val('1');			
			$('#district_code_fk').val(district_code_fk);
			$('#circle_code_fk').val(circle_code_fk);
			$('#block_code_fk').val(block_code_fk);
			$('#subdiv_code_fk').val(subdiv_code_fk);
			$('#school_code_fk').val(school_code_pk);
			$('#schcd').val(schcd);
			$('#incharge_contact_code_fk').val(contact_code_pk);
			$('#profile_code_fk').val(localStorage.getItem("profile_code_pk"));
			$('#inspector_phno_citizen').val(localStorage.getItem("profile_mobile_no"));
			$('#mdm_in_charge_name').val(mdm_in_charge_name);
			$('#contact_no').val(contact_no);
			$('#running_y_n').val(running_y_n);
			$('#not_running_cause').val(not_running_cause);
			$('#pre_primary_enroll').val(pre_primary);
			$('#class_i_enroll').val(class_i);
			$('#class_ii_enroll').val(class_ii);
			$('#class_iii_enroll').val(class_iii);
			$('#class_iv_enroll').val(class_iv);
			$('#class_v_enroll').val(class_v);
			$('#class_vi_enroll').val(class_vi);
			$('#class_vii_enroll').val(class_vii);
			$('#class_viii_enroll').val(class_viii);
			$('#pre_primary_coverage').val(coverage_arr_pre_primary);
			$('#class_i_iv_coverage').val(coverage_arr_class_i_iv);
			$('#class_v_coverage').val(coverage_arr_class_v);
			$('#class_vi_viii_coverage').val(coverage_arr_class_vi_viii);
			$('#contact_code_pk').val(contact_code_pk);
		 image0=(document.getElementById('smallImage0').src);
			localStorage.setItem("image0",image0);
		 image=(document.getElementById('smallImage').src);
			localStorage.setItem("image",image);
		 image1=(document.getElementById('smallImage1').src);
			localStorage.setItem("image1",image1);
		 image2=(document.getElementById('smallImage2').src);
			localStorage.setItem("image2",image2);
		 image3=(document.getElementById('smallImage3').src);
			localStorage.setItem("image3",image3);
		 image4=(document.getElementById('smallImage4').src);
			localStorage.setItem("image4",image4);
		$('#serving_eating_picture').val(image0);
		$('#school_premises_picture').val(image);
		$('#toilets_picture').val(image1);
		$('#drinking_water_source_picture').val(image2);
		$('#kitchen_picture').val(image3);
		$('#other_picture').val(image4);
		var mobile_no = localStorage.getItem("phno");
		var inspection_date=local_date_new;
		var school_code_fk = school_code_pk;
		totaldata = $('#validate').serialize();	
		console.log(totaldata);
	/////////////////////     checking network connection



	if(navigator.onLine==true) 
	{
		//alert("online");
		//alert(school_code_pk);
		//alert(buttonIndex);
		if(buttonIndex==1)
		{
			$("#preloader").fadeIn();
				$.ajax({
					type: "POST",
					//url: "https://mdm.wbsed.gov.in/Inspection_Apps/mdm_inspection_app/mdm/school_inspection_officer_data_all_insert",
					//url: "http://192.168.0.238:81/mdmwbsed/Inspection_Apps/mdm_inspection_app/mdm/school_inspection_officer_data_all_insert",
					url: "https://pmposhan.wb.gov.in/Inspection_Apps/Mdm/school_inspection_officer_data_all_insert_test",
					data: $('#validate').serialize(),   			
					dataType:"JSON",
					success: function(result)
					{
						console.log(result);
						alert(result.msg);
						if(result.status=="1")
						{
							localStorage.removeItem('image0');
							localStorage.removeItem('image');
							localStorage.removeItem('image1');
							localStorage.removeItem('image2');
							localStorage.removeItem('image3');
							localStorage.removeItem('image4');
							window.location="officer_Dashboard.html"
						}
						$("#preloader").fadeOut();				
					}
				});
		}
		else if(buttonIndex==2)
		{
			localdb(mobile_no,inspection_date,school_code_fk,totaldata,image0,image,image1,image2,image3,image4);
		}

		/*navigator.notification.confirm(
	        'Do you want to save the Inspection Data Locally?',  // message
	        function(buttonIndex){																// callback to invoke with index of button pressed
	        	onConfirm(buttonIndex);
	        },			
	        'Please Select',            													// title
	        ['Yes','No']          																// buttonLabels
	      );
		function onConfirm(buttonIndex){
			//alert(buttonIndex);
			if(buttonIndex===1){
				localdb(mobile_no,inspection_date,school_code_fk,totaldata,image0,image,image1,image2,image3,image4);
			}
			else if(buttonIndex===2){
				$("#preloader").fadeIn();
				$.ajax({
					type: "GET",
					//url: "https://mdm.wbsed.gov.in/Inspection_Apps/mdm_inspection_app/mdm/school_inspection_officer_data_all_insert",
					//url: "http://192.168.0.238:81/mdmwbsed/Inspection_Apps/mdm_inspection_app/mdm/school_inspection_officer_data_all_insert",
					url: "https://pmposhan.wb.gov.in/Inspection_Apps/Mdm/school_inspection_officer_data_all_insert",
					data: $('#validate').serialize(),   			
					dataType:"JSON",
					success: function(result)
					{
					console.log(result);
					alert(result.msg);
					if(result.status=="1")
					{
						localStorage.removeItem('image0');
						localStorage.removeItem('image');
						localStorage.removeItem('image1');
						localStorage.removeItem('image2');
						localStorage.removeItem('image3');
						localStorage.removeItem('image4');
						window.location="officer_Dashboard.html"
					}
						$("#preloader").fadeOut();				
					}
					});
			}
		}*/
	}
		////////////// Internet Connection Checking Ends
		
		/////////////////////////// If No Internet Connection
		else
		{
		  alert("No Internet connection Stored locally");   		
		  localdb(mobile_no,inspection_date,school_code_fk,totaldata,image0,image,image1,image2,image3,image4);	
		}
  }  
/////////////////////////////////////////////////// online inser after pic names
  
 //////////////////////////////////////////////////////////
 function stringToArrayBuffer(str) {
    var buf = new ArrayBuffer(str.length*2); // 2 bytes for each char
    var bufView = new Uint16Array(buf);
    for (var i=0, strLen=str.length; i < strLen; i++) {
        bufView[i] = str.charCodeAt(i);
    }
    return buf;
};

function arrayBufferToString(buf) {
    return String.fromCharCode.apply(null, new Uint16Array(buf));
};
 
 
//////////////////////////////////////////////////////////
 /////////////////////////////////////////////
///ofline insert////
function localdb(mobile_no,inspection_date,school_code_fk,totaldata,image0,image,image1,image2,image3,image4)
	{
	$("#preloader").fadeIn();
 //////////////// Securing localdata ///////////////////////
	//var total_data = totaldata;	
	var totaldata1 = totaldata;	
	var img0 = image0;	
	var img = image;	
	var img1 = image1;	
	var img2 = image2;	
	var img3 = image3;	
	var img4 = image4;	
	/////////////////////////////////
	var secret = localStorage.getItem("phno");
    
  var mobile_no = mobile_no;
  var inspection_date = inspection_date;
  var school_code_fk = school_code_fk;
	var plainText = totaldata1;
	var ImgText0 = image0;
	var ImgText1 = image;
	var ImgText2 = image1;
	var ImgText3 = image2;
	var ImgText4 = image3;
	var ImgText5 = image4;
	
	//var encrypted = CryptoJS.AES.encrypt(plainText, secret);
	
	var encryptedI1 = CryptoJS.AES.encrypt(ImgText0, secret);
	var encryptedI2 = CryptoJS.AES.encrypt(ImgText1, secret);
	var encryptedI3 = CryptoJS.AES.encrypt(ImgText2, secret);
	var encryptedI4 = CryptoJS.AES.encrypt(ImgText3, secret);
	var encryptedI5 = CryptoJS.AES.encrypt(ImgText4, secret);
	var encryptedI6 = CryptoJS.AES.encrypt(ImgText5, secret);
	
	
////////////////////////////////////////////////////	
	db.transaction(function(tx) {
	tx.executeSql('INSERT INTO InspectionFormTable VALUES (?,?,?,?,?,?,?,?,?,?)', [mobile_no,inspection_date,school_code_fk,plainText,encryptedI1,encryptedI2,encryptedI3,encryptedI4,encryptedI5,encryptedI6]);   
  }, function(error) {
  var myJSON = JSON.stringify(error);
  //alert(myJSON);
  alert("UN - Succesfully submitted into localDB");
  }, function() {
	$("#preloader").fadeOut();	
		alert("Succesfully submitted into local Database");
		localStorage.removeItem('image0');
		localStorage.removeItem('image');
		localStorage.removeItem('image1');
		localStorage.removeItem('image2');
		localStorage.removeItem('image3');
		localStorage.removeItem('image4');
		window.location="officer_offline_history.html";
  });
}
///ofline insert////
			
	

   
   
   
   function capturePhotoEdit(a) {
	appState.takingPicture = true;
	 divid=a;
      navigator.camera.getPicture(onPhotoDataSuccess, onFail, {
      	quality: 30, 
				allowEdit: false,
				targetWidth: 1024,
				targetHeight: 1024,
				destinationType: Camera.DestinationType.DATA_URL,
				encodingType: Camera.EncodingType.JPG,
				correctOrientation: true
				});
		}
         function onPhotoDataSuccess(imageData) {
			appState.takingPicture = false;
			appState.imageUrl = "data:image/jpeg;base64," + imageData;
			localStorage.setItem('image_div_id',divid);
			//alert(imageData);		
			var imageData;      
			var smallImage = document.getElementById(divid);
			smallImage.style.display = 'block';
			smallImage.src = "data:image/jpeg;base64," + imageData;
		}
        function onFail(message) {
			appState.takingPicture = false;
			alert('Failed because: ' + message);
		}

		
	