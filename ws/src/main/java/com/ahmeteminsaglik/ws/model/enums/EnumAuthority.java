package com.ahmeteminsaglik.ws.model.enums;

public enum EnumAuthority {
    ROLE_ADMIN(1, "ADMIN"),
    ROLE_DOCTOR(2, "DOCTOR"),
    ROLE_PATIENT(3, "PATIENT");
    private final int id;

    private final String name;

    EnumAuthority(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }
}
