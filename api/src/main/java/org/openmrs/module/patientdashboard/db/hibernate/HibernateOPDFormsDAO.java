package org.openmrs.module.patientdashboard.db.hibernate;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.openmrs.module.patientdashboard.DatabaseConnector;
import org.openmrs.module.patientdashboard.db.OPDFormsDAO;
import org.openmrs.module.patientdashboard.model.PatientHepatitisBDetail;
import org.openmrs.module.patientdashboard.model.PatientReferralDetail;
import org.springframework.jdbc.core.JdbcTemplate;

public class HibernateOPDFormsDAO implements OPDFormsDAO {

    private SessionFactory sessionFactory;

    private DatabaseConnector databaseConnector = new DatabaseConnector();
    private DataSource dataSource = databaseConnector.dataSource();

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public PatientHepatitisBDetail savePatientHepatitisBDetail(PatientHepatitisBDetail PatientHepatitisBDetail) {
        return (PatientHepatitisBDetail) sessionFactory.getCurrentSession().merge(PatientHepatitisBDetail);
    }

    @Override
    public List<Map<String, Object>> getPatientHepatitisBDetails(Integer patientId) throws ParseException {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "select afp, alu, cirrhosis, clinical_notes_medication, complications, cr, concat('', created_date) as createdDate, family_hcc, fibroscan, concat('', followup_date) as followupDate, hbeag, hbv_dna, high_hbv_dna, `others`, concat('', rx_date) as rxDate, rx_others, usg_liver, years_of_diagnosis from patient_hepatitis_b_details where patient_id = "
                + patientId + " order by id desc";
        return jdbcTemplate.queryForList(sql);
    }

    @Override
    public PatientReferralDetail savePatientReferralDetail(PatientReferralDetail patientReferralDetail) {
        return (PatientReferralDetail) sessionFactory.getCurrentSession().merge(patientReferralDetail);
    }

    @Override
    public List<Map<String, Object>> getPatientReferralDetails(Integer patientId) throws ParseException {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "select referral_id, refer_to, symptoms, investigations, diagnosis, treatment_given, concat('', created_date) as createdDate, past_history, reason_for_referral from patient_referral_details where patient_id = "
                + patientId + " order by referral_id desc";
        return jdbcTemplate.queryForList(sql);
    }
}
