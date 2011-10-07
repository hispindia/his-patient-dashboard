/**
 *  Copyright 2011 Health Information Systems Project of India
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

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.ConceptDatatype;
import org.openmrs.ConceptNumeric;
import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.Location;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.LabService;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.model.Lab;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.openmrs.module.patientdashboard.web.controller.global.Node;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("InvestigationReportController")
@RequestMapping("/module/patientdashboard/investigationReport.htm")
public class InvestigationReportController {
	

	@RequestMapping(method=RequestMethod.GET)
	public String firstView( @RequestParam("patientId") Integer patientId,@RequestParam(value="date", required=false) String date, Model model){
			PatientDashboardService dashboardService =  Context.getService(PatientDashboardService.class);
	        String orderLocationId = "1";
	        Location location = StringUtils.hasText(orderLocationId) ? Context.getLocationService().getLocation(Integer.parseInt(orderLocationId)) : null;
			LabService labService = Context.getService(LabService.class);
			// get all labs
			List<Lab> labs = labService.getAllActivelab();

			// get all test in system base on list labs
			Set<Concept> listParent = new HashSet<Concept>();
			if ( labs != null && !labs.isEmpty() ){
				for( Lab lab : labs ){
					 listParent.addAll(lab.getInvestigationsToDisplay());
				}
			}
			Set<Node> nodes = new TreeSet<Node>();
			
	        Patient patient = Context.getPatientService().getPatient(patientId);
	        
	        String gpLabEncType = Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_LAB_ENCOUTNER_TYPE);
	        EncounterType labEncType = Context.getEncounterService().getEncounterType(gpLabEncType);
	        
			List<Encounter> encounters = dashboardService.getEncounter(patient, location, labEncType, date);
			
			Set<String> dates = new HashSet<String>();
			if( encounters != null && encounters.size() > 0 )
			{
				Set<Obs> listObs = null;
				Concept obsConcept  = null;
				Concept orderConcept  = null;
				for( Encounter enc : encounters)
				{
					listObs = enc.getAllObs(false);
					if( listObs != null && !listObs.isEmpty() ){
						for( Obs obs : listObs ){
							// result 
							obsConcept = obs.getConcept();
//							System.out.println("con: "+obsConcept.getDisplayString()+"=======================================================");
							
							orderConcept = obs.getOrder().getConcept();
//							System.out.println("orderConcept: "+orderConcept.getDisplayString() + " - "+orderConcept.getConceptId());
							
							if( orderConcept.getConceptClass().getName().equalsIgnoreCase("Test")){
								Node node = new Node(obsConcept.getConceptId(), obsConcept.getName().toString());
								addNode(node, nodes, obsConcept, listParent);
							}else if( orderConcept.getConceptClass().getName().equalsIgnoreCase("Labset")){
								Node node = new Node(obsConcept.getConceptId(), obsConcept.getName().toString());
								nodes = addNodeAndChild(nodes, orderConcept, node, null, listParent, false);
								
							}
							// add date
							dates.add(Context.getDateFormat().format(obs.getDateCreated()));
						}
					}
				}// end for encounter
			}
//			System.out.println("nodes : "+nodes);
			model.addAttribute("nodes", nodes);
			model.addAttribute("dates",dates);
			model.addAttribute("patientId",patientId);
		
		return "module/patientdashboard/investigationReport";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public String formSubmit(InvestigationCommand investigationCommand , Model model){
//		System.out.println("submit form investigation");
		try{
		// get list encounter
		PatientDashboardService dashboardService =  Context.getService(PatientDashboardService.class);
        String orderLocationId = "1";
        Location location = StringUtils.hasText(orderLocationId) ? Context.getLocationService().getLocation(Integer.parseInt(orderLocationId)) : null;
		LabService labService = Context.getService(LabService.class);
		List<Lab> labs = labService.getAllActivelab();

		Set<Concept> listParent = new HashSet<Concept>();
		if ( labs != null && !labs.isEmpty() ){
			for( Lab lab : labs ){
				 listParent.addAll(lab.getInvestigationsToDisplay());
			}
		}
		
        Patient patient = Context.getPatientService().getPatient(investigationCommand.getPatientId());
        
        String gpLabEncType = Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_LAB_ENCOUTNER_TYPE);
        EncounterType labEncType = Context.getEncounterService().getEncounterType(gpLabEncType);
        
        if( "all".equalsIgnoreCase(investigationCommand.getDate())){
        	investigationCommand.setDate(null);
        }
        
		List<Encounter> encounters = dashboardService.getEncounter(patient, location, labEncType, investigationCommand.getDate());
		Set<String> dates = new TreeSet<String>();
		if( encounters != null ){
			Set<Obs> listObs = null;
			Set<Node> nodes = new TreeSet<Node>();
			Concept orderConcept = null;
			Concept obsConcept  = null;
			for( Encounter enc : encounters)
			{
				listObs = enc.getAllObs(false);
				if( listObs != null && !listObs.isEmpty() ){
					for( Obs obs : listObs ){
						// result 
						obsConcept = obs.getConcept();
						
						if(!checkSubmitTest(obsConcept.getConceptId(), investigationCommand.getTests())){
							continue;
						}
//						System.out.println("con: "+obsConcept.getDisplayString()+"=======================================================");
						
						orderConcept = obs.getOrder().getConcept();
//						System.out.println("orderConcept: "+orderConcept.getDisplayString() + " - "+orderConcept.getConceptId());
						
						if( orderConcept.getConceptClass().getName().equalsIgnoreCase("Test")){
							Node node = getNode(obsConcept.getId(), nodes);
							if( node == null ){
								node = new Node(obsConcept.getId(), obsConcept.getName().getName());
								addNode(node, nodes, obsConcept, listParent);
							}
							Node result = new Node(obsConcept.getName().getName(),Context.getDateFormat().format(obs.getDateCreated()),
									obs.getValueAsString(Context.getLocale())+"  " + getUnitStringFromConcept(obsConcept));
							node.addResultToSet(result);
						}else if( orderConcept.getConceptClass().getName().equalsIgnoreCase("Labset")){
							
							Node resultNode = new Node(obsConcept.getName().getName(), Context.getDateFormat().format(obs.getDateCreated()),
									obs.getValueAsString(Context.getLocale())+"  " + getUnitStringFromConcept(obsConcept));
							
							Node childNode = new Node(obsConcept.getId(), obsConcept.getName().getName());
							
//							System.out.println("child node to add : "+childNode);
							nodes = addNodeAndChild(nodes, orderConcept, childNode, resultNode, listParent, true);
						}
//						 add date
						dates.add(Context.getDateFormat().format(obs.getDateCreated()));
					}
				}
			}// end for encounter
//						if( !con.getConceptId().equals(orderConcept.getConceptId())){
//							orderNode.getResults().add(new Node(Context.getDateFormat().format(obs.getDateCreated()),
//									obs.getValueAsString(Context.getLocale())+"  " + getUnitStringFromConcept(con)));
//						}
						
				
//			System.out.println("nodes: "+nodes);
			model.addAttribute("nodes", nodes);
		}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
//		System.out.println("out form investigation");
		return "module/patientdashboard/investigationReportResult";
	}
	
	public boolean checkSubmitTest(Integer conceptId, Integer[] conIds){
		for( Integer id : conIds ){
			if( id.equals(conceptId) ){
				return true;
			}
		}
		return false;
	}
	
	private Node getNode(Integer id, Set<Node> nodes ){
		for( Node n : nodes ){
			if( n.getId().equals(id)){
				return n;
			}else {
				Node rs = getNode(id, n.getChildren());
				if( rs != null ) return rs;
			}
		}
		return null;
	}
	
	 public static String getUnitStringFromConcept(Concept con) {
	        String unit = null;
	        ConceptDatatype dt = con.getDatatype();
	        if (dt.isNumeric()) {
	            ConceptNumeric cn = Context.getConceptService().getConceptNumeric( con.getConceptId());
	            if(cn.getUnits()!=null)
	                unit = cn.getUnits();
	            else
	                unit = "";
	        } 
	        else
	        {
	            unit = "";
	        }
	        return unit;
	    }
	 
	 
	 
	 private Node  addNode(Node node, Set<Node>  nodes , Concept concept, Set<Concept> listParent) {
		
		 for( Concept pa : listParent ){
				for(  ConceptAnswer answer : pa.getAnswers()){
//					System.out.println("answer: "+answer.getAnswerConcept().getName() );
					if( answer.getAnswerConcept().getId().equals(concept.getConceptId())){
//						System.out.println("orderConcept in parent : 	"+ orderConcept.getDisplayString());
//						System.out.println("nodes: "+nodes + " - pa : "+pa.getDisplayString() + "- "+pa.getId());
						Node parentNode =  getNode(pa.getConceptId(), nodes);
//						System.out.println("parentNod1e: "+parentNode);
						if( parentNode == null ){
//							System.out.println("add parent node : "+pa.getName().toString());
							parentNode = new Node(pa.getConceptId(), pa.getName().toString());
							nodes.add(parentNode);
						}
//						System.out.println("nodes: "+nodes);
						// add orderNode to parent
//							System.out.println("add result to pa : "+node );
							parentNode.addChild(node);
					}
				}
					
				//find parent of order concept : Labset  case
				List<Concept> set = Context.getConceptService().getConceptsByConceptSet(pa);
//				System.out.println("set: "+set);
				if( set != null && set.size() > 0){
					if ( set.contains(concept)){
						Node parentNode =  getNode(pa.getConceptId(), nodes);
//								System.out.println("parentNode2: "+parentNode);
						if( parentNode == null ){
							parentNode = new Node(pa.getConceptId(), pa.getName().toString());
							nodes.add(parentNode);
						}
						// add orderNode to parent
						parentNode.addChild(node);
					}
				}
		}
		 return node;
	 }
	 
	 private Set<Node>  addNodeAndChild(Set<Node>  nodes , Concept pa, Node childNode, Node resultNode, Set<Concept> listParent, boolean result) {
//		 System.out.println("addNodeAndChild================================");
//		 System.out.println("pa: "+pa +" -- child: "+childNode );
		 Node paNode = getNode(pa.getConceptId(), nodes);
//		 System.out.println("paNode : "+paNode);
		 if( paNode == null ){
			Node node = new Node(pa.getConceptId(), pa.getName().toString());
			paNode =  addNode(node, nodes, pa, listParent);
		 }
		 if( ! result ){
			 paNode.getChildren().add(childNode);
		 }else {
			 paNode.addDates(resultNode.getDate());
			 paNode.getChildren().add(childNode);
			 paNode.addResultToMap(resultNode);
		 }
//		 System.out.println("panodechild : "+paNode.getChildren());
		 return nodes;
	 }
}
