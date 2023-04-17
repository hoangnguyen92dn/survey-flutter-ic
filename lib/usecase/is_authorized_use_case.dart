import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/persistence/auth_persistence.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

@Injectable()
class IsAuthorizedUseCase extends NoParamsUseCase<bool> {
  final AuthPersistence _persistence;

  const IsAuthorizedUseCase(this._persistence);

  @override
  Future<Result<bool>> call() async {
    final isAuthorized = await _persistence.accessToken != null;

    return Success(isAuthorized);
  }
}
