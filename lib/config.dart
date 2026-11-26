/// Base URL of the Django REST Framework backend.
///
/// Android emulators reach the host machine through `10.0.2.2`.
/// For Flutter Web, override this with
/// `--dart-define=API_BASE_URL=http://localhost:8000`.
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);
