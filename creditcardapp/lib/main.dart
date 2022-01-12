import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Credit Card Input Exercise"),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  value = value.toString();
                  if ((new RegExp(
                          r'^4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|^(222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)[0-9]{12}|6(?:011|5[0-9]{2})[0-9]{12}|3[47]\d{13,14}$'))
                      .hasMatch(value)) {
                    if (Luhn(value)) {
                      return null;
                    }
                  }
                  return "Invalid Credit card Number";
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Card number",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
                autocorrect: false,
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        value = value.toString();
                        if ((new RegExp(r'[0-3][0-9][/][0-9][0-9]'))
                            .hasMatch(value)) {
                          return null;
                        }
                        return "Invalid Expiry date";
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "MM/YY",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                        ),
                      ),
                      autocorrect: false,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        value = value.toString();
                        if ((new RegExp(r'^[0-9]{3,4}$')).hasMatch(value)) {
                          return null;
                        }
                        return "Invalid Security Code";
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Security Code",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                        ),
                      ),
                      autocorrect: false,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        value = value.toString();
                        if ((new RegExp(r'[A-Za-z ]$')).hasMatch(value)) {
                          return null;
                        }
                        return "Invalid First name";
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "First name",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                        ),
                      ),
                      autocorrect: false,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        value = value.toString();
                        if ((new RegExp(r'[A-Za-z ]$')).hasMatch(value)) {
                          return null;
                        }
                        return "Invalid Last name";
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Last name",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                        ),
                      ),
                      autocorrect: false,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            'Transaction Successful',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "SUBMIT PAYMENT",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Luhn(String input) {
  int sum = 0;
  int length = input.length;
  for (var i = 0; i < length; i++) {
    int digit = int.parse(input[length - i - 1]);
    if (i % 2 == 1) {
      digit *= 2;
    }
    sum += digit > 9 ? (digit - 9) : digit;
  }

  if (sum % 10 == 0) {
    return true;
  }

  return false;
}
