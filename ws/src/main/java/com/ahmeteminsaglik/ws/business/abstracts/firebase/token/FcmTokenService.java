package com.ahmeteminsaglik.ws.business.abstracts.firebase.token;

import com.ahmeteminsaglik.ws.model.firebase.FcmToken;

import java.util.List;

public interface FcmTokenService {

    FcmToken save(FcmToken fcmToken);

    FcmToken findByToken(String token);

    FcmToken findByUserId(long patientId);
    List<FcmToken> findAllByUserId(long patientId);

    FcmToken findByUserIdAndToken(long patientId, String token);

    void delete(FcmToken fcmToken);
}
