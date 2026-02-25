


import 'package:get_it/get_it.dart';

import '../../modules/product/repo/mock_product_repo.dart';
import '../../modules/product/repo/product_repo.dart';

final serviceLocator = GetIt.instance;

void repoDi() async{

  serviceLocator.registerLazySingleton<ProductRepo>(() => MockProductRepo());

  
  // serviceLocator.registerFactory<AuthRepo>(
  //     () => AuthRepoImpl());
  // serviceLocator.registerLazySingleton<ClassPhotoRepo>(
  //     () => ClassPhotoRepoImpl(
  //       authRepo: serviceLocator<AuthRepo>(),
  //     )); 
  // serviceLocator.registerLazySingleton<ProfileRepo>(
  //     () => ProfileRepoImpl(),
  // );
  // serviceLocator.registerLazySingleton<OnboardingRepo>(
  //     () => OnboardingRepoImpl(),
  // );
  // serviceLocator.registerSingleton<ImageRepo>(
  //     FirebaseImageRepo(),
  // );
  // serviceLocator.registerLazySingleton(
  //     () => ImageInMemoryCacheService(serviceLocator<ImageRepo>()));
  // arrow360degree@gmail.com
}
