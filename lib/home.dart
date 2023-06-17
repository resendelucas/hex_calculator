import 'package:hex_calculator/operate.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {



  String userInput = "";
  String result = "";
  var buttonList = [
    "D","E","F","CLR",
    "A","B","C","⌫",
    "7","8","9","+",
    "4","5","6","-",
    "1","2","3","/",
    " ","0", "=","*"
    ];



  var opsList = ["+", "-", "/", "*"];

  _setInput(int i) {
    String char = buttonList[i];
    setState(() {
      if (char=="CLR") {
        userInput = "";
        result = "";
      }
      if (char!="CLR" && char != "⌫" && char != "=" && _verifyEnable(char)){
          userInput += char;
      }
      if (char == "⌫") userInput = userInput.substring(0, userInput.length -1);
      // else if (char == "=") {
      if (userInput.contains("*")||userInput.contains("/")||userInput.contains("-")||userInput.contains("+")){
        if (userInput[userInput.length-1]!="+"&&userInput[userInput.length-1]!="/"&&userInput[userInput.length-1]!="*"&&userInput[userInput.length-1]!="-"){
          result = Operate(userInput).calculate();
        }
        else {
          result = "";
        }
      }
      // }
      if(char=="=") userInput = result;
    }
    );
  }

  bool _verifyEnable(String char){
    if (userInput.isNotEmpty && opsList.contains(userInput[userInput.length-1]) && opsList.contains(char)) return false;
    if (opsList.contains(char)&&userInput.isEmpty) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Calculadora Hexadecimal"), 
        backgroundColor: Color.fromARGB(255, 53, 57, 63)
      ),
      backgroundColor: Color.fromARGB(255, 58, 67, 73),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              // color: Colors.red,
              margin: const EdgeInsets.all(10),
              height: 100,
              // width: MediaQuery.of(context).size.width,
              width: 400,
              child: Text(userInput,
                textAlign: TextAlign.end, 
                style: const TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 225, 215, 215)
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              // color: Colors.yellow,
              margin: const EdgeInsets.all(10),
              height: 140,
              // width: MediaQuery.of(context).size.width,
              width: 400,
              child: Text(result,
                textAlign: TextAlign.end, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 52,
                  color: Colors.white,
                
                ),
              ),
            ),
            Container(
              height: 578,
              width: 400,
              child: _buildGrid()
            )
          ]
        )
      ),
    );
  }


  Widget _buildGrid() =>  GridView.extent(
    childAspectRatio: 1.25,
    shrinkWrap: true,
    maxCrossAxisExtent: 100,
    padding: const EdgeInsets.all(10),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(buttonList.length)
    );
  List<SizedBox> _buildGridTileList(int count) => List.generate(
    count, (i) => _createBox(i));
  
  _createBox(int i){
    return SizedBox(
      width: 50,
      child: OutlinedButton(
      onPressed: () => {
        _setInput(i)
      },
      style: OutlinedButton.styleFrom( backgroundColor: _selectColor(i) ),
      child: Text(buttonList[i], 
        style: const TextStyle(
          fontSize: 20
        ),
      ),
    ),
    );
  }

  Color _selectColor(int i){
    List<int> operators = [11,15,19,23];

    if (operators.contains(i)) {
      return Color.fromARGB(255, 75, 85, 92);
    } else if ([3,7].contains(i)) {
      return Color.fromARGB(255, 65, 73, 78);
    } else if ([22].contains(i)) {
      return Color.fromARGB(255, 86, 102, 114);
    } else if (20 == i) {
      return Color.fromARGB(255, 58, 67, 73);
    }
    return Color.fromARGB(255, 67, 76, 83);
  }
}