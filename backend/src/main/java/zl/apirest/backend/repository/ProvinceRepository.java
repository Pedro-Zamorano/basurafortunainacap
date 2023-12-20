package zl.apirest.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import zl.apirest.backend.model.Province;

@Repository
public interface ProvinceRepository extends JpaRepository<Province, Long>{
    
}
