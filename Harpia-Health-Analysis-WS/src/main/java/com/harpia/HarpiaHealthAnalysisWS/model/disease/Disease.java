package com.harpia.HarpiaHealthAnalysisWS.model.disease;

import com.harpia.HarpiaHealthAnalysisWS.model.users.HealthcarePersonnel;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "disease_type")
@Table(name = "diseases")
public abstract class Disease {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;
    //    @Column
//    private int diseaseTypeId;
//    @Column
//    private String name;
//    @OneToOne
//    @JoinColumn(name = "patient_id")
    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @Override
    public String toString() {
        return "Disease{" +
                "id=" + id +
//                ", diseaseTypeId=" + diseaseTypeId +
                ", patient=" + patient +
                '}';
    }
}
