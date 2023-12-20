// consumir servicios rest
String emailForApi = '';

//--- base url
String baseUrl = 'http://localhost:9999/api/v1';

//--- location-controller
String regionUrl = '$baseUrl/locations/regions';
String provinceUrl = '$baseUrl/locations/provinces';
String communeUrl = '$baseUrl/locations/communes';

//--- loign-controller
String userSiginUrl = '$baseUrl/signin/user/login'; // ! POST

//--- pyme-controller
String pymeInfoUrl = '$baseUrl/pyme/pymes/info'; // ? GET
String pymeSchedules = '$baseUrl/pyme/schedules'; // ? GET

//--- user-controller
String editProfileUrl = '$baseUrl/users/edit/profile'; // ! POST
String profileUrl = '$baseUrl/users/profile'; // ? GET
String recoverPasswordUrl = '$baseUrl/users/recover/password'; // ! POST
String recyclingRequestUrl = '$baseUrl/users/recycling/request'; // ! POST
String recyclingRequestHistoryUrl = '$baseUrl/users/recycling/request/history'; // ? GET
String userRegistrationUrl = '$baseUrl/users/registration'; // ! POST