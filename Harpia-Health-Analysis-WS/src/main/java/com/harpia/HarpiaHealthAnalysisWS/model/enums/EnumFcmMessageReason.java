package com.harpia.HarpiaHealthAnalysisWS.model.enums;

import lombok.Getter;

public enum EnumFcmMessageReason {
    //  X___ :  Process : Update, Save ...
    // _XXX : Item : LineChart, Sensor
    UPDATE_LINE_CHART(1000, "Update Line Chart"),
    UPDATE_SENSOR_TIMER(1001, "Update Sensor Timer");

    @Getter
    private final int code;
    @Getter
    private final String reason;


    EnumFcmMessageReason(int code, String reason) {
        this.code = code;
        this.reason = reason;
    }


}
