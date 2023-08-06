package com.harpia.HarpiaHealthAnalysisWS.model.users;

import com.harpia.HarpiaHealthAnalysisWS.utility.datetime.UtilCustomDateTime;
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
    @Column(name = "created_at")
    private String createdTime = UtilCustomDateTime.createDateTimeStringFormat();

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
//                ", userRoleId=" + roleId +
                ", name='" + name + '\'' +
                ", lastname='" + lastname + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", createdTime='" + createdTime + '\'' +
                '}';
    }

}
