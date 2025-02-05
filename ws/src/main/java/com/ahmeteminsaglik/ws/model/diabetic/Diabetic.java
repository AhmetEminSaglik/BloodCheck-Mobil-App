package com.ahmeteminsaglik.ws.model.diabetic;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "diabetic_types")
public class Diabetic {
    @Column
    String name;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private long id;

    public Diabetic(long id,String name) {
        this.name = name;
        this.id = id;
    }
}
