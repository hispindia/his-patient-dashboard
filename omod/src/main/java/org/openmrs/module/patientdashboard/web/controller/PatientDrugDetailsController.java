package org.openmrs.module.patientdashboard.web.controller;

import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("api/patientdrugdetails.json")
public class PatientDrugDetailsController {
    @RequestMapping(method = RequestMethod.GET)
    public @ResponseBody String getApi(@RequestParam(value = "identifier", required = true) String identifier,
            @RequestParam(value = "date", required = true) String date) {

        PatientDashboardService pds = Context.getService(PatientDashboardService.class);
        List<Map<String, Object>> patientDrugDetailsList = pds.getPatientDrugDetails(identifier, date);

        ObjectMapper mapper = new ObjectMapper();
        String response = "";

        try {
            response = mapper.writeValueAsString(patientDrugDetailsList);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;
    }
}