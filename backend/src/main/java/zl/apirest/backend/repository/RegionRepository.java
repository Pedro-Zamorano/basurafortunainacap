package zl.apirest.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import zl.apirest.backend.model.Region;

@Repository
public interface RegionRepository extends JpaRepository<Region, Long>{

}
