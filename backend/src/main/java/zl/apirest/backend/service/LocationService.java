package zl.apirest.backend.service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zl.apirest.backend.json.LocationsResponse;
import zl.apirest.backend.model.Commune;
import zl.apirest.backend.model.Province;
import zl.apirest.backend.model.Region;
import zl.apirest.backend.repository.CommuneRepository;
import zl.apirest.backend.repository.ProvinceRepository;
import zl.apirest.backend.repository.RegionRepository;
import zl.apirest.backend.vo.CommuneVO;
import zl.apirest.backend.vo.ProvinceVO;
import zl.apirest.backend.vo.RegionVO;

@Service
public class LocationService {

    @Autowired
    private transient RegionRepository regionRepository;

    @Autowired
    private transient ProvinceRepository provinceRepository;

    @Autowired
    private transient CommuneRepository communeRepository;

    public LocationsResponse getLocations() {
        LocationsResponse locations = new LocationsResponse();

        List<Region> regions = regionRepository.findAll();
        List<Province> provinces = provinceRepository.findAll();
        List<Commune> communes = communeRepository.findAll();

        List<RegionVO> regionsVO = new ArrayList<>();
        List<ProvinceVO> provincesVO = new ArrayList<>();
        List<CommuneVO> communesVO = new ArrayList<>();

        for (Region r : regions) {
            RegionVO rvo = new RegionVO();
            rvo.setId(r.getId());
            rvo.setRegionName(r.getRegionName());

            regionsVO.add(rvo);
        }

        for (Province p : provinces) {
            ProvinceVO pvo = new ProvinceVO();
            pvo.setId(p.getId());
            pvo.setProvinceName(p.getName());

            provincesVO.add(pvo);
        }

        for (Commune c : communes) {
            CommuneVO cvo = new CommuneVO();
            cvo.setId(c.getId());
            cvo.setCommuneName(c.getName());

            communesVO.add(cvo);
        }

        locations.setRegions(regionsVO);
        locations.setProvinces(provincesVO);
        locations.setCommunes(communesVO);

        return locations;
    }

    public List<Region> getRegions() {
        return regionRepository.findAll();
    }

    public List<Province> getProvinces() {
        return provinceRepository.findAll();
    }

    public List<Commune> getCommunes() {
        return communeRepository.findAll();
    }

}
