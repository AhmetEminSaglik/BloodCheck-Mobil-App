package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup;

import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;

public interface SignupCredentialsValidationService {
    Result isUsernameRegistered(String username);

    Result isUsernameValid(String username);
}
