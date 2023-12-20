package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleRequest extends BaseJson {

    @JsonProperty("date")
    private LocalDate date;
    @JsonProperty("start_hour")
    private LocalTime startHour;
    @JsonProperty("end_hour")
    private LocalTime endHour;
    @JsonProperty("available_capacity")
    private BigDecimal availableCapacity;
    @JsonProperty("reserved_capacity")
    private BigDecimal reservedCapacity;
    @JsonProperty("operative")
    private boolean operative;
    @JsonProperty("pyme_fk")
    private Long pymeId;

}
