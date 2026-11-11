import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

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

  testWidgets('Homepage menampilkan tiga menu', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);

    expect(find.byIcon(Icons.folder), findsOneWidget);
    expect(find.byIcon(Icons.add_circle), findsOneWidget);
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });

  testWidgets('Menekan menu menampilkan SnackBar', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Lihat Proyek'));
    await tester.pump();

    expect(
      find.text('Kamu telah menekan tombol Lihat Proyek!'),
      findsOneWidget,
    );
  });
  testWidgets('Setiap menu memiliki warna berbeda', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final materialProyek = tester.widget<Material>(
      find
          .ancestor(
            of: find.text('Lihat Proyek'),
            matching: find.byType(Material),
          )
          .first,
    );

    final materialTambah = tester.widget<Material>(
      find
          .ancestor(
            of: find.text('Tambah Proyek'),
            matching: find.byType(Material),
          )
          .first,
    );

    final materialLogout = tester.widget<Material>(
      find
          .ancestor(of: find.text('Logout'), matching: find.byType(Material))
          .first,
    );

    expect(materialProyek.color, Colors.blue);
    expect(materialTambah.color, Colors.green);
    expect(materialLogout.color, Colors.red);
  });
}
