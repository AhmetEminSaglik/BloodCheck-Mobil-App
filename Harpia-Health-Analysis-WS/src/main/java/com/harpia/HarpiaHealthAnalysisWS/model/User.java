package com.harpia.HarpiaHealthAnalysisWS.model;

import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import jakarta.persistence.*;
import lombok.*;

@Data
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "user_type")//@Table(name = "users")
public abstract class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;

    @OneToOne
    @PrimaryKeyJoinColumn
    private UserRole userRole= new UserRole();
    @Column
    private String name;
    @Column
    private String lastname;
    @Column
    private String username;
    @Column
    private String password;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", lastname='" + lastname + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public void setUserRole(EnumUserRole enumRole) {
        this.userRole.setId(enumRole.getId());
        this.userRole.setRole(enumRole.getName());

    }

}
