import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igzut/controllers/course_data_controller.dart';
import 'package:igzut/controllers/user_info_controller.dart';
import 'package:igzut/pages/home/componets/courses_info_card.dart';
import 'package:igzut/pages/home/componets/credit_earn_card.dart';
import 'package:igzut/pages/home/componets/grade_points_card.dart';
import 'package:igzut/pages/home/componets/net_icon.dart';
import 'package:igzut/pages/home/componets/other_action_card.dart';
import 'package:igzut/pages/home/componets/user_icon.dart';
import 'package:igzut/pages/home/controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var courseDataController = Get.find<CourseDataController>();
    var userInfoController = Get.find<UserInfoController>();
    var homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text("主页"),
        actions: [
          Obx(() {
            return Row(
              children: [
                UserIcon(loginState: homeController.loginState.value),
                NetIcon(netState: homeController.netState.value)
              ],
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(() => Column(
              children: [
                const SizedBox(height: 10),
                GradePointsCard(
                    gradePoint: courseDataController.gradePoint.value,
                    administrativeClass:
                        userInfoController.administrativeClass.value,
                    college: userInfoController.college.value),
                const SizedBox(height: 10),
                CreditEarnCard(
                    weightedAverageScore:
                        courseDataController.weightedAverageScore.value,
                    name: userInfoController.name.value,
                    studentNumber: userInfoController.studentNumber.value),
                const SizedBox(height: 10),
                CoursesInfoCard(
                    all: courseDataController.courseCount.all,
                    pass: courseDataController.courseCount.pass,
                    failed: courseDataController.courseCount.failed,
                    score: courseDataController.credit.value),
                const SizedBox(height: 10),
                OtherActionCard(),
                const SizedBox(height: 20), // 底部留白
              ],
            )),
      ),
    );
  }
}
