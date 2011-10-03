package org.openmrs.module.patientdashboard.web.controller;

import java.util.List;
import java.util.Set;

import org.openmrs.Encounter;
import org.openmrs.module.patientdashboard.web.controller.global.Node;

public class InvestigationCommand {
	
	
	private Integer patientId;
	private Integer[] tests;
	private String date;
	private List<Encounter> encounters;
	private List<Node> nodes;
	private Set<String> dates;
	public List<Node> getNodes() {
		return nodes;
	}
	public void setNodes(List<Node> nodes) {
		this.nodes = nodes;
	}
	public Integer getPatientId() {
		return patientId;
	}
	public void setPatientId(Integer patientId) {
		this.patientId = patientId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public List<Encounter> getEncounters() {
		return encounters;
	}
	public void setEncounters(List<Encounter> encounters) {
		this.encounters = encounters;
	}
	public Set<String> getDates() {
		return dates;
	}
	public void setDates(Set<String> dates) {
		this.dates = dates;
	}
	public Integer[] getTests() {
		return tests;
	}
	public void setTests(Integer[] tests) {
		this.tests = tests;
	}
	
}
