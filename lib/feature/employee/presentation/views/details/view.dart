import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assessment/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:mobile_assessment/feature/employee/presentation/widgets/bold_text.dart';

import '../../../../../core/helpers/api/data.dart';
import '../../../../../injection_container.dart';
import '../../widgets/regualar_text.dart';
import '../../widgets/semi_bold_text.dart';

class DetailsView extends StatelessWidget {
  final int id;
  final String avatar;
  const DetailsView({super.key, required this.avatar, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SemiBoldText(fontSize: 16, title: "Employee Detail"),
              ],
            )
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: BlocProvider(
        create: (context) =>
            getIt<EmployeeBloc>()..add(FetchEmployeeDetailByIdEvent(id)),
        child:
            BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
          if (state is Loading) {
            return Container();
          } else if (state is IdFetchSuccessful) {
            return Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const Image(
                        image: AssetImage("lib/images/chat_profile.png")),
                    const SizedBox(
                      height: 12,
                    ),
                    BoldText(
                        fontSize: 16,
                        title:
                            "${state.response.firstName} ${state.response.lastName}"),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RegularText(title: "designation:"),
                        SemiBoldText(title: state.response.designation)
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RegularText(title: "level:"),
                        SemiBoldText(title: state.response.level.toString())
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RegularText(title: "Productivity Score:"),
                        SemiBoldText(
                            title: state.response.productivityScore.toString())
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RegularText(title: "Current Salary:"),
                        SemiBoldText(
                            title:
                                "₦${state.response.currentSalary.toString()}")
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        const RegularText(
                          title: "Remark:",
                          color: Colors.red,
                        ),
                        SemiBoldText(
                          title: _constructRemark(
                              state.response.level, state.response.newLevel),
                          color: Colors.red,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ]),
            );
          } else {
            return Container();
          }
        }),
      )),
    );
  }

  String _constructRemark(int currentLevel, int newLevel) {
    if (newLevel == -1) {
      return "Your contract has been terminated";
    }
    if (newLevel > currentLevel) {
      return "You did well. You have been promoted and will earn ${Api.levelSalaryMap[newLevel]}";
    } else if (currentLevel == newLevel) {
      return "You did well. Keep it up";
    } else if (newLevel < currentLevel) {
      return "You will now earn ${Api.levelSalaryMap[newLevel]}";
    } else {
      return "Your contract has been terminated";
    }
  }
}
