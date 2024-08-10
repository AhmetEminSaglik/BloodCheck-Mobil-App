package com.ahmeteminsaglik.ws.dataaccess.firebase;

import com.ahmeteminsaglik.ws.model.firebase.FcmToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TokenRepository extends JpaRepository<FcmToken, Long> {
    FcmToken findByUserId(long patientId);
    FcmToken findByToken(String token);


}
