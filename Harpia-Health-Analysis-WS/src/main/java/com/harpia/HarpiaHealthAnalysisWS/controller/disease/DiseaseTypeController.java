/*
package com.harpia.HarpiaHealthAnalysisWS.controller.disease;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.disease.DiseaseTypeService;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumDiseaseType;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.DiseaseType;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/diseases/types")
@CrossOrigin
public class DiseaseTypeController {
    private static final Logger log = LoggerFactory.getLogger(DiseaseTypeController.class);

    @Autowired
    private DiseaseTypeService service;

    @PostMapping
    public SuccessDataResult<List<DiseaseType>> setupDiseaseTypes() {
        List<DiseaseType> list = service.saveAll(getDiseaseTypeList());
        String msg = "1 disease type is added";
        return new SuccessDataResult<>(list,msg);
    }

    private List<DiseaseType> getDiseaseTypeList() {
        List<DiseaseType> list = new ArrayList<>();
        list.add(new DiseaseType(1, EnumDiseaseType.DIABETIC.getName()));
        list.add(new DiseaseType(2, "Canser"));
        return list;
    }
}
*/
