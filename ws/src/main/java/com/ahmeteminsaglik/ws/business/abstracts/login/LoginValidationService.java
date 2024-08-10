package com.ahmeteminsaglik.ws.business.abstracts.login;

import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.result.DataResult;

public interface LoginValidationService {
    DataResult<User> validateLoginCredentials(String username, String password);
}
