package com.ahmeteminsaglik.ws.model;

import com.ahmeteminsaglik.ws.model.users.User;

public class JwtAuthResponse {
    private String accessToken;
    private User user;
    private String tokenType = "Bearer";

    public JwtAuthResponse() {
    }

    public JwtAuthResponse(String accessToken, User user, String tokenType) {
        this.accessToken = accessToken;
        this.user = user;
        this.tokenType = tokenType;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "JwtAuthResponse{" +
                "accessToken='" + accessToken + '\'' +
                ", tokenType='" + tokenType + '\'' +
                '}';
    }
}