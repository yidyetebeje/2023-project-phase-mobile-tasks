import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/onboarding.dart';
import 'package:todoappwithcleanarchitecture/features/todo/presentation/pages/task_list.dart';
import 'package:todoappwithcleanarchitecture/main.dart';


void main() {
  testWidgets('OnBoardingPage displays correctly', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: const OnBoardingPage(),
        routes: {
          TaskAppPageRoutes.taskList: (context) => Placeholder(),
        },
      ),
    );

    // Verify that the background color is correct
    expect(find.byType(Container), findsOneWidget);
    final container = tester.widget<Container>(find.byType(Container));
    expect(container.decoration, const BoxDecoration(color: Color(0xFFEE6F57)));

    // Verify that the image is displayed
    expect(find.byType(Image), findsOneWidget);
    final image = tester.widget<Image>(find.byType(Image));
    expect(image.image, const AssetImage('assets/images/painting.png'));

    // Verify that the button is displayed
    expect(find.byType(FilledButton), findsOneWidget);
    // Tap the button and trigger a frame.
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(find.byType(Placeholder), findsOneWidget);
  });
}