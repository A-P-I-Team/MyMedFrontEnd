class Date {
  final int year;
  final int month;
  final int day;

  const Date(
    this.year,
    this.month,
    this.day,
  );

  @override
  String toString() {
    return '$year/$month/$day';
  }
}
