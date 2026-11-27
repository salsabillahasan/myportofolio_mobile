import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/education.dart';

class EducationDetailScreen extends StatelessWidget {
  const EducationDetailScreen({required this.education, super.key});

  final Education education;

  String _date(DateTime? value) => value == null
      ? 'Tidak diisi'
      : '${value.day}/${value.month}/${value.year}';

  @override
  Widget build(BuildContext context) {
    final thumbnail = (education.thumbnail ?? '').trim();
    final imageUrl = education.logoSrc.trim().isNotEmpty
        ? education.logoSrc.trim()
        : thumbnail;
    return Scaffold(
      appBar: AppBar(title: Text(education.institution)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            education.institution,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text('ID: ${education.id ?? "Tidak tersedia"}'),
          const SizedBox(height: 8),
          Text('Degree: ${education.degree}'),
          const SizedBox(height: 8),
          Text('Field of study: ${education.fieldOfStudy}'),
          const SizedBox(height: 8),
          Text('Start date: ${_date(education.startedAt)}'),
          const SizedBox(height: 8),
          Text('End date: ${_date(education.endedAt)}'),
          const SizedBox(height: 8),
          Text('Description: ${education.description}'),
          const SizedBox(height: 8),
          Text(
            'Thumbnail URL: ${thumbnail.isEmpty ? "Tidak diisi" : thumbnail}',
          ),
          const SizedBox(height: 8),
          Text('Jumlah favorit: ${education.starCount}'),
          const SizedBox(height: 8),
          Text(
            'Kamu memfavoritkan ini: ${education.isStarred ? "Ya" : "Tidak"}',
          ),
          const SizedBox(height: 8),
          Text(
            'Nama pemberi favorit: ${education.starredByNames.isEmpty ? "Belum ada" : education.starredByNames}',
          ),
          if (imageUrl.isNotEmpty) ...[
            const SizedBox(height: 16),
            Image.network(
              imageUrl,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const Text('Gambar Education tidak dapat dimuat.'),
            ),
          ],
        ],
      ),
    );
  }
}
