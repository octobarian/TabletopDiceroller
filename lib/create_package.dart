import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CreatePackage extends StatefulWidget {
  const CreatePackage({super.key});

  @override
  State<CreatePackage> createState() => _CreatePackageState();
}

class _CreatePackageState extends State<CreatePackage> {
  bool weapon = true;
  bool spell = false;
  bool basic = false;
  bool isLoading = false;
  int d4 = 0;
  int d6 = 0;
  int d8 = 0;
  int d10 = 0;
  int d12 = 0;
  int d20 = 0;
  int d100 = 0;

  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController dice = TextEditingController();
  TextEditingController inte = TextEditingController(text: '0');
  TextEditingController modifier = TextEditingController(text: '0');
  var time = DateTime.now();
  final box = Hive.box('dataBox');
  @override
  void initState() {
    setState(() {
      dice.text = 'D20';
    });
    _bannerAd = createBannerAd()..load();
    super.initState();
  }

  BannerAd? _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
      // ignore: prefer_const_constructors
      request: AdRequest(
        // testDevices: <String>[testDevice],
        nonPersonalizedAds: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.indigo.shade400,
                      Colors.indigo.shade600
                    ])),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width / 2.5,
                          //  color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('New Package',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width / 4.3,
                          //  color: Colors.red,
                          child: SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Image.asset('assets/logo.png')],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text('Package Name',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text('what would you like to call this package?',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                                //  fontWeight: FontWeight.bold
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text('Roll Type',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text('is this an attack and single roll?',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                                //  fontWeight: FontWeight.bold
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              weapon = true;
                              spell = false;
                              basic = false;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: weapon
                                    ? Colors.indigo.shade500
                                    : Colors.indigo.shade50),
                            child: Center(
                              child: Text('Weapon Attack',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color:
                                          weapon ? Colors.white : Colors.black,

                                      fontSize: 12,

                                      //   fontWeight: FontWeight.bold
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              weapon = false;
                              spell = true;
                              basic = false;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: spell
                                    ? Colors.indigo.shade500
                                    : Colors.indigo.shade50),
                            child: Center(
                              child: Text('Spell Attack',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color:
                                          spell ? Colors.white : Colors.black,

                                      fontSize: 12,

                                      //   fontWeight: FontWeight.bold
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              weapon = false;
                              spell = false;
                              basic = true;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: basic
                                    ? Colors.indigo.shade500
                                    : Colors.indigo.shade50),
                            child: Center(
                              child: Text('Basic Roll',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color:
                                          basic ? Colors.white : Colors.black,

                                      fontSize: 12,

                                      //   fontWeight: FontWeight.bold
                                    ),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text('Initial Roll',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text('roll a single dice and add/subtract a modifier?',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                                //  fontWeight: FontWeight.bold
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 150,
                          child: TextFormField(
                            readOnly: true,
                            controller: dice,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              suffixIcon: PopupMenuButton(
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            dice.text = 'D4';
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'D4',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          //   fontWeight:FontWeight.bold,
                                                          fontSize: 16)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            dice.text = 'D6';
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'D6',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          //   fontWeight:FontWeight.bold,
                                                          fontSize: 16)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            dice.text = 'D8';
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'D8',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          //   fontWeight:FontWeight.bold,
                                                          fontSize: 16)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            dice.text = 'D10';
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'D10',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          //   fontWeight:FontWeight.bold,
                                                          fontSize: 16)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            dice.text = 'D12';
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Row(
                                            children: [
                                              Text(
                                                'D12',
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        color: Colors
                                                            .grey.shade800,
                                                        // fontWeight:FontWeight.bold,
                                                        fontSize: 16)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            dice.text = 'D20';
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Row(
                                            children: [
                                              Text(
                                                'D20',
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        color: Colors
                                                            .grey.shade800,
                                                        //   fontWeight:FontWeight.bold,
                                                        fontSize: 16)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            dice.text = 'D100';
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Row(
                                            children: [
                                              Text(
                                                'D100',
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        color: Colors
                                                            .grey.shade800,
                                                        // fontWeight:FontWeight.bold,
                                                        fontSize: 16)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          '+',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade800,
                                  // fontWeight:FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 45,
                          width: 100,
                          child: TextFormField(
                            // readOnly: true,
                            controller: inte,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  weapon || spell
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text('Damage Roll',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        )
                      : Container(),
                  weapon || spell
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                  'choose the amount of each line to roll and sum',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 11,
                                      //  fontWeight: FontWeight.bold
                                    ),
                                  )),
                            ],
                          ),
                        )
                      : Container(),
                  weapon || spell
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        )
                      : Container(),
                  weapon || spell
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade500)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('D4',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            )),
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.indigo),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d4--;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade500)),
                                              child: Center(
                                                child: Text(d4.toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo.shade500,
                                                  shape: BoxShape.circle),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d4++;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade500)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('D6',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            )),
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.indigo),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d6--;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade500)),
                                              child: Center(
                                                child: Text(d6.toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo.shade500,
                                                  shape: BoxShape.circle),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d6++;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        )
                      : Container(),
                  weapon || spell
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        )
                      : Container(),
                  weapon || spell
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade500)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('D8',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            )),
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.indigo),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d8--;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade500)),
                                              child: Center(
                                                child: Text(d8.toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo.shade500,
                                                  shape: BoxShape.circle),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d8++;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade500)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('D10',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            )),
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.indigo),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d10--;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade500)),
                                              child: Center(
                                                child: Text(d10.toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo.shade500,
                                                  shape: BoxShape.circle),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d10++;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        )
                      : Container(),
                  weapon || spell
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        )
                      : Container(),
                  weapon || spell
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade500)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('D12',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            )),
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.indigo),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d12--;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade500)),
                                              child: Center(
                                                child: Text(d12.toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo.shade500,
                                                  shape: BoxShape.circle),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d12++;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade500)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('D20',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            )),
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.indigo),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d20--;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade500)),
                                              child: Center(
                                                child: Text(d20.toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo.shade500,
                                                  shape: BoxShape.circle),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d20++;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        )
                      : Container(),
                  weapon || spell
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        )
                      : Container(),
                  weapon || spell
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade500)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('D100',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            )),
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.indigo),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d100--;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade500)),
                                              child: Center(
                                                child: Text(d100.toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo.shade500,
                                                  shape: BoxShape.circle),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      d100++;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.shade500)),
                                child: TextFormField(
                                  controller: modifier,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Modifier',
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 14)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  weapon || spell
                      ? const SizedBox(
                          height: 20,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  weapon || spell
                      ? Divider(
                          color: Colors.grey.shade400,
                        )
                      : Container(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text('Cancel',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            // setState(() {
                            //   isLoading = true;
                            // });
                            await box.put(
                                '${time.second}${time.minute}${time.hour}${time.day}${time.month}${time.year}',
                                // box.keys.length + 1,
                                {
                                  'Name': name.text,
                                  'Type': weapon
                                      ? 'Weapon'
                                      : spell
                                          ? 'Spell'
                                          : basic
                                              ? 'Basic'
                                              : '',
                                  'Initial Roll': dice.text,
                                  'Integer': inte.text == '0' ? '0' : inte.text,
                                  'ID':
                                      '${time.second}${time.minute}${time.hour}${time.day}${time.month}${time.year}',
                                  'D4': d4 > 0 ? d4 : 0,
                                  'D6': d6 > 0 ? d6 : 0,
                                  'D8': d8 > 0 ? d8 : 0,
                                  'D10': d10 > 0 ? d10 : 0,
                                  'D12': d12 > 0 ? d12 : 0,
                                  'D20': d20 > 0 ? d20 : 0,
                                  'D100': d100 > 0 ? d100 : 0,
                                  'Modifier': modifier.text != '0'
                                      ? modifier.text
                                      : '0',
                                }).then((value) {
                              Fluttertoast.showToast(msg: 'Package saved');
                              Navigator.pop(context);
                            });
                            // await FirebaseFirestore.instance
                            //     .collection('AllPackages')
                            //     .doc('All')
                            //     .collection('All')
                            //     .doc('${time.second}${time.minute}${time.hour}${time.day}${time.month}${time.year}')
                            //     .set(
                            //       {
                            //   'Name': name.text,
                            //   'Type': weapon
                            //       ? 'Weapon'
                            //       : spell
                            //           ? 'Spell'
                            //           : basic
                            //               ? 'Basic'
                            //               : '',
                            //   'Initial Roll': dice.text,
                            //   'Integer': inte.text,
                            //   'ID': '${time.second}${time.minute}${time.hour}${time.day}${time.month}${time.year}',
                            //   'D4': d4 > 0 ? d4 : '',
                            //   'D6': d6 > 0 ? d6 : '',
                            //   'D8': d8 > 0 ? d8 : '',
                            //   'D10': d10 > 0 ? d10 : '',
                            //   'D12': d12 > 0 ? d12 : '',
                            //   'D20': d20 > 0 ? d20 : '',
                            //   'D100': d100 > 0 ? d100 : '',
                            // }).whenComplete(() {
                            //   Fluttertoast.showToast(msg: 'Package saved');
                            //   Navigator.of(context).pop();
                            // });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade500,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text('Save',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    // color: Colors.grey.withOpacity(0.6),
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    alignment: Alignment.center,
                    child: AdWidget(ad: _bannerAd!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
    );
  }
}
