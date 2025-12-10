import 'package:get/get.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/controllers/common_controller.dart';
import 'package:igzut/service/exam_service.dart';

class ExamDataController extends CommonController {
  final RxList<Exam> examList = <Exam>[].obs;

  @override
  void onInit() async {
    super.onInit();
    var examService = ExamService();
    final exams = await examService.getAllExams();
    examList.addAll(exams);
  }

  @override
  void onLogin() async {
    var examService = ExamService();
    final exams = await examService.updateExamList();
    examList.clear();
    examList.addAll(exams);
  }
}
