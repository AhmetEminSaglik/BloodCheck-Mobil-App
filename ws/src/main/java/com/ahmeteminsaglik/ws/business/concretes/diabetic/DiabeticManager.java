package com.ahmeteminsaglik.ws.business.concretes.diabetic;

import com.ahmeteminsaglik.ws.business.abstracts.diabetic.DiabeticService;
import com.ahmeteminsaglik.ws.dataaccess.diabetic.DiabeticRepository;
import com.ahmeteminsaglik.ws.model.diabetic.Diabetic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DiabeticManager implements DiabeticService {
    @Autowired
    DiabeticRepository rep;

    @Override
    public Diabetic save(Diabetic diabetic) {
        return rep.save(diabetic);
    }
}
