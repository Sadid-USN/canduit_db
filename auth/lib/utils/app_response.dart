import 'package:auth/models/response_model.dart';
import 'package:conduit_core/conduit_core.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class AppResponse extends Response {
  AppResponse.serverError(dynamic error, {String? message})
      : super.serverError(
          body: _getApiResponseModel(error, message),
        );

  static ApiResponseModel _getApiResponseModel(dynamic error, String? message) {
    if (error is QueryException) {
      return ApiResponseModel(
          error: error.toString(), message: message ?? error.message);
    }
    if (error is JwtException) {
      return ApiResponseModel(
          error: error.toString(), message: message ?? error.message);
    }
    if (error is AuthorizationParserException) {
      return ApiResponseModel(
          error: error.toString(), message: message ?? error.toString());
    }

    return ApiResponseModel(
        error: error.toString(), message: message ?? "Неизвестная ошибка!");
  }

  AppResponse.ok({dynamic body, String? message})
      : super.ok(ApiResponseModel(
          data: body,
          message: message,
        ));
  AppResponse.badRequest({dynamic body, String? message})
      : super.badRequest(
            body: ApiResponseModel(
          data: body,
          message: message,
        ));
}
