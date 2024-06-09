class SessionOn {
  final String title;
  final String dateTime;
  final String location;
  bool isSelected;
  String name;
  String surname;

  SessionOn({
    required this.title,
    required this.dateTime,
    required this.location,
    this.isSelected = false,
    this.name = '',
    this.surname = '',
  });
}
