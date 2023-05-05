import 'dart:io';

import 'package:auth/models/app_user_model.dart';
import 'package:auth/utils/app_contant.dart';
import 'package:auth/utils/app_response.dart';
import 'package:auth/utils/app_utils.dart';
import 'package:conduit_core/conduit_core.dart';

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
  Future<Response> updateProfile(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.body() User user,
  ) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final fUser = await managedContext.fetchObjectWithID<User>(id);
      final qUpdateUser = Query<User>(managedContext)
        ..where((x) => x.id).equalTo(id)
        ..values.username = user.username ?? fUser?.username
        ..values.email = user.email ?? fUser?.email;
      await qUpdateUser.updateOne();
      final uUser = await managedContext.fetchObjectWithID<User>(id);
      uUser?.removePropertiesFromBackingMap([
        AppConst.accessToken,
        AppConst.refreshToken,
      ]);

      if (user.username != null && user.username != fUser?.username) {
        // Имя было изменено
        return AppResponse.ok(
            message:
                "Имя успешно изменено с '${fUser?.username ?? ''}' на '${user.username}'",
            body: uUser?.backing.contents);
      } else if (user.email != null && user.email != fUser?.email) {
        // Email был изменен
        return AppResponse.ok(
            message:
                "Email успешно изменен с '${fUser?.email ?? ''}' на '${user.email}'",
            body: uUser?.backing.contents);
      } else {
        // Ни имя, ни email не были изменены
        return AppResponse.ok(
            message: "Данные успешно обновлены", body: uUser?.backing.contents);
      }
    } catch (error) {
      return AppResponse.serverError(error,
          message: "Ошибка обновления данных");
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
