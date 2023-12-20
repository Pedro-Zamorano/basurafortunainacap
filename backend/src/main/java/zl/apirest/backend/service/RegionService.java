package zl.apirest.backend.service;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zl.apirest.backend.model.Region;
import zl.apirest.backend.repository.RegionRepository;

@Service
public class RegionService {

    @Autowired
    private transient RegionRepository regionRepository;

    public Region getById(Long id) {
        Optional<Region> regionOpt = regionRepository.findById(id);
        if (regionOpt.isPresent()) {
            return regionOpt.get();
        } else {
            return null;
        }
    }

}
