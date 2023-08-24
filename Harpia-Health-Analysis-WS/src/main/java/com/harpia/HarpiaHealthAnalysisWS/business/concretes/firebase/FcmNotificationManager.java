package com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.FcmNotificationService;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.stereotype.Service;

import java.awt.*;

@Service
public class FcmNotificationManager implements FcmNotificationService {
//    private static CustomLog log = new CustomLog(FcmNotificationManager.class);

    @Override
    public String generateTextWithHtmlColor(String notificationTitle, Color color) {
        String cssColor = rgbToCssColor(color.getRed(), color.getGreen(), color.getBlue());
        String generatedText = "<span style='color:" + cssColor + "'>" + notificationTitle + "<span/>";
//        log.info("generatedText : " + generatedText);
        return generatedText;
    }

    public String rgbToCssColor(int red, int green, int blue) {
        return String.format("#%02X%02X%02X", red, green, blue);
    }
}
