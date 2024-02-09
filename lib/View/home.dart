import 'package:crypto/Model/coinModel.dart';
import 'package:crypto/View/Components/item.dart';
import 'package:crypto/View/Components/item2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 242, 179, 6),
            Color.fromARGB(255, 255, 255, 17),
          ],
        )),
        child: Column(
          //ye na yellow dabba n container ko upar neeche rakhta h
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: myWidth * 0.04,
                vertical: myHeight * 0.015,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.02,
                      vertical: myHeight * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Main Portfolio',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Text(
                    'Top 10 coins',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Experimental',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: myWidth * 0.07,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '\$ 4577.56',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(myWidth * 0.015),
                    height: myHeight * 0.05,
                    width: myWidth * 0.1,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5)),
                    child: Image.asset('assets/icons/5.1.png'),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: myWidth * 0.07,
                //vertical: myHeight * .005,
              ),
              child: const Row(
                children: [
                  Text(
                    '+162% all time',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: myHeight * 0.017,
            ),
            Container(
              height: myHeight * 0.75,
              width: myWidth,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.shade100,
                      spreadRadius: 3,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: myHeight * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.08,
                      //vertical: myHeight * .005,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Assets',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  Container(
                    height: myHeight * 0.37,
                    width: myWidth,
                    child: isRefreshing == true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount:
                                10, //link crypto api se market list ka list bnaye h
                            shrinkWrap: true,
                            //physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Item(
                                item: coinMarket![index],
                              );
                            }),
                  ),
                  SizedBox(
                    height: myHeight * 0.013,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.06,
                      //vertical: myHeight * .005,
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Recommend to Buy',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.003,
                  ),
                  Container(
                    height: myHeight * 0.23,
                    child: Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: myWidth * 0.03,
                          //vertical: myHeight * .005,
                        ),
                        child: ListView.builder(
                            itemCount: coinMarket!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Item2(item: coinMarket![index]);
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.002,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isRefreshing = true;

// vhi jo link tha na usse bnaye h list of item and ye list ko init state me daalte h
  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isRefreshing = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });

    setState(() {
      isRefreshing = false;
    });

    if (response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
