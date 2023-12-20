package zl.apirest.backend.service;

import java.util.List;
import java.util.Optional;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zl.apirest.backend.exception.BackendException;
import zl.apirest.backend.json.LoginRequest;
import zl.apirest.backend.json.LoginResponse;
import zl.apirest.backend.json.PymeEditProfileRequest;
import zl.apirest.backend.json.PymeEditProfileResponse;
import zl.apirest.backend.json.RequestHistoryRequest;
import zl.apirest.backend.json.RequestHistoryResponse;
import zl.apirest.backend.json.ResetPasswordRequest;
import zl.apirest.backend.json.ResetPasswordResponse;
import zl.apirest.backend.json.ScheduleRequest;
import zl.apirest.backend.json.ScheduleResponse;
import zl.apirest.backend.model.Commune;
import zl.apirest.backend.model.Pyme;
import zl.apirest.backend.model.PymeAddress;
import zl.apirest.backend.model.RecyclingRequest;
import zl.apirest.backend.model.RequestHistory;
import zl.apirest.backend.model.Schedule;
import zl.apirest.backend.repository.CommuneRepository;
import zl.apirest.backend.repository.PymeRepository;
import zl.apirest.backend.repository.RecyclingRequestRepository;
import zl.apirest.backend.repository.RequestHistoryRepository;
import zl.apirest.backend.repository.ScheduleRepository;

@Service
public class PymeService {

    @Autowired
    private transient PymeRepository pymeRepository;
    @Autowired
    private transient ScheduleRepository scheduleRepository;
    @Autowired
    private transient CommuneRepository communeRepository;
    @Autowired
    private transient RequestHistoryRepository requestHistoryRepository;
    @Autowired
    private transient RecyclingRequestRepository recyclingRequestRepository;

    // obtener listado de pymes registradas
    public List<Pyme> getPymesInfo() {
        return pymeRepository.findAll();
    }

    // obtener datos de la pyme
    public Pyme pymeProfile(String email) {
        Pyme pyme = pymeRepository.findByEmail(email);

        if (pyme != null) {
            return pyme;
        }
        return null;
    }

    // editar perfil
    public PymeEditProfileResponse pymeEditProfile(PymeEditProfileRequest request) {
        PymeEditProfileResponse response = new PymeEditProfileResponse();

        try {
            Pyme pymeEdit = pymeRepository.findByEmail(request.getEmail());

            Optional<Commune> commune = communeRepository.findById(request.getCommuneId());
            if (!commune.isPresent()) {
                throw new BackendException("Comuna no encontrada: " + request.getCommuneId());
            }

            if (pymeEdit != null) {

                pymeEdit.setName(request.getName());
                pymeEdit.setPhone(request.getPhone());

                PymeAddress pymeAddress = pymeEdit.getPymeAddress();

                if (pymeAddress != null) {
                    pymeAddress.setAdditional(request.getAddress());
                    pymeAddress.setCommune(commune.get());
                }

                Pyme saved = pymeRepository.save(pymeEdit);

                if (saved != null && saved.getId() != null) {
                    response.setOk(true);
                    response.setMessage("Perfil actualizado");
                } else {
                    response.setOk(false);
                    response.setMessage("Ocurrio un error al actualizar el perfil");
                }
            }
        } catch (BackendException be) {
            response.setOk(false);
            response.setMessage("Error: " + be.getMessage());
        } catch (Exception e) {
            response.setOk(false);
            response.setMessage("Ocurrio un error al actualizar: " + e.getMessage());
        }

        return response;
    }

    // obtener horarios
    public Schedule getScheduleInfo(Long id) {
        Schedule schedule = scheduleRepository.findAllById(id);

        if (id != null) {
            return schedule;
        }
        return null;
    }

    // iniciar sesion
    public LoginResponse signIn(LoginRequest request) {
        LoginResponse response = new LoginResponse();

        Pyme pyme = pymeRepository.findByEmail(request.getEmail());
        String hashedPassword = DigestUtils.sha256Hex(request.getPassword());

        if (pyme != null) {

            if (pyme.getPassword().equals(hashedPassword)) {

                response.setOk(true);
                response.setMessage("Login satisfactorio");

                return response;
            }
        } else {
            response.setOk(false);
            response.setMessage("No se pudo iniciar sesión");
        }
        return response;
    }

    // recuperar contraseña
    public ResetPasswordResponse recoverPassword(ResetPasswordRequest request) {
        ResetPasswordResponse response = new ResetPasswordResponse();

        // buscar pyme por correo y dni
        Pyme pymeEmail = pymeRepository.findByEmail(request.getEmail());
        Pyme pymeDni = pymeRepository.findByDni(request.getDni());

        // verificar si la pyme existe
        if (pymeEmail != null && pymeDni != null) {
            String password = request.getPassword();
            String repeatPassword = request.getRepeatPassword();

            // verificar si las contraseñas no estan vacias y son iguales
            if (!password.isEmpty() && !repeatPassword.isEmpty() && password.equals(repeatPassword)) {

                // Hash de la contraseña
                String hashedPassword = DigestUtils.sha256Hex(password);

                // Actualizar la contraseña en el objeto User
                pymeDni.setPassword(hashedPassword);

                // Guardar la pyme actualizado en la base de datos
                Pyme saved = pymeRepository.save(pymeDni);

                if (saved != null) {
                    response.setOk(true);
                    response.setMessage("Contraseña actualizada");
                } else {
                    response.setOk(false);
                    response.setMessage("Ocurrió un error al actualizar la contraseña");
                }
            } else {
                response.setOk(false);
                response.setMessage("Las contraseñas no son válidas");
            }
        } else {
            response.setOk(false);
            response.setMessage("Usuario no encontrado");
        }

        return response;
    }

    // Registrar horario
    public ScheduleResponse registerSchedule(ScheduleRequest request) {

        ScheduleResponse response = new ScheduleResponse();

        try {
            Optional<Pyme> pyme = pymeRepository.findById(request.getPymeId());
            if (!pyme.isPresent()) {
                throw new BackendException("Pyme no encontrada: " + request.getPymeId());
            }

            Schedule scheduleToRegister = new Schedule();

            scheduleToRegister.setDate(request.getDate());
            scheduleToRegister.setStartHour(request.getStartHour());
            scheduleToRegister.setEndHour(request.getEndHour());
            scheduleToRegister.setAvailableCapacity(request.getAvailableCapacity());
            scheduleToRegister.setReservedCapacity(request.getReservedCapacity());
            scheduleToRegister.setOperative(request.isOperative());
            scheduleToRegister.setPyme(pyme.get());

            Schedule saved = scheduleRepository.save(scheduleToRegister);

            if (saved != null && saved.getId() != null) {
                response.setOk(true);
                response.setMessage("Horario registrado");
            } else {
                response.setOk(false);
                response.setMessage("Ocurrio un error al registrar el horario");
            }
        } catch (BackendException be) {
            response.setOk(false);
            response.setMessage("Error: " + be.getMessage());
        } catch (Exception e) {
            response.setOk(false);
            response.setMessage("Ocurrio un error al registrar: " + e.getMessage());
        }
        return response;
    }

    // historico de solicitudes
    public RequestHistoryResponse requestUpdate(RequestHistoryRequest request) {
        RequestHistoryResponse response = new RequestHistoryResponse();

        try {
            Optional<RecyclingRequest> optionalRecyclingRequest = recyclingRequestRepository.findById(request.getRecyclingRequestId());
            if (optionalRecyclingRequest.isEmpty()) {
                throw new BackendException("Usuario no encontrado: " + request.getRecyclingRequestId());
            }

            RecyclingRequest recyclingRequest = optionalRecyclingRequest.get();

            // Actualizar el estado de la solicitud
            recyclingRequest.setState(request.getNewState());

            // Crear un historial de solicitud
            RequestHistory requestHistory = new RequestHistory();

            requestHistory.setDescription(request.getDescription());
            requestHistory.setOrigin(request.getOrigin());
            requestHistory.setPicture(request.getPicture());

            // Guardar la solicitud de reciclaje actualizada
            RecyclingRequest updatedRecyclingRequest = recyclingRequestRepository.save(recyclingRequest);

            // Guardar el historial de solicitud
            requestHistory.setRecyclingRequest(updatedRecyclingRequest);
            RequestHistory savedRequestHistory = requestHistoryRepository.save(requestHistory);

            if (savedRequestHistory != null && savedRequestHistory.getId() != null) {
                response.setOk(true);
                response.setMessage("Solicitud de reciclaje actualizada exitosamente");
            } else {
                response.setOk(false);
                response.setMessage("Ocurrió un error al guardar el historial de la solicitud");
            }

        } catch (BackendException be) {
            response.setOk(false);
            response.setMessage("Error: " + be.getMessage());
        } catch (Exception e) {
            response.setOk(false);
            response.setMessage("Ocurrio un error al registrar: " + e.getMessage());
        }

        return response;
    }

    // Obtener historico de solicitudes
    public List<RequestHistory> getRequestHistory() {
        return requestHistoryRepository.findAll();
    }

}
