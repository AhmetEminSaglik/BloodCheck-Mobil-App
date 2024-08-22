package com.ahmeteminsaglik.ws.utility;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class CustomUTCTime {
    public static LocalDateTime getUTCTime() {
        ZonedDateTime zonedDateTime = LocalDateTime.now().atZone(ZoneId.systemDefault());
        ZonedDateTime utcZonedDateTime = zonedDateTime.withZoneSameInstant(ZoneId.of("UTC"));
        return utcZonedDateTime.toLocalDateTime();
    }

    public static LocalDateTime convertToUTCTime(LocalDateTime localDateTime) {
        ZonedDateTime zonedDateTime = localDateTime.atZone(ZoneId.systemDefault());
        ZonedDateTime utcZonedDateTime = zonedDateTime.withZoneSameInstant(ZoneId.of("UTC"));
        return utcZonedDateTime.toLocalDateTime();
    }
}
