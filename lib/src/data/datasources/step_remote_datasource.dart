abstract class StepRemoteDataSource {
  Future<void> saveDailySteps(int steps);
  Future<int?> loadRanking();
}
