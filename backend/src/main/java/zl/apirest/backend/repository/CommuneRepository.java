package zl.apirest.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import zl.apirest.backend.model.Commune;

@Repository
public interface CommuneRepository extends JpaRepository<Commune, Long>{
    
}
