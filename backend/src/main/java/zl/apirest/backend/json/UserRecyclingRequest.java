package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.math.BigDecimal;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserRecyclingRequest extends BaseJson {
    
    @JsonProperty("estimated_weight")
    private BigDecimal estimatedWeight; 
    
    @JsonProperty("state")
    private int state;
    
    @JsonProperty("schedule_fk")
    private Long scheduleId;
    
    @JsonProperty("user_fk")
    private Long userId;
    
    @JsonProperty("description")
    private String description;
    
    @JsonProperty("type")
    private int type;

}
