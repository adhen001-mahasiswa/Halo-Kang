import 'order_item_model.dart';

class OrderModel {
  final String id;
  final String customerName;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.items,
  });

  double get totalPrice {
    return items.fold(0, (sum, item) => sum + item.total);
  }
}
