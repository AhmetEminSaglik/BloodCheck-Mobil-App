package com.harpia.HarpiaHealthAnalysisWS.dataaccess;

//import model.User;
//import org.springframework.data.repository.Repository;

import com.harpia.HarpiaHealthAnalysisWS.model.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;
import org.springframework.data.repository.Repository;

public interface UserRepository extends Repository<User,Long> {
    User save(User u);

}
