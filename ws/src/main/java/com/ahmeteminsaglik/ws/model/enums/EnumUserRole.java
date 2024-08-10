package com.ahmeteminsaglik.ws.model.enums;

public enum EnumUserRole {
    ADMIN(1, "Admin"),
    DOCTOR(2, "Doctor"),
    PATIENT(3, "Patient");
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
