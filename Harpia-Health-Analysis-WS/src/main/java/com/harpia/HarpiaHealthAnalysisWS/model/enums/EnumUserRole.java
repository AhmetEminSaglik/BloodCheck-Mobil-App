package com.harpia.HarpiaHealthAnalysisWS.model.enums;

public enum EnumUserRole {
    ADMIN(1, "ADMIN"), HEALTHCARE_PERSONNEL(2, "HEALTHCARE_PERSONNEL"), PATIENT(3, "PATIENT");

    private final int id;
    private final String role;

    EnumUserRole(int id, String role) {
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
