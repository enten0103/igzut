import 'dart:convert';

import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseRepo {
  final String _selectCourseKey = "course_key";
  update(List<Course> courseList) async {
    final prefs = await SharedPreferences.getInstance();
    final strs = courseList.map((e) => e.toJsonStr());
    prefs.setStringList(_selectCourseKey, strs.toList());
  }

  Future<List<Course>> getAllSelectCourse() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList(_selectCourseKey);
    if (data == null) return [];
    Iterable<Map<String, dynamic>> map = data.map((e) => json.decode(e));
    return map.map(Course.fromJson).toList();
  }
}
