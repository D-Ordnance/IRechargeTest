class EmployeeData {
  final int id, level, employmentStatus;
  final String firstName, lastName, designation, currentSalary;
  final double productivityScore;
  late int newLevel;

  EmployeeData(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.level,
      this.newLevel = 0,
      required this.designation,
      required this.productivityScore,
      required this.currentSalary,
      required this.employmentStatus});

  factory EmployeeData.fromRemoteJson(Map json) {
    return EmployeeData(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        designation: json['designation'],
        level: json['level'],
        productivityScore: json['employee_score'],
        currentSalary: json['current_salary'],
        employmentStatus: json['employment_status']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "designation": designation,
      "level": level,
      "productivityScore": productivityScore,
      "currentSalary": currentSalary,
      "employmentStatus": employmentStatus,
    };
  }
}
