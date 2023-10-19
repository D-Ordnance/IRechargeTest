class EmployeeData {
  final int id, employmentStatus;
  final String firstName, lastName, level, designation, currentSalary;
  final double employeeScore;

  const EmployeeData(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.level,
      required this.designation,
      required this.employeeScore,
      required this.currentSalary,
      required this.employmentStatus});

  factory EmployeeData.fromRemoteJson(Map json) {
    return EmployeeData(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        designation: json['designation'],
        level: json['level'],
        employeeScore: json['employee_score'],
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
      "employeeScore": employeeScore,
      "currentSalary": currentSalary,
      "employmentStatus": employmentStatus,
    };
  }
}
