import 'package:app/src/data/repositories/pedometer_repository.dart';
import 'package:app/src/domain/entities/step_entity.dart';

class GetTodaySteps {
  final PedometerRepository repository;

  GetTodaySteps(this.repository);

  Future<StepEntity> call() async {
    final steps = await repository.getTodaySteps();
    return StepEntity(steps: steps);
  }
}
