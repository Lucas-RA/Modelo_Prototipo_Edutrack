class ClassSession {
  final String id;
  final String subject;
  final String partner;
  final String time;
  final String instructor;
  final bool presenceConfirmed;
  final String description;
  final List<String> topics;

  const ClassSession({
    required this.id,
    required this.subject,
    required this.partner,
    required this.time,
    required this.instructor,
    required this.presenceConfirmed,
    required this.description,
    required this.topics,
  });
}
