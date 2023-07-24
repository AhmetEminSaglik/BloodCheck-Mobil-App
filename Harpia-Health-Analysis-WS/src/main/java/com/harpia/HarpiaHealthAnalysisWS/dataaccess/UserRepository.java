package com.harpia.HarpiaHealthAnalysisWS.dataaccess;


import com.harpia.HarpiaHealthAnalysisWS.model.User;
import org.springframework.data.repository.Repository;

public interface UserRepository extends Repository<User,Long> {
    User save(User u);

}
