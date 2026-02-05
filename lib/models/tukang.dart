class Tukang {
  final String uid; // 🔥 SATU-SATUNYA ID
  final String name;
  final String expertise;
  final double rating;
  final int reviews;
  final double priceFrom;
  final double distanceKm;
  final String avatarUrl;
  final String bio;

  Tukang({
    required this.uid,
    required this.name,
    required this.expertise,
    required this.rating,
    required this.reviews,
    required this.priceFrom,
    required this.distanceKm,
    required this.avatarUrl,
    required this.bio,
  });

  factory Tukang.fromMap(String uid, Map<String, dynamic> m) {
    return Tukang(
      uid: uid,
      name: m['name'] ?? '',
      expertise: m['expertise'] ?? '',
      rating: (m['rating'] ?? 0).toDouble(),
      reviews: (m['reviews'] ?? 0),
      priceFrom: (m['price'] ?? m['priceFrom'] ?? 0).toDouble(),
      distanceKm: (m['distanceKm'] ?? 0).toDouble(),
      avatarUrl: m['avatarUrl'] ?? '',
      bio: m['description'] ?? m['bio'] ?? '',
    );
  }
}
