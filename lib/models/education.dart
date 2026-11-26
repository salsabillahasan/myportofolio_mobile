import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

/// Education record returned by the Django REST API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Education {
  const Education({
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    this.startedAt,
    this.endedAt,
    this.description = '',
    this.thumbnail,
    this.logoSrc = '',
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
    this.id,
  });

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);

  @JsonKey(includeToJson: false)
  final int? id;
  final String institution;
  final String degree;
  final String fieldOfStudy;
  final DateTime? startedAt;
  final DateTime? endedAt;
  @JsonKey(defaultValue: '')
  final String description;
  final String? thumbnail;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String logoSrc;
  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;
  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;
  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}
