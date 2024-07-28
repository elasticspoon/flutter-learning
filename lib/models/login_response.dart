import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'session_state')
  String sessionState;
  String? scope;
  @JsonKey(name: 'not-before-policy')
  int notBeforePolicy;
  @JsonKey(name: 'expires_in')
  int expiresIn;
  @JsonKey(name: 'refresh_expires_in')
  int refreshExpiresIn;
  @JsonKey(name: 'token_type')
  String tokenType;
  @JsonKey(name: 'id_token')
  String idToken;

  LoginResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.refreshToken,
    required this.tokenType,
    required this.idToken,
    required this.sessionState,
    required this.notBeforePolicy,
    required this.scope,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
