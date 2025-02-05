package com.ahmeteminsaglik.ws.business.concretes.diabetic;

import com.ahmeteminsaglik.ws.business.abstracts.diabetic.DiabeticService;
import com.ahmeteminsaglik.ws.dataaccess.diabetic.DiabeticRepository;
import com.ahmeteminsaglik.ws.model.diabetic.Diabetic;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiabeticManager implements DiabeticService {
    private final DiabeticRepository repository;

    @Autowired
    public DiabeticManager(DiabeticRepository repository) {
        this.repository = repository;
    }

    @Override
    public Diabetic save(Diabetic diabetic) {
        return repository.save(diabetic);
    }

    @Override
    public List<Diabetic> findAll() {
        return repository.findAll();
    }

    @Override
    @Transactional
    public void deleteAll() {
        repository.deleteAll();
        repository.resetAutoIncrement();
    }
}
