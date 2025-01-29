package com.ahmeteminsaglik.ws.model.enums;

public enum EnumAuthority {
    ROLE_ADMIN(1,"ADMIN"),
    ROLE_DOCTOR(2,"DOCTOR"),
    ROLE_PATIENT(3,"PATIENT"),
    ROLE_SUPER_ADMIN(4,"SUPER_ADMIN");
    private final int id;

    private String name;

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
