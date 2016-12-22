package org.openmrs.module.patientdashboard.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.openmrs.Encounter;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.PersonAttribute;
import org.openmrs.PersonAttributeType;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.IpdService;
import org.openmrs.module.hospitalcore.PatientQueueService;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmissionLog;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmitted;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmittedLog;
import org.openmrs.module.hospitalcore.util.PatientUtils;
import org.openmrs.module.patientdashboard.web.controller.global.IPDRecord;
import org.openmrs.module.patientdashboard.web.controller.global.IPDRecordUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("PrintDischargeSummarySlipController")
@RequestMapping("/module/patientdashboard/printDischargeSummarySlip.form")
public class PrintDischargeSummarySlipController {
	@RequestMapping(method = RequestMethod.GET)
	public String firstView(@RequestParam("patientId") Integer patientId,
			@RequestParam("encounterId") Integer encounterId, Model model) {
		
		Patient patient = Context.getPatientService().getPatient(patientId);
		String hospitalName = Context.getAdministrationService()
				.getGlobalProperty("hospital.location_user");
		model.addAttribute("hospitalName", hospitalName);
		SimpleDateFormat sdf = new SimpleDateFormat("EEE dd/MM/yyyy hh:mm a");
		model.addAttribute("currentDateTime", sdf.format(new Date()));
		String patientName;
		if (patient.getMiddleName() != null) {
			patientName = patient.getGivenName() + " "
					+ patient.getFamilyName() + " " + patient.getMiddleName();
		} else {
			patientName = patient.getGivenName() + " "
					+ patient.getFamilyName();
		}

		model.addAttribute("patient", patient);
		model.addAttribute("patientIdentifier", patient.getPatientIdentifier());
		model.addAttribute("patientName", patientName);
		
		Date birthday = patient.getBirthdate();
		model.addAttribute("age", PatientUtils.estimateAge(birthday));
		HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
		List<PersonAttribute> pas = hcs.getPersonAttributes(patient.getPatientId());
		for (PersonAttribute pa : pas) {
			PersonAttributeType attributeType = pa.getAttributeType();
			if (attributeType.getPersonAttributeTypeId() == 14) {
				model.addAttribute("selectedCategory", pa.getValue());
			}

		}
		PersonAttribute relationNameattr = patient.getAttribute("Father/Husband Name");
		PersonAttribute relationTypeattr = patient.getAttribute("Relative Name Type");
		model.addAttribute("relationName", relationNameattr.getValue());
		if(relationTypeattr!=null){
			model.addAttribute("relationType", relationTypeattr.getValue());
		}
		else{
			model.addAttribute("relationType", "Relative Name");
		}
		
		IpdService ipdService = Context.getService(IpdService.class);
		List<IpdPatientAdmissionLog> listPatientDischarge = ipdService.listIpdPatientAdmissionLog(patientId, null, IpdPatientAdmitted.STATUS_DISCHARGE, 0, 0);			
		List<IpdPatientAdmittedLog> admittedLogs = ipdService.listAdmittedLogByPatientId(patientId);
		for(IpdPatientAdmittedLog admitted:admittedLogs)
		{
			
			model.addAttribute("admitted",admitted);
			model.addAttribute("admissionDateTime",admitted.getPatientAdmissionLog().getAdmissionDate());
			if(admitted.getPatientAdmittedLogTransferFrom()!=null){
			
				model.addAttribute("referredFrom", admitted.getPatientAdmittedLogTransferFrom());
			}
			else{
				
				model.addAttribute("referredFrom", admitted.getPatientAdmissionLog().getOpdLog().getOpdConceptName());
			}
			final long DAY_IN_MILLIS = 1000 * 60 * 60 * 24;

			int diffInDays = (int) ((new Date().getTime() - admitted.getPatientAdmissionLog().getAdmissionDate().getTime() )/ DAY_IN_MILLIS );
			if(diffInDays<1){
				diffInDays=1;
			}
			model.addAttribute("admittedDays", diffInDays);

		}
		
		IPDRecordUtil util = new IPDRecordUtil();
		List<IPDRecord> records = util.generateIPDRecord(listPatientDischarge, admittedLogs);
		model.addAttribute("records", records);
		PatientQueueService queueService = Context.getService(PatientQueueService.class);
		Encounter enc=Context.getEncounterService().getEncounter(encounterId);
		
		Obs ob=queueService.getObservationByPersonConceptAndEncounter(Context.getPersonService().getPerson(patientId),Context.getConceptService().getConcept("OTHER INSTRUCTIONS"),enc);
	    if(ob!=null)
	    {
		 model.addAttribute("otherinstructions",ob.getValueText());
	    }
	    else
	    {
	    	model.addAttribute("otherinstructions","");
	    }
		return "module/patientdashboard/printDischargeSummarySlip";
}
	
}
