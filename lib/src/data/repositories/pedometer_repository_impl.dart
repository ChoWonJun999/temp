import 'package:app/src/data/datasources/step_local_datasource.dart';
import 'package:app/src/data/datasources/step_remote_datasource.dart';
import 'package:app/src/data/repositories/pedometer_repository.dart';

class PedometerRepositoryImpl implements PedometerRepository {
  final StepLocalDataSource local;
  final StepRemoteDataSource remote;

  PedometerRepositoryImpl({
    required this.local,
    required this.remote,
  });

  @override
  Future<int> getTodaySteps() async {
    final steps = await local.getTodaySteps();
    await remote.saveDailySteps(steps);
    return steps;
  }
}
