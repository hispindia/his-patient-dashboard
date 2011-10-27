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

DASHBOARD={
		load : function(url , container)
		{
			jQuery(container).load(url);
		},
		onChangeDianosis : function(id)
		{
			var text = jQuery("#"+id).val();
			if(text != null && text != ''){
				if(SESSION.checkSession()){
					var data = jQuery.ajax(
							{
								type:"GET"
								,url: "comboboxDianosis.htm"
								,data: ({text: text})	
								,async: false
								, cache : false
							}).responseText;
					if(data != undefined  && data != null && data != ''){
						jQuery("#divAvailableDiagnosisList").html("");
						jQuery("#divAvailableDiagnosisList").html(data);
					}
				}
			}
		},
		onChangeProcedure : function(id)
		{
			var text = jQuery("#"+id).val();
			if(text != null && text != ''){
				if(SESSION.checkSession()){
					var data = jQuery.ajax(
							{
								type:"GET"
								,url: "comboboxProcedure.htm"
								,data: ({text: text})	
								,async: false
								, cache : false
							}).responseText;
					if(data != undefined  && data != null && data != ''){
						jQuery("#divAvailableProcedureList").html("");
						jQuery("#divAvailableProcedureList").html(data);
					}
				}
			}
		},
		submitOpdEntry : function(){
				jQuery('#selectedDiagnosisList option').each(function(i) {  
					 jQuery(this).attr("selected", "selected");  
				}); 
				jQuery('#selectedProcedureList option').each(function(i) {  
					 jQuery(this).attr("selected", "selected");  
				}); 
				jQuery("#opdEntryForm").submit();
		},
		detailClinical : function(id)
		{
			if(SESSION.checkSession()){
				url = "detailClinical.htm?id="+id+"&keepThis=false&TB_iframe=true&height=300&width=500";
				tb_show(" ",url,false);
			}
		},
		showAllDiagnosis : function()
		{
			if(SESSION.checkSession()){
				var patientId = jQuery("#patientId").val();
				var opdId = jQuery("#opdId").val();
				var queueId = jQuery("#queueId").val();
				var referralId = jQuery("#referralId").val();
				url = "showAllDiagnosis.htm?patientId="+patientId+"&opdId="+opdId+"&queueId="+queueId+"&referralId="+referralId+"&keepThis=false&TB_iframe=true&height=600&width=1000";
				tb_show("All diagnosis",url,false);
			}
		},
		onChangeDiagnosis : function(container, id, name)
		{
			if(container == 'diagnosis'){
				
				var exists = false;
				jQuery('#selectedDiagnosisList option').each(function(){
				    if (this.value == id) {
				        exists = true;
				        return false;
				    }
				});
				if(exists){
					alert('It\'s existed!');
					return false;
				}
				exists = false;
				jQuery('#availableDiagnosisList option').each(function(){
				    if (this.value == id) {
				        exists = true;
				        return false;
				    }
				});
				jQuery("#diagnosis").val("");
				if(exists){
					jQuery("#availableDiagnosisList option[value=" +id+ "]").appendTo("#selectedDiagnosisList");
					jQuery("#availableDiagnosisList option[value=" +id+ "]").remove();
				}else{
					jQuery('#selectedDiagnosisList').append('<option value="' + id + '">' + name + '</option>');
					if(confirm("Do you want also add this diagnosis to opd diagnosis?"))
					{
						jQuery.ajax({
							  type: 'POST',
							  url: 'addConceptToWard.htm',
							  data: {opdId: jQuery("#"+container).attr("title"), conceptId: id, typeConcept: 1}
							});
					}
				}
			}
			if(container == 'procedure'){
				var exists = false;
				jQuery('#selectedProcedureList option').each(function(){
				    if (this.value == id) {
				        exists = true;
				        return false;
				    }
				});
				if(exists){
					alert('It\'s existed!');
					return false;
				}
				exists = false;
				jQuery('#availableProcedureList option').each(function(){
				    if (this.value == id) {
				        exists = true;
				        return false;
				    }
				});
				jQuery("#procedure").val("");
				if(exists){
					jQuery("#availableProcedureList option[value=" +id+ "]").appendTo("#selectedProcedureList");
					jQuery("#availableProcedureList option[value=" +id+ "]").remove();
				}else{
					jQuery('#selectedProcedureList').append('<option value="' + id + '">' + name + '</option>');
					if(confirm("Do you want also add this procedure to opd procedure?"))
					{
						jQuery.ajax({
							  type: 'POST',
							  url: 'addConceptToWard.htm',
							  data: {opdId: jQuery("#"+container).attr("title"), conceptId: id, typeConcept: 2}
							});
					}
				}
			}
		},
		onChangeRadio : function(thiz)
		{
			var text = jQuery(thiz).val();
			if(text != null && text !='' && text == 'admit'){
				jQuery(".tdIpdWard").show();
			}else{
				jQuery(".tdIpdWard").hide();
			}
		},
		backToQueue : function(queueId)
		{
			ACT.go('backToOpdQueue.htm?queueId='+queueId);
		},
		onClickFollowDate : function(thiz)
		{
			jQuery('input#input_follow').attr('checked', true);
		}
		
};

ADMITTED = {
		discharge: function(id)
		{
			if(SESSION.checkSession())
			{
				
				var url = "discharge.htm?id="+id+"&keepThis=false&TB_iframe=true&height=500&width=1000";
				tb_show("Discharge",url,false);
			}
		},
		changeFinalResult : function(id)
		{
			var url = "changeFinalResult.htm?id="+id+"&keepThis=false&TB_iframe=true&height=500&width=1000";
			tb_show("Final Result",url,false);
		},
		submitIpdFinalResult : function(){
			jQuery('#selectedDiagnosisList option').each(function(i) {  
				 jQuery(this).attr("selected", "selected");  
			}); 
			jQuery('#selectedProcedureList option').each(function(i) {  
				 jQuery(this).attr("selected", "selected");  
			}); 
			jQuery("#finalResultForm").submit();
		}
};
DIAGNOSIS = {
		 chooseOption : function(thiz)
		 {
			 var x = jQuery(thiz).val();
			 var name = jQuery(thiz).attr("title");
			 if(x != null){
				
				if(jQuery(thiz).attr('checked')){
					if(self.parent.jQuery("#selectedDiagnosisList option[value="+x+"]").length <= 0){
						//obj.appendTo(self.parent.jQuery("#selectedDiagnosisList"));
						self.parent.jQuery("#selectedDiagnosisList").append("<option value="+x+">"+name+"</option>")
					}
					//obj.attr("selected", "selected");  
				 }else{
					//obj.attr("selected", "");  
					if(self.parent.jQuery("#selectedDiagnosisList option[value="+x+"]").length > 0){
						self.parent.jQuery("#selectedDiagnosisList").remove(self.parent.jQuery("#selectedDiagnosisList option[value="+x+"]"));
					}
				 }
			 }
		 },
		 close : function()
		 {
			 self.parent.tb_remove();
		 }
		 
};


