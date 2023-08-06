package com.harpia.HarpiaHealthAnalysisWS.model.users;

import com.harpia.HarpiaHealthAnalysisWS.utility.datetime.UtilCustomDateTime;
import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "user_type")
@AllArgsConstructor
//@NoArgsConstructor
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

    @Column(name = "created_at", columnDefinition = "TIMESTAMP")
    private LocalDateTime createdTime = LocalDateTime.now();
//    @Column(name = "time_string")
//    private String createdTime = UtilCustomDateTime.createDateTimeStringFormat();
//    @Column(name = "time_local_date_time2", columnDefinition = "TIMESTAMP")
//    private Timestamp timestamp = new Timestamp(System.currentTimeMillis());
//    @Column(name = "time_stamp")
//    private  Timestamp timestamp= Timestamp.from(Instant.from(localDateTime));

    static int counter = 1;

    public User() {
        createdTime = LocalDateTime.now().minusMinutes(3 * counter);
        counter++;
        /*try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }*/
    }

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
