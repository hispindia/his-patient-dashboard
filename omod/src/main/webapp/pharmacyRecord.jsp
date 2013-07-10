
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
 * author: ghanshyam
 * date: 11-01-2013
 * issue: #556 Bangladesh
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>
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
function datep(){
        var patientId = ${patientId};
		var date = jQuery("#drugIssuedDate").val();
jQuery.ajax({
				type : "POST",
				url : getContextPath() + "/module/patientdashboard/pharmacyRecord.htm",
				data : ({
					patientId			: patientId,
					date			    : date
				}),
				success : function(data) {
					jQuery("#pharmacyResultContainer").html(data);	
				}
});
}
</script>
<c:choose>
	<c:when test="${ not empty dates }">
		<form id="pharmacyRecordForm">
			<table width="100%">
				<tr valign="top">
					<td id="pharmacyResultContainer" style="text-align: left;"></td>
					<td id="pharmacyFormContainer" style="text-align: right;">
						Date: <select name="drugIssuedDate" id="drugIssuedDate"
						onchange="datep();">
							<option selected="selected" value="null">Select</option>
							<option value="all">All</option>
							<c:forEach var="date" items="${dates}">
								<option value="${date}">${date}</option>
							</c:forEach>
					</select>
					</td>
			</table>
		</form>
	</c:when>
	<c:otherwise>No Pharmacy record found</c:otherwise>
</c:choose>