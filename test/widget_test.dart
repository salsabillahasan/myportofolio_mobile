import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';

void main() {
  testWidgets('Homepage menampilkan identitas dan sambutan', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
  });

  testWidgets('Homepage menampilkan opsi login saat belum login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Logout'), findsNothing);
  });

  testWidgets('Tambah Proyek meminta login sebelum membuka form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('Kartu menu mempertahankan warna masing-masing', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final projectCard = tester.widget<Material>(
      find
          .ancestor(
            of: find.text('Lihat Proyek'),
            matching: find.byType(Material),
          )
          .first,
    );
    final addProjectCard = tester.widget<Material>(
      find
          .ancestor(
            of: find.text('Tambah Proyek'),
            matching: find.byType(Material),
          )
          .first,
    );
    final loginCard = tester.widget<Material>(
      find
          .ancestor(of: find.text('Login'), matching: find.byType(Material))
          .first,
    );

    expect(projectCard.color, Colors.blue);
    expect(addProjectCard.color, Colors.green);
    expect(loginCard.color, Colors.red);
  });
}
