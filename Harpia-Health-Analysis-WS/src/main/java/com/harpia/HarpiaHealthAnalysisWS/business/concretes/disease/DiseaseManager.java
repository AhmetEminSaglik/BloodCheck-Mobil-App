package com.harpia.HarpiaHealthAnalysisWS.business.concretes.disease;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.disease.DiseaseService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.disease.DiseaseRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.Disease;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiseaseManager implements DiseaseService {
    @Autowired
    DiseaseRepository repository;

    @Override
    public Disease save(Disease disease) {
        return repository.save(disease);
    }

    @Override
    public Disease findById(long id) {
        return repository.findById(id).get();
    }

    @Override
    public List<Disease> findAll() {
        return repository.findAll();
    }
}
