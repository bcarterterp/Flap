// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'1c8be288571ca06fe4e803d16111ae2afb53e010';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$logInUseCaseHash() => r'26d1c9c43ad84bf04a8c5c6fbe111e13bd1c8445';

/// See also [logInUseCase].
@ProviderFor(logInUseCase)
final logInUseCaseProvider = AutoDisposeProvider<LogInUseCase>.internal(
  logInUseCase,
  name: r'logInUseCaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logInUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogInUseCaseRef = AutoDisposeProviderRef<LogInUseCase>;
<<<<<<< HEAD
String _$sharedPreferencesHash() => r'7cd30c9640ca952d1bcf1772c709fc45dc47c8b3';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeFutureProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef = AutoDisposeFutureProviderRef<SharedPreferences>;
||||||| e65703d
=======
String _$secureStorageHash() => r'6dba70129dbb0dcdeb377aac78279a52351d50e8';

/// See also [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider = AutoDisposeProvider<StorageService>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SecureStorageRef = AutoDisposeProviderRef<StorageService>;
>>>>>>> app_flavor_no_package
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
