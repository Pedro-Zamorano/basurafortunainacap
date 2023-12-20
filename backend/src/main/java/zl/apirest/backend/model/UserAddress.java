package zl.apirest.backend.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "users_addresses")
public class UserAddress extends PkEntityBase{
      
    @Column(name = "additional", nullable = false)
    private String additional;
    
    @ManyToOne
    @JoinColumn(name = "commune_fk", referencedColumnName = "id", nullable = false)
    private Commune commune;

}
