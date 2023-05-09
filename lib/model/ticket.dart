import 'package:flutter_pos/model/product_model.dart';

class Ticket_model {
  int statusCode;
  String message;
  List<Ticket> data;
  int total;

  Ticket_model({this.statusCode, this.message, this.data, this.total});

  Ticket_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Ticket>();
      json['data'].forEach((v) { data.add(new Ticket.fromJson(v)); });
    }
    total = json['total'];
  }


}

class Ticket {
  int id;
  String ticketNo;
  String title;
  int ticketpriorityId;
  String priority;
  bool loading=false;
  bool tloading=false;
  String message;
  String status;
  int categoryId;
  String categoryName;
  String product_name;
  String product_name_en;
  int userId;
  String userName;
  String userEmail;
  String userPhone;
  int vendorId;
  String vendorName;
  int orderId;
  List<Comments> comments;
  String Case;
  String reply;
  int orderNumber;
  String orderCreatedAt;
  String vendorEmail;
  String createdAt;
  PhotoProduct attachment;


  Ticket({this.id, this.ticketNo, this.title, this.ticketpriorityId, this.priority, this.message, this.status, this.categoryId, this.categoryName, this.userId, this.userName, this.userEmail, this.userPhone, this.vendorId, this.vendorName, this.orderId, this.comments, this.Case, this.reply, this.orderNumber, this.orderCreatedAt, this.vendorEmail, this.createdAt});

Ticket.fromJson(Map<String, dynamic> json) {
id = json['id'];
ticketNo = json['ticket_no'];
title = json['title'];
ticketpriorityId = json['ticketpriority_id'];
priority = json['priority'];
message = json['message'];
status = json['status'];
categoryId = json['category_id'];
categoryName = json['category_name'];
userId = json['user_id'];
userName = json['user_name'];
product_name = json['product_name'];
product_name_en = json['name_en'];
userEmail = json['user_email'];
userPhone = json['user_phone'];
vendorId = json['vendor_id'];
vendorName = json['vendor_name'];
orderId = json['order_id'];

if (json['comments'] != null) {
comments = new List<Comments>();
json['comments'].forEach((v) { comments.add(new Comments.fromJson(v)); });
}
Case = json['case'];
reply = json['reply'];
if (json['orderDetails'] != null) {
orderNumber = json['order_number'];
orderCreatedAt = json['order_created_at'];
vendorEmail = json['vendor_email'];
createdAt = json['created_at'];
attachment = json['attachment'] != null?PhotoProduct.fromJson(json['attachment']):null;
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['ticket_no'] = this.ticketNo;
  data['title'] = this.title;
  data['ticketpriority_id'] = this.ticketpriorityId;
  data['priority'] = this.priority;
  data['message'] = this.message;
  data['status'] = this.status;
  data['category_id'] = this.categoryId;
  data['category_name'] = this.categoryName;
  data['user_id'] = this.userId;
  data['user_name'] = this.userName;
  data['user_email'] = this.userEmail;
  data['user_phone'] = this.userPhone;
  data['vendor_id'] = this.vendorId;
  data['vendor_name'] = this.vendorName;
  data['order_id'] = this.orderId;

  if (this.comments != null) {
    data['comments'] = this.comments.map((v) => v.toJson()).toList();
  }
  data['case'] = this.Case;
  data['reply'] = this.reply;

  data['order_number'] = this.orderNumber;
  data['order_created_at'] = this.orderCreatedAt;
  data['vendor_email'] = this.vendorEmail;
  data['created_at'] = this.createdAt;

  return data;
}
}}
class Comments {
  int id;
  int ticketId;
  int userId;
  String userName;
  String userRole;
  String comment;
  String createdAt;

  Comments({this.id, this.ticketId, this.userId, this.userName, this.userRole, this.comment, this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userRole = json['user_role'];
    comment = json['comment'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_role'] = this.userRole;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    return data;
  }
}

