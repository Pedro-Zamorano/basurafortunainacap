package zl.apirest.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import zl.apirest.backend.model.RequestHistory;

@Repository
public interface RequestHistoryRepository extends JpaRepository<RequestHistory, Long> {

}
