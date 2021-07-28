class TokenRequest {
  String secret;
  TokenRequest(this.secret);

  TokenRequest.fromJson(Map<String, dynamic> json) : secret = json['secret'];

  Map<String, dynamic> toJson() => {
        'secret': secret,
      };
}
