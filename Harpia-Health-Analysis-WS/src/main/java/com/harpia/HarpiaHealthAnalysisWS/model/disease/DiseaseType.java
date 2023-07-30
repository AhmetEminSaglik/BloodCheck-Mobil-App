package com.harpia.HarpiaHealthAnalysisWS.model.disease;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "disease_type", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
public class DiseaseType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    int id;
    @Column()
    String name;

//    @JsonBackReference
//    @OneToOne(mappedBy = "userRole")
//    private User user;
}
