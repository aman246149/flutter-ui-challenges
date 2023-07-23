import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'coffe_challenge_view_model.dart';

class CoffeChallenge extends StatefulWidget {
  const CoffeChallenge({super.key});

  @override
  State<CoffeChallenge> createState() => _CoffeChallengeState();
}

class _CoffeChallengeState extends State<CoffeChallenge> {
  bool isDragStarted = false;
  int selectedIndex = 0;

  List<String> coffeName = [
    "Iced Coffe",
    "Americano",
    "Latte",
    "Cappaccino",
    "Espresso",
    "Doppio"
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "BARISTA",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "COFFEE",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.91),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Text(
                      "Drag Your Cuppa",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ).animate(target: isDragStarted == false ? 1 : 0).fade(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Icon(Icons.arrow_downward_outlined)
                        .animate(target: isDragStarted == false ? 1 : 0)
                        .fade(),
                    const SizedBox(
                      height: 80,
                    ),
                    Image.asset(
                      "assets/images/plate.png",
                      width: size.width / 1.7,
                    )
                        .animate(
                          target: !isDragStarted ? 0 : 1,
                        )
                        .slideY(begin: 0, end: 0.2)
                        .scaleXY(
                          begin: 1,
                          end: 0.8,
                          curve: Curves.easeInCubic,
                        ),
                  ],
                ),
              ),
            ),
            PageView.builder(
              controller: PageController(viewportFraction: 0.6),
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) => CoffeChallengeViewModel.clearNumber(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0) {
                      setState(() {
                        isDragStarted = true;
                        selectedIndex = index;
                      });
                    } else if (details.delta.dy < 0) {
                      setState(() {
                        isDragStarted = false;
                        selectedIndex = index;
                      });
                    }
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Align(
                        alignment: const Alignment(0.0, -0.3),
                        child: SizedBox(
                          height: 250,
                          width: 250,
                          child: Center(
                            child: Image.asset(
                              "assets/images/coffe1.png",
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                          .animate(
                            target:
                                isDragStarted && selectedIndex == index ? 1 : 0,
                          )
                          .moveY(
                              end: size.height / 2.2,
                              curve: Curves.easeInCubic),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          coffeName[index],
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 40),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Align(
                alignment: const Alignment(0, 0.93),
                child: ValueListenableBuilder(
                  valueListenable: CoffeChallengeViewModel.number,
                  builder: (context, value, child) {
                    String formattedNumber =
                        CoffeChallengeViewModel.formatNumberWithLeadingZero();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            CoffeChallengeViewModel.decrement();
                          },
                          icon: const Icon(Icons.remove, color: Colors.grey),
                          padding: EdgeInsets.zero,
                        ),
                        Text(
                          formattedNumber,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                        )
                            .animate(target: isDragStarted ? 1 : 0)
                            .scaleXY(end: 1.2)
                            .shimmer(),
                        IconButton(
                          onPressed: () {
                            CoffeChallengeViewModel.increment();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
