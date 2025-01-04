import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/score_repo.dart';
import 'package:igzut/service/index.dart';
import 'package:igzut/tools/event_bus.dart';

class ScoreService {
  static String _stamp = "";
  final EventBus _eventBus = EventBus();
  final ScoreRepo _scoreRepo = ScoreRepo();
  Future<List<ScoreRow>> getScoreList(String stamp) async {
    var scores = await _scoreRepo.getAllScores();
    if (stamp != _stamp) {
      _stamp = stamp;
      Service.zfImpl.queryScore().then((result) async {
        await _scoreRepo.update(result['scoreRows'] as List<ScoreRow>);
        _eventBus.emit("scoreUpdate");
      });
    }
    return scores;
  }
}
