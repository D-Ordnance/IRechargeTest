import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_assessment/core/error/failure.dart';
import 'package:mobile_assessment/core/usecase/usecase.dart';

import '../entity/employee_entity.dart';
import '../repository/employee_repository.dart';

class FetchEmployees implements UseCase<EmployeeEntity, NoParams> {
  late EmployeeRepository repo;
  FetchEmployees(this.repo);
  @override
  Future<Either<Failure, EmployeeEntity>> call(NoParams params) async {
    return await repo.getEmployee();
  }
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
