package org.openmrs.module.patientdashboard.model;

import java.io.Serializable;
import java.util.Date;

import org.openmrs.Patient;

public class PatientDialysisFormDetail implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private Patient patient;
    private String bunPreDialysis;
    private String bunPostDialysis;
    private String urr;
    private String serumCreatinine;
    private String hemoglobin;
    private String potassium;
    private String calcium;
    private String phosphorus;
    private String albumin;
    private String fbs;
    private String rbs;
    private String iron;
    private String tibc;
    private String saturation;
    private String ferritin;
    private String hbsAntibody;
    private String hbsAg;
    private String hcv;
    private String hiv;
    private String sodium;
    private String sBilli;
    private String sgpt;
    private String alkPhos;
    private String uricAcid;
    private Date createdDate;

    public String getAlbumin() {
        return albumin;
    }

    public void setAlbumin(String albumin) {
        this.albumin = albumin;
    }

    public String getAlkPhos() {
        return alkPhos;
    }

    public void setAlkPhos(String alkPhos) {
        this.alkPhos = alkPhos;
    }

    public String getBunPostDialysis() {
        return bunPostDialysis;
    }

    public void setBunPostDialysis(String bunPostDialysis) {
        this.bunPostDialysis = bunPostDialysis;
    }

    public String getBunPreDialysis() {
        return bunPreDialysis;
    }

    public void setBunPreDialysis(String bunPreDialysis) {
        this.bunPreDialysis = bunPreDialysis;
    }

    public String getCalcium() {
        return calcium;
    }

    public void setCalcium(String calcium) {
        this.calcium = calcium;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getFbs() {
        return fbs;
    }

    public void setFbs(String fbs) {
        this.fbs = fbs;
    }

    public String getFerritin() {
        return ferritin;
    }

    public void setFerritin(String ferritin) {
        this.ferritin = ferritin;
    }

    public String getHbsAg() {
        return hbsAg;
    }

    public void setHbsAg(String hbsAg) {
        this.hbsAg = hbsAg;
    }

    public String getHbsAntibody() {
        return hbsAntibody;
    }

    public void setHbsAntibody(String hbsAntibody) {
        this.hbsAntibody = hbsAntibody;
    }

    public String getHcv() {
        return hcv;
    }

    public void setHcv(String hcv) {
        this.hcv = hcv;
    }

    public String getHemoglobin() {
        return hemoglobin;
    }

    public void setHemoglobin(String hemoglobin) {
        this.hemoglobin = hemoglobin;
    }

    public String getHiv() {
        return hiv;
    }

    public void setHiv(String hiv) {
        this.hiv = hiv;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIron() {
        return iron;
    }

    public void setIron(String iron) {
        this.iron = iron;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getPhosphorus() {
        return phosphorus;
    }

    public void setPhosphorus(String phosphorus) {
        this.phosphorus = phosphorus;
    }

    public String getPotassium() {
        return potassium;
    }

    public void setPotassium(String potassium) {
        this.potassium = potassium;
    }

    public String getRbs() {
        return rbs;
    }

    public void setRbs(String rbs) {
        this.rbs = rbs;
    }

    public String getSaturation() {
        return saturation;
    }

    public void setSaturation(String saturation) {
        this.saturation = saturation;
    }

    public String getSerumCreatinine() {
        return serumCreatinine;
    }

    public void setSerumCreatinine(String serumCreatinine) {
        this.serumCreatinine = serumCreatinine;
    }

    public String getSgpt() {
        return sgpt;
    }

    public void setSgpt(String sgpt) {
        this.sgpt = sgpt;
    }

    public String getSodium() {
        return sodium;
    }

    public void setSodium(String sodium) {
        this.sodium = sodium;
    }

    public String getTibc() {
        return tibc;
    }

    public void setTibc(String tibc) {
        this.tibc = tibc;
    }

    public String getUricAcid() {
        return uricAcid;
    }

    public void setUricAcid(String uricAcid) {
        this.uricAcid = uricAcid;
    }

    public String getUrr() {
        return urr;
    }

    public void setUrr(String urr) {
        this.urr = urr;
    }

    public String getsBilli() {
        return sBilli;
    }

    public void setsBilli(String sBilli) {
        this.sBilli = sBilli;
    }

}
