package com.harpia.HarpiaHealthAnalysisWS.dataaccess.firebase;

import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TokenRepository extends JpaRepository<FcmToken, Long> {
    FcmToken findByPatientId(long patientId);
    FcmToken findByToken(String token);


}
