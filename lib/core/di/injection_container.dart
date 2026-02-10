import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:ghost_counter/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ghost_counter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ghost_counter/features/auth/domain/repositories/auth_repository.dart';
import 'package:ghost_counter/features/auth/domain/usecases/auth_state_change_use_case.dart';
import 'package:ghost_counter/features/auth/domain/usecases/google_sign_in_use_case.dart';
import 'package:ghost_counter/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:ghost_counter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;

//init
Future<void> init() async {
  await initExternalService();
  initAuthFeature();
}

// external service
Future<void> initExternalService() async {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);
}

// auth feature
void initAuthFeature() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), googleSignIn: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => AuthStateChangeUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GoogleSignInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(authRepository: sl()));

  sl.registerFactory(
    () => AuthBloc(
      authStateChangeUseCase: sl(),
      googleSignInUseCase: sl(),
      signOutUseCase: sl(),
    ),
  );
}
