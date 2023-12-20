package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserRecyclingResponse extends BaseJson {

    @JsonProperty("ok")
    private boolean ok;
    @JsonProperty("message")
    private String message;

}
