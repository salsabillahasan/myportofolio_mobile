import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = "";
  String _degree = "";
  String _fieldOfStudy = "";

  DateTime? _startedAt;
  DateTime? _endedAt;

  String _description = "";
  String _thumbnail = "";
  bool _isSubmitting = false;

  Future<void> _selectDate({required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startedAt ?? DateTime.now())
          : (_endedAt ?? _startedAt ?? DateTime.now()),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null && mounted) {
      setState(() {
        if (isStartDate) {
          _startedAt = picked;
        } else {
          _endedAt = picked;
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final isDateValid =
        _startedAt == null ||
        _endedAt == null ||
        !_endedAt!.isBefore(_startedAt!);
    if (!isDateValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal selesai tidak boleh sebelum tanggal mulai!'),
        ),
      );
      return;
    }

    if (!await ensureLoggedIn(context) || !mounted) return;
    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() => _isSubmitting = true);
    try {
      final created = await context.read<ApiClient>().createEducation(
        Education(
          institution: _institution.trim(),
          degree: _degree.trim(),
          fieldOfStudy: _fieldOfStudy.trim(),
          startedAt: _startedAt,
          endedAt: _endedAt,
          description: _description.trim(),
          thumbnail: _thumbnail.trim().isEmpty ? null : _thumbnail.trim(),
        ),
        token: token,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Education berhasil ditambahkan!'),
          content: Text('${created.institution} sudah tersimpan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context, true);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        await ensureLoggedIn(context);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login lagi, lalu tekan Simpan sekali lagi.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Education gagal disimpan (${error.statusCode}).'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Add Education Form'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Education',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Fill in your education information below.'),
              const SizedBox(height: 24),

              // === Institution ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Institution',
                  hintText: 'Contoh: Universitas Indonesia',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                onChanged: (value) {
                  setState(() {
                    _institution = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama institusi tidak boleh kosong!';
                  }
                  if (value.trim().length > 255) {
                    return 'Nama institusi maksimal 255 karakter!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Degree ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Degree',
                  hintText: 'Contoh: Bachelor of Information Systems',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.workspace_premium),
                ),
                onChanged: (value) {
                  setState(() {
                    _degree = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Degree tidak boleh kosong!';
                  }
                  if (value.trim().length > 255) {
                    return 'Degree maksimal 255 karakter!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Field of Study ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Field of Study',
                  hintText: 'Contoh: Information Systems',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.menu_book),
                ),
                onChanged: (value) {
                  setState(() {
                    _fieldOfStudy = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bidang studi tidak boleh kosong!';
                  }
                  if (value.trim().length > 255) {
                    return 'Bidang studi maksimal 255 karakter!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Start Date ===
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: const Text('Start Date'),
                subtitle: Text(
                  _startedAt == null
                      ? 'Pilih tanggal mulai (opsional)'
                      : '${_startedAt!.day}/${_startedAt!.month}/${_startedAt!.year}',
                ),

                trailing: _startedAt == null
                    ? const Icon(Icons.arrow_drop_down)
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        tooltip: 'Hapus tanggal mulai',
                        onPressed: () {
                          setState(() {
                            _startedAt = null;
                          });
                        },
                      ),
                onTap: () => _selectDate(isStartDate: true),
              ),
              const SizedBox(height: 16),

              // === End Date ===
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event_available),
                title: const Text('End Date'),
                subtitle: Text(
                  _endedAt == null
                      ? 'Pilih tanggal selesai (opsional)'
                      : '${_endedAt!.day}/${_endedAt!.month}/${_endedAt!.year}',
                ),

                trailing: _endedAt == null
                    ? const Icon(Icons.arrow_drop_down)
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        tooltip: 'Hapus tanggal selesai',
                        onPressed: () {
                          setState(() {
                            _endedAt = null;
                          });
                        },
                      ),
                onTap: () => _selectDate(isStartDate: false),
              ),

              if (_startedAt != null &&
                  _endedAt != null &&
                  _endedAt!.isBefore(_startedAt!))
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 8),
                  child: Text(
                    'Tanggal selesai tidak boleh sebelum tanggal mulai!',
                    style: TextStyle(color: Colors.red),
                  ),
                ),

              const SizedBox(height: 16),

              // === Description ===
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Ceritakan pengalaman pendidikanmu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // === Thumbnail URL ===
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Thumbnail URL',
                  hintText: 'https://example.com/image.png',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
                onChanged: (value) {
                  setState(() {
                    _thumbnail = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }

                  final uri = Uri.tryParse(value.trim());

                  if (uri == null ||
                      !uri.hasAuthority ||
                      (uri.scheme != 'http' && uri.scheme != 'https')) {
                    return 'Masukkan URL yang valid!';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),

              // === Tombol Simpan ===
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
