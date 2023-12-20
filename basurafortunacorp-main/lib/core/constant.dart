// consumir servicios rest
String emailForApi = '';

//--- base url
String baseUrl = 'http://localhost:9999/api/v1';

//--- location-controller
String regionUrl = '$baseUrl/locations/regions'; // * GET
String provinceUrl = '$baseUrl/locations/provinces'; // * GET
String communeUrl = '$baseUrl/locations/communes'; // * GET

//--- loign-controller
String pymeSiginUrl = '$baseUrl/signin/pyme/login'; // ! POST

//--- pyme-controller
String pymeRegistrationUrl = '$baseUrl/pyme/registration'; // ! POST
String pymeRecoverPasswordUrl = '$baseUrl/pyme/recover/password'; // ! POST
String pymeInfoUrl = '$baseUrl/pyme/pymes/info'; // * GET
String pymeRequestHistoryUrl = '$baseUrl/pyme/request/history'; // * GET
String pymeProfileUrl = '$baseUrl/pyme/pyme/profile'; // * GET
String editProfileUrl = '$baseUrl/pyme/pyme/edit/profile'; // ! POST

String  recyclingRequestHistoryUrl = '$baseUrl/users/recycling/request/all'; // * GET