package com.ahmeteminsaglik.ws.business.concretes.firebase.token;

import com.ahmeteminsaglik.ws.business.abstracts.firebase.token.FcmTokenService;
import com.ahmeteminsaglik.ws.dataaccess.firebase.TokenRepository;
import com.ahmeteminsaglik.ws.model.firebase.FcmToken;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FcmTokenManager implements FcmTokenService {
    private static final CustomLog log = new CustomLog(FcmTokenManager.class);

    private final TokenRepository repository;

    @Autowired
    public FcmTokenManager(TokenRepository repository) {
        this.repository = repository;
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

    @Override
    public List<FcmToken> findAllByUserId(long patientId) {
        return repository.findAllByUserId(patientId);
    }

    @Override
    public FcmToken findByUserIdAndToken(long patientId, String token) {
        return repository.findByUserIdAndToken(patientId, token);
    }

    @Override
    public void delete(FcmToken fcmToken) {
        repository.delete(fcmToken);
    }
}
