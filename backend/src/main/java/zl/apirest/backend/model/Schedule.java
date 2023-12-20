// Datos que registra la pyme

package zl.apirest.backend.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
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
@Table(name = "schedules")
public class Schedule extends PkEntityBase{

    @Column(name = "date", nullable = false)
    private LocalDate date;
    
    @Column(name = "start_hour", nullable = false)
    private LocalTime startHour;
    
    @Column(name = "end_hour", nullable = false)
    private LocalTime endHour;
    
    @Column(name = "available_capacity", nullable = false)
    private BigDecimal availableCapacity;
    
    @Column(name = "reserved_capacity", nullable = false)
    private BigDecimal reservedCapacity;
    
    @Column(name = "operative", nullable = false)
    private boolean operative;
    
    @ManyToOne
    @JoinColumn(name = "pyme_fk", referencedColumnName = "id", nullable = false)
    private Pyme pyme;
    
}
