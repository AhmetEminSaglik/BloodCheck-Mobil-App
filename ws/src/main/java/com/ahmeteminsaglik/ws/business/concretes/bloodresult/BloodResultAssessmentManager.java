package com.ahmeteminsaglik.ws.business.concretes.bloodresult;

import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultAssessmentService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.token.FcmTokenService;
import com.ahmeteminsaglik.ws.business.abstracts.user.PatientService;
import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;
import com.ahmeteminsaglik.ws.model.bloodresult.BloodResultBound;
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
    private static final Logger log = LoggerFactory.getLogger(BloodResultAssessmentManager.class);
    private final String dangerous = "DANGEROUS:";
    private final FcmService fcmService;
    private final FcmTokenService fcmTokenService;
    private final PatientService patientService;
    private String patientFullName = "";
    private final BloodResultBound bloodResultBound = new BloodResultBound();

    @Autowired
    public BloodResultAssessmentManager(FcmService fcmService, FcmTokenService fcmTokenService, PatientService patientService) {
        this.fcmService = fcmService;
        this.fcmTokenService = fcmTokenService;
        this.patientService = patientService;
    }

    @Override
    public void assessToSendFcmMsg(BloodResult bloodResult) {
        HashMap<String, Integer> subItemMap = new HashMap<>();

        subItemMap.put(EnumBloodResultContent.BLOOD_SUGAR.getName(), bloodResult.getBloodSugar());
        subItemMap.put(EnumBloodResultContent.BLOOD_PRESSURE.getName(), bloodResult.getBloodPressure());
        subItemMap.put(EnumBloodResultContent.CALCIUM.getName(), bloodResult.getCalcium());
        subItemMap.put(EnumBloodResultContent.MAGNESIUM.getName(), bloodResult.getMagnesium());

        try {

            FcmMessage fcmMessage = createFcmMessage(bloodResult.getPatientId(), subItemMap);
            Patient patient = patientService.findById(bloodResult.getPatientId());

            List<FcmToken> list = fcmTokenService.findAllByUserId(patient.getId());
            if (!list.isEmpty()) {
                fcmMessage.setTo(list.get(list.size() - 1).getToken());
            } else {
                fcmMessage.setTo("");
            }
            log.info("Token: " + fcmMessage.getTo());
            log.info("fcmMessage.getTo().isBlank() : " + fcmMessage.getTo().isBlank());
            if (!fcmMessage.getTo().isBlank()) {
                sendMsgToPatient(fcmMessage);
            }
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

            FcmNotification notification = fcmMessage.getNotification();
            notification.setTitle(notification.getTitle() + ": " + patientFullName);
            notification.setBody(body);
        }
        fcmService.sendNotification(fcmMessage);
    }

    FcmMessage createFcmMessage(long patientId, Map<String, Integer> itemMap) {

        boolean tooHigh = false;
        boolean tooLow = false;

        StringBuffer msgBody = new StringBuffer();
        StringBuffer msgTitle = new StringBuffer();
        Map<String, ItemRangeValue> boundMap = bloodResultBound.getRangeMap();

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
        String token;
        if (list.isEmpty()) {
            token = "";
            log.info("Token is not found.");
        } else {
            log.info("Token List (must be>0) :" + list.size());
            token = list.get(list.size() - 1).getToken();
        }
        FcmNotification notification = new FcmNotification();

        FcmData data = new FcmData();
        if (msgTitle.toString().contains(dangerous)) {
            data.setShowNotification(true);
            notification.setTitle("DANGEROUS");
            notification.setBody("Your blood results are out of normal.\nYour doctor is informed.");
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
