package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResetPasswordRequest extends BaseJson {

    @JsonProperty("email")
    private String email;
    @JsonProperty("dni")
    private int dni;
    @JsonProperty("password")
    private String password;
    @JsonProperty("repeat_password")
    private String repeatPassword;

}
