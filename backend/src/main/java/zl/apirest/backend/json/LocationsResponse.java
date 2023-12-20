package zl.apirest.backend.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import zl.apirest.backend.vo.CommuneVO;
import zl.apirest.backend.vo.ProvinceVO;
import zl.apirest.backend.vo.RegionVO;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LocationsResponse extends BaseJson{

    @JsonProperty("regions")
    private List<RegionVO> regions;
    @JsonProperty("provinces")
    private List<ProvinceVO> provinces;
    @JsonProperty("communes")
    private List<CommuneVO> communes;
}
