import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Grid.view state

  // variebales(start)
  int iswinx = 0;
  int iswino = 0;
  String playerturn = 'turn';
  bool isturnXorO = false;
  int finishgame = 0;
  int drawnumber = 0;
  //variebales(end)

  //show X or O(start)
  List<String> XorO = ['', '', '', '', '', '', '', '', ''];
  void GetXorO(int index) {
    if (XorO[index] != '') return;
    if (finishgame == 1 || finishgame == 2) return;
    isturnXorO = !isturnXorO;
    if (isturnXorO) {
      setState(() {
        XorO[index] = 'X';
        playerturn = 'turn O';
        drawnumber++;
      });
    } else {
      setState(() {
        XorO[index] = 'O';
        playerturn = 'turn X';
        drawnumber++;
      });
    }
  }

  //show X or O(end)
  //get winner X or O(start)
  void GetWinnerXorO() {
    if (finishgame == 1) return;
    if (XorO[0] == XorO[1] && XorO[0] == XorO[2] && XorO[0] == 'X' ||
        XorO[0] == XorO[4] && XorO[0] == XorO[8] && XorO[0] == 'X' ||
        XorO[2] == XorO[4] && XorO[2] == XorO[6] && XorO[2] == 'X' ||
        XorO[2] == XorO[5] && XorO[2] == XorO[8] && XorO[2] == 'X' ||
        XorO[0] == XorO[3] && XorO[0] == XorO[6] && XorO[0] == 'X' ||
        XorO[3] == XorO[4] && XorO[3] == XorO[5] && XorO[3] == 'X' ||
        XorO[6] == XorO[7] && XorO[6] == XorO[8] && XorO[6] == 'X' ||
        XorO[1] == XorO[4] && XorO[1] == XorO[7] && XorO[1] == 'X') {
      finishgame = 1;
      setState(() {
        playerturn = 'player X win';
        iswinx++;
      });
      return;
    }
    if (finishgame == 2) return;
    if (XorO[0] == XorO[1] && XorO[0] == XorO[2] && XorO[0] == 'O' ||
        XorO[0] == XorO[4] && XorO[0] == XorO[8] && XorO[0] == 'O' ||
        XorO[2] == XorO[4] && XorO[2] == XorO[6] && XorO[2] == 'O' ||
        XorO[2] == XorO[5] && XorO[2] == XorO[8] && XorO[2] == 'O' ||
        XorO[0] == XorO[3] && XorO[0] == XorO[6] && XorO[0] == 'O' ||
        XorO[3] == XorO[4] && XorO[3] == XorO[5] && XorO[3] == 'O' ||
        XorO[6] == XorO[7] && XorO[6] == XorO[8] && XorO[6] == 'O' ||
        XorO[1] == XorO[4] && XorO[1] == XorO[7] && XorO[1] == 'O') {
      finishgame = 2;
      setState(() {
        playerturn = 'player O win';
        iswino++;
      });
      return;
    }
    if (drawnumber == 9) {
      setState(() {
        playerturn = 'draw';
      });
      return;
    }
  }

  //get winner X or O(end)

  //get draw(start)

  //reset the X or O(start)
  void GetresetXorO() {
    finishgame = 0;
    playerturn = 'turn';
    isturnXorO = false;
    drawnumber = 0;
    for (var i = 0; i < XorO.length; i++) {
      setState(() {
        XorO[i] = '';
      });
    }
  }
  // reset the X or O(end)

  //reset the whole game(start)
  void GetResetWholeGame() {
    GetresetXorO();
    iswino = 0;
    iswinx = 0;
  }

  //change color X or O(start)
  bool isXorO(int index) {
    if (XorO[index] == 'O') {
      return true;
    }
    return false;
  }
  //change color X or O(end)

  Color GetColorXorO(int index) {
    if (isXorO(index)) {
      return Colors.white;
    } else {
      return Color.fromARGB(255, 212, 0, 255);
    }
  }

  Widget MainGridView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                GetXorO(index);
                GetWinnerXorO();
                print(drawnumber);
              },
              splashColor: Color.fromARGB(255, 212, 0, 255),
              child: Card(
                color: Color.fromARGB(255, 65, 65, 65),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      XorO[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: GetColorXorO(index),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: 9,
        ),
      ),
    );
  }

  Widget GetPLayerTurn() {
    return Text(
      playerturn,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 97, 97, 97)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
        appBar: AppBar(
          elevation: 3,
          shadowColor: Colors.purpleAccent,
          backgroundColor: Color.fromARGB(255, 49, 49, 49),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.sports_esports_sharp,
                color: Colors.grey,
              ),
              Text(
                'Tick-Tack-Toe',
                style: TextStyle(
                  color: Colors.purpleAccent,
                ),
              ),
              InkWell(
                onTap: () {
                  GetresetXorO();
                },
                onDoubleTap: () {
                  GetResetWholeGame();
                },
                child: Icon(
                  Icons.restart_alt_sharp,
                  color: Colors.grey,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'PLayer X = $iswinx',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    'PLayer O = $iswino',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.0,
              ),
              MainGridView(),
              GetPLayerTurn(),
              SizedBox(
                height: 120.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
