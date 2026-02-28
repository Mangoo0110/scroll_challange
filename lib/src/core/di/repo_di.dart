import 'package:get_it/get_it.dart';
import 'package:app_pigeon/app_pigeon.dart';
import 'package:scroll_challenge/src/modules/category/repo/category_repo_impl.dart';
import 'package:scroll_challenge/src/modules/category/repo/mock_category_repo.dart';
import 'package:scroll_challenge/src/modules/product/repo/fakestore_product_repo.dart';

import '../constants/api_endpoints.dart';
import '../../modules/cart/controller/cart_store.dart';
import '../../modules/cart/repo/cart_repo.dart';
import '../../modules/cart/repo/cart_repo_impl.dart';
import '../../modules/cart/service/local_cart_service.dart';
import '../../modules/cart/service/remote_cart_service.dart';
import '../../modules/category/repo/category_repo.dart';
import '../../modules/product/repo/mock_product_repo.dart';
import '../../modules/product/repo/product_repo.dart';

final serviceLocator = GetIt.instance;

void repoDi() async {
  
  serviceLocator.registerLazySingleton<AppPigeon>(
    () => GhostPigeon(baseUrl: ApiEndpoints.baseUrl),
  );

  serviceLocator.registerLazySingleton<ProductRepo>(
    () => 
    //MockProductRepo()
    FakeStoreProductRepo(fallbackRepo: MockProductRepo(), appPigeon: serviceLocator<AppPigeon>()),
  );

  serviceLocator.registerLazySingleton<CategoryRepo>(
    () => 
    CategoryRepoImpl(appPigeon: serviceLocator<AppPigeon>()),
    //MockCategoryRepo(),
  );

  serviceLocator.registerLazySingleton<CartRepo>(
    () => CartRepoImpl(
      localService: LocalCartService(),
      remoteService: RemoteCartService(),
    ),
  );
  
  serviceLocator.registerLazySingleton<CartStore>(
    () => CartStore(repo: serviceLocator<CartRepo>()),
  );

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
