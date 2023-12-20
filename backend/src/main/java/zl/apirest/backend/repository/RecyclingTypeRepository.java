package zl.apirest.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import zl.apirest.backend.model.RecyclingType;

@Repository
public interface RecyclingTypeRepository extends JpaRepository<RecyclingType, Long>{
    
}
