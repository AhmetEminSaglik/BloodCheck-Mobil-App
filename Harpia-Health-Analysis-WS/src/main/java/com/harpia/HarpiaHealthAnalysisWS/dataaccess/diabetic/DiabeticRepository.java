package com.harpia.HarpiaHealthAnalysisWS.dataaccess.diabetic;

import com.harpia.HarpiaHealthAnalysisWS.model.diabetic.Diabetic;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DiabeticRepository extends JpaRepository<Diabetic, Long> {

}
