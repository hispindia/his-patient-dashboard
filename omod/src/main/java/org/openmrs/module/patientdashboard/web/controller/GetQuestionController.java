/**
 *  Copyright 2014 Society for Health Information Systems Programmes, India (HISP India)
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

package org.openmrs.module.patientdashboard.web.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.openmrs.ConceptAnswer;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("GetQuestionController")
@RequestMapping("/module/patientdashboard/getQuestion.htm")
public class GetQuestionController {
	@RequestMapping(method = RequestMethod.GET)
	public String firstView(@RequestParam(value = "selectedSymptom", required = false) String selectedSymptom,
			               Model model) {
		HospitalCoreService hospitalCoreService = Context.getService(HospitalCoreService.class);
		System.out.println("selectedSymptom"+selectedSymptom);
		if(!selectedSymptom.equals("")){
		String[] columns = selectedSymptom.split(",");
		int a=columns.length;
		List<String> al=new ArrayList<String>();
		Map<String,String> syptomname=new LinkedHashMap<String,String>();
		Map<String,Collection<ConceptAnswer>> syptomquestionanswer=new LinkedHashMap<String,Collection<ConceptAnswer>>();
		Map<Integer,Collection<ConceptAnswer>> syptomquestionanswer2=new LinkedHashMap<Integer,Collection<ConceptAnswer>>();
		for(int i=0;i<a;i++){
			al.add(columns[i]);
			syptomname.put(columns[i], Context.getConceptService().getConcept( Integer.parseInt(columns[i])).getName().toString());
			Collection<ConceptAnswer> conceptAnswers=Context.getConceptService().getConcept(Integer.parseInt(columns[i])).getAnswers();
			syptomquestionanswer.put( columns[i], (Collection<ConceptAnswer>) conceptAnswers);
			
			for(ConceptAnswer conceptAnswer:conceptAnswers){
				Collection<ConceptAnswer> conceptAnswers2=conceptAnswer.getAnswerConcept().getAnswers();
				for(ConceptAnswer conceptAnswe:conceptAnswers2){
					conceptAnswe.getAnswerConcept().getDatatype();
				}
				Integer conceptId=conceptAnswer.getAnswerConcept().getConceptId();
				syptomquestionanswer2.put( conceptId, (Collection<ConceptAnswer>) conceptAnswers2  );
				
			}
			
		}
		model.addAttribute("al", al);
		model.addAttribute("syptomname", syptomname);
		model.addAttribute("syptomquestionanswer", syptomquestionanswer);
		model.addAttribute("syptomquestionanswer2", syptomquestionanswer2);
		}
	
		return "module/patientdashboard/getQuestion";
		}
	}