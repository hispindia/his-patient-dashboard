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

package org.openmrs.module.patientdashboard.web.controller;


public class Clinical {

	private Integer id;
	private String dateOfVisit;
	private String typeOfVisit;
	private String treatingDoctor;
	private String diagnosis;
	private String procedures ;
	private String linkedVisit;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getDateOfVisit() {
		return dateOfVisit;
	}
	public void setDateOfVisit(String dateOfVisit) {
		this.dateOfVisit = dateOfVisit;
	}
	public String getTypeOfVisit() {
		return typeOfVisit;
	}
	public void setTypeOfVisit(String typeOfVisit) {
		this.typeOfVisit = typeOfVisit;
	}
	public String getTreatingDoctor() {
		return treatingDoctor;
	}
	public void setTreatingDoctor(String treatingDoctor) {
		this.treatingDoctor = treatingDoctor;
	}
	public String getDiagnosis() {
		return diagnosis;
	}
	public void setDiagnosis(String diagnosis) {
		this.diagnosis = diagnosis;
	}
	public String getProcedures() {
		return procedures;
	}
	public void setProcedures(String procedures) {
		this.procedures = procedures;
	}
	public String getLinkedVisit() {
		return linkedVisit;
	}
	public void setLinkedVisit(String linkedVisit) {
		this.linkedVisit = linkedVisit;
	}
	
	

}
