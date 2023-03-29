import 'package:animations/animations.dart';
import 'package:dice/ad_helper.dart';
import 'package:dice/alert_dialog.dart';
import 'package:dice/create_package.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;
  // final box = Hive.box('myBox');

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
  void initState() {
    super.initState();
    // MobileAds.instance.initialize();
    _bannerAd = createBannerAd()..load();
  }

  @override
  void dispose() {
    _bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(seconds: 1),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                animation =
                    CurvedAnimation(parent: animation, curve: Curves.linear);
                return SharedAxisTransition(
                    child: child,
                    animation: animation,
                    secondaryAnimation: secAnimation,
                    transitionType: SharedAxisTransitionType.horizontal);
              },
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secAnimation) {
                return const CreatePackage();
              }));
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.indigo.shade500,
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
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
                                child: Text('Your Armory',
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
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ValueListenableBuilder(
                        // stream: FirebaseFirestore.instance
                        //     .collection('AllPackages')
                        //     .doc('All')
                        //     .collection('All')
                        //     .snapshots(),
                        valueListenable: Hive.box('dataBox').listenable(),
                        builder: (BuildContext context, box, _) {
                          _bannerAd = createBannerAd()..load();

                          if (box.isNotEmpty) {
                            return ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: Colors.black54,
                                  );
                                },
                                itemCount: box.values.length + 1,
                                itemBuilder: (context, index) {
                                  return index != box.values.length
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: ListTile(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return MyAlertDialog(
                                                    data: box.getAt(index),
                                                    packageName: box
                                                        .getAt(index)['Name'],
                                                  );
                                                },
                                              );
                                            },
                                            trailing: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                await box
                                                    .deleteAt(index)
                                                    .then((value) {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                });
                                                // await FirebaseFirestore.instance
                                                //     .collection('AllPackages')
                                                //     .doc('All')
                                                //     .collection('All')
                                                //     .doc(box.getAt(index)['ID'])
                                                //     .delete()
                                                //     .whenComplete(() {
                                                //   setState(() {
                                                //     isLoading = false;
                                                //   });
                                                // });
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  height: 25,
                                                  width: 25,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Image.asset(
                                                      'assets/del.png',
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ),
                                            leading: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Image.asset(box.getAt(
                                                          index)['Type'] ==
                                                      'Weapon'
                                                  ? 'assets/swords.png'
                                                  : box.getAt(index)['Type'] ==
                                                          'Spell'
                                                      ? 'assets/fire.png'
                                                      : box.getAt(index)[
                                                                  'Type'] ==
                                                              'Basic'
                                                          ? 'assets/dice.png'
                                                          : ''),
                                            ),
                                            title: Text(
                                                box.getAt(index)['Name'],
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18))),
                                          ),
                                        )
                                      : Container(
                                          // color: Colors.grey.withOpacity(0.6),
                                          width:
                                              _bannerAd!.size.width.toDouble(),
                                          height:
                                              _bannerAd!.size.height.toDouble(),
                                          alignment: Alignment.center,
                                          child: AdWidget(ad: _bannerAd!),
                                        );
                                });
                          }
                          return const Center(
                              child: Text(
                            'No Package available',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ));
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
