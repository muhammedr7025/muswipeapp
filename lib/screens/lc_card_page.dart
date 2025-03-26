import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:muapp/screens/widget/lc_card.dart';
import 'dart:math';

class LcCardPage extends StatefulWidget {
  const LcCardPage({super.key});

  @override
  State<LcCardPage> createState() => _LcCardPageState();
}

class _LcCardPageState extends State<LcCardPage> {
  final CardSwiperController controller = CardSwiperController();
  final Random random = Random();

  // Static test data
  final List<Map<String, dynamic>> testData = [
    {'karma': 45, 'title': 'Test Group 1', 'memberCount': 128},
    {'karma': 87, 'title': 'Test Group 2', 'memberCount': 256},
    {'karma': 23, 'title': 'Test Group 3', 'memberCount': 512},
    {'karma': 65, 'title': 'Test Group 4', 'memberCount': 64},
    {'karma': 91, 'title': 'Test Group 5', 'memberCount': 324},
    {'karma': 38, 'title': 'Test Group 6', 'memberCount': 176},
    {'karma': 72, 'title': 'Test Group 7', 'memberCount': 221},
    {'karma': 54, 'title': 'Test Group 8', 'memberCount': 389},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LC Lists'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: CardSwiper(
                controller: controller,
                onSwipe: (previousIndex, currentIndex, direction) {
                  return _onSwipe(previousIndex, currentIndex, direction);
                },
                onUndo: _onUndo,
                isLoop: false,
                allowedSwipeDirection:
                    const AllowedSwipeDirection.symmetric(horizontal: true),
                maxAngle: 30,
                cardsCount: testData.length,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) {
                  final data = testData[index];
                  return LcCard(
                    karma: data['karma'].toString(),
                    title: data['title'],
                    memberCount: data['memberCount'].toString(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.left),
                    child: const Text('Reject'),
                  ),
                  FloatingActionButton(
                    onPressed: controller.undo,
                    child: const Icon(Icons.rotate_left),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.right),
                    child: const Text('Accept'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
      int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
