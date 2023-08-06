package com.harpia.HarpiaHealthAnalysisWS.model.enums;

public enum EnumInputName {
    USERNAME("Username"), PASSWORD("Password");
    private final String name;

    EnumInputName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }
}
