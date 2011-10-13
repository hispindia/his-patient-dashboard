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

import java.text.ParseException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.ConceptDatatype;
import org.openmrs.ConceptNumeric;
import org.openmrs.Obs;
import org.openmrs.api.context.Context;

public class LabResultListItem {

   Log log = LogFactory.getLog(getClass());
    private Integer orderId;
    private Integer obsId;
    private Integer conceptId;
    private String conceptName;
    private String result;
    private String unit;
    private String lowNormal;
    private String highNormal;

    private Integer testFailureCode = 0; //0 = no failure, 1 = railed re-order, 2 = failed no re-order, 3 = order closed

    public LabResultListItem() {
    }

    public LabResultListItem(Obs obs) {
        orderId = obs.getOrder().getOrderId();
        obsId = obs.getObsId();
        conceptId = obs.getConcept().getConceptId();
        conceptName = obs.getConcept().getName().getName();
        result = getValueStringFromObs(obs);
        unit = getUnitStringFromObs(obs);
        lowNormal = getLowNormalStringFromObs(obs);
        highNormal = getHighNormalStringFromObs(obs);
        
        if (obs.getComment() != null && obs.getComment().contains("Failed")) {
            testFailureCode = 2;
        } else if (obs.getComment() != null && obs.getComment().contains("Re-Order")) {
            testFailureCode = 1;
        } else if (obs.getComment() != null && obs.getComment().contains("Closed")) {
            testFailureCode = 3;
        }
    }

    public String toString() {
        String ret = "result: " + orderId + "," + obsId + "," + conceptId + "," + result;
        if (this.testFailureCode.equals(1)) {
            ret += "Failed: Re-Order";
        }
        if (this.testFailureCode.equals(2)) {
            ret += "Failed: No Re-Order";
        }
        if (this.testFailureCode.equals(3)) {
            ret += "Re-Ordered and Closed";
        }
        return ret;
    }

    public static String getUnitStringFromObs(Obs obs) {
        String unit = null;
        ConceptDatatype dt = obs.getConcept().getDatatype();
        if (dt.isNumeric()) {
            ConceptNumeric cn = Context.getConceptService().getConceptNumeric( obs.getConcept().getConceptId());
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

    public static String getLowNormalStringFromObs(Obs obs){
        String lowNormal = null;
        ConceptDatatype dt = obs.getConcept().getDatatype();
        if (dt.isNumeric()) {
            ConceptNumeric cn = Context.getConceptService().getConceptNumeric( obs.getConcept().getConceptId());
            if(cn.getLowNormal()!=null)
                lowNormal = cn.getLowNormal().toString();
            else
                lowNormal = "";
        }
        else
        {
            lowNormal = "";
        }
        return lowNormal;
    }

    public static String getHighNormalStringFromObs(Obs obs){
        String highNormal = null;
        ConceptDatatype dt = obs.getConcept().getDatatype();
        if (dt.isNumeric()) {
            ConceptNumeric cn = Context.getConceptService().getConceptNumeric( obs.getConcept().getConceptId());

            if(cn.getHiNormal()!=null)
                 highNormal = cn.getHiNormal().toString();
            else
                highNormal = "";
        }
        else
        {
            highNormal = "";
        }
        return highNormal;
    }

    public static String getValueStringFromObs(Obs obs) {
        String result = null;
        ConceptDatatype dt = obs.getConcept().getDatatype();
        if (dt.isBoolean() || dt.isNumeric()) {
            result = obs.getValueNumeric() == null ? null : obs.getValueNumeric().toString();
        } else if (dt.isCoded()) {
            result = obs.getValueCoded() == null ? null : obs.getValueCoded().getName().getName();
        } else if (dt.isDate()) {
            result = obs.getValueDatetime() == null ? null : Context.getDateFormat().format(obs.getValueDatetime());
        } else if (dt.isText()) {
            result = obs.getValueText();
        } else {
            result = obs.getValueAsString(Context.getLocale());
        }
        return result;
    }

    public static void setObsFromValueString(Obs obs, String value) {
        ConceptDatatype dt = obs.getConcept().getDatatype();
        if (dt.isBoolean() || dt.isNumeric()) {
            obs.setValueNumeric(value == null ? null : Double.valueOf(value));
        } else if (dt.isCoded()) {
            obs.setValueCoded(value == null ? null : Context.getConceptService().getConcept(Integer.parseInt(value)));
        } else if (dt.isDate()) {
            try {
                obs.setValueDatetime(value == null ? null : Context.getDateFormat().parse(value));
            } catch (ParseException e) {
                throw new RuntimeException("Unable to set date for value = " + value + " and obs = " + obs);
            }
        } else if (dt.isText()) {
            obs.setValueText(value);
        } else {
            throw new RuntimeException("Unable to set value of " + value + " for obs: " + obs);
        }
    }

    public static String getFailureCodeStringFromObs(Obs o) {
        if (o.getComment() == null) {
            return "0";
        }
        if (o.getComment().equals("Re-Order")) {
            return "1";
        } else if (o.getComment().equals("Failed")) {
            return "2";
        } else if (o.getComment().equals("Closed")) {
            return "3";
        } else {
            return "0";
        }
    }

    public static String getReadibleFailureStringFromObs(Obs o) {
        if (o.getComment() == null) {
            return "";
        } else if (o.getComment().equals("Re-Order")) {
            return "Re-Order";
        } else if (o.getComment().equals("Failed")) {
            return "Failed, Do Not Reorder";
        } else if (o.getComment().equals("Closed")) {
            return "Test Re-Ordered, Order Closed";
        } else {
            return "";
        }
    }

    public boolean equals(Object obj) {
        if (obj instanceof LabResultListItem) {
            LabResultListItem ot = (LabResultListItem) obj;
            if (ot.getObsId() == null || getObsId() == null) {
                return false;
            }
            return ot.getObsId().equals(getObsId());
        }
        return false;
    }

    public int hashCode() {
        if (getObsId() != null) {
            return 31 * getObsId().hashCode();
        } else {
            return super.hashCode();
        }
    }

    
    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getObsId() {
        return obsId;
    }

    public void setObsId(Integer obsId) {
        this.obsId = obsId;
    }

    public Integer getConceptId() {
        return conceptId;
    }

    public void setConceptId(Integer conceptId) {
        this.conceptId = conceptId;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Integer getTestFailureCode() {
        return testFailureCode;
    }

    public void setTestFailureCode(Integer testFailureCode) {
        this.testFailureCode = testFailureCode;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getHighNormal() {
        return highNormal;
    }

    public void setHighNormal(String highNormal) {
        this.highNormal = highNormal;
    }

    public String getLowNormal() {
        return lowNormal;
    }

    public void setLowNormal(String lowNormal) {
        this.lowNormal = lowNormal;
    }

	public String getConceptName() {
		return conceptName;
	}
    
}
