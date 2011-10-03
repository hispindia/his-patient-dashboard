

var EVT =
{
	ready : function()
	{
		/**
		 * Page Actions
		 */
		var enableCheck = true;
		var pageId = jQuery("#pageId").val();
		if(enableCheck && pageId != undefined && eval("CHECK." + pageId))
		{
			eval("CHECK." + pageId + "()");
		}
		
		

		/**
		 * Ajax Indicator when send and receive data
		 */
		if(jQuery.browser.msie)
		{
			jQuery.ajaxSetup({cache: false});
		}
	
	}
};

var CHECK = 
{
	
	patientDashboard : function()
	{
		 jQuery("#tabs").tabs({cache: true, 
             load : function(event, ui)
             { 
				
			 	var $tabs = $("#tabs").tabs();
				var selected = $tabs.tabs('option', 'selected');
				if( selected == 0 ){
					// OPD ENTRY FORM
				 	
					jQuery("#diagnosis").autocomplete('autoCompleteDiagnosis.htm', {
						delay:1000,
						scroll: true,
						 parse: function(xml){
				                var results = [];
				                $(xml).find('item').each(function() {
				                    var text = $.trim($(this).find('text').text());
				                    var value = $.trim($(this).find('value').text());
				                    results[results.length] = { 'data': { text: text, value: value },
				                        'result': text, 'value': value
				                    };
				                });
				                return results;

						 },
						formatItem: function(data) {
							  return data.text;
						},
						formatResult: function(data) {
						      return data.text;
						}
						  
						}).result(function(event, item) {
							DASHBOARD.onChangeDiagnosis('diagnosis',item.value, item.text);
						});
					
					
					jQuery("#procedure").autocomplete('autoCompleteProcedure.htm', {
						delay:1000,
						scroll: true,
						 parse: function(xml){
				                var results = [];
				                $(xml).find('item').each(function() {
				                    var text = $.trim($(this).find('text').text());
				                    var value = $.trim($(this).find('value').text());
				                    results[results.length] = { 'data': { text: text, value: value },
				                        'result': text, 'value': value
				                    };
				                });
				                return results;

						 },
						formatItem: function(data) {
							  return data.text;
						},
						formatResult: function(data) {
						      return data.text;
						}
						  
						}).result(function(event, item) {
							DASHBOARD.onChangeDiagnosis('procedure',item.value, item.text);
						});
		
					
					jQuery('.date-pick').datepicker({yearRange:'c-30:c+30', dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true,minDate:'0'});
					//jQuery('#diagnosisList').listnav();
					var validator = jQuery("#opdEntryForm").validate(
							{
								
								event : "blur",
								rules : 
								{
								
									"selectedDiagnosisList" : { required : true},
									"radio_f" : { required : true},
									"dateFollowUp" : {
							            required: {
							                depends: function() {
							                    return (jQuery("input[name='radio_f']:checked").val() == 'follow'? true : false);
							                }
							            }
							        },
							        "ipdWard" : {
							            required: {
							                depends: function() {
							                    return (jQuery("input[name='radio_f']:checked").val() == 'admit'? true : false);
							                }
							            }
							        }
									
								}
							});
					
				}
				if( selected == 2 ){
					// INVESTIGATION REPORT
					jQuery("#tree").checkTree();
					$('#investigationForm').ajaxForm({
						target: '#resultContainer'
					});
				}
             }
             });
		 
		 
	
	
	},
	dischagePage: function(){
		var validator = jQuery("#dischargeForm").validate(
				{
					event : "blur",
					rules : 
					{
						"outCome" : { required : true},
					}
				});
	},
	finalResultPage: function(){
		var validator = jQuery("#finalResultForm").validate(
				{
					event : "blur",
					rules : 
					{
						"selectedDiagnosisList" : { required : true},
					}
				});
		
		jQuery("#diagnosis").autocomplete('autoCompleteDiagnosis.htm', {
			delay:1000,
			scroll: true,
			 parse: function(xml){
	                var results = [];
	                $(xml).find('item').each(function() {
	                    var text = $.trim($(this).find('text').text());
	                    var value = $.trim($(this).find('value').text());
	                    results[results.length] = { 'data': { text: text, value: value },
	                        'result': text, 'value': value
	                    };
	                });
	                return results;

			 },
			formatItem: function(data) {
				  return data.text;
			},
			formatResult: function(data) {
			      return data.text;
			}
			  
			}).result(function(event, item) {
				DASHBOARD.onChangeDiagnosis('diagnosis',item.value, item.text);
			});
		
		
		jQuery("#procedure").autocomplete('autoCompleteProcedure.htm', {
			delay:1000,
			scroll: true,
			 parse: function(xml){
	                var results = [];
	                $(xml).find('item').each(function() {
	                    var text = $.trim($(this).find('text').text());
	                    var value = $.trim($(this).find('value').text());
	                    results[results.length] = { 'data': { text: text, value: value },
	                        'result': text, 'value': value
	                    };
	                });
	                return results;

			 },
			formatItem: function(data) {
				  return data.text;
			},
			formatResult: function(data) {
			      return data.text;
			}
			  
			}).result(function(event, item) {
				DASHBOARD.onChangeDiagnosis('procedure',item.value, item.text);
			});
	}
	
};

/**
 * Pageload actions trigger
 */

jQuery(document).ready(
	function() 
	{
		EVT.ready();
	}
);



