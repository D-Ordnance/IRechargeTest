import 'package:dartz/dartz.dart';
import 'package:mobile_assessment/core/error/failure.dart';
import 'package:mobile_assessment/feature/employee/data/model/employee_data.dart';
import 'package:mobile_assessment/feature/employee/domain/entity/employee_entity.dart';
import 'package:mobile_assessment/feature/employee/domain/usecase/fetch_employee_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'usecase/fetch_employee_test.mocks.dart';

void main() {
  late MockEmployeeRepository repo;
  late FetchEmployeeDetails usecase;

  setUp(() {
    repo = MockEmployeeRepository();
    usecase = FetchEmployeeDetails(repo);
  });

  group('getEmployee', () {
    test('Should return [EmployeeEntity]', () async {
      EmployeeData data = EmployeeData(
          id: 1,
          firstName: "Dolapo",
          lastName: "Olakanmi",
          level: 4,
          designation: "Mobile Engineer",
          productivityScore: 70,
          currentSalary: "100,000",
          employmentStatus: 1);
      EmployeeEntity employee =
          EmployeeEntity(msg: "Successful", employees: [data]);
      when(usecase(1)).thenAnswer((_) async => Right(data));

      final actual = await usecase(1);

      expect(actual, Right(data));

      verify(repo.getEmployeeDetails(1));

      verifyNoMoreInteractions(repo);
    });

    test('Should return [Failure]', () async {
      Failure failure =
          const Failure(msg: "The table entry 'salary' does not exist");
      when(usecase(1)).thenAnswer((_) async => Left(failure));

      final actual = await usecase(1);

      expect(actual, Left(failure));

      verify(repo.getEmployeeDetails(1));

      verifyNoMoreInteractions(repo);
    });
  });
}
