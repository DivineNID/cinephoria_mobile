class Booking {
  final String id;
  final Movie movie;
  final String sessionDate;
  final List<String> seats;
  final double totalPrice;

  Booking({
    required this.id,
    required this.movie,
    required this.sessionDate,
    required this.seats,
    required this.totalPrice,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      movie: Movie.fromJson(json['movie']),
      sessionDate: json['session_date'],
      seats: List<String>.from(json['seats']),
      totalPrice: json['total_price'].toDouble(),
    );
  }
}