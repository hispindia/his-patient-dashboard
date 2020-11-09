package org.openmrs.module.patientdashboard.impl;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.patientdashboard.OPDFormsService;
import org.openmrs.module.patientdashboard.db.OPDFormsDAO;
import org.openmrs.module.patientdashboard.model.PatientHepatitisBDetail;
import org.openmrs.module.patientdashboard.model.PatientReferralDetail;

public class OPDFormsServiceImpl extends BaseOpenmrsService implements OPDFormsService {

    public OPDFormsServiceImpl() {
    }

    protected OPDFormsDAO dao;

    public void setDao(OPDFormsDAO dao) {
        this.dao = dao;
    }

    @Override
    public PatientHepatitisBDetail savePatientHepatitisBDetail(PatientHepatitisBDetail PatientHepatitisBDetail) {
        return dao.savePatientHepatitisBDetail(PatientHepatitisBDetail);
    }

    @Override
    public List<Map<String, Object>> getPatientHepatitisBDetails(Integer patientId) throws ParseException {
        return dao.getPatientHepatitisBDetails(patientId);
    }

    @Override
    public PatientReferralDetail savePatientReferralDetail(PatientReferralDetail patientReferralDetail) {
        return dao.savePatientReferralDetail(patientReferralDetail);
    }

    @Override
    public List<Map<String, Object>> getPatientReferralDetails(Integer patientId) throws ParseException {
        return dao.getPatientReferralDetails(patientId);
    }

}
