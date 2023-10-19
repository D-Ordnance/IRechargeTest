import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_assessment/feature/employee/data/model/employee_data.dart';
import 'package:mobile_assessment/feature/employee/domain/usecase/fetch_employee.dart';

import '../../domain/entity/employee_entity.dart';
import '../../domain/usecase/fetch_employee_detail.dart';
import '../../domain/usecase/fetch_filtered_employee.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final FetchEmployees fetchEmployees;
  final FetchFilteredEmployee fetchFilteredEmployee;
  final FetchEmployeeDetails fetchEmployeeDetails;
  EmployeeBloc(this.fetchEmployees, this.fetchEmployeeDetails,
      this.fetchFilteredEmployee)
      : super(EmployeeInitial()) {
    on<EmployeeEvent>((event, emit) async {
      if (event is FetchEmployeesEvent) {
        emit(Loading());
        final failureOrSuccess = await fetchEmployees(const NoParams());
        emit(failureOrSuccess.fold(
            (l) => Error(message: l.msg), (r) => Success(response: r)));
      } else if (event is FetchEmployeesByKeysEvent) {
        emit(Loading());
        final failureOrSuccess = await fetchFilteredEmployee(event.keys);
        emit(failureOrSuccess.fold(
            (l) => Error(message: l.msg), (r) => Success(response: r)));
      } else if (event is FetchEmployeeDetailByIdEvent) {
        emit(Loading());
        final failureOrSuccess = await fetchEmployeeDetails(event.id);
        emit(failureOrSuccess.fold((l) => Error(message: l.msg),
            (r) => IdFetchSuccessful(response: r)));
      }
    });
  }
}
