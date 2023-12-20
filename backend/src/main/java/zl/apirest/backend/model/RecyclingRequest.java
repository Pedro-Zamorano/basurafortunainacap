package zl.apirest.backend.model;

import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import zl.apirest.backend.enums.MaterialType;
import zl.apirest.backend.enums.RequestState;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "recycling_requests")
public class RecyclingRequest extends PkEntityBase {

    @Column(name = "estimated_weight")
    private BigDecimal estimatedWeight;

    @Column(name = "state", nullable = false)
    @Enumerated(EnumType.ORDINAL)
    private RequestState state;
    
    @Column(name = "description")
    private String description;

    @Column(name = "type")
    @Enumerated(EnumType.ORDINAL)
    private MaterialType type;

    @ManyToOne
    @JoinColumn(name = "schedule_fk", referencedColumnName = "id")
    private Schedule schedule;

    @ManyToOne
    @JoinColumn(name = "user_fk", referencedColumnName = "id")
    private User user;

}
