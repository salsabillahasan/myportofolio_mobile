import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final imageUrl = project.projectImageUrl.trim();

    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text('Tech stack: ${project.techStack}'),
            const SizedBox(height: 12),
            Text(project.description),
            const SizedBox(height: 12),
            Text('Project URL: ${project.projectUrl}'),
            if (imageUrl.isNotEmpty) ...[
              const SizedBox(height: 16),
              Image.network(
                imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Text('Project image could not be loaded.'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
