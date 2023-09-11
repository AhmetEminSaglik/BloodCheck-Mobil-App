package com.harpia.HarpiaHealthAnalysisWS.business.concretes.bloodresult;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.bloodresult.BloodResultAssessmentService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.token.FcmTokenService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.PatientService;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResultAssessmentValue;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.ItemRangeValue;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumBloodResultContent;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumFcmMessageReason;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.util.HashMap;
import java.util.Map;

@Service
public class BloodResultAssessmentManager implements BloodResultAssessmentService {
    private final String dangerous = "DANGEROUS:";
    private String patientFullName = "";
    private static CustomLog log = new CustomLog(BloodResultAssessmentManager.class);

    private BloodResultAssessmentValue bloodResultAssessmentValue = new BloodResultAssessmentValue();
    @Autowired
    FcmService fcmService;
    @Autowired
    FcmTokenService fcmTokenService;
    @Autowired
    PatientService patientService;

    @Override
    public void assessToSendFcmMsg(BloodResult bloodResult) {
        HashMap<String, Integer> subItemMap = new HashMap<>();

        subItemMap.put(EnumBloodResultContent.BLOOD_SUGAR.getName(), bloodResult.getBloodSugar());
        subItemMap.put(EnumBloodResultContent.BLOOD_PRESSURE.getName(), bloodResult.getBloodPressure());
        subItemMap.put(EnumBloodResultContent.CALCIUM.getName(), bloodResult.getCalcium());
        subItemMap.put(EnumBloodResultContent.MAGNESIUM.getName(), bloodResult.getMagnesium());

//        sendFcmMessage(bloodResult.getPatientId(), subItemMap);
        try {
            FcmMessage fcmMessage = createFcmMessage(bloodResult.getPatientId(), subItemMap);
//            fcmMessage.getData().setPatientId(bloodResult.getPatientId());
            Patient patient = patientService.findById(bloodResult.getPatientId());
            sendMsgToPatient(fcmMessage);

            patientFullName = " " + patient.getName() + " " + patient.getLastname();
            sendMsgToDoctorOfPatient(bloodResult.getPatientId(), fcmMessage);
        } catch (Exception e) {
            log.error("ERROR OCCURED : " + e.getMessage());
        }
    }

    private void sendMsgToPatient(FcmMessage fcmMessage) {
        fcmService.sendNotification(fcmMessage);
    }

    private void sendMsgToDoctorOfPatient(long patientId, FcmMessage fcmMessage) {
        long doctorId = patientService.findById(patientId).getDoctorId();
        String token = fcmTokenService.findByUserId(doctorId).getToken();
        fcmMessage.setTo(token);

        if (fcmMessage.getData().isShowNotification()) {
            String msgTitle = fcmMessage.getData().getMsgTitle();
            StringBuffer sbTitle = new StringBuffer(msgTitle);
            sbTitle.insert(dangerous.length(), patientFullName.toUpperCase());
            fcmMessage.getData().setMsgTitle(sbTitle.toString());

            FcmNotification notification = fcmMessage.getNotification();
            notification.setTitle(notification.getTitle() + ": " + patientFullName);
            notification.setBody("Patient's blood result values are out of normal bounds.");
        }
        fcmService.sendNotification(fcmMessage);
    }

    FcmMessage createFcmMessage(long patientId, Map<String, Integer> itemMap) {

        boolean tooHigh = false;
        boolean tooLow = false;

        StringBuffer msgBody = new StringBuffer();
        StringBuffer msgTitle = new StringBuffer();
        Map<String, ItemRangeValue> boundMap = bloodResultAssessmentValue.getMap();

        for (String subItem : itemMap.keySet()) {
            int lowBound = boundMap.get(subItem).getLowBound();
            int highBound = boundMap.get(subItem).getHighBound();
            int subItemValue = itemMap.get(subItem);
            if (subItemValue > highBound) {
                msgBody.append(createFcmMsgBody(subItem, Color.RED));
                msgBody.append("-");
                tooHigh = true;
            } else if (subItemValue < lowBound) {
                msgBody.append(createFcmMsgBody(subItem, Color.BLUE));
                msgBody.append("-");
                tooLow = true;
            }
        }
        if (msgBody.length() > 0) {
            msgBody.deleteCharAt(msgBody.length() - 1);
        }
        if (tooHigh || tooLow) {
            msgTitle.append(dangerous);
        }
        if (tooHigh) {
            msgTitle.append(createFcmMsgTitle("- HIGH", Color.RED));
        }
        if (tooLow) {

            msgTitle.append(createFcmMsgTitle("- LOW", Color.BLUE));
        }

        String token = fcmTokenService.findByUserId(patientId).getToken();
        FcmNotification notification = new FcmNotification();

        FcmData data = new FcmData();
        if (msgTitle.toString().contains(dangerous)) {
            data.setShowNotification(true);
            notification.setTitle("DANGEROUS");
            notification.setBody("You should have a look urgently");
            data.setMsgTitle(msgTitle.toString());
            data.setReasonCode(EnumFcmMessageReason.UPDATE_LINE_CHART.getCode());
            data.setReasonSend(EnumFcmMessageReason.UPDATE_LINE_CHART.getReason());
            data.setMsg(msgBody.toString());
        } else {
            data.setShowNotification(false);
            notification.setTitle("");
            notification.setBody("");
        }

        FcmMessage fcmMessage = fcmService.generateFcmMsg(token, notification, data);
        return fcmMessage;
    }


    String createFcmMsgTitle(String text, Color color) {
        return fcmService.generateTextWithHtmlColor(text, color);
    }

    String createFcmMsgBody(String text, Color color) {
        return fcmService.generateTextWithHtmlColor(text, color);
    }

}
