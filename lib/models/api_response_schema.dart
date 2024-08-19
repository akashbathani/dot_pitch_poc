class ResponseSchema {
  final bool status;
  final String message;
  final List<Item> list;

  ResponseSchema({
    required this.status,
    required this.message,
    required this.list,
  });

  factory ResponseSchema.fromJson(Map<String, dynamic> json) {
    return ResponseSchema(
      status: json['status'],
      message: json['message'],
      list: List<Item>.from(json['list'].map((item) => Item.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'list': list.map((item) => item.toJson()).toList(),
    };
  }
}

class Item {
  final int id;
  final String link;
  final String name;
  final bool isFree;
  final double? amount;

  Item({
    required this.id,
    required this.link,
    required this.name,
    required this.isFree,
    this.amount,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      link: json['link'],
      name: json['name'],
      isFree: json['isFree'],
      amount: json['amount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'link': link,
      'name': name,
      'isFree': isFree,
      'amount': amount,
    };
  }
}
