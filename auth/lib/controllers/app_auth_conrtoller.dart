import 'package:auth/controllers/app_user_controller.dart';
import 'package:conduit_core/conduit_core.dart';

import '../models/response_model.dart';

class AppAuthController extends ResourceController {
  final ManagedContext managedContext;
  AppAuthController(this.managedContext);

  @Operation.post()
  Future<Response> signIn(@Bind.body() User user) async {
    if (user.username == null || user.password == null) {
      return Response.badRequest(
          body:
              ApiResponseModel(message: "Поля username password обязательеы!"));
    }

    final User fechedUser = User();
    // Connect to database
    // Find User
    // Check password
    // Fetch user
    return Response.ok(ApiResponseModel(data: {
      "id": fechedUser.id,
      "refreshToken": fechedUser.refreshToken,
      "accessToken": fechedUser.accessToken,
    }, message: "Успешная авторизация")
        .toJson());
  }

  @Operation.put()
  Future<Response> signUp(@Bind.body() User user) async {
    if (user.username == null || user.password == null || user.email == null) {
      return Response.badRequest(
          body:
              ApiResponseModel(message: "Поля username password email обязательеы!"));
    }

    final User fechedUser = User();
    // Connect to DB
    // Create User
    // Fetch user
    return Response.ok(ApiResponseModel(data: {
      "id": fechedUser.id,
      "refreshToken": fechedUser.refreshToken,
      "accessToken": fechedUser.accessToken,
    }, message: "Успешная регистрация")
        .toJson());
  }

  @Operation.post('refresh')
  Future<Response> refreshToken(@Bind.path('refresh') String refreshToken) async {

     final User fechedUser = User();

    // Connect to DB
    // Find user by token
    // Check Token
    // Fetch user
   return Response.ok(ApiResponseModel(data: {
      "id": fechedUser.id,
      "refreshToken": fechedUser.refreshToken,
      "accessToken": fechedUser.accessToken,
    }, message: "Успешная обновление токенов")
        .toJson());
  }
}
