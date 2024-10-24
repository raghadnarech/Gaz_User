class Profile {
  int? id;
  String? userName;
  String? phone;
  String? email;
  String? bankNum;
  String? bankName;
  String? logo;
  String? role;
  int? ordersCount;
  WalletTrans? walletTrans;

  Profile(
      {this.id,
      this.userName,
      this.phone,
      this.email,
      this.bankNum,
      this.bankName,
      this.logo,
      this.role,
      this.ordersCount,
      this.walletTrans});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['data'][0]['id'];
    userName = json['data'][0]['user_name'];
    phone = json['data'][0]['phone'];
    email = json['data'][0]['email'];
    bankNum = json['data'][0]['bank_num'];
    bankName = json['data'][0]['bank_name'];
    logo = json['data'][0]['logo'];
    role = json['data'][0]['role'];
    ordersCount = json['orders_count'];
    walletTrans = json['data'][0]['wallet_trans'] != null
        ? WalletTrans.fromJson(json['data'][0]['wallet_trans'])
        : null;
  }
}

class WalletTrans {
  int? id;
  int? userId;
  // Null? transactionId;
  int? balance;
  String? createdAt;
  String? updatedAt;
  List<Transaction>? transaction;

  WalletTrans(
      {this.id,
      this.userId,
      // this.transactionId,
      this.balance,
      this.createdAt,
      this.updatedAt,
      this.transaction});

  WalletTrans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    // transactionId = json['transaction_id'];
    balance = json['balance'];
    createdAt = json['created_at'];
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      json['transaction'].forEach((v) {
        transaction!.add(Transaction.fromJson(v));
      });
    }
  }
}

class Transaction {
  int? id;
  int? userId;
  String? number;
  int? amount;
  String? status;
  String? createdAt;
  int? walletId;
  String? image;

  Transaction(
      {this.id,
      this.userId,
      this.number,
      this.amount,
      this.status,
      this.createdAt,
      this.walletId,
      this.image});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    number = json['number'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    walletId = json['wallet_id'];
    image = json['image'];
  }
}
