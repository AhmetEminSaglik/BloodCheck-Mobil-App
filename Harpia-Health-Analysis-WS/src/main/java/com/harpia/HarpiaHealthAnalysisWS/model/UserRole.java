package com.harpia.HarpiaHealthAnalysisWS.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor()
@NoArgsConstructor
@Table(name = "user_role", uniqueConstraints = @UniqueConstraint(columnNames = "role"))
public class UserRole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    int id;
    @Column
    String role;

    @JsonBackReference
    @OneToOne(mappedBy = "userRole")
    private User user;

    public UserRole(int id, String role) {
        this.id = id;
        this.role = role;
    }
}
