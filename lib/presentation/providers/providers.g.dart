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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
