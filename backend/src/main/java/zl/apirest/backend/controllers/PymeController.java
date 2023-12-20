package zl.apirest.backend.controllers;

import java.util.List;
import java.util.Optional;
import org.hibernate.annotations.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import zl.apirest.backend.json.PymeEditProfileRequest;
import zl.apirest.backend.json.PymeEditProfileResponse;
import zl.apirest.backend.json.PymeRegistrationRequest;
import zl.apirest.backend.json.PymeRegistrationResponse;
import zl.apirest.backend.json.RequestHistoryRequest;
import zl.apirest.backend.json.RequestHistoryResponse;
import zl.apirest.backend.json.ResetPasswordRequest;
import zl.apirest.backend.json.ResetPasswordResponse;
import zl.apirest.backend.json.ScheduleRequest;
import zl.apirest.backend.json.ScheduleResponse;
import zl.apirest.backend.model.Pyme;
import zl.apirest.backend.model.RequestHistory;
import zl.apirest.backend.model.Schedule;
import zl.apirest.backend.service.PymeRegistrationService;
import zl.apirest.backend.service.PymeService;

@RestController
@CrossOrigin
@RequestMapping("api/v1/pyme")
public class PymeController {

    @Autowired
    private transient PymeRegistrationService pymeRegistrationService;
    @Autowired
    private transient PymeService pymeService;
    
    // obtener todas las pymes
    @GetMapping("/pymes/info")
    public List<Pyme> getAllPymes() {
        return pymeService.getPymesInfo();
    }

    // obtener datos de perfil
    @GetMapping("/pyme/profile")
    public Pyme getPymeProfile(String email) {
        return pymeService.pymeProfile(email);
    }
    
    // editar perfil
    @PostMapping("/pyme/edit/profile")
    public PymeEditProfileResponse editPymeProfile(@RequestBody PymeEditProfileRequest request) {
        return pymeService.pymeEditProfile(request);
    }

    // registrar nueva pyme
    @PostMapping("/registration")
    public PymeRegistrationResponse registration(@RequestBody PymeRegistrationRequest request) {
        return pymeRegistrationService.registerPyme(request);
    }

    // recuperar contraseña
    @PostMapping("/recover/password")
    public ResetPasswordResponse recoverPassword(@RequestBody ResetPasswordRequest request) {
        return pymeService.recoverPassword(request);
    }
    
    // horarios
    @GetMapping("/schedules")
    public Schedule schedulesInfo(Long id) {
        return pymeService.getScheduleInfo(id);
    }

    // registrar horario
    @PostMapping("/register/schedule")
    public ScheduleResponse registerSchedule(@RequestBody ScheduleRequest request) {
        return pymeService.registerSchedule(request);
    }
    
    // historico de solicitudes
    @PostMapping("/update/request/history")
    public RequestHistoryResponse updateActualRequest(@RequestBody RequestHistoryRequest request) {
        return pymeService.requestUpdate(request);
    }
    
    // obtener todo el historico de solicitudes
    @GetMapping("/request/history")
    public List<RequestHistory> getAllRequestHistory() {
        return pymeService.getRequestHistory();
    }
}
