package com.harpia.HarpiaHealthAnalysisWS.model.disease;

import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumDiseaseType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
//@NoArgsConstructor
@Table(name = "diabetic_patients")
public class Diabetic extends Disease {
    @Column
    int bloodSugar;
    @Column
    int bloodPressure;
    @Column
    int cholesterol;

    public Diabetic() {
        setDiseaseTypeId(EnumDiseaseType.DIABETIC.getId());
//        setName(EnumDiseaseType.DIABETIC.getName());
    }
}
