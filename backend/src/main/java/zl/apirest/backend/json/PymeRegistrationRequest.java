package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PymeRegistrationRequest extends BaseJson {

    @JsonProperty("name")
    private String name;
    @JsonProperty("dni")
    private int dni;
    @JsonProperty("phone")
    private int phone;
    @JsonProperty("password")
    private String password;
    @JsonProperty("email")
    private String email;
    
    // pymes_addresses
    @JsonProperty("address")
    private String address;
    @JsonProperty("commune_id")
    private Long communeId;
    
    // recycling_types
    @JsonProperty("status")
    private boolean status;
    @JsonProperty("type_recycling")
    private int typeRecycling;
}
