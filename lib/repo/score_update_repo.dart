import 'package:shared_preferences/shared_preferences.dart';

///存储更新过的成绩的code
class ScoreUpdateRepo {
  final String _scoreUpdatekey = "score_update_key";
  Future add(List<String> scoreUpdated) async {
    final prefs = await SharedPreferences.getInstance();
    var current = prefs.getStringList(_scoreUpdatekey) ?? [];
    current.addAll(scoreUpdated);
    await prefs.setStringList(_scoreUpdatekey, current);
  }

  Future update(List<String> scoreUpdated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_scoreUpdatekey, scoreUpdated);
  }
}
