import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igzut/pages/schedule/controller.dart';

class TermSelector extends StatelessWidget {
  const TermSelector({super.key, required this.terms});

  final List<String> terms;

  @override
  Widget build(BuildContext context) {
    final scheduleController = Get.find<ScheduleController>();
    if (terms.isEmpty) {
      return Container();
    }
    return Obx(() {
      var selectTerm = scheduleController.selectTerm;
      return PopupMenuButton<int>(
        icon: Row(
          children: [
            Text(
              ScheduleController.extraTermString(terms[selectTerm.value]),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
        onSelected: (int index) {
          selectTerm.value = index;
        },
        itemBuilder: (BuildContext context) {
          return terms.map<PopupMenuEntry<int>>((String value) {
            return PopupMenuItem<int>(
              value: terms.indexOf(value),
              child: Text(ScheduleController.extraTermString(value)),
            );
          }).toList();
        },
      );
    });
  }
}
