package zl.apirest.backend.service;

import java.util.List;
import java.util.Optional;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zl.apirest.backend.enums.MaterialType;
import zl.apirest.backend.enums.RequestState;
import zl.apirest.backend.exception.BackendException;
import zl.apirest.backend.json.LoginRequest;
import zl.apirest.backend.json.LoginResponse;
import zl.apirest.backend.json.ResetPasswordRequest;
import zl.apirest.backend.json.ResetPasswordResponse;
import zl.apirest.backend.json.UserEditProfileRequest;
import zl.apirest.backend.json.UserEditProfileResponse;
import zl.apirest.backend.json.UserRecyclingRequest;
import zl.apirest.backend.json.UserRecyclingResponse;
import zl.apirest.backend.model.Commune;
import zl.apirest.backend.model.RecyclingRequest;
import zl.apirest.backend.model.Schedule;
import zl.apirest.backend.model.User;
import zl.apirest.backend.model.UserAddress;
import zl.apirest.backend.repository.CommuneRepository;
import zl.apirest.backend.repository.RecyclingRequestRepository;
import zl.apirest.backend.repository.ScheduleRepository;
import zl.apirest.backend.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private transient UserRepository userRepository;
    @Autowired
    private transient CommuneRepository communeRepository;
    @Autowired
    private transient RecyclingRequestRepository recyclingRequestRepository;
    @Autowired
    private transient ScheduleRepository scheduleRepository;

    // obtener datos de perfil
    public User userProfile(String email) {
        User user = userRepository.findByEmail(email);

        if (user != null) {
            return user;
        }
        return null;
    }

    // obtener historial de solicitudes 
    public List<RecyclingRequest> recyclingHistory(String email) {
        List<RecyclingRequest> recyclingFound = recyclingRequestRepository.findByUserEmail(email);

        if (recyclingFound.isEmpty()) {
            return null;
        }

        return recyclingFound;
    }
    
    // obtener todo el historial registrado
    public List<RecyclingRequest> allRecyclingHistory() {
        return recyclingRequestRepository.findAll();
    }

    // iniciar sesion
    public LoginResponse signIn(LoginRequest request) {
        LoginResponse response = new LoginResponse();

        User user = userRepository.findByEmail(request.getEmail());
        String hashedPassword = DigestUtils.sha256Hex(request.getPassword());

        if (user != null) {

            if (user.getPassword().equals(hashedPassword)) {

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

        // Buscar al usuario por correo y DNI
        User userEmail = userRepository.findByEmail(request.getEmail());
        User userDni = userRepository.findByDni(request.getDni());

        // Verificar si el usuario existe
        if (userEmail != null && userDni != null) {
            String password = request.getPassword();
            String repeatPassword = request.getRepeatPassword();

            // Verificar si las contraseñas no están vacías y son iguales
            if (!password.isEmpty() && !repeatPassword.isEmpty() && password.equals(repeatPassword)) {

                // Hash de la contraseña
                String hashedPassword = DigestUtils.sha256Hex(password);

                // Actualizar la contraseña en el objeto User
                userDni.setPassword(hashedPassword);

                // Guardar el usuario actualizado en la base de datos
                User saved = userRepository.save(userDni);

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

    // editar perfil
    public UserEditProfileResponse editProfile(UserEditProfileRequest request) {
        UserEditProfileResponse response = new UserEditProfileResponse();

        try {
            User userEdit = userRepository.findByEmail(request.getEmail());

            Optional<Commune> commune = communeRepository.findById(request.getCommuneId());
            if (!commune.isPresent()) {
                throw new BackendException("Comuna no encontrada: " + request.getCommuneId());
            }

            if (userEdit != null) {

                userEdit.setUsername(request.getUsername());
                userEdit.setName(request.getName());
                userEdit.setLastname(request.getLastname());
                userEdit.setPhone(request.getPhone());

                UserAddress userAddress = userEdit.getUserAddress();

                if (userAddress != null) {
                    userAddress.setAdditional(request.getAddress());
                    userAddress.setCommune(commune.get());
                }

                // guardar datos actualizados
                User saved = userRepository.save(userEdit);

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

    // Solicitud de retiro
    public UserRecyclingResponse requestRecycling(UserRecyclingRequest request) {
        UserRecyclingResponse response = new UserRecyclingResponse();

        try {

            Optional<User> user = userRepository.findById(request.getUserId());
            if (!user.isPresent()) {
                throw new BackendException("Usuario no encontrado: " + request.getUserId());
            }
            Optional<Schedule> schedule = scheduleRepository.findById(request.getScheduleId());

            if (!schedule.isPresent()) {
                throw new BackendException("Horario no encontrado: " + request.getScheduleId());
            }

            RecyclingRequest recyclingToRequest = new RecyclingRequest();

            recyclingToRequest.setEstimatedWeight(request.getEstimatedWeight());
            recyclingToRequest.setDescription(request.getDescription());

            // RequestState (emun)
            RequestState requestState = RequestState.values()[request.getState()];
            recyclingToRequest.setState(requestState);

            // type (enum)
            MaterialType materialType = MaterialType.values()[request.getType()];
            recyclingToRequest.setType(materialType);

            // Schedule
            recyclingToRequest.setSchedule(schedule.get());

            // User
            recyclingToRequest.setUser(user.get());

            RecyclingRequest saved = recyclingRequestRepository.save(recyclingToRequest);

            if (saved != null && saved.getId() != null) {
                response.setOk(true);
                response.setMessage("Solicitud de retiro creada");
            } else {
                response.setOk(false);
                response.setMessage("Ocurrio un error al realizar la solicitud");
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

}
