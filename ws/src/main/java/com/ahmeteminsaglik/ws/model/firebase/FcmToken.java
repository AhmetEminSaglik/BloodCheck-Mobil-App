package com.ahmeteminsaglik.ws.model.firebase;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Objects;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "firebase_tokens"/*, uniqueConstraints = @UniqueConstraint(columnNames = "user_id")*/)
public class FcmToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private long id;

    @Column(name = "user_id")
    private int userId;
    @Column
    private String token;

    @Override
    public String toString() {
        return "FcmToken{" +
                "id=" + id +
                ", userId=" + userId +
                ", token='" + token + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof FcmToken fcmToken)) return false;
        return userId == fcmToken.userId && Objects.equals(token, fcmToken.token);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, token);
    }
}
