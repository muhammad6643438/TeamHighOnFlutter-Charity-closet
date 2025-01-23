class ComplaintModel {
  String? id;
  String? complainerId;
  String? createdAt;
  String? title;
  String? description;
  String? userName;
  String? status;

  ComplaintModel({
    this.id,
    this.complainerId,
    this.createdAt,
    this.title,
    this.description,
    this.userName,
    this.status,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      complainerId: json['complainerId'],
      createdAt: json['createdAt'],
      title: json['title'],
      description: json['description'],
      userName: json['name'],
      status: json['status'] ?? 'Pending',
    );
  }
}
