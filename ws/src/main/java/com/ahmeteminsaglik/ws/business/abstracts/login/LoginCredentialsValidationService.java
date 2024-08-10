package com.ahmeteminsaglik.ws.business.abstracts.login;

import com.ahmeteminsaglik.ws.utility.result.Result;

public interface LoginCredentialsValidationService {
    Result isUsernameValid(String username);

    Result isPasswordValid(String password);

    Result isUsernameAndPasswordRegistered(String username, String password);
}
