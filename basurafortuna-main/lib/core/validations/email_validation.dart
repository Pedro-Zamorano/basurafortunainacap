bool esFormatoEmailValido(String email) {
  String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}
