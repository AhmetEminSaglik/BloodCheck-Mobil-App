package com.ahmeteminsaglik.ws.model.enums;

public enum EnumBloodResultContent {

    BLOOD_SUGAR(1, "Blood Sugar"),
    BLOOD_PRESSURE(2, "Blood Pressure"),
    MAGNESIUM(3, "Magnesium"),
    CALCIUM(4, "Calcium");

    private final int id;
    private final String name;

    EnumBloodResultContent(int id, String name) {
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
