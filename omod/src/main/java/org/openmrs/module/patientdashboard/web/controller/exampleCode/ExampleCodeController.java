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
