package org.openmrs.module.patientdashboard.util;

import java.util.Calendar;
import java.util.Date;

public class PatientDashboardUtil {

	 public static String getAgeFromBirthDate(Date birth, boolean estimate){
			String result = "";
//	        var d = parseDateString(birth.substring(0,9));
//	        Date d2 = parseDateString(birth);

	        Date today = new Date();
	        Calendar now = Calendar.getInstance();
	        Calendar bd = Calendar.getInstance();
	        bd.setTime(birth);
	        
	        // The number of milliseconds in one day
	        long ONE_DAY = 1000 * 60 * 60 * 24;

	        // Convert both dates to milliseconds
	        long date1_ms = now.getTimeInMillis();
	        long date2_ms = bd.getTimeInMillis();

	        // Calculate the difference in milliseconds
	        long difference_ms = Math.abs(date1_ms - date2_ms);

	    	int day = Math.round(difference_ms/ONE_DAY);

	        String est = "";
	        
	        if(estimate	){
	        	est ="~";
	        }
	        if(bd.get(Calendar.YEAR)<now.get(Calendar.YEAR)  && day > now.getActualMaximum(Calendar.DAY_OF_YEAR)){
	            int year = now.get(Calendar.YEAR) - bd.get(Calendar.YEAR); 
	        	if(year==1){
	        		result = est + year + " year";
	            }else{
	            	result = est + year + " years";
	            }
	        }else if( day > 31){
	        	int month = 0;
	        	if(bd.get(Calendar.YEAR) < now.get(Calendar.YEAR)  )
	        		month = 12 - bd.get(Calendar.MONTH)  + now.get(Calendar.MONTH) ;
	        	if(bd.get(Calendar.YEAR) == now.get(Calendar.YEAR)  )
	        		month = now.get(Calendar.MONTH) - bd.get(Calendar.MONTH) ;
	        	if(month==1){
	        		result += est + month + " month";
	            }else{
	            	result += est + month + " months";
	            }
	        }else{
	            if(day==1){
	        		result += est + day + "day";
	            }else{
	            	result += est + day + " days";
	            }
	        }
	    	return result;
	    }
	 /**
		 * Returns the patient's age class
		 * 
		 * @param patientAge
		 * @return
		 */
		public static String calcAgeClass(int patientAge) {
			if (patientAge >= 0 && patientAge <= 12)
				return "Child";
			else if (patientAge > 12 && patientAge <= 19)
				return "Adolescent";
			else if (patientAge > 19 && patientAge <= 59)
				return "Adult";
			else
				return "Senior Citizen";
		}
}
