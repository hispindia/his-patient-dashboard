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
<%@ include file="/WEB-INF/template/include.jsp"%>
<script type="text/javascript">
MODEL = {
		selectedDate: "${dat}",
		selectedTest: "${test}"
	}
</script>
<script type="text/javascript">
jQuery(document).ready(function() {	
			    if(!StringUtils.isBlank(MODEL.selectedDate)){			
			    jQuery("#testDate").val(MODEL.selectedDate);
		        }
		        if(!StringUtils.isBlank(MODEL.selectedTest)){			
			    jQuery("#test").val(MODEL.selectedTest);
		        }
});
</script>
<script type="text/javascript">
// get context path in order to build controller url
	function getContextPath(){		
		pn = location.pathname;
		len = pn.indexOf("/", 1);				
		cp = pn.substring(0, len);
		return cp;
	}
</script>
<script type="text/javascript">
function dater(){
        var patientId = ${patientId};
		var date = jQuery("#testDate").val();
if (date=="all") {		
jQuery.ajax({
				type : "POST",
				url : getContextPath() + "/module/patientdashboard/radiologyRecord.htm",
				data : ({
					patientId			: patientId,
					date			    : date
				}),
				success : function(data) {
					jQuery("#radiologyResultContainer").html(data);
					jQuery("#tests").hide();
					jQuery("#subTests").hide();
				}
          });
  }
else if (date!="null") {		
jQuery.ajax({
				type : "GET",
				url : getContextPath() + "/module/patientdashboard/radiologyRecord.htm",
				data : ({
					patientId			: patientId,
					date			    : date
				}),
				success : function(data) {
					jQuery("#radiologyFormContainer").html(data);
					jQuery("#radiologyResultContainer").remove();		
				}
          });
  }
else{
jQuery.ajax({
				type : "GET",
				url : getContextPath() + "/module/patientdashboard/radiologyRecord.htm",
				data : ({
					patientId			: patientId
				}),
				success : function(data) {
					jQuery("#radiologyFormContainer").html(data);
					jQuery("#radiologyResultContainer").remove();	
				}
          });
   }
}
</script>
<script type="text/javascript">
function testr(){
        var patientId = ${patientId};
		var date = jQuery("#testDate").val();
		var test = jQuery("#test").val();
if (test!="null") {				
jQuery.ajax({
				type : "GET",
				url : getContextPath() + "/module/patientdashboard/radiologyRecord.htm",
				data : ({
					patientId			: patientId,
					date			    : date,
					test			    : test
				}),
				success : function(data) {
					jQuery("#radiologyFormContainer").html(data);	
				}
          });
  }
else{
jQuery.ajax({
				type : "GET",
				url : getContextPath() + "/module/patientdashboard/radiologyRecord.htm",
				data : ({
					patientId			: patientId,
					date			    : date
				}),
				success : function(data) {
					jQuery("#radiologyFormContainer").html(data);	
				}
          });
   }
}
</script>
<script type="text/javascript">
function subtest(){
        var patientId = ${patientId};
		var date = jQuery("#testDate").val();
		var test = jQuery("#test").val();
		var subtest = jQuery("#subTest").val();
jQuery.ajax({
				type : "POST",
				url : getContextPath() + "/module/patientdashboard/radiologyRecord.htm",
				data : ({
					patientId			: patientId,
					date			    : date,
					test			    : test,
					subtest			    : subtest
				}),
				success : function(data) {
					jQuery("#radiologyResultContainer").html(data);	
				}
});
}
</script>
<c:choose>
	<c:when test="${ not empty dates }">
		<form id="radiologyRecordForm">
			<table width="100%">
				<tr valign="top">
					<td id="radiologyResultContainer" style="text-align: left;"></td>
					<td id="radiologyFormContainer" style="text-align: right;"><b
						id="dates"> Date: <select name="testDate" id="testDate"
							onchange="dater();">
								<option selected="selected" value="null">Select</option>
								<option value="all">All</option>
								<c:forEach var="date" items="${dates}">
									<option value="${date}">${date}</option>
								</c:forEach>
						</select> </b> <c:choose>
							<c:when test="${not empty tests}">
								<b id="tests"> Test<select name="test" id="test"
									onchange="testr();">
										<option selected="selected" value="null">Select</option>
										<c:forEach var="test" items="${tests}">
											<option value="${test}">${test}</option>
										</c:forEach>
								</select> </b>
							</c:when>
						</c:choose> <c:choose>
							<c:when test="${not empty subtests}">
								<b id="subTests"> SubTest<select name="subTest" id="subTest"
									onchange="subtest();">
										<option selected="selected">Select</option>
										<c:forEach var="subtest" items="${subtests}">
											<option value="${subtest}">${subtest}</option>
										</c:forEach>
								</select> </b>
							</c:when>
						</c:choose></td>
			</table>
		</form>
	</c:when>
	<c:otherwise>No Radiology record found</c:otherwise>
</c:choose>