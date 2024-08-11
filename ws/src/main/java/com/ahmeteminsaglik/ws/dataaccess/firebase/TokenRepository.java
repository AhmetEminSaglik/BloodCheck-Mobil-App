package com.ahmeteminsaglik.ws.dataaccess.firebase;

import com.ahmeteminsaglik.ws.model.firebase.FcmToken;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TokenRepository extends JpaRepository<FcmToken, Long> {
    FcmToken findByUserId(long patientId);
    FcmToken findByToken(String token);
    FcmToken findByUserIdAndToken(long patientId, String token);
    List<FcmToken> findAllByUserId(long patientId);
}
