class CreatedBy {
  String username;
  String? fullName; // Using nullable type for optional field

  CreatedBy({
    required this.username,
    this.fullName,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      username: json['username'],
      fullName: json['full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'full_name': fullName,
    };
  }
}
