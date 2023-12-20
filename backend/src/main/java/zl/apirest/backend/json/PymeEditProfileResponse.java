package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PymeEditProfileResponse extends BaseJson {

    @JsonProperty("ok")
    private boolean ok;
    @JsonProperty("message")
    private String message;

}
