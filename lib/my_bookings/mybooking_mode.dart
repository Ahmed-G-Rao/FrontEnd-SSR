class MyBookingModel {
  List<Data>? data;

  MyBookingModel({this.data});

  MyBookingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? orderId;
  int? userId;
  int? tableId;
  String? orderDetails;
  int? amount;
  String? orderedAt;
  String? status;

  Data(
      {this.orderId,
      this.userId,
      this.tableId,
      this.orderDetails,
      this.amount,
      this.orderedAt,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    tableId = json['table_id'];
    orderDetails = json['order_details'];
    amount = json['amount'];
    orderedAt = json['ordered_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['table_id'] = this.tableId;
    data['order_details'] = this.orderDetails;
    data['amount'] = this.amount;
    data['ordered_at'] = this.orderedAt;
    data['status'] = this.status;
    return data;
  }
}
