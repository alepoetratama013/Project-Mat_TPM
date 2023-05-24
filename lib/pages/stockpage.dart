import 'package:flutter/material.dart';
import 'package:stock_app/models/stock_model.dart';

class Stockpage extends StatefulWidget {
  const Stockpage({Key? key}) : super(key: key);

  @override
  State<Stockpage> createState() => _StockpageState();
}

class _StockpageState extends State<Stockpage> {
  final stockResults = Results();
  Future<List<Results>>? leagueResults;
  @override
  void initState() {
    leagueResults = Results.fetchStocks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Page'),
      ),
      body: Center(
        child: FutureBuilder(
          future: leagueResults,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(5),
                    child: buildCard(
                      snapshot.data?[index].ticker,
                      snapshot.data?[index].close,
                      snapshot.data?[index].change,
                      "${snapshot.data?[index].percent} %",
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('error : ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildCard(
          String? ticker, String? close, String? change, String? percentage) =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(2),
                  height: 105,
                  width: 180,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ticker ?? "No title",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        close ?? "No title",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        change ?? "no competititon",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        percentage ?? "no competititon",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
