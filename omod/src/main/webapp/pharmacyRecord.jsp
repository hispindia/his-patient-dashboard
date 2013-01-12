
<%--
 *  Copyright 2012 Society for Health Information Systems Programmes, India (HISP India)
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
<form id="pharmacyRecordForm" action="pharmacyRecord.htm?patientId=${patient.patientId}" method="post">
<table width="100%" >
	<tr valign="top">
		<td width="60%" id="pharmacyResultContainer">
		</td>
		<td width="30%">
		Date:
		<select name="date" id="date">
			<option value="all">--All--</option>
			<c:forEach var="date" items="${dates}">
				<option value="${date}">${date}</option>
			</c:forEach>
		</select>
		<input type="submit"
			class="ui-button ui-widget ui-state-default ui-corner-all"
			value="View" />
			</td>
	</table>
</form>