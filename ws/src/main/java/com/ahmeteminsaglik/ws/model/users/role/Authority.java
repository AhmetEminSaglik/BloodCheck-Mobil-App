package com.ahmeteminsaglik.ws.model.users.role;

import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import com.ahmeteminsaglik.ws.model.users.User;
import jakarta.persistence.*;
import org.springframework.security.core.GrantedAuthority;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "authorities")
public class Authority implements GrantedAuthority {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    //    @Column(name = "username")
//    private String username;
    @Column(name = "authority")
    private String authority;

    @ManyToMany(mappedBy = "authorities")
    private final Set<User> users = new HashSet<>();

    public Authority() {
    }

    public Authority(EnumAuthority enumAuthority) {
        this.authority = enumAuthority.toString();
    }

    public Authority(int id, EnumAuthority enumAuthority) {
        this.id = id;
        this.authority = enumAuthority.toString();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAuthority() {
        return authority;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }

    @Override
    public String toString() {
        return "Authority{" +
                "id=" + id +
                ", authority='" + authority + '\'' +
                '}';
    }
}
