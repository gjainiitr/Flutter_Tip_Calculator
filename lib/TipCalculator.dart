import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {

  double _bill = 0.0;
  int _tipPercentage = 0;
  int _personCounter = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(bottom: 20),
            children: <Widget>[

              Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.only(
                  top: 80,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Total per person",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.deepPurpleAccent.shade200,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Text("\$""${getBillPerHead(_tipPercentage, _bill, _personCounter)}",
                            style: TextStyle(
                              color: Colors.deepPurpleAccent.shade700,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.only(top: 20.0,),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid,// set border color
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true,),
                      style: TextStyle(color: Colors.deepPurpleAccent.shade700),
                      decoration: InputDecoration(
                        prefixText: "Bill Amount",
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (String val) {
                        try{
                          _bill = double.parse(val);
                        }
                        catch(e){
                          _bill = 0.0;
                        }
                      },
                    ),
                    Divider(thickness: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Split",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if(_personCounter > 1){
                                    _personCounter--;
                                  }
                                });
                              },
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade50,
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: Center(
                                  child: Text("-",
                                    style: TextStyle(
                                      color: Colors.deepPurpleAccent.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text("$_personCounter",
                              style: TextStyle(
                                color: Colors.deepPurpleAccent.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                    _personCounter++;
                                });
                              },
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade50,
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: Center(
                                  child: Text("+",
                                    style: TextStyle(
                                      color: Colors.deepPurpleAccent.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tip",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(18.0),
                          child: Text("${calculateTip(_bill, _tipPercentage)}",
                            style: TextStyle(
                              color: Colors.deepPurpleAccent.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("$_tipPercentage%",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                        Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.deepPurpleAccent.shade700,
                          inactiveColor: Colors.grey.shade300,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: updateTip
                        )

                      ],
                    ),
                  ],
                ),
              ),
            ],

          ),
        ),
      ),
    );

  }

  void updateTip(double newVal){
    setState(() {
      _tipPercentage = newVal.round();
    });
  }

  calculateTip(double billAmount, int tipPercentage){
    double tipValue = 0;
    if(billAmount<0 || billAmount.toString().isEmpty || billAmount==null){

    }
    else{
      tipValue = ((billAmount * tipPercentage)/100);
    }

    return tipValue.toStringAsFixed(2);
  }

  getBillPerHead(int tipPercentage, double billAmount, int splitBy){
    var billPerHead = (billAmount * (100 + tipPercentage))/(100 * splitBy);
    return billPerHead.toStringAsFixed(2);
  }
}
