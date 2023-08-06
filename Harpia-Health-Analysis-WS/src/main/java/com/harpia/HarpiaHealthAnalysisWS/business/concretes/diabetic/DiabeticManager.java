package com.harpia.HarpiaHealthAnalysisWS.business.concretes.diabetic;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic.DiabeticService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.diabetic.DiabeticRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.diabetic.Diabetic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DiabeticManager implements DiabeticService {

    @Autowired
    DiabeticRepository rep;

    @Override
    public Diabetic save(Diabetic diabetic) {
        return rep.save(diabetic);
    }
}
