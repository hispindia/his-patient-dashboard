/**
 *  Copyright 2010 Society for Health Information Systems Programmes, India (HISP India)
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
 **/

package org.openmrs.module.patientdashboard.web.controller.global;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Obs;
import org.openmrs.Order;
import org.openmrs.api.ObsService;
import org.openmrs.api.context.Context;

public class LabOrderListItem {
	
	Log log = LogFactory.getLog(getClass());

	private Integer orderId;
	private Integer patientId;
	private Integer conceptId;
	private String conceptShortName;
	private String startDateString; // This is the accept Date
	private String orderDateString; // The Order date
	private String encounterDateString;
	private Integer locationId;
	private String locationName;
	private String discontinuedDateString;
	private String accessionNumber;
	private String instructions;
	private List<LabResultListItem> labResults = new ArrayList<LabResultListItem>();
//	private List<String> labOrderIdsForPatient = new ArrayList<String>();
	private Set<String> dates = new TreeSet<String>();

	public LabOrderListItem() { }
	
	public LabOrderListItem(Order order) {
		orderId = order.getOrderId();
		patientId = order.getPatient().getPatientId();
		conceptId = order.getConcept().getConceptId();
		conceptShortName = order.getConcept().getName().getShortName().isEmpty() ? order.getConcept().getName().getName() : order.getConcept().getName().getShortName();
		startDateString = order.getStartDate() == null ? null : Context.getDateFormat().format(order.getStartDate());
		orderDateString = order.getDateCreated() == null ? null : Context.getDateFormat().format(order.getDateCreated());
		encounterDateString = order.getEncounter().getEncounterDatetime() == null ? null : Context.getDateFormat().format(order.getEncounter().getEncounterDatetime());
		locationId = order.getEncounter().getLocation().getLocationId();
		locationName = order.getEncounter().getLocation().getName();
		discontinuedDateString = order.getDiscontinuedDate() == null ? null : Context.getDateFormat().format(order.getDiscontinuedDate());
		accessionNumber = order.getAccessionNumber();
		instructions = order.getInstructions();
		ObsService obsService = Context.getService(ObsService.class);
	
		for (Obs o : order.getEncounter().getObs()) {
			if( o.getOrder().getOrderId().equals(this.orderId)){
				labResults.add(new LabResultListItem(o));
				dates.add(Context.getDateFormat().format(o.getDateCreated()));
			}
			
		}
//		labOrderIdsForPatient = SimpleLabEntryUtil.getLabOrderIDsByPatient(order.getPatient(), 6);
	}

	public boolean equals(Object obj) {
		if (obj instanceof LabOrderListItem) {
			LabOrderListItem ot = (LabOrderListItem)obj;
			if (ot.getOrderId() == null || getOrderId() == null)
				return false;
			return ot.getOrderId().equals(getOrderId());
		}
		return false;
	}
	
	public int hashCode() {
		if (orderId != null)
			return 31 * orderId.hashCode();
		else
			return super.hashCode();
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getPatientId() {
		return patientId;
	}

	public void setPatientId(Integer patientId) {
		this.patientId = patientId;
	}

	public Integer getConceptId() {
		return conceptId;
	}

	public void setConceptId(Integer conceptId) {
		this.conceptId = conceptId;
	}

	public String getConceptShortName() {
		return conceptShortName;
	}

	public void setConceptShortName(String conceptShortName) {
		this.conceptShortName = conceptShortName;
	}

	public String getStartDateString() {
		return startDateString;
	}

	public void setStartDateString(String startDateString) {
		this.startDateString = startDateString;
	}

	public String getEncounterDateString() {
		return encounterDateString;
	}

	public void setEncounterDateString(String encounterDateString) {
		this.encounterDateString = encounterDateString;
	}

	public String getDiscontinuedDateString() {
		return discontinuedDateString;
	}

	public void setDiscontinuedDateString(String discontinuedDateString) {
		this.discontinuedDateString = discontinuedDateString;
	}

	public Integer getLocationId() {
		return locationId;
	}

	public void setLocationId(Integer locationId) {
		this.locationId = locationId;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public String getAccessionNumber() {
		return accessionNumber;
	}

	public void setAccessionNumber(String accessionNumber) {
		this.accessionNumber = accessionNumber;
	}

	public List<LabResultListItem> getLabResults() {
		return labResults;
	}

	public void setLabResults(List<LabResultListItem> labResults) {
		this.labResults = labResults;
	}
	
	public void addLabResult(LabResultListItem labResult) {
		this.labResults.add(labResult);
	}

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

//    public List<String> getLabOrderIdsForPatient() {
//        return labOrderIdsForPatient;
//    }
//
//    public void setLabOrderIdsForPatient(List<String> labOrderIdsForPatient) {
//        this.labOrderIdsForPatient = labOrderIdsForPatient;
//    }

    public Log getLog() {
        return log;
    }

	public String getOrderDateString() {
		return orderDateString;
	}

	public Set<String> getDates() {
		return dates;
	}
}
