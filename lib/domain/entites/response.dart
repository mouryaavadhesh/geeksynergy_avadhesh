class Response {
  final String message;
  final bool status;

  const Response({
    required this.message,
    required this.status,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }
}
