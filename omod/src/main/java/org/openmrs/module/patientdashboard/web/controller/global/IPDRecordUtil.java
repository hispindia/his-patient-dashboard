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

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.openmrs.Concept;
import org.openmrs.Obs;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.ConceptService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmissionLog;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmittedLog;
import org.openmrs.module.hospitalcore.model.OpdDrugOrder;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;

public class IPDRecordUtil {
	
	private static final String HOSPITAL_NAME = " Hospital";
	
	public List<IPDRecord> generateIPDRecord(List<IpdPatientAdmissionLog> admissionLogs,
	                                         List<IpdPatientAdmittedLog> admittedLogs) {
		List<IPDRecord> records = new ArrayList<IPDRecord>();
		for (IpdPatientAdmissionLog admissionLog : admissionLogs) {
			IPDRecord record = new IPDRecord();
			record.setHospitalName(HOSPITAL_NAME);
			record.setAdmissionDate(admissionLog.getAdmissionDate());
			PatientDashboardService patientDashboardService = Context
					.getService(PatientDashboardService.class);
			List<OpdDrugOrder>opd=patientDashboardService
					.getOpdDrugOrder(admissionLog.getIpdEncounter());
			
			IpdPatientAdmittedLog admittedLog = getAdmitedLogByAdmissionLog(admittedLogs, admissionLog);
			record.setId(admissionLog.getIpdEncounter().getEncounterId());
			record.setDischargeDate(admittedLog.getAdmissionDate());
			record.setDiagnosis(getDiagnosisProcedure(admissionLog, 1));
			record.setProcedures(getDiagnosisProcedure(admissionLog, 2));
			record.setAdmissionOutcome(admittedLog.getAdmissionOutCome());
			record.setSubDetails(opd);
			records.add(record);
		}
		
		return records;
	}
	
	private IpdPatientAdmittedLog getAdmitedLogByAdmissionLog(List<IpdPatientAdmittedLog> logs,
	                                                          IpdPatientAdmissionLog admissionLog) {
		for (IpdPatientAdmittedLog log : logs) {
			if (log.getPatientAdmissionLog().getId().equals(admissionLog.getId())) {
				return log;
			}
		}
		return null;
	}
	
	private String getDiagnosisProcedure(IpdPatientAdmissionLog currentAdmissionLog, int type) {
		
		String results = "";
		
		// get diagnosis concept
		ConceptService conceptService = Context.getConceptService();
		AdministrationService administrationService = Context.getAdministrationService();
		
		Set<Obs> listObsByObsGroup = currentAdmissionLog.getIpdEncounter().getAllObs();
		//System.out.println("listObsByObsGroup ;"+listObsByObsGroup);
		if (type == 1) {
			String gpDiagnosis = administrationService
			        .getGlobalProperty(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
			Concept conDiagnosis = conceptService.getConcept(gpDiagnosis);
			
			if (CollectionUtils.isNotEmpty(listObsByObsGroup)) {
				for (Obs obs : listObsByObsGroup) {
					//	System.out.println("obs : "+obs.getId());
					if (obs.getConcept().getConceptId().equals(conDiagnosis.getConceptId())) {
						if (obs.getValueCoded() != null) {
							//		System.out.println(" value coded : "+obs.getValueCoded().getName());
							results += obs.getValueCoded().getName() + "<br/>";
						}
						if (StringUtils.isNotBlank(obs.getValueText())) {
							//	System.out.println(" value text : "+obs.getValueAsString(Context.getLocale()));
							results += obs.getValueText() + "<br/>";
						}
					}
					
				}
			}
		} else if (type == 2) {
			String gpProcedure = administrationService
			        .getGlobalProperty(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
			Concept conProcedure = conceptService.getConcept(gpProcedure);
			if (CollectionUtils.isNotEmpty(listObsByObsGroup)) {
				for (Obs obs : listObsByObsGroup) {
					//	System.out.println("obs : "+obs.getId());
					if (obs.getConcept().getConceptId().equals(conProcedure.getConceptId())) {
						if (obs.getValueCoded() != null) {
							//		System.out.println(" value coded : "+obs.getValueCoded().getName());
							results += obs.getValueCoded().getName() + "<br/>";
						}
						if (StringUtils.isNotBlank(obs.getValueText())) {
							//	System.out.println(" value text : "+obs.getValueAsString(Context.getLocale()));
							results += obs.getValueText() + "<br/>";
						}
					}
					
				}
			}
		}
		
		if (StringUtils.endsWith(results, "<br/>")) {
			results = StringUtils.removeEnd(results, "<br/>");
		}
		
		return results;
	}
	
	private String getProcedure(IpdPatientAdmissionLog currentAdmissionLog) {
		
		String procedure = "";
		
		// get diagnosis concept
		ConceptService conceptService = Context.getConceptService();
		AdministrationService administrationService = Context.getAdministrationService();
		String gpProcedure = administrationService.getGlobalProperty(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		Concept conProcedure = conceptService.getConcept(gpProcedure);
		List<Obs> listObsByObsGroup = Context.getObsService().findObsByGroupId(currentAdmissionLog.getOpdObsGroup().getId());
		
		if (CollectionUtils.isNotEmpty(listObsByObsGroup)) {
			for (Obs obs : listObsByObsGroup) {
				if (obs.getConcept().getConceptId().equals(conProcedure.getConceptId()) && obs.getObsGroup() != null
				        && obs.getObsGroup().getId().equals(currentAdmissionLog.getOpdObsGroup().getId())) {
					if (obs.getValueCoded() != null) {
						procedure += obs.getValueCoded().getName() + "<br/>";
					}
					if (StringUtils.isNotBlank(obs.getValueText())) {
						procedure += obs.getValueText() + "<br/>";
					}
				}
				
			}
		}
		
		if (StringUtils.endsWith(procedure, "<br/>")) {
			procedure = StringUtils.removeEnd(procedure, "<br/>");
		}
		
		return procedure;
	}
	
}
