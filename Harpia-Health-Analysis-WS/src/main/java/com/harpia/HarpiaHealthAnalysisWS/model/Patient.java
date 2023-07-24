package com.harpia.HarpiaHealthAnalysisWS.model;

import jakarta.persistence.*;
import lombok.Data;

@Data

@Entity
@Table(name = "patients")
public class Patient extends User {
    @Column
    String patientNo;
}
