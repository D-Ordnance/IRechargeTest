import 'package:dartz/dartz.dart';
import 'package:mobile_assessment/feature/employee/data/model/employee_data.dart';
import 'package:mobile_assessment/feature/employee/domain/entity/employee_entity.dart';

import '../../../../core/error/failure.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, EmployeeEntity>> getEmployee();
  Future<Either<Failure, EmployeeData>> getEmployeeDetails(int id);
  Future<Either<Failure, EmployeeEntity>> getFilteredEmployees(
      Map<String, String> keys);
}
