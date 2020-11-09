package org.openmrs.module.patientdashboard;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.openmrs.api.OpenmrsService;
import org.openmrs.module.patientdashboard.model.PatientHepatitisBDetail;
import org.openmrs.module.patientdashboard.model.PatientReferralDetail;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface OPDFormsService extends OpenmrsService {
    /**
     * Save patient hepatitis-B details
     * 
     * @param PatientHepatitisBDetail
     * @return
     */
    public PatientHepatitisBDetail savePatientHepatitisBDetail(PatientHepatitisBDetail PatientHepatitisBDetail);

    /**
     * Get list of patient hepatitis-B details
     * 
     * @param patient
     * @return
     * @throws ParseException
     */
    public List<Map<String, Object>> getPatientHepatitisBDetails(Integer patientId) throws ParseException;

    /**
     * Save patient referral detail
     * 
     * @param patientReferralDetail
     * @return
     */
    public PatientReferralDetail savePatientReferralDetail(PatientReferralDetail patientReferralDetail);

    /**
     * Get list of patient referral details
     * 
     * @param patientId
     * @return
     * @throws ParseException
     */
    public List<Map<String, Object>> getPatientReferralDetails(Integer patientId) throws ParseException;
}
