import 'dart:convert';

import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExamRepo {
  final String _selectCourseKey = "exam_key";
  update(List<Exam> examList) async {
    final prefs = await SharedPreferences.getInstance();
    final strs = examList.map((e) => e.toJsonStr());
    prefs.setStringList(_selectCourseKey, strs.toList());
  }

  Future<List<Exam>> getAllExams() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList(_selectCourseKey);
    if (data == null) return [];
    Iterable<Map<String, dynamic>> map = data.map((e) => json.decode(e));
    return map.map(Exam.fromJson).toList();
  }
}
