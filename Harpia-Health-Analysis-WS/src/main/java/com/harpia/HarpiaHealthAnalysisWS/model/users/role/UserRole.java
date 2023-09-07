package com.harpia.HarpiaHealthAnalysisWS.model.users.role;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user_roles", uniqueConstraints = @UniqueConstraint(columnNames = "role"))
public class UserRole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    int id;
    @Column()
    String role;
}
