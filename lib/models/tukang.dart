class Tukang {
  final String id;
  final String name;
  final String expertise;
  final double rating;
  final int reviews;
  final double priceFrom;
  final double distanceKm;
  final String avatarUrl;
  final String bio;

  Tukang({
    required this.id,
    required this.name,
    required this.expertise,
    required this.rating,
    required this.reviews,
    required this.priceFrom,
    required this.distanceKm,
    required this.avatarUrl,
    required this.bio,
  });

  factory Tukang.fromMap(Map<String, dynamic> m) {
    return Tukang(
      id: m['id'],
      name: m['name'],
      expertise: m['expertise'],
      rating: (m['rating'] ?? 0).toDouble(),
      reviews: (m['reviews'] ?? 0),
      priceFrom: (m['priceFrom'] ?? 0).toDouble(),
      distanceKm: (m['distanceKm'] ?? 0).toDouble(),
      avatarUrl: m['avatarUrl'] ?? '',
      bio: m['bio'] ?? '',
    );
  }
}
