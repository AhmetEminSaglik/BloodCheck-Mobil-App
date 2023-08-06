package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.login;

import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;

public interface LoginCredentialsValidationService {
    Result isUsernameValid(String username);

    Result isPasswordValid(String password);

    Result isUsernameAndPasswordRegistered(String username, String password);
}
