import 'dart:convert';

import 'package:crypto/Model/chartModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class SelectCoin extends StatefulWidget {
  var selectItem;
  SelectCoin({this.selectItem});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  late TrackballBehavior trackballBehavior;
  @override
  void initState() {
    getChart();
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: myWidth * 0.05,
                  vertical: myHeight * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: myHeight * 0.09,
                            child: Image.network(widget.selectItem.image)),
                        SizedBox(
                          width: myWidth * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectItem.id,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: myHeight * 0.003,
                            ),
                            Text(
                              widget.selectItem.symbol,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$' + widget.selectItem.currentPrice.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: myHeight * 0.01,
                        ),
                        Text(
                          widget.selectItem.marketCapChangePercentage24H
                                  .toString() +
                              '%',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: widget.selectItem
                                          .marketCapChangePercentage24H >=
                                      0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                  child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.05,
                      vertical: myHeight * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Low',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              '\$' + widget.selectItem.low24H.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'High',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              '\$' + widget.selectItem.high24H.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Vol',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              '\$' +
                                  widget.selectItem.totalVolume.toString() +
                                  'M',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.02,
                  ),
                  Container(
                    height: myHeight * 0.48,
                    width: myWidth,
                    //color: Colors.amber,
                    child: isRefresh == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 239, 195, 18),
                            ),
                          )
                        : SfCartesianChart(
                            trackballBehavior: trackballBehavior,
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePanning: true,
                              zoomMode: ZoomMode.x,
                            ),
                            series: <CandleSeries>[
                              CandleSeries<ChartModel, int>(
                                enableSolidCandles: true,
                                enableTooltip: true,
                                bullColor: Colors.green,
                                bearColor: Colors.red,
                                dataSource: itemChart!,
                                xValueMapper: (ChartModel sales, _) =>
                                    sales.time,
                                lowValueMapper: (ChartModel sales, _) =>
                                    sales.low,
                                highValueMapper: (ChartModel sales, _) =>
                                    sales.high,
                                openValueMapper: (ChartModel sales, _) =>
                                    sales.open,
                                closeValueMapper: (ChartModel sales, _) =>
                                    sales.close,
                                animationDuration: 55,
                              )
                            ],
                          ),
                  ),
                  SizedBox(
                    height: myHeight * 0.018,
                  ),
                  Center(
                    child: Container(
                      height: myHeight * 0.04,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: text.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: myWidth * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    textBool = [
                                      false,
                                      false,
                                      false,
                                      false,
                                      false,
                                      false
                                    ];
                                    textBool[index] = true;
                                  });
                                  setDays(text[index]);
                                  getChart();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: myWidth * 0.03,
                                    vertical: myHeight * 0.005,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: textBool[index] == true
                                        ? Color.fromARGB(255, 239, 195, 18)
                                            .withOpacity(0.5)
                                        : Colors.transparent.withOpacity(0.3),
                                  ),
                                  child: Text(
                                    text[index],
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              )),
              Container(
                height: myHeight * 0.14,
                width: myWidth,
                //color: Colors.amber,
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: myHeight * 0.022,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: myWidth * 0.05,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: myWidth * 0.05,
                              vertical: myHeight * 0.01,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color.fromARGB(255, 239, 195, 18),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: myHeight * 0.033,
                                ),
                                Text(
                                  'Add to portfolio',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: myWidth * 0.05,
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: myWidth * 0.05,
                                  vertical: myWidth * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              child: Image.asset(
                                'assets/icons/3.1.png',
                                height: myHeight * 0.05,
                                color: Colors.black,
                              ),
                            )),
                        SizedBox(
                          width: myWidth * 0.05,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [false, true, false, false, false, false];

  int days = 30;
  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;

  bool isRefresh = true;
  Future<void> getChart() async {
    String url = 'https://api.coingecko.com/api/v3/coins/' +
        widget.selectItem.id +
        '/ohlc?vs_currency=usd&days=' +
        days.toString();

    setState(() {
      isRefresh = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefresh = false;
    });

    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
