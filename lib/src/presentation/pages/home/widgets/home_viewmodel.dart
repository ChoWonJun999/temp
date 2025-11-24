import 'package:app/src/data/repositories/pedometer_repository.dart';

class HomeViewModel {
  final PedometerRepository pedometerRepository;

  HomeViewModel({required this.pedometerRepository});

  Future<int> loadSteps() async {
    return pedometerRepository.getTodaySteps();
  }
}
