package com.harpia.HarpiaHealthAnalysisWS.model.signincredentials;

public abstract class SignupUserCredentials {
    String Username, password, name, lastname;

    public SignupUserCredentials(String username, String password, String name, String lastname) {
        Username = username;
        this.password = password;
        this.name = name;
        this.lastname = lastname;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }
}
