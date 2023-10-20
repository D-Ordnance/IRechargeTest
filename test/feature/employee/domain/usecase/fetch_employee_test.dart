import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/core/error/failure.dart';
import 'package:mobile_assessment/feature/employee/data/model/employee_data.dart';
import 'package:mobile_assessment/feature/employee/domain/entity/employee_entity.dart';
import 'package:mobile_assessment/feature/employee/domain/repository/employee_repository.dart';
import 'package:mobile_assessment/feature/employee/domain/usecase/fetch_employee.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_employee_test.mocks.dart';

@GenerateNiceMocks([MockSpec<EmployeeRepository>()])
void main() {
  late MockEmployeeRepository repo;
  late FetchEmployees usecase;

  setUp(() {
    repo = MockEmployeeRepository();
    usecase = FetchEmployees(repo);
  });

  group('getEmployee', () {
    test('Should return [EmployeeEntity]', () async {
      EmployeeData data = EmployeeData(
          id: 1,
          firstName: "Dolapo",
          lastName: "Olakanmi",
          level: 4,
          newLevel: 0,
          designation: "Mobile Engineer",
          productivityScore: 70,
          currentSalary: "100,000",
          employmentStatus: 1);
      EmployeeEntity employee =
          EmployeeEntity(msg: "Successful", employees: [data]);
      when(usecase(const NoParams())).thenAnswer((_) async => Right(employee));

      final actual = await usecase(const NoParams());

      expect(actual, Right(employee));

      verify(repo.getEmployee());

      verifyNoMoreInteractions(repo);
    });

    test('Should return [Failure]', () async {
      Failure failure =
          const Failure(msg: "The table entry 'salary' does not exist");
      when(usecase(const NoParams())).thenAnswer((_) async => Left(failure));

      final actual = await usecase(const NoParams());

      expect(actual, Left(failure));

      verify(repo.getEmployee());

      verifyNoMoreInteractions(repo);
    });
  });
}
