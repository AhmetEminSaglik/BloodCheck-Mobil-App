package com.harpia.HarpiaHealthAnalysisWS.dataaccess.disease;

import com.harpia.HarpiaHealthAnalysisWS.model.disease.Disease;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DiseaseRepository extends JpaRepository<Disease, Long> {
    Disease save(Disease u);

    @Override
    <S extends Disease> List<S> saveAll(Iterable<S> entities);

    List<Disease> findAll();

    List<Disease> findAllByPatientId(long id);
}
