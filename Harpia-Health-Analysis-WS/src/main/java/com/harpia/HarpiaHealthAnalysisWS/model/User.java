package com.harpia.HarpiaHealthAnalysisWS.model;

import lombok.*;

@Data
public class User {
    private long id;
    private String name;
    private String lastname;
    private String username;
    private String password;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", lastname='" + lastname + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
