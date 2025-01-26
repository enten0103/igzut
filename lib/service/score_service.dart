import 'package:get/instance_manager.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/score_repo.dart';

class ScoreService {
  final ScoreRepo _scoreRepo = ScoreRepo();
  Future<List<Score>> getScoreList() async {
    return await _scoreRepo.getAllScores();
  }

  Future<List<Score>> updateScoreList() async {
    var impl = Get.find<ZfImpl>();
    var scoreList = await impl.queryScores();
    _scoreRepo.update(scoreList);
    return scoreList;
  }
}
