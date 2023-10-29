class LoginResponse {
  final bool success;
  final String token;
  final String msg;

  LoginResponse({required this.success, required this.token, required this.msg});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      token: json['token'],
      msg: json['msg'],
    );
  }
}