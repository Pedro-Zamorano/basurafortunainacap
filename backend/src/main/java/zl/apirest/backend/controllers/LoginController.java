package zl.apirest.backend.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import zl.apirest.backend.json.LoginRequest;
import zl.apirest.backend.json.LoginResponse;
import zl.apirest.backend.service.PymeService;
import zl.apirest.backend.service.UserService;

@RestController
@CrossOrigin
@RequestMapping("api/v1/signin")
public class LoginController {

    @Autowired
    private transient UserService userService;
    @Autowired
    private transient PymeService pymeService;

    @PostMapping("/user/login")
    public LoginResponse login(@RequestBody LoginRequest request) {
        return userService.signIn(request);
    }

    @PostMapping("/pyme/login")
    public LoginResponse pymeLogin(@RequestBody LoginRequest request) {
        return pymeService.signIn(request);
    }

}
