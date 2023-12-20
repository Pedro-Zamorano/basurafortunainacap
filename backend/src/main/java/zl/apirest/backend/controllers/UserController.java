package zl.apirest.backend.controllers;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import zl.apirest.backend.json.ResetPasswordRequest;
import zl.apirest.backend.json.ResetPasswordResponse;
import zl.apirest.backend.json.UserEditProfileRequest;
import zl.apirest.backend.json.UserEditProfileResponse;
import zl.apirest.backend.json.UserRecyclingRequest;
import zl.apirest.backend.json.UserRecyclingResponse;
import zl.apirest.backend.json.UserRegistrationRequest;
import zl.apirest.backend.json.UserRegistrationResponse;
import zl.apirest.backend.model.RecyclingRequest;
import zl.apirest.backend.model.User;
import zl.apirest.backend.service.RegistrationService;
import zl.apirest.backend.service.UserService;

@RestController
@CrossOrigin
@RequestMapping("api/v1/users")
public class UserController {

    @Autowired
    private transient RegistrationService registrationService;
    @Autowired
    private transient UserService userService;

    @PostMapping("/registration")
    public UserRegistrationResponse registration(@RequestBody UserRegistrationRequest request) {
        // aqui valido cualquier wea que quiera (formato, null, etc)
        return registrationService.registerUser(request);
    }

    @PostMapping("/edit/profile")
    public UserEditProfileResponse editProfile(@RequestBody UserEditProfileRequest request) {
        return userService.editProfile(request);
    }

    @PostMapping("/recover/password")
    public ResetPasswordResponse recoverPassword(@RequestBody ResetPasswordRequest request) {
        return userService.recoverPassword(request);
    }

    @GetMapping("/profile")
    public User getProfile(@RequestParam String email) {
        return userService.userProfile(email);
    }

    @PostMapping("/recycling/request")
    public UserRecyclingResponse recyclingRequest(@RequestBody UserRecyclingRequest request) {
        return userService.requestRecycling(request);
    }

    @GetMapping("/recycling/request/history")
    public List<RecyclingRequest> getRecyclingRequest(@RequestParam("email") String email) {
        return userService.recyclingHistory(email);
    }
    
    @GetMapping("/recycling/request/all")
    public List<RecyclingRequest> getAllRecyclingRequest() {
        return userService.allRecyclingHistory();
    }

}
