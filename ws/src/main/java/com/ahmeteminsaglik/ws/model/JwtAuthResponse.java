package com.ahmeteminsaglik.ws.model;

import com.ahmeteminsaglik.ws.model.dto.UserDto;

public class JwtAuthResponse {
    private String accessToken;
    private UserDto userDto;
    private String tokenType = "Bearer";

//    public JwtAuthResponse() {
//    }

    public JwtAuthResponse( UserDto userDto,String accessToken) {
        this.accessToken = accessToken;
        this.userDto = userDto;
    }

    public String getAccessToken() {
        return accessToken;
    }
//
//    public void setAccessToken(String accessToken) {
//        this.accessToken = accessToken;
//    }

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public UserDto getUserDto() {
        return userDto;
    }

    public void setUserDto(UserDto userDto) {
        this.userDto = userDto;
    }

    @Override
    public String toString() {
        return "JwtAuthResponse{" +
                "accessToken='" + accessToken + '\'' +
                ", tokenType='" + tokenType + '\'' +
                '}';
    }
}