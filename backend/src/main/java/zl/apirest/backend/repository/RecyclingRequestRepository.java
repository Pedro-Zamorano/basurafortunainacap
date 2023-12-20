package zl.apirest.backend.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import zl.apirest.backend.model.RecyclingRequest;

@Repository
public interface RecyclingRequestRepository extends JpaRepository<RecyclingRequest, Long>{
    
    public List<RecyclingRequest> findByUserEmail(String email);
    
}
