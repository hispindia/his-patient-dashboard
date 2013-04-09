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
	jQuery(document).ready(function(){		
		fillData();
	});
	
	// set input value
	function setInputValue(name, value, testId){		
		
		jQuery("#form_content_" + testId + " input[name=" + name + "]").each(function(index){
			input = jQuery(this);
			if(input.attr("type")=="radio"){
				if(input.attr("value")==value){
					input.attr("checked", "checked");
				};
			} else {
				input.val(value);
			}
		});
		
		jQuery("#form_content_" + testId + " select[name="+ name + "]").each(function(index){
			select = jQuery(this);			
			jQuery("option", select).each(function(index){
				option = jQuery(this);				
				if(option.attr("value")==value){
					option.attr("selected", "selected");
				}
			});
		});
		
		jQuery("#form_content_" + testId + " textarea[name="+ name + "]").each(function(index){
			textarea = jQuery(this);
			jQuery("textarea").html(value);
		});
	}
	
	// Fill data into all inputs
	function fillData(){
		<c:if test="${not empty inputNames}">
			<c:forEach var="i" begin="0" end="${inputLength-1}" step="1">
				setInputValue("${inputNames[i]}", "${inputValues[i]}", ${testId});
			</c:forEach>
		</c:if>		
	}		
</script>

<input type="hidden" name="encounterId" value="${encounterId}"/>	
<div id="form_content_${testId}">	
	${form.content}
</div>

<c:if test="${mode eq 'edit'}">	 
	<input type="button" value="Cancel" onClick="tb_remove();"/>
</c:if>