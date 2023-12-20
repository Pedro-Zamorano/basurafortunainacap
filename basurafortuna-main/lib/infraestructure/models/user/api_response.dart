class ApiResponse {
  final String message;
  final bool ok;

  ApiResponse({
    required this.message,
    required this.ok,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'] ?? '',
      ok: json['ok'] ?? false,
    );
  }
}
