package zl.apirest.backend.vo;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import zl.apirest.backend.json.BaseJson;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProvinceVO extends BaseJson{

    @JsonProperty("id")
    private Long id;
    @JsonProperty("name")
    private String provinceName;
}
