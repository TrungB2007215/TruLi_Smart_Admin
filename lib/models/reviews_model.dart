class ReviewsModel {
  final String reviewsId;
  final String userId;
  final String productId;
  final String reviewContent;
  final int rating;
  final DateTime reviewDate;

  ReviewsModel({
    required this.reviewsId,
    required this.userId,
    required this.productId,
    required this.reviewContent,
    required this.rating,
    required this.reviewDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'reviews_id': reviewsId,
      'user_id': userId,
      'product_id': productId,
      'review_content': reviewContent,
      'rating': rating,
      'review_date': reviewDate.toIso8601String(),
    };
  }

  factory ReviewsModel.fromMap(Map<String, dynamic> map) {
    return ReviewsModel(
      reviewsId: map['reviews_id'],
      userId: map['user_id'],
      productId: map['product_id'],
      reviewContent: map['review_content'],
      rating: map['rating'],
      reviewDate: DateTime.parse(map['review_date']),
    );
  }
}
