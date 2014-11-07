/**
 *  Copyright 2009 Society for Health Information Systems Programmes, India (HISP India)
 *
 *  This file is part of Patient-dashboard module.
 *
 *  Patient-dashboard module is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  Patient-dashboard module is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Patient-dashboard module.  If not, see <http://www.gnu.org/licenses/>.
 *
*/

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
						
					jQuery("#investigation").autocomplete('autoCompleteInvestigation.htm', {
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
							DASHBOARD.onChangeDiagnosis('investigation',item.value, item.text);
						});
						
					jQuery("#drugName").autocomplete('autoCompleteDrug.htm', {
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
							DASHBOARD.onChangeDiagnosis('drug',item.value, item.text);
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
			
	    jQuery("#investigation").autocomplete('autoCompleteInvestigation.htm', {
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
				DASHBOARD.onChangeDiagnosis('investigation',item.value, item.text);
			});
			
		 jQuery("#drugName").autocomplete('autoCompleteDrug.htm', {
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
				DASHBOARD.onChangeDiagnosis('drug',item.value, item.text);
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



