import 'package:flutter/material.dart';
import 'package:mobile_assessment/feature/employee/presentation/widgets/regualar_text.dart';
import 'package:mobile_assessment/feature/employee/presentation/widgets/semi_bold_text.dart';

class EmployeeItem extends StatelessWidget {
  final String avatar;
  final int id;
  final String name;
  final String lastMessage;
  final String lastTimeStamp;
  final bool lastItem;
  final void Function(BuildContext context, String avatar, int id) onTap;
  const EmployeeItem(
      {super.key,
      required this.id,
      required this.avatar,
      required this.name,
      required this.lastMessage,
      required this.lastTimeStamp,
      required this.lastItem,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context, avatar, id),
      child: Column(
        children: [
          Row(
            children: [
              Image(
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
                image: AssetImage(avatar),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SemiBoldText(
                      title: name,
                      fontSize: 16,
                    ),
                    RegularText(title: lastMessage)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RegularText(title: lastTimeStamp),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: lastItem ? 0 : 16,
          ),
        ],
      ),
    );
  }
}
