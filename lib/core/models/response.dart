class StatusResponse {
  final String message;
  final List<Map<String, dynamic>> data;

  StatusResponse({this.message = '', this.data = const [{}]});

  factory StatusResponse.fromJson(Map json) {
    return StatusResponse(message: json['message'], data: json['data']);
  }

  Map<String, dynamic> toJson(StatusResponse response) {
    return {"message": response.message, "data": response.data};
  }
}
