import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  group('Education API', () {
    test('GET parses education JSON into model objects', () async {
      final client = ApiClient(
        baseUrl: 'https://example.test',
        client: MockClient((request) async {
          expect(request.method, 'GET');
          expect(request.url.path, '/api/v1/education/');
          return http.Response(
            jsonEncode([
              {
                'id': 12,
                'institution': 'Example University',
                'degree': 'Bachelor',
                'field_of_study': 'Information Systems',
                'started_at': '2022-08-01T00:00:00Z',
                'ended_at': null,
                'description': 'Studying information systems.',
                'thumbnail': null,
                'logo_src': '',
                'star_count': 2,
                'is_starred': false,
                'starred_by_names': 'student, tutor',
              },
            ]),
            200,
          );
        }),
      );

      final educations = await client.getEducations();

      expect(educations, hasLength(1));
      expect(educations.single.id, 12);
      expect(educations.single.institution, 'Example University');
      expect(educations.single.startedAt, DateTime.utc(2022, 8, 1));
      expect(educations.single.starredByNames, 'student, tutor');
    });

    test('POST sends token and only writable education fields', () async {
      final education = Education(
        id: 99,
        institution: 'Example University',
        degree: 'Bachelor',
        fieldOfStudy: 'Information Systems',
        startedAt: DateTime.utc(2022, 8, 1),
        description: 'Studying information systems.',
        logoSrc: '/media/logo.png',
        starCount: 3,
        starredByNames: 'someone',
      );

      final client = ApiClient(
        baseUrl: 'https://example.test',
        client: MockClient((request) async {
          expect(request.method, 'POST');
          expect(request.url.path, '/api/v1/education/');
          expect(request.headers['Authorization'], 'Token test-token');
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['institution'], 'Example University');
          expect(body['field_of_study'], 'Information Systems');
          expect(body.containsKey('id'), isFalse);
          expect(body.containsKey('logo_src'), isFalse);
          expect(body.containsKey('star_count'), isFalse);
          return http.Response(
            jsonEncode({
              'id': 13,
              'institution': body['institution'],
              'degree': body['degree'],
              'field_of_study': body['field_of_study'],
              'started_at': body['started_at'],
              'ended_at': body['ended_at'],
              'description': body['description'],
              'thumbnail': body['thumbnail'],
              'logo_src': '',
              'star_count': 0,
              'is_starred': false,
              'starred_by_names': '',
            }),
            201,
          );
        }),
      );

      final created = await client.createEducation(
        education,
        token: 'test-token',
      );

      expect(created.id, 13);
      expect(created.institution, 'Example University');
    });
  });
}
