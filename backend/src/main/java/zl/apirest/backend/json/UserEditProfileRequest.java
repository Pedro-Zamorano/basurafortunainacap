package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserEditProfileRequest extends BaseJson {

    // editable
    @JsonProperty("username")
    private String username;
    @JsonProperty("name")
    private String name;
    @JsonProperty("lastname")
    private String lastname;
    @JsonProperty("phone")
    private int phone;
    @JsonProperty("address")
    private String address;
    @JsonProperty("commune_id")
    private Long communeId;

    @JsonProperty("email")
    private String email;

}
