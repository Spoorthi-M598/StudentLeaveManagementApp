class LeaveModel {

  final int id;
  final String fromDate;
  final String toDate;
  final String reason;
  final String status;

  LeaveModel({
    required this.id,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.status,
  });

  factory LeaveModel.fromJson(
      Map<String, dynamic> json) {

    return LeaveModel(
      id: json["id"],
      fromDate: json["from_date"],
      toDate: json["to_date"],
      reason: json["reason"],
      status: json["status"],
    );
  }
}