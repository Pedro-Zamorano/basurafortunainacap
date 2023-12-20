package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PymeEditProfileRequest extends BaseJson {

    // no editable
//    @JsonProperty("name")
//    private String name;
//    @JsonProperty("dni")
//    private int dni;

    @JsonProperty("email")
    private String email;
    
    // editable
    @JsonProperty("name")
    private String name;
    @JsonProperty("phone")
    private int phone;
    @JsonProperty("address")
    private String address;
    @JsonProperty("commune_id")
    private Long communeId;

}
