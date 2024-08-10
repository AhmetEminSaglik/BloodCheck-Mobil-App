package com.ahmeteminsaglik.ws.business.abstracts.firebase.token;

import com.ahmeteminsaglik.ws.model.firebase.FcmToken;

public interface FcmTokenService {

    FcmToken save(FcmToken fcmToken);

    FcmToken findByToken(String token);

    FcmToken findByUserId(long patientId);
}
