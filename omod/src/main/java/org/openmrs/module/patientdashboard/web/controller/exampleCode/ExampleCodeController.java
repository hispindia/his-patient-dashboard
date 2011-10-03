/**
 * <p> File: org.openmrs.module.patientdashboard.web.controller.exampleCode.ExampleCodeController.java </p>
 * <p> Project: patientdashboard-omod </p>
 * <p> Copyright (c) 2011 HISP Technologies. </p>
 * <p> All rights reserved. </p>
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Jan 26, 2011 5:27:52 PM </p>
 * <p> Update date: Jan 26, 2011 5:27:52 PM </p>
 **/

package org.openmrs.module.patientdashboard.web.controller.exampleCode;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.openmrs.Drug;
import org.openmrs.api.context.Context;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * <p> Class: ExampleCodeController </p>
 * <p> Package: org.openmrs.module.patientdashboard.web.controller.exampleCode </p> 
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Jan 26, 2011 5:27:52 PM </p>
 * <p> Update date: Jan 26, 2011 5:27:52 PM </p>
 **/
@Controller("ExampleCodeController")
@RequestMapping("/module/patientdashboard/example.htm")
public class ExampleCodeController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String firstView(Model model) {
		return "/module/patientdashboard/exampleCode/example";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String submit(Model model) {
		return "/module/patientdashboard/exampleCode/example";
	}

}
