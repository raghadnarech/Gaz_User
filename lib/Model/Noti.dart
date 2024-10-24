class Noti {
  int? id;
  int? orderId;
  int? invoiceId;
  int? userId;
  String? text;
  String? createdAt;
  String? updatedAt;

  Noti(
      {this.id,
      this.orderId,
      this.invoiceId,
      this.userId,
      this.text,
      this.createdAt,
      this.updatedAt});

  Noti.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    invoiceId = json['invoice_id'];
    userId = json['user_id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
