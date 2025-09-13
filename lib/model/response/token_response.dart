class TokenResponse {
  final String uid;
  final String refreshToken;
  final String idToken;

  TokenResponse({required this.uid, required this.refreshToken, required this.idToken});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      uid: json['uid'] as String,
      refreshToken: json['refresh_token'] as String,
      idToken: json['id_token'] as String,
    );
  }
}
