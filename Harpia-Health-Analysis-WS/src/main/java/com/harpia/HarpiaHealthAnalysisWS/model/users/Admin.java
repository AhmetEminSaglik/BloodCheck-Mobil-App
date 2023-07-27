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

//    public Admin() {
//        setRoleId(EnumUserRole.ADMIN.getId());
//    }
}
