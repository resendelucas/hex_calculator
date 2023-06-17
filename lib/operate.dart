
class Operate {
  String expression;
  
  Operate(this.expression);

  List<String> _getElementsSplitted(){
    List<String> splitted = [];
    String combined = "";
    while (expression.isNotEmpty){
      if (expression[0].contains(RegExp('^[0-9A-F]'))){
        combined += expression[0];
      }
      else {
        splitted.add(combined);
        splitted.add(expression[0]);
        combined = "";
      }
      expression = expression.substring(1);
    }
    splitted.add(combined);
    return splitted;
  }


  String calculate(){
    List<String> exp = _getElementsSplitted();
    int valor = 0;
      while(exp.length>1){
      for (int i = 0; i < exp.length; i++){
        if (exp[i] == "/"){
          valor = (int.parse(exp[i-1], radix: 16))~/(int.parse(exp[i+1], radix: 16));
          exp[i-1] = valor.toRadixString(16);
          exp.removeAt(i);
          exp.removeAt(i);
          break;
        }
        else if (exp[i] == "*"){
          valor = (int.parse(exp[i-1], radix: 16))*(int.parse(exp[i+1], radix: 16));
          exp[i-1] = valor.toRadixString(16);
          exp.removeAt(i);
          exp.removeAt(i);
          break;
        }
      }
      for (int i = 0; i < exp.length; i++){
        if (exp[i] == "+"){
          valor = int.parse(exp[i-1], radix: 16)+int.parse(exp[i+1], radix: 16);
          exp[i-1] = valor.toRadixString(16);
          exp.removeAt(i);
          exp.removeAt(i);
          break;
        }
        else if (exp[i] == "-"){
          valor = int.parse(exp[i-1], radix: 16)-int.parse(exp[i+1], radix: 16);
          exp[i-1] = valor.toRadixString(16);
          exp.removeAt(i);
          exp.removeAt(i);
          break;
        }
      }
      }

    return exp[0].toUpperCase();
  }

}
