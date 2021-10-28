import 'dart:math';

import 'package:flutter/material.dart';
import 'package:udemy_black_jack/screens/widgets/cards_grid_view.dart';
import 'package:udemy_black_jack/screens/widgets/my_button.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  _BlackJackScreenState createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool isGameStarted = false;
  List<Image> myCards = [];
  List<Image> dealerCards = [];
  String? playersFirstCard;
  String? playersSecondCard;
  String? dealersFirstCard;
  String? dealersSecondCard;
  int playerScore = 0;
  int dealerScore = 0;
  Map<String, int> playingCards = {};
  @override
  void initState() {
    super.initState();
    playingCards.addAll(deckOfCards);
  }

  void changeCards() {
    setState(() {
      isGameStarted = true;
    });
    myCards = [];
    dealerCards = [];
    Random random = Random();
    String cardOneKey = (playingCards.keys.elementAt(random.nextInt(
        playingCards.length))); //from 1 to playingCards.lentght including
    //Sure playingCards are unique and remove cardOneKey in playingCards
    playingCards.removeWhere((key, value) => key == cardOneKey);
    String cardTwoKey =
        (playingCards.keys.elementAt(random.nextInt(playingCards.length)));

    playingCards.removeWhere((key, value) => key == cardTwoKey);
    String cardThreeKey =
        (playingCards.keys.elementAt(random.nextInt(playingCards.length)));

    playingCards.removeWhere((key, value) => key == cardThreeKey);
    String cardFourKey =
        (playingCards.keys.elementAt(random.nextInt(playingCards.length)));

    playingCards.removeWhere((key, value) => key == cardFourKey);

    dealersFirstCard = cardOneKey;
    dealersSecondCard = cardTwoKey;
    playersFirstCard = cardThreeKey;
    playersSecondCard = cardFourKey;
    dealerCards.add(Image.asset(dealersFirstCard!));
    dealerCards.add(Image.asset(dealersSecondCard!));
    dealerScore =
        deckOfCards[dealersFirstCard]! + deckOfCards[dealersSecondCard]!;
    myCards.add(Image.asset(playersFirstCard!));
    myCards.add(Image.asset(playersSecondCard!));
    playerScore =
        deckOfCards[playersFirstCard]! + deckOfCards[playersSecondCard]!;
  }

  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };
  void addCard() {
    Random random = Random();
    if (playingCards.length > 0) {
      String cardKey =
          (playingCards.keys.elementAt(random.nextInt(playingCards.length)));
      setState(() {
        myCards.add(Image.asset(cardKey));
        playingCards.removeWhere((key, value) => key == cardKey);
      });
      playerScore = playerScore + deckOfCards[cardKey]!;
      if (dealerScore <= 14) {
        String thirdDealerCardKey =
            (playingCards.keys.elementAt(random.nextInt(playingCards.length)));

        playingCards.removeWhere((key, value) => key == thirdDealerCardKey);
        dealerCards.add(Image.asset(thirdDealerCardKey));
        dealerScore = dealerScore + deckOfCards[thirdDealerCardKey]!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isGameStarted
            ? SafeArea(
                child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //dealers Card
                    Column(
                      children: [
                        Text("Dealer score $dealerScore",
                            style: TextStyle(
                                color: dealerScore <= 21
                                    ? Colors.green[900]
                                    : Colors.red)),
                        const SizedBox(height: 20),
                        //gridView
                        CardsGridView(cards: dealerCards)
                      ],
                    ),
                    //players Card
                    Column(
                      children: [
                        Text("Player score $playerScore",
                            style: TextStyle(
                                color: playerScore <= 21
                                    ? Colors.blue[600]
                                    : Colors.red)),
                        SizedBox(height: 20),
                        CardsGridView(cards: myCards),
                      ],
                    ),
                    //2 buttons
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MyButton(onPressed: addCard, label: "Another Card"),
                          MyButton(onPressed: changeCards, label: "Next round"),
                          // MaterialButton(
                          //   color: Colors.brown[200],
                          //   child: Text("Another Card"),
                          //   onPressed: addCard,
                          // ),
                          // MaterialButton(
                          //   color: Colors.brown[200],
                          //   child: Text("Next round"),
                          //   onPressed: changeCards,
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            : Center(
                child: MyButton(onPressed: changeCards, label: "Start Game"),
                // MaterialButton(
                //   color: Colors.brown[200],
                //   onPressed: changeCards,
                //   child: Text("Start Game"),
                // ),
                ));
  }
}
