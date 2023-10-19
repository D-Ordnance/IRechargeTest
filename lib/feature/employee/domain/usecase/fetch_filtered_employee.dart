import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/employee_entity.dart';
import '../repository/employee_repository.dart';

class FetchFilteredEmployee
    implements UseCase<EmployeeEntity, Map<String, String>> {
  late EmployeeRepository repo;
  FetchFilteredEmployee(this.repo);
  @override
  Future<Either<Failure, EmployeeEntity>> call(Map<String, String> keys) async {
    return await repo.getFilteredEmployees(keys);
  }
}
