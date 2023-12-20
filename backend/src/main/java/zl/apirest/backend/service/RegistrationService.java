package zl.apirest.backend.service;

import java.util.Optional;
import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zl.apirest.backend.exception.BackendException;
import zl.apirest.backend.json.UserRegistrationRequest;
import zl.apirest.backend.json.UserRegistrationResponse;
import zl.apirest.backend.model.Commune;
import zl.apirest.backend.model.User;
import zl.apirest.backend.model.UserAddress;
import zl.apirest.backend.repository.CommuneRepository;
import zl.apirest.backend.repository.UserAddressRepository;
import zl.apirest.backend.repository.UserRepository;

@Service
public class RegistrationService {

    Logger LOGGER = LoggerFactory.getLogger(RegistrationService.class);

    @Autowired
    private transient UserRepository userRepository;

    @Autowired
    private transient CommuneRepository communeRepository;

    @Autowired
    private transient UserAddressRepository userAddressRepository;

    public UserRegistrationResponse registerUser(UserRegistrationRequest request) {

        UserRegistrationResponse response = new UserRegistrationResponse();

        try {
            User user = userRepository.findByEmail(request.getEmail());
            if (user != null) {
                throw new BackendException("Email ya registrado");
            }

            User userDni = userRepository.findByDni(request.getDni());
            if (userDni != null) {
                throw new BackendException("Rut ya registrado");
            }

            Optional<Commune> commune = communeRepository.findById(request.getCommuneId());
            if (!commune.isPresent()) {
                throw new BackendException("Comuna no encontrada: " + request.getCommuneId());
            }

            String hashedPassword = DigestUtils.sha256Hex(request.getPassword());

            User userToRegister = new User();
            userToRegister.setUsername(request.getUsername());
            userToRegister.setName(request.getName());
            userToRegister.setLastname(request.getLastname());
            userToRegister.setPhone(request.getPhone());
            userToRegister.setPassword(hashedPassword);
            userToRegister.setDni(request.getDni());
            userToRegister.setEmail(request.getEmail());

            UserAddress userAddress = new UserAddress();
            userAddress.setAdditional(request.getAddress());
            userAddress.setCommune(commune.get());

            UserAddress savedUserAddress = userAddressRepository.save(userAddress);

            userToRegister.setUserAddress(savedUserAddress);

            User saved = userRepository.save(userToRegister);

            if (saved != null && saved.getId() != null) {
                response.setOk(true);
                response.setMessage("Usuario registrado");
            } else {
                response.setOk(false);
                response.setMessage("Ocurrio un error al registrar");
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
