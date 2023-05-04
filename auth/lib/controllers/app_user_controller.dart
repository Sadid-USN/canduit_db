import 'dart:io';

import 'package:auth/models/app_user_model.dart';
import 'package:auth/utils/app_contant.dart';
import 'package:auth/utils/app_response.dart';
import 'package:auth/utils/app_utils.dart';
import 'package:conduit_core/conduit_core.dart';

//! следуйщий Урок 1.14
class AppUserController extends ResourceController {
  final ManagedContext managedContext;
  AppUserController(this.managedContext);

  @Operation.get()
  Future<Response> getProfile(
      @Bind.header(HttpHeaders.authorizationHeader) String header) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final user = await managedContext.fetchObjectWithID<User>(id);
      user?.removePropertiesFromBackingMap([
        AppConst.accessToken,
        AppConst.refreshToken,
      ]);
      return AppResponse.ok(
        message: "Профиль успешно получен!",
        body: user?.backing.contents,
      );
    } catch (error) {
      return AppResponse.serverError(
        error,
        message: "Ошибка получение профиля",
      );
    }
  }

  @Operation.post()
  Future<Response> updateProfile() async {
    try {
      return AppResponse.ok(message: "Profile updated");
    } catch (error) {
      return AppResponse.serverError(error);
    }
  }

  @Operation.put()
  Future<Response> updatePassword() async {
    try {
      return AppResponse.ok(message: "Password updated");
    } catch (error) {
      return AppResponse.serverError(error);
    }
  }
}
