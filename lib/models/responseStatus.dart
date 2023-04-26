import 'dart:convert';

ResponseStatus ResponseStatusFromJson(String str) =>
    ResponseStatus.fromJson(json.decode(str));

String ResponseStatusToJson(ResponseStatus data) => json.encode(data.toJson());

class ResponseStatus {
  ResponseStatus({
    required this.status,
    required this.message,
  });

  int status;
  String message;

  factory ResponseStatus.fromJson(Map<String, dynamic> json) {
    return ResponseStatus(
      status: json["data"] == null || json["data"] == ""
          ? 404
          : json["status"], //handle multiple error code
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
