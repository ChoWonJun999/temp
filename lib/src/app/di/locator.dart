import 'package:app/src/data/datasources/step_local_datasource.dart';
import 'package:app/src/data/datasources/step_local_datasource_impl.dart';
import 'package:app/src/data/datasources/step_remote_datasource.dart';
import 'package:app/src/data/datasources/step_remote_datasource_impl.dart';
import 'package:app/src/data/repositories/pedometer_repository.dart';
import 'package:app/src/data/repositories/pedometer_repository_impl.dart';
import 'package:app/src/presentation/pages/walking_activity/widgets/home_viewmodel.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<StepLocalDataSource>(
    () => StepLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<StepRemoteDataSource>(
    () => StepRemoteDataSourceImpl(),
  );

  locator.registerLazySingleton<PedometerRepository>(
    () => PedometerRepositoryImpl(
      local: locator<StepLocalDataSource>(),
      remote: locator<StepRemoteDataSource>(),
    ),
  );

  locator.registerFactory<HomeViewModel>(
    () => HomeViewModel(pedometerRepository: locator<PedometerRepository>()),
  );
}
