import 'package:equatable/equatable.dart';
import 'package:mobile_assessment/feature/employee/data/model/employee_data.dart';

class EmployeeEntity extends Equatable {
  final String msg;
  final List<EmployeeData> employees;

  const EmployeeEntity({required this.msg, required this.employees});

  @override
  List<Object?> get props => [msg, employees];
}
