class ReactionType {
  String id;

  ReactionType({
    this.id,
  });

  static ReactionType fromJson(Map<String, Object> json) {
    return ReactionType(
      id: json["id"] as String,
    );
  }
}
