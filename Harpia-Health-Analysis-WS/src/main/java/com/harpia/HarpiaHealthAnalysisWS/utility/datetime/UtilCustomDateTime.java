package com.harpia.HarpiaHealthAnalysisWS.utility.datetime;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class UtilCustomDateTime {
    private static DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static String createDateTimeStringFormat() {
        LocalDateTime time = LocalDateTime.now();
        return time.format(formatter);
    }
}
