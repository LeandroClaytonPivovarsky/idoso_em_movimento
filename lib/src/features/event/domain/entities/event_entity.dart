import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String category;
  final String imageUrl;
  final int attendees;
  final int maxAttendees;
  final String description;

  const EventEntity({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.imageUrl,
    required this.attendees,
    required this.maxAttendees,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, date, time, location, category, imageUrl, attendees, maxAttendees, description];
}