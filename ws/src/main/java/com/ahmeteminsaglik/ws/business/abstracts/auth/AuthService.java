package com.ahmeteminsaglik.ws.business.abstracts.auth;

import com.ahmeteminsaglik.ws.model.LoginCredentials;

public interface AuthService {

    String login(LoginCredentials loginDto);
}
