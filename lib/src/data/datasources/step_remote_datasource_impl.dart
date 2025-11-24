import 'package:app/src/data/datasources/step_remote_datasource.dart';

class StepRemoteDataSourceImpl implements StepRemoteDataSource {
  @override
  Future<void> saveDailySteps(int steps) async {}

  @override
  Future<int?> loadRanking() async {
    return null;
  }
}
