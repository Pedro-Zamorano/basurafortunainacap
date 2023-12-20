package zl.apirest.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import zl.apirest.backend.model.Pyme;

@Repository
public interface PymeRepository extends JpaRepository<Pyme, Long> {

    public Pyme findByEmail(String email);
    public Pyme findByDni(int dni);
    
}
