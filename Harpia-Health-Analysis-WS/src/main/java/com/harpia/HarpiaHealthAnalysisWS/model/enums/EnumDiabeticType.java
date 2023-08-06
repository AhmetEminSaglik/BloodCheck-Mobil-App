package com.harpia.HarpiaHealthAnalysisWS.model.enums;

public enum EnumDiabeticType {
    TIP_1(1, "Tip 1"), TIP_2(2, "TIP 2"), HIPOGLISEMI(1, "Hipoglisemi"), HIPERGLISEMI(2, "Hiperglisemi");
    private final int id;
    private final String name;

    EnumDiabeticType(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }
}
