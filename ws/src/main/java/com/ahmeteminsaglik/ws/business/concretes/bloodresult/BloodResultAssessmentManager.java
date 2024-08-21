package com.ahmeteminsaglik.ws.business.concretes.bloodresult;

import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultAssessmentService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.token.FcmTokenService;
import com.ahmeteminsaglik.ws.business.abstracts.user.PatientService;
import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;
import com.ahmeteminsaglik.ws.model.bloodresult.BloodResultAssessmentValue;
import com.ahmeteminsaglik.ws.model.bloodresult.ItemRangeValue;
import com.ahmeteminsaglik.ws.model.enums.EnumBloodResultContent;
import com.ahmeteminsaglik.ws.model.enums.EnumFcmMessageReason;
import com.ahmeteminsaglik.ws.model.firebase.FcmData;
import com.ahmeteminsaglik.ws.model.firebase.FcmMessage;
import com.ahmeteminsaglik.ws.model.firebase.FcmNotification;
import com.ahmeteminsaglik.ws.model.firebase.FcmToken;
import com.ahmeteminsaglik.ws.model.users.Patient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BloodResultAssessmentManager implements BloodResultAssessmentService {
    private final String dangerous = "DANGEROUS:";
    private String patientFullName = "";
    //    private static CustomLog log = new CustomLog(BloodResultAssessmentManager.class);

    private static final Logger log = LoggerFactory.getLogger(BloodResultAssessmentManager.class);

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
            System.out.println("Gelen FCM Message : "+fcmMessage);;
//            fcmMessage.getData().setPatientId(bloodResult.getPatientId());
            Patient patient = patientService.findById(bloodResult.getPatientId());
//            fcmMessage.setTo(fcmTokenService.findAllByUserId(patient.getId()).getLast().getToken());

            List<FcmToken> list = fcmTokenService.findAllByUserId(patient.getId());
            fcmMessage.setTo(list.get(list.size() - 1).getToken());
            System.out.println("gelen token : "+fcmMessage.getTo());
            sendMsgToPatient(fcmMessage);

            patientFullName = " " + patient.getName() + " " + patient.getLastname();
            sendMsgToDoctorOfPatient(bloodResult.getPatientId(), fcmMessage);
        } catch (Exception e) {
            log.error("ERROR OCCURRED : " + e.getMessage());
        }
    }

    private void sendMsgToPatient(FcmMessage fcmMessage) {
        fcmService.sendNotification(fcmMessage);
    }

    private void sendMsgToDoctorOfPatient(long patientId, FcmMessage fcmMessage) {
        long doctorId = patientService.findById(patientId).getDoctorId();
//        String token = fcmTokenService.findByUserId(doctorId).getToken();
        List<FcmToken> list = fcmTokenService.findAllByUserId(doctorId);
        if (list.isEmpty()) {
            log.info("Doctor has not been login before. Could not send Notification to Doctor");
            return;
        }
        String token = list.get(list.size() - 1).getToken();
        fcmMessage.setTo(token);

        if (fcmMessage.getData().isShowNotification()) {
            String msgTitle = fcmMessage.getData().getMsgTitle();
            StringBuffer sbTitle = new StringBuffer(msgTitle);
            sbTitle.insert(dangerous.length(), patientFullName.toUpperCase());
            fcmMessage.getData().setMsgTitle(sbTitle.toString());

            String body = "Patient's blood result values are out of normal bounds.";

//            body = fcmService.generateTextWithHtmlColor(body,Color.);
            FcmNotification notification = fcmMessage.getNotification();
            notification.setTitle(notification.getTitle() + ": " + patientFullName);
//            notification.setBody("Patient's blood result values are out of normal bounds.");
            notification.setBody(body);
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
        List<FcmToken> list = fcmTokenService.findAllByUserId(patientId);
        String token = list.get(list.size() - 1).getToken();
//        System.out.println("gelen First " + fcmTokenService.findAllByUserId(patientId).getLast());
        FcmNotification notification = new FcmNotification();

        FcmData data = new FcmData();
        if (msgTitle.toString().contains(dangerous)) {
            data.setShowNotification(true);
//            notification.setTitle(fcmService.generateTextWithHtmlColor("DANGEROUS",Color.RED));
            notification.setTitle("DANGEROUS");
            notification.setBody("You should have a look urgently");
            data.setMsgTitle(msgTitle.toString());

            data.setMsg(msgBody.toString());
        } else {
            data.setShowNotification(false);
            notification.setTitle("");
            notification.setBody("");
        }
        data.setPatientId(patientId);
        data.setReasonCode(EnumFcmMessageReason.UPDATE_LINE_CHART.getCode());
        data.setReasonSend(EnumFcmMessageReason.UPDATE_LINE_CHART.getReason());

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
