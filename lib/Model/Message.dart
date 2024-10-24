class Message {
  int? id;
  int? senderId;
  int? receiverId;
  int? ticketId;
  String? text;
  String? image;
  bool? sender;
  String? createdAt;
  String? updatedAt;

  Message(
      {this.id,
      this.senderId,
      this.receiverId,
      this.ticketId,
      this.text,
      this.image,
      this.sender,
      this.createdAt,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    ticketId = json['ticket_id'];
    text = json['text'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
