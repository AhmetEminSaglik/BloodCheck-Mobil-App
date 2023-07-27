package com.harpia.HarpiaHealthAnalysisWS.model.enums;

public enum EnumDiseaseType {
    DIABETIC(1, "Diabetic");

    private final int id;
    private final String role;

    EnumDiseaseType(int id, String role) {
        this.id = id;
        this.role = role;
    }

    public int getId() {
        return this.id;
    }

    public String getName() {
        return this.role;
    }
}
