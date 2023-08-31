package com.harpia.HarpiaHealthAnalysisWS.model.bloodresult;

import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumBloodResultContent;
import org.checkerframework.checker.units.qual.C;

import java.util.HashMap;
import java.util.Map;

public class BloodResultContentMap extends HashMap<String, String> {
    public BloodResultContentMap() {
        EnumBloodResultContent[] enums = EnumBloodResultContent.values();
        for (int i = 0; i < enums.length; i++) {
            putIfAbsent(enums[i].name(), enums[i].getName());
        }
    }
}
