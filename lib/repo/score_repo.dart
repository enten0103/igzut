import 'dart:convert';

import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreRepo {
  final String _scoreListKey = "score_list";

  update(List<Score> scoreList) async {
    final prefs = await SharedPreferences.getInstance();
    final strs = scoreList.map((e) => e.toJsonStr());
    prefs.setStringList(_scoreListKey, strs.toList());
  }

  Future<List<Score>> getAllScores() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList(_scoreListKey);
    if (data == null) return [];
    Iterable<Map<String, dynamic>> map = data.map((e) => json.decode(e));
    return map.map(Score.fromMap).toList();
  }
}
