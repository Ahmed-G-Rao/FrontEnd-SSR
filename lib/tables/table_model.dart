class TablesModel {
  List<Data>? data;

  TablesModel({this.data});

  TablesModel.fromJson(Map<String, dynamic> json) {
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
  int? tableId;
  String? tableName;
  int? capacity;
  String? status;
  int? bookedBy;
  Null? bookedAt;

  Data(
      {this.tableId,
      this.tableName,
      this.capacity,
      this.status,
      this.bookedBy,
      this.bookedAt});

  Data.fromJson(Map<String, dynamic> json) {
    tableId = json['table_id'];
    tableName = json['table_name'];
    capacity = json['capacity'];
    status = json['status'];
    bookedBy = json['booked_by'];
    bookedAt = json['booked_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['table_id'] = this.tableId;
    data['table_name'] = this.tableName;
    data['capacity'] = this.capacity;
    data['status'] = this.status;
    data['booked_by'] = this.bookedBy;
    data['booked_at'] = this.bookedAt;
    return data;
  }
}
