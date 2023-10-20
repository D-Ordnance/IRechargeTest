import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assessment/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:mobile_assessment/feature/employee/presentation/widgets/app_yextfield.dart';
import 'package:mobile_assessment/feature/employee/presentation/widgets/semi_bold_text.dart';
import 'package:mobile_assessment/injection_container.dart';

import '../../widgets/bold_text.dart';
import '../../widgets/employee_item.dart';
import '../../widgets/no_background_button.dart';
import '../../widgets/regualar_text.dart';
import '../details/view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          headerSection(context),
          const SizedBox(
            height: 16,
          ),
          BlocProvider(
            create: (context) =>
                getIt<EmployeeBloc>()..add(FetchEmployeesEvent()),
            child: BlocBuilder<EmployeeBloc, EmployeeState>(
                builder: (context, state) {
              if (state is Loading) {
                return Container();
              } else if (state is Error) {
                _showErrorDialog(context, msg: state.message);
                return Container();
              } else if (state is Success) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.response.employees.length,
                    itemBuilder: (context, index) => EmployeeItem(
                        id: state.response.employees[index].id,
                        avatar: "lib/images/chat_avatar_one.png",
                        name:
                            "${state.response.employees[index].firstName} ${state.response.employees[index].lastName}",
                        lastMessage:
                            state.response.employees[index].designation,
                        lastTimeStamp:
                            state.response.employees[index].currentSalary,
                        lastItem: state.response.employees.length - 1 == index,
                        onTap: _navigateToDetailPage));
              } else {
                return Container();
              }
            }),
          )
        ],
      ),
    ));
  }

  Widget headerSection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            const Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText(
                    title: "Hello Admin",
                    fontSize: 16,
                  ),
                  RegularText(
                    title: "Check Eployees Productivity",
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const CustomTextField(
                                      hintText: "Enter Name",
                                      labelText: "By Name"),
                                  ElevatedButton(
                                    child: const RegularText(title: 'Filter'),
                                    onPressed: () {
                                      filterEmployee(context, {
                                        "firstName": "Ben",
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                            alignment: Alignment.centerRight,
                            image: AssetImage('lib/images/filter.png')),
                        SemiBoldText(
                          title: "FILTER",
                          color: Color(0xFF0E6EBE),
                        ),
                      ],
                    )))
          ],
        ),
      ],
    );
  }

  void filterEmployee(BuildContext context, Map<String, String> key) {
    BlocProvider.of<EmployeeBloc>(context).add(FetchEmployeesByKeysEvent(key));
  }

  Future<void> _showErrorDialog(BuildContext context,
      {String msg = "An Error occured"}) async {
    Future.delayed(Duration.zero, () {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(msg),
                  ],
                ),
              ),
              actions: [
                NoBackGroundButton(
                    onPressed: (context) => Navigator.of(context).pop(),
                    buttonText: "Dismiss")
              ],
            );
          });
    });
  }

  void _navigateToDetailPage(BuildContext context, String avatar, int id) {
    Future.delayed(Duration.zero, () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsView(avatar: avatar, id: id)));
    });
  }
}
