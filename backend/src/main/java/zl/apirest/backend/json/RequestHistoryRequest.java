package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import zl.apirest.backend.enums.RequestState;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RequestHistoryRequest extends BaseJson {

    // Buscamos por el ID los datos de recycling_request
    @JsonProperty("recycling_request_id")
    private Long idRecyclingRequest;
    
    @JsonProperty("description")
    private String description;
    @JsonProperty("origin")
    private String origin;
    @JsonProperty("attach_picture")
    private String picture;
    
    @JsonProperty("state")
    private RequestState newState;
    
    @JsonProperty("recycling_request_fk")
    private Long recyclingRequestId;

}
