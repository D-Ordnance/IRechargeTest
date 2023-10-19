import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/employee_data.dart';
import '../repository/employee_repository.dart';

class FetchEmployeeDetails implements UseCase<EmployeeData, int> {
  late EmployeeRepository repo;
  FetchEmployeeDetails(this.repo);
  @override
  Future<Either<Failure, EmployeeData>> call(int id) async {
    return await repo.getEmployeeDetails(id);
  }
}
