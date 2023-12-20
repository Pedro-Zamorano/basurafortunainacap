package zl.apirest.backend.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import zl.apirest.backend.enums.MaterialType;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "recycling_types")
public class RecyclingType extends PkEntityBase{
    
    @Column(name = "status_type_recycling", nullable = false)
    @Enumerated(EnumType.ORDINAL)
    private MaterialType typeRecycling;
    
    @Column(name = "active")
    private boolean active;

}
