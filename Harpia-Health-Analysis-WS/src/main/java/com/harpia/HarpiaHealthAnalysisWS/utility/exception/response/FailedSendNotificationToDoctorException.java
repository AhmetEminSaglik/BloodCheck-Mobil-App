package com.harpia.HarpiaHealthAnalysisWS.utility.exception.response;

public class FailedSendNotificationToDoctorException extends RuntimeException {
    public static String customErrorMsg = "Could not send Notification to Doctor. Because the doctor has not been logged into the system.";

    public FailedSendNotificationToDoctorException() {
        super(customErrorMsg);
    }


}
