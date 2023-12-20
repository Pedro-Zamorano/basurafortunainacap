package zl.apirest.backend.service;

import java.util.Optional;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zl.apirest.backend.enums.MaterialType;
import zl.apirest.backend.exception.BackendException;
import zl.apirest.backend.json.PymeRegistrationRequest;
import zl.apirest.backend.json.PymeRegistrationResponse;
import zl.apirest.backend.model.Commune;
import zl.apirest.backend.model.Pyme;
import zl.apirest.backend.model.PymeAddress;
import zl.apirest.backend.model.RecyclingType;
import zl.apirest.backend.repository.CommuneRepository;
import zl.apirest.backend.repository.PymeAddressRepository;
import zl.apirest.backend.repository.PymeRepository;
import zl.apirest.backend.repository.RecyclingTypeRepository;

@Service
public class PymeRegistrationService {

    @Autowired
    private transient PymeRepository pymeRepository;
    @Autowired
    private transient CommuneRepository communeRepository;
    @Autowired
    private transient PymeAddressRepository pymeAddressRepository;
    @Autowired
    private transient RecyclingTypeRepository recyclingTypeRepository;

    public PymeRegistrationResponse registerPyme(PymeRegistrationRequest request) {

        PymeRegistrationResponse response = new PymeRegistrationResponse();

        try {
            Pyme pyme = pymeRepository.findByEmail(request.getEmail());
            if (pyme != null) {
                throw new BackendException("Email ya registrado");
            }

            Pyme pymeDni = pymeRepository.findByDni(request.getDni());
            if (pymeDni != null) {
                throw new BackendException("Rut ya registrado");
            }

            Optional<Commune> commune = communeRepository.findById(request.getCommuneId());
            if (!commune.isPresent()) {
                throw new BackendException("Comuna no encontrada: " + request.getCommuneId());
            }

            String hashedPassword = DigestUtils.sha256Hex(request.getPassword());

            Pyme pymeToRegister = new Pyme();
            pymeToRegister.setName(request.getName());
            pymeToRegister.setDni(request.getDni());
            pymeToRegister.setPhone(request.getPhone());
            pymeToRegister.setPassword(hashedPassword);
            pymeToRegister.setEmail(request.getEmail());

            // Registrando la direccion
            PymeAddress pymeAddress = new PymeAddress();
            pymeAddress.setAdditional(request.getAddress());
            pymeAddress.setCommune(commune.get());

            PymeAddress savedPymeAddress = pymeAddressRepository.save(pymeAddress);
            pymeToRegister.setPymeAddress(savedPymeAddress);

            // Convertir el int recibido a MaterialType enum
            MaterialType materialType = MaterialType.values()[request.getTypeRecycling()];

            // Registrando el tipo de reciclaje
            RecyclingType recyclingType = new RecyclingType();
            recyclingType.setActive(request.isStatus());
            recyclingType.setTypeRecycling(materialType);

            RecyclingType savedRecyclingType = recyclingTypeRepository.save(recyclingType);
            pymeToRegister.setRecyclingType(savedRecyclingType);

            Pyme saved = pymeRepository.save(pymeToRegister);

            if (saved != null && saved.getId() != null) {
                response.setOk(true);
                response.setMessage("Pyme registrada");
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
