package com.ahmeteminsaglik.ws.model.dto;

import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.CustomUTCTime;

import java.time.LocalDateTime;

public class UserDto {
    private Long id;
    private int roleId;
    private String name;
    private String lastname;
    private String username;
    private String token;
    private int dia;
    private LocalDateTime createdAt = CustomUTCTime.getUTCTime();

    public UserDto(User user) {
        this.id = user.getId();
        this.roleId = user.getRoleId();
        this.name = user.getName();
        this.lastname = user.getLastname();
        this.token = user.getToken();
        this.createdAt = user.getCreatedAt();
        this.username = user.getUsername();
    }

    public Long getId() {
        return id;
    }

    public UserDto setId(Long id) {
        this.id = id;
        return this;
    }

    public int getRoleId() {
        return roleId;
    }

    public UserDto setRoleId(int roleId) {
        this.roleId = roleId;
        return this;
    }

    public String getName() {
        return name;
    }

    public UserDto setName(String name) {
        this.name = name;
        return this;
    }

    public String getLastname() {
        return lastname;
    }

    public UserDto setLastname(String lastname) {
        this.lastname = lastname;
        return this;
    }

    public String getUsername() {
        return username;
    }

    public UserDto setUsername(String username) {
        this.username = username;
        return this;
    }

    public String getToken() {
        return token;
    }

    public UserDto setToken(String token) {
        this.token = token;
        return this;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "UserDto{" +
                "id=" + id +
                ", roleId=" + roleId +
                ", name='" + name + '\'' +
                ", lastname='" + lastname + '\'' +
                ", username='" + username + '\'' +
                ", token='" + token + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
