import 'dart:io';
import 'package:auth/utils/app_contant.dart';
import 'package:conduit_core/conduit_core.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import '../models/app_user_model.dart';

abstract class AppUtils {
  const AppUtils._();
  static int getIdFromToken(String token) {
    try {
      //  final key = Platform.environment["SECRET_KEY"];
      final jwtClaim = verifyJwtHS256Signature(token, AppConst.secretKey);

      return int.parse(jwtClaim["id"].toString());
    } catch (e) {
      rethrow;
    }
  }

  static int getIdFromHeader(String header) {
    try {
      final token = AuthorizationBearerParser().parse(header);
      return getIdFromToken(token ?? "");
    } catch (e) {
      rethrow;
    }
  }
}
