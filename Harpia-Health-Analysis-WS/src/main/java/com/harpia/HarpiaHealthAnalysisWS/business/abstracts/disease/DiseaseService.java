package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.disease;

import com.harpia.HarpiaHealthAnalysisWS.model.disease.Disease;

import java.util.List;

public interface DiseaseService {
    Disease save(Disease d);

    Disease findById(long id);

    List<Disease> findAll();

    List<Disease> saveAll(List<Disease> list);
}
