package com.harpia.HarpiaHealthAnalysisWS.business.concretes.bloodresult;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.bloodresult.BloodResultAssessmentService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.token.FcmTokenService;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResultAssessmentValue;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.ItemRangeValue;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumBloodResultContent;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.util.HashMap;
import java.util.Map;

@Service
public class BloodResultAssessmentManager implements BloodResultAssessmentService {
    private static CustomLog log = new CustomLog(BloodResultAssessmentManager.class);

    private BloodResultAssessmentValue bloodResultAssessmentValue = new BloodResultAssessmentValue();
    @Autowired
    FcmService fcmService;
    @Autowired
    FcmTokenService fcmTokenService;

    @Override
    public void assessToSendFcmMsg(BloodResult bloodResult) {
        log.info("assess blood result : " + bloodResult);
        HashMap<String, Integer> subItemMap = new HashMap<>();

        subItemMap.put(EnumBloodResultContent.BLOOD_SUGAR.name(), bloodResult.getBloodSugar());
        subItemMap.put(EnumBloodResultContent.BLOOD_PRESSURE.name(), bloodResult.getBloodPressure());
        subItemMap.put(EnumBloodResultContent.CALCIUM.name(), bloodResult.getCalcium());
        subItemMap.put(EnumBloodResultContent.MAGNESIUM.name(), bloodResult.getMagnesium());

        sendFcmMessage(bloodResult.getPatientId(), subItemMap);
    }

    void sendFcmMessage(long patientId, Map<String, Integer> itemMap) {
        final String dangerous = "DANGEROUS";
        boolean tooHigh = false;
        boolean tooLow = false;

        StringBuffer msgBody = new StringBuffer();
        StringBuffer msgTitle = new StringBuffer();
        Map<String, ItemRangeValue> boundMap = bloodResultAssessmentValue.getMap();

        for (String subItem : itemMap.keySet()) {
            log.info("item : " + subItem);
//            String item=itemMap.get(tmp);
//log.info("Demo :"+boundMap.get(subItem));
//            for (String boundTmp : boundMap.keySet()) {
//                log.info("Bound Map item : "+boundTmp);
            int lowBound = boundMap.get(subItem).getLowBound();
            int highBound = boundMap.get(subItem).getHighBound();

            int subItemValue = itemMap.get(subItem);
            if (subItemValue > highBound) {
                msgBody.append(createFcmMsgBody(subItem.toUpperCase(), Color.RED));
                msgBody.append("-");
                tooHigh = true;
            } else if (subItemValue < lowBound) {
                msgBody.append(createFcmMsgBody(subItem.toUpperCase(), Color.BLUE));
                msgBody.append("-");
                tooLow = true;
            }
//            }

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
            data.setMsg(msgBody.toString());
        } else {
            data.setShowNotification(false);
            notification.setTitle("");
            notification.setBody("");
        }

        FcmMessage fcmMessage = fcmService.generateFcmMsg(token, notification, data);
        log.info("sending fcm msg : " + fcmMessage);

        fcmService.sendNotification(fcmMessage);
    }


    String createFcmMsgTitle(String text, Color color) {
        return fcmService.generateTextWithHtmlColor(text, color);
    }

    String createFcmMsgBody(String text, Color color) {
        log.info("GELEN TEXT : " + text);
        return fcmService.generateTextWithHtmlColor(text, color);
    }


}
