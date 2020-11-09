package org.openmrs.module.patientdashboard.web.controller.opdForms;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.openmrs.Encounter;
import org.openmrs.Patient;
import org.openmrs.PatientIdentifier;
import org.openmrs.PersonAddress;
import org.openmrs.PersonAttribute;
import org.openmrs.api.context.Context;
import org.openmrs.module.patientdashboard.OPDFormsService;
import org.openmrs.module.patientdashboard.model.PatientHepatitisBDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("HepatitiBFormController")
@RequestMapping("module/patientdashboard")
public class HepatitisBFormController {
    @RequestMapping(value = "/hepatitisBForm.htm", method = RequestMethod.GET)
    public String firstView(@RequestParam(value = "patientId", required = false) Integer patientId, Model model)
            throws ParseException {
        List<Map<String, Object>> patientHepatitisBDetailList = Context.getService(OPDFormsService.class)
                .getPatientHepatitisBDetails(patientId);

        String yearsOfDiagnosis = "";
        String complications = "";
        String rxDate = "";
        String cirrhosis = "";
        String highHbvDna = "";
        String familyHcc = "";
        String rxOthers = "";

        if (patientHepatitisBDetailList.size() > 0) {
            Map<String, Object> patientHepatitisBDetail = patientHepatitisBDetailList.get(0);
            yearsOfDiagnosis = patientHepatitisBDetail.get("years_of_diagnosis").toString();
            complications = patientHepatitisBDetail.get("complications").toString();

            if (patientHepatitisBDetail.get("rxDate") != null) {
                rxDate = patientHepatitisBDetail.get("rxDate").toString();
            }
            System.out.println(rxDate);
            

            if (!rxDate.equals("")) {
                Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rxDate);
                rxDate = new SimpleDateFormat("MM/dd/yyyy").format(date).toString();
            }

            
            cirrhosis = patientHepatitisBDetail.get("cirrhosis").toString();
            highHbvDna = patientHepatitisBDetail.get("high_hbv_dna").toString();
            familyHcc = patientHepatitisBDetail.get("family_hcc").toString();
            rxOthers = patientHepatitisBDetail.get("rx_others").toString();
        }

        model.addAttribute("yearsOfDiagnosis", yearsOfDiagnosis);
        model.addAttribute("complications", complications);
        model.addAttribute("rxDate", rxDate);
        model.addAttribute("cirrhosis", cirrhosis);
        model.addAttribute("highHbvDna", highHbvDna);
        model.addAttribute("familyHcc", familyHcc);
        model.addAttribute("rxOthers", rxOthers);
        model.addAttribute("patientId", patientId);
        return "module/patientdashboard/opdForms/hepatitisBForm";
    }

    @RequestMapping(value = "/getPatientHepatitisBDetails.list", method = RequestMethod.GET)
    public void getDetails(@RequestParam(value = "patientId", required = false) Integer patientId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {

        Patient patient = Context.getPatientService().getPatient(patientId);

        PatientIdentifier patientIdentifier = patient.getPatientIdentifier();
        String identifier = patientIdentifier.getIdentifier();
        String patientName = patient.getGivenName() + " " + patient.getFamilyName();
        patientName = patientName.replace(" .", "");
        int patientAge = patient.getAge(new Date());
        String patientGender = patient.getGender();
        String patientPhoneNumber = "";

        Map<String, PersonAttribute> attributes = patient.getAttributeMap();

        for (String key : attributes.keySet()) {
            if (attributes.get(key).getAttributeType().getName().equals("Phone Number")) {
                patientPhoneNumber = attributes.get(key).getValue();
                break;
            }
        }
        PersonAddress personAddress = patient.getPersonAddress();
        String address = personAddress.getAddress1() + ", " + personAddress.getCityVillage() + ", "
                + personAddress.getCountyDistrict();
        List<Encounter> encounter = Context.getEncounterService().getEncountersByPatient(patient);
        Date encounterDate = null;

        for (Encounter encounter2 : encounter) {
            if (encounter2.getEncounterType().getName().equals("REGINITIAL")) {
                encounterDate = encounter2.getEncounterDatetime();
                break;
            }
        }

        Map<String, Object> patientDetails = new HashMap<String, Object>();
        patientDetails.put("patientIdentifier", identifier);
        patientDetails.put("patientName", patientName);
        patientDetails.put("patientAge", patientAge);
        patientDetails.put("patientGender", patientGender);
        patientDetails.put("patientPhoneNumber", patientPhoneNumber);
        patientDetails.put("patientAddress", address);
        patientDetails.put("registrationDate", encounterDate);

        List<Map<String, Object>> patientHepatitisBDetailList = Context.getService(OPDFormsService.class)
                .getPatientHepatitisBDetails(patientId);

        patientHepatitisBDetailList.add(patientDetails);

        response.setContentType("application/json");
        ServletOutputStream outputStream = response.getOutputStream();

        new ObjectMapper().writeValue(outputStream, patientHepatitisBDetailList);
    }

    @RequestMapping(value = "/hepatitisBForm.htm", method = RequestMethod.POST)
    public void formSubmit(@RequestParam(value = "patientId", required = false) Integer patientId,
            HttpServletRequest request, HttpServletResponse response) throws Exception {

        Patient patient = Context.getPatientService().getPatient(patientId);

        PatientHepatitisBDetail patientHepatitisBDetail = new PatientHepatitisBDetail();

        patientHepatitisBDetail.setPatient(patient);

        patientHepatitisBDetail.setYearsOfDiagnosis(request.getParameter("yearsOfDiagnosis").trim());
        patientHepatitisBDetail.setComplications(request.getParameter("complications").trim());

        Date rxDate = null;
        if (!request.getParameter("rxDate").trim().equals("")) {
            rxDate = new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("rxDate"));
        }
        patientHepatitisBDetail.setRxDate(rxDate);

        patientHepatitisBDetail.setCirrhosis(request.getParameter("cirrhosis"));
        patientHepatitisBDetail.setHighHbvDna(request.getParameter("highHbvDna"));
        patientHepatitisBDetail.setFamilyHcc(request.getParameter("familyHcc"));
        patientHepatitisBDetail.setRxOthers(request.getParameter("rxOthers"));

        patientHepatitisBDetail.setAlu(request.getParameter("alu"));
        patientHepatitisBDetail.setHbvDna(request.getParameter("hbvDna"));
        patientHepatitisBDetail.setHbeag(request.getParameter("hbeag"));
        patientHepatitisBDetail.setUsgLiver(request.getParameter("usgLiver"));
        patientHepatitisBDetail.setFibroscan(request.getParameter("fibroscan"));
        patientHepatitisBDetail.setAfp(request.getParameter("afp"));
        patientHepatitisBDetail.setCr(request.getParameter("cr"));
        patientHepatitisBDetail.setOthers(request.getParameter("others"));

        Date followupDate = new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("followupDate"));
        patientHepatitisBDetail.setFollowupDate(followupDate);

        patientHepatitisBDetail.setClinicalNotesMedication(request.getParameter("clinicalNotesMedication"));

        patientHepatitisBDetail.setCreatedDate(new Date());

        Context.getService(OPDFormsService.class).savePatientHepatitisBDetail(patientHepatitisBDetail);

        response.setContentType("application/json");
        ServletOutputStream outputStream = response.getOutputStream();

        new ObjectMapper().writeValue(outputStream, "Success");
    }
}
