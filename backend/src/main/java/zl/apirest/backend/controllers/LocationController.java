package zl.apirest.backend.controllers;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import zl.apirest.backend.json.LocationsResponse;
import zl.apirest.backend.model.Commune;
import zl.apirest.backend.model.Province;
import zl.apirest.backend.model.Region;
import zl.apirest.backend.service.LocationService;

@RestController
@CrossOrigin
@RequestMapping("api/v1/locations")
public class LocationController {

    @Autowired
    private transient LocationService locationService;

    @GetMapping("/location")
    public LocationsResponse getLocations() {
        return locationService.getLocations();
    }

    @GetMapping("/regions")
    public List<Region> getRegions() {
        return locationService.getRegions();
    }

    @GetMapping("/provinces")
    public List<Province> getProvinces() {
        return locationService.getProvinces();
    }

    @GetMapping("/communes")
    public List<Commune> getCommunes() {
        return locationService.getCommunes();
    }

}
