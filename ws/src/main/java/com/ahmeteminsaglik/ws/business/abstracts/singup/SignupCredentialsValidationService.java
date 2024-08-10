package com.ahmeteminsaglik.ws.business.abstracts.singup;

import com.ahmeteminsaglik.ws.utility.result.Result;

public interface SignupCredentialsValidationService {
    Result isUsernameRegistered(String username);

    Result isUsernameValid(String username);
}
