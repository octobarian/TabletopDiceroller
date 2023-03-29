import 'dart:math';

import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final Map data;
  final String packageName;
  MyAlertDialog({super.key, required this.data, required this.packageName});
  var random = Random();
  List d4 = [];
  List d6 = [];
  List d8 = [];
  List d10 = [];
  List d12 = [];
  List d20 = [];
  List d100 = [];
  int sum = 0;
  void damagePhase() {
    for (var i = 0; i < data['D10']; i++) {
      d10.add(random.nextInt(10) + 1);
    }
    for (var i = 0; i < data['D4']; i++) {
      d4.add(random.nextInt(4) + 1);
    }
    for (var i = 0; i < data['D6']; i++) {
      d6.add(random.nextInt(6) + 1);
    }
    for (var i = 0; i < data['D8']; i++) {
      d8.add(random.nextInt(8) + 1);
    }
    for (var i = 0; i < data['D12']; i++) {
      d12.add(random.nextInt(12) + 1);
    }
    for (var i = 0; i < data['D20']; i++) {
      d20.add(random.nextInt(20) + 1);
    }
    for (var i = 0; i < data['D100']; i++) {
      d100.add(random.nextInt(100) + 1);
    }
    sum = (data['D4'] > 0 ? (d4.reduce((a, b) => a + b)) : 0) +
        (data['D6'] > 0 ? (d6.reduce((a, b) => a + b)) : 0) +
        (data['D8'] > 0 ? (d8.reduce((a, b) => a + b)) : 0) +
        (data['D10'] > 0 ? (d10.reduce((a, b) => a + b)) : 0) +
        (data['D12'] > 0 ? (d12.reduce((a, b) => a + b)) : 0) +
        (data['D20'] > 0 ? (d20.reduce((a, b) => a + b)) : 0) +
        (data['D100'] > 0 ? (d100.reduce((a, b) => a + b)) : 0) +
        // (d8.reduce((a, b) => a + b)) +
        // (d10.reduce((a, b) => a + b)) +
        // (d12.reduce((a, b) => a + b)) +
        // (d20.reduce((a, b) => a + b)) +
        // (d100.reduce((a, b) => a + b)) +
        (int.parse(data['Modifier']));
  }

  @override
  Widget build(BuildContext context) {
    var initialRole = random
        .nextInt(int.parse(data['Initial Roll'].split('D')[1].toString()));
    if (data['Type'] != 'Basic') {
      damagePhase();
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: Colors.indigo,
          style: BorderStyle.solid,
          width: 4.0,
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      // title:
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          // height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),

                  gradient: LinearGradient(
                    colors: [Colors.indigo.shade400, Colors.indigo.shade600],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  // borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      packageName,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.indigoAccent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Initial Roll',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customHexagone(text: (initialRole + 1).toString()),
                        const customText(text: '+'),
                        customContainer(text: data['Integer'].toString()),
                        const customText(text: '='),
                        customContainer(
                          text: (initialRole + 1 + int.parse(data['Integer']))
                              .toString(),
                          color: Colors.indigoAccent.shade100,
                          textcolor: Colors.white,
                        ),
                      ],
                    ),
                    // const SizedBox(height: 10),
                    Divider(
                      color: Colors.grey.shade500,
                      thickness: 1.5,
                    ),
                    data['Type'] == 'Basic'
                        ? const Center()
                        : const Text(
                            'Damage Roll',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                    const SizedBox(height: 5),
                    data['Type'] == 'Basic'
                        ? const Center()
                        : Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ...List.generate(d4.length, (index) {
                                return Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      customHexagone(
                                          text: d4[index].toString()),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const customText(text: '+'),
                                    ]);
                              }),
                              ...List.generate(d6.length, (index) {
                                return Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      customHexagone(
                                          text: d6[index].toString()),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const customText(text: '+'),
                                    ]);
                              }),
                              ...List.generate(d8.length, (index) {
                                return Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      customHexagone(
                                          text: d8[index].toString()),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const customText(text: '+'),
                                    ]);
                              }),
                              // const customText(text: '+'),
                              // customHexagone(text: '8'),
                              // const customText(text: '+'),
                              // const Center(),

                              ...List.generate(d10.length, (index) {
                                return Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      customHexagone(
                                          text: d10[index].toString()),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const customText(text: '+'),
                                    ]);
                              }),
                              ...List.generate(d12.length, (index) {
                                return Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      customHexagone(
                                          text: d12[index].toString()),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const customText(text: '+'),
                                    ]);
                              }),
                              ...List.generate(d20.length, (index) {
                                return Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      customHexagone(
                                          text: d20[index].toString()),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const customText(text: '+'),
                                    ]);
                              }),
                              ...List.generate(d100.length, (index) {
                                return Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      customHexagone(
                                          text: d100[index].toString()),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const customText(text: '+'),
                                    ]);
                              }),
                              // customHexagone(
                              //     text: data['D10'].toString() == ''
                              //         ? '1'
                              //         : data['D10'].toString()),
                              // const Center(),
                              // const customText(text: '+'),
                              customContainer(
                                  text: data['Modifier'].toString() == ''
                                      ? '1'
                                      : data['Modifier'].toString()),
                              const SizedBox(
                                width: 5.0,
                              ),
                              const customText(text: '='),
                              customContainer(
                                text: (sum).toString(),
                                color: Colors.indigoAccent.shade100,
                                textcolor: Colors.white,
                              ),
                            ],
                          ),
                    data['Type'] == 'Basic'
                        ? const Center()
                        : Divider(
                            color: Colors.grey.shade500,
                            thickness: 1.5,
                          ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class customText extends StatelessWidget {
  final String text;
  const customText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class customContainer extends StatelessWidget {
  final String text;
  final Color color;
  final Color textcolor;
  const customContainer(
      {super.key,
      required this.text,
      this.color = Colors.transparent,
      this.textcolor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade500,
          width: 2.0,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: textcolor,
          ),
        ),
      ),
    );
  }
}

class customHexagone extends StatelessWidget {
  final String text;
  const customHexagone({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/hexagone.png'))),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
