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
<style>
.rsTable{ margin:5px 5px;text-align:center; border-style:1px  solid black; border-collapse: collapse;}
.rsCell { padding:3px 3px;}
</style>
<script type="text/javascript">
//  reenter result for a test
	function reEnterResult(testId){
		tb_show("testing", "showRadiologyForm.form?modal=true&height=600&width=800&mode=edit&radiologyTestId=" + testId);	
	}
	
	// show form for xray test
	function reEnterXRayResult(testId){
		tb_show("testing", "getDefaultXRayFormm.form?modal=true&height=600&width=800&mode=edit&radiologyTestId=" + testId);	
	}
</script>
<table width="100%" class="rsTable" cellspacing="3" border="1"  cellpadding="3">
	<thead>
		<tr align="center"> 
			<th align="center">Sr.No.</th>
			<th align="center">Results</th>
			<th align="center">Date</th>
			<th align="center">SubTest</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="test" items="${radiologytests}" varStatus="varStatus">
	    <tr align="center" class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
		<td><c:out value="${varStatus.count }"/></td>
		<td>
		<c:choose>
						<c:when test='${test.xray}'>							
							<a href="javascript:reEnterXRayResult(${test.testId});">
								View results
							</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:reEnterResult(${test.testId});">
								View results
							</a>
						</c:otherwise>
					</c:choose>
		 </td>
		<td>${test.startDate}</td>
		<td>${test.testName}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>