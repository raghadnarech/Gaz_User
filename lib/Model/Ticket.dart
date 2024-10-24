class Ticket {
  int? id;
  int? senderId;
  int? receiverId;
  String? text;
  String? image;
  String? createdAt;
  String? updatedAt;

  Ticket(
      {this.id,
      this.senderId,
      this.receiverId,
      this.text,
      this.image,
      this.createdAt,
      this.updatedAt});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    text = json['text'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
