import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/exam_repo.dart';

class ExamService {
  final _examRepo = ExamRepo();
  Future<List<Exam>> getAllExams() {
    return _examRepo.getAllExams();
  }

  Future<List<Exam>> updateExamList() async {
    var impl = Get.find<ZfImpl>();
    var examList = await impl.queryExams();
    _examRepo.update(examList);
    return examList;
  }
}
