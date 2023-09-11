package com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase.token;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.token.FcmTokenService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.firebase.TokenRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmToken;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FcmTokenManager implements FcmTokenService {
    private static CustomLog log = new CustomLog(FcmTokenManager.class);

    @Autowired
    TokenRepository repository;

    public FcmTokenManager() {
        log.info("FCM TOKEN MANAGER IS CREATED > TokenRepository : "+repository);
    }

    @Override
    public FcmToken save(FcmToken fcmToken) {
        return repository.save(fcmToken);
    }

    @Override
    public FcmToken findByToken(String token) {
        return repository.findByToken(token);
    }

    @Override
    public FcmToken findByUserId(long patientId) {
        return repository.findByUserId(patientId);
    }
}
