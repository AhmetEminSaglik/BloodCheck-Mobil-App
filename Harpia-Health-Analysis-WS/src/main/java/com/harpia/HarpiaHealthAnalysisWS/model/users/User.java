package com.harpia.HarpiaHealthAnalysisWS.model.users;

import jakarta.persistence.*;
import lombok.*;

@Data
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "user_type")
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "users", uniqueConstraints = @UniqueConstraint(columnNames = "username"))
public abstract class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;
    @Column
    private int roleId;
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
//                ", userRoleId=" + roleId +
                ", name='" + name + '\'' +
                ", lastname='" + lastname + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

}
