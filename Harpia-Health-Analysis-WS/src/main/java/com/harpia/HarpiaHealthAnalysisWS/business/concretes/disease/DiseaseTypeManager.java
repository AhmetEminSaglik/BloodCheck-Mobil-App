/*
package com.harpia.HarpiaHealthAnalysisWS.business.concretes.disease;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.disease.DiseaseTypeService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.disease.DiseaseTypeRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.DiseaseType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiseaseTypeManager implements DiseaseTypeService {
    @Autowired
    private DiseaseTypeRepository repository;

    @Override
    public DiseaseType save(DiseaseType dt) {
        return repository.save(dt);
    }
    @Override
    public List<DiseaseType> saveAll(List<DiseaseType> list) {
        return repository.saveAll(list);
    }

    @Override
    public DiseaseType findById(long id) {
        return repository.findById(id).get();
    }
}
*/
