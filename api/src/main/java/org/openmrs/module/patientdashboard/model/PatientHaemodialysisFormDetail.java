package org.openmrs.module.patientdashboard.model;

import java.io.Serializable;
import java.util.Date;

public class PatientHaemodialysisFormDetail implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private PatientHaemodialysisForm patientHaemodialysisForm;
    private String bp;
    private String pulse;
    private String tmp;
    private String vp;
    private Date createdDate;

    /**
     * @return Integer return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return PatientHeamodialysisForm return the patientHaemodialysisForm
     */
    public PatientHaemodialysisForm getPatientHaemodialysisForm() {
        return patientHaemodialysisForm;
    }

    /**
     * @param patientHaemodialysisForm the patientHaemodialysisForm to set
     */
    public void setPatientHaemodialysisForm(PatientHaemodialysisForm patientHaemodialysisForm) {
        this.patientHaemodialysisForm = patientHaemodialysisForm;
    }

    /**
     * @return String return the bp
     */
    public String getBp() {
        return bp;
    }

    /**
     * @param bp the bp to set
     */
    public void setBp(String bp) {
        this.bp = bp;
    }

    /**
     * @return String return the pulse
     */
    public String getPulse() {
        return pulse;
    }

    /**
     * @param pulse the pulse to set
     */
    public void setPulse(String pulse) {
        this.pulse = pulse;
    }

    /**
     * @return String return the tmp
     */
    public String getTmp() {
        return tmp;
    }

    /**
     * @param tmp the tmp to set
     */
    public void setTmp(String tmp) {
        this.tmp = tmp;
    }

    /**
     * @return String return the vp
     */
    public String getVp() {
        return vp;
    }

    /**
     * @param vp the vp to set
     */
    public void setVp(String vp) {
        this.vp = vp;
    }

    /**
     * @return Date return the createdDate
     */
    public Date getCreatedDate() {
        return createdDate;
    }

    /**
     * @param createdDate the createdDate to set
     */
    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

}
