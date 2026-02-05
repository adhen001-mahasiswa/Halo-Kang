class OrderFirestoreModel {
  final String id;
  final String userId;
  final String mitraId;
  final String mitraName;
  final String expertise;
  final int price;
  final String date;
  final String time;
  final String status;

  OrderFirestoreModel({
    required this.id,
    required this.userId,
    required this.mitraId,
    required this.mitraName,
    required this.expertise,
    required this.price,
    required this.date,
    required this.time,
    required this.status,
  });

  factory OrderFirestoreModel.fromMap(
    String id,
    Map<String, dynamic> m,
  ) {
    return OrderFirestoreModel(
      id: id,
      userId: m['userId'],
      mitraId: m['mitraId'],
      mitraName: m['mitraName'],
      expertise: m['expertise'],
      price: m['price'],
      date: m['date'],
      time: m['time'],
      status: m['status'],
    );
  }
}
