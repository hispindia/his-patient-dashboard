 <%--
 *  Copyright 2013 Society for Health Information Systems Programmes, India (HISP India)
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
 *  author:ghanshyam
 *  date:6-april-2013
 *  issue:#554 Radiology record
--%> 
<%@ include file="/WEB-INF/template/include.jsp" %>
<script type="text/javascript">
	var mode = "${mode}";
	jQuery(document).ready(function(){
		if(mode=="view"){
			fillData();
			makeForView();			
		} else if (mode=="edit"){
			fillData();
		} else if (mode=="preview"){
			
		}
		addValidations();		
	});
	
	// Add required class
	function addValidations(){
		jQuery("#form_content input").each(function(index){
			input = jQuery(this);
			input.addClass("required");
			input.attr("title", "Required!");
		});
		
		jQuery("#form_content select").each(function(index){
			select = jQuery(this);			
			select.addClass("required");
			select.attr("title", "Required!");
		});
		
		jQuery("#form_content textarea").each(function(index){
			textarea = jQuery(this);			
			textarea.addClass("required");
			textarea.attr("title", "Required!");
		});
	}
	
	// Make all inputs for view (hide box, dropdown)
	function makeForView(){
		jQuery("#form_content input").each(function(index){
			input = jQuery(this);
			input.css("border", "0px");
			input.css("color", "blue");
			input.css("font-size", "medium");
			input.attr("disabled", "disabled");
			input.css("background-color", "white");
			
			// make changes for radio buttons
			if(input.attr('type')=='radio'){
				if(input.attr('checked')==false){
					input.parent().hide();
				} else {
					input.hide();
					input.parent().css("color", "blue");
					input.parent().css("font-size", "medium");					
				}
			}
		});
		
		jQuery("#form_content select").each(function(index){
			select = jQuery(this);
			select.css("border", "0px");			
			selectedOption = jQuery("option:selected", select);
			selectedOption.css("color", "blue");
			select.after("<span style='color:blue; font-size: medium;'>"+selectedOption.html()+"</span>");
			select.hide();
		});
		
		jQuery("#form_content textarea").each(function(index){
			textarea = jQuery(this);
			value = textarea.val().replace(/\n/g, "<br/>");			
			textarea.after("<p style='color:blue; font-size: medium;'>" + value + "</p>");
			textarea.hide();
		});
	}
	
	// set input value
	function setInputValue(name, value){		
		
		jQuery("#form_content input[name=" + name + "]").each(function(index){
			input = jQuery(this);
			if(input.attr("type")=="radio"){
				if(input.attr("value")==value){
					input.attr("checked", "checked");
				};
			} else {
				input.val(value);
			}
		});
		
		jQuery("#form_content select[name="+ name + "]").each(function(index){
			select = jQuery(this);			
			jQuery("option", select).each(function(index){
				option = jQuery(this);				
				if(option.attr("value")==value){
					option.attr("selected", "selected");
				}
			});
		});
		
		jQuery("#form_content textarea[name="+ name + "]").each(function(index){
			textarea = jQuery(this);			
			jQuery("textarea").html(value);
		});
	}
	
	// get the context path
	function getContextPath() {
		pn = location.pathname;
		len = pn.indexOf("/", 1);
		cp = pn.substring(0, len);
		return cp;
	}
	
	// Submit the form
	function submitForm(){
		validated = jQuery("#contentForm").valid();		
		if(validated){
			var formContent = jQuery("#contentForm").formSerialize();
			jQuery.post(getContextPath() + "/module/radiology/showForm.form", formContent, function(data) {
				${param.script}
			});
			 tb_remove();
		} else {
			alert("Please complete the form");
		}
	}
	
	// Validate
	function isValidated(){
		validated = true;
		jQuery("#form_content input").each(function(index){
			input = jQuery(this);
			
			if(input.attr('type')=='text'){
				if(input.val().length<=0){
					validated = false;
				}
			}
			
			// make changes for radio buttons
			if(input.attr('type')=='radio'){
				if(jQuery("#form_content input[name="+ input.attr('name') + "]:checked").length<=0)
					validated = false;
			}
		});
		
		jQuery("#form_content select").each(function(index){
			select = jQuery(this);			
			jQuery("option:selected", select).each(function(){
				option = jQuery(this);
				if(option.attr('value')=='Please select')
					validated = false;
			});
		});
		return validated;
	}
	
	// Fill data into all inputs
	function fillData(){
		<c:if test="${not empty inputNames}">
			<c:forEach var="i" begin="0" end="${inputLength-1}" step="1">
				setInputValue("${inputNames[i]}", "${inputValues[i]}");
			</c:forEach>
		</c:if>		
	}	
	
</script>

<input type="hidden" name="encounterId" value="${encounterId}"/>
<div id="form_content">	
${form.content}
</div>	

<c:if test="${mode eq 'edit'}">	 
	<input type="button" value="Cancel" onClick="tb_remove();"/>
</c:if>