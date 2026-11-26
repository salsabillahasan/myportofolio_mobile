import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

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

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Tidak diisi';
    }

    return '${date.day}/${date.month}/${date.year}';
  }

  void _showEducationSummary() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Education berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Institution: $_institution'),
                const SizedBox(height: 8),

                Text('Degree: $_degree'),
                const SizedBox(height: 8),

                Text('Field of Study: $_fieldOfStudy'),
                const SizedBox(height: 8),

                Text('Start Date: ${_formatDate(_startedAt)}'),
                const SizedBox(height: 8),

                Text('End Date: ${_formatDate(_endedAt)}'),
                const SizedBox(height: 8),

                Text(
                  'Description: ${_description.isEmpty ? "Tidak diisi" : _description}',
                ),
                const SizedBox(height: 8),

                Text(
                  'Thumbnail URL: ${_thumbnail.isEmpty ? "Tidak diisi" : _thumbnail}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
                  onPressed: () {
                    final isFormValid = _formKey.currentState!.validate();

                    final isDateValid =
                        _startedAt == null ||
                        _endedAt == null ||
                        !_endedAt!.isBefore(_startedAt!);

                    if (!isDateValid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Tanggal selesai tidak boleh sebelum tanggal mulai!',
                          ),
                        ),
                      );
                    }

                    if (isFormValid && isDateValid) {
                      _showEducationSummary();
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
