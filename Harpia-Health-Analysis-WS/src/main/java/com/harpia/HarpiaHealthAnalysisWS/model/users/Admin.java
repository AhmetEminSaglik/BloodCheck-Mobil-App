package com.harpia.HarpiaHealthAnalysisWS.model.users;


import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
//@AllArgsConstructor
//@NoArgsConstructor
@Table(name = "admins")
public class Admin extends User {
//    public Admin(Long id, String name, String lastname, String username, String password) {
//        super(id, name, lastname, username, password);
//    }

//    public Admin() {
//        setRoleId(EnumUserRole.ADMIN.getId());
//    }

    @Override
    public String toString() {
        return "Admin{"+super.toString()+"}";
    }
}
