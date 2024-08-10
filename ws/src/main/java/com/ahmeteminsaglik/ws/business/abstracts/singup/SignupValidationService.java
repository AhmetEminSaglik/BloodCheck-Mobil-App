package com.ahmeteminsaglik.ws.business.abstracts.singup;

import com.ahmeteminsaglik.ws.utility.result.Result;

public interface SignupValidationService {
    Result validateSingupCredentials(String username);
}
