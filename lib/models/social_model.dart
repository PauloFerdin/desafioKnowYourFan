class SocialModel {
  final String twitter;
  final String discord;
  final String twitch;
  final String instagram;

  const SocialModel({
    required this.twitter,
    required this.discord,
    required this.twitch,
    required this.instagram,
  });

  SocialModel copyWith({
    String? twitter,
    String? discord,
    String? twitch,
    String? instagram,
  }) {
    return SocialModel(
      twitter: twitter ?? this.twitter,
      discord: discord ?? this.discord,
      twitch: twitch ?? this.twitch,
      instagram: instagram ?? this.instagram,
    );
  }
}
