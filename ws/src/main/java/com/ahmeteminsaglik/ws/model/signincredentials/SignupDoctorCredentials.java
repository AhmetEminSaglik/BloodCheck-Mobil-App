package com.ahmeteminsaglik.ws.model.signincredentials;

public class SignupDoctorCredentials extends SignupUserCredentials {
    int totalPatientNumber;

    public SignupDoctorCredentials(String username, String password, String name, String lastname, int totalPatientNumber) {
        super(username, password, name, lastname);
        this.totalPatientNumber = totalPatientNumber;
    }
}
