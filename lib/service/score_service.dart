import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/score_repo.dart';

class ScoreService {
  final ScoreRepo _scoreRepo = ScoreRepo();
  Future<List<Score>> getScoreList() async {
    return await _scoreRepo.getAllScores();
  }
}
