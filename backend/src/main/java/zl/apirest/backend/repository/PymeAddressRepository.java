package zl.apirest.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import zl.apirest.backend.model.PymeAddress;

@Repository
public interface PymeAddressRepository extends JpaRepository<PymeAddress, Long>{

}
