class AuthResponse{
  AuthStatus status;
  String message;

  AuthResponse._({required this.status, required this.message});

  static AuthResponse success(String m){
    return AuthResponse._(status: AuthStatus.success, message: m);
  }

  static AuthResponse fail(String m){
    return AuthResponse._(status: AuthStatus.fail, message: m);
  }

  static AuthResponse weakPass(String m){
    return AuthResponse._(status: AuthStatus.weakPassword, message: m);
  }

  static AuthResponse usedEmail(String m){
    return AuthResponse._(status: AuthStatus.emailAlreadyInUse, message: m);
  }

  static AuthResponse wrong(String m){
    return AuthResponse._(status: AuthStatus.wrongEmailOrPassword, message: m);
  }
}

enum AuthStatus{
  weakPassword,
  emailAlreadyInUse,
  wrongEmailOrPassword,
  success,
  fail
}
