// Mocks generated by Mockito 5.4.2 from annotations
// in flap_app/test/data/source/network/spoonacular_api_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flap_app/domain/repository/flavor/flavor_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [FlavorRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlavorRepository extends _i1.Mock implements _i2.FlavorRepository {
  MockFlavorRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String getAppTitle() => (super.noSuchMethod(
        Invocation.method(
          #getAppTitle,
          [],
        ),
        returnValue: '',
      ) as String);

  @override
  String getFlavorName() => (super.noSuchMethod(
        Invocation.method(
          #getFlavorName,
          [],
        ),
        returnValue: '',
      ) as String);

  @override
  String getBaseUrlHost() => (super.noSuchMethod(
        Invocation.method(
          #getBaseUrlHost,
          [],
        ),
        returnValue: '',
      ) as String);

  @override
  bool shouldMockEndpoints() => (super.noSuchMethod(
        Invocation.method(
          #shouldMockEndpoints,
          [],
        ),
        returnValue: false,
      ) as bool);
}
