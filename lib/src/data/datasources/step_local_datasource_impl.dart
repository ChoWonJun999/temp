import 'package:app/src/data/datasources/step_local_datasource.dart';

class StepLocalDataSourceImpl implements StepLocalDataSource {
  @override
  Future<int> getTodaySteps() async {
    return 1200;
  }
}
