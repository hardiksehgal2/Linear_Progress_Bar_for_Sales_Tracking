import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'JSON/BonnApi.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BonnApi> postList = [];
  List<BonnApi> filteredList = []; // List to hold the filtered items
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call getApi() only once when the widget is initialized
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('http://b6.bonn.in:10240/api/Target'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(BonnApi.fromJson(i));
      }
      _runFilter(searchController.text); // Update filteredList after fetching data
    } else {
      // Handle error
    }
  }

  void _runFilter(String enterKeyWord) {
    List<BonnApi> result = [];
    if (enterKeyWord.isEmpty) {
      result = List.from(postList); // Reset result to the full list if search bar is empty
    } else {
      // Filter the list based on the entered keyword
      result = postList.where((e) => e.parameterName!.toLowerCase().contains(enterKeyWord.toLowerCase())).toList();
    }
    setState(() {
      filteredList = result; // Update the filteredList with the filtered data
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bonn API'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // Search Bar
          TextFormField(
            controller: searchController,
            onChanged: (value) => _runFilter(value),
            decoration:const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ).px16(),
          const SizedBox(height: 15),
          Expanded(
            child: filteredList.isEmpty
                ? Center(child: CircularProgressIndicator()) // Show loading indicator while data is being fetched
                : ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                double progress = (filteredList[index].parameterValues!.actualValue!.toDouble() -
                    filteredList[index].parameterValues!.minValue!.toDouble()) /
                    (filteredList[index].parameterValues!.maxValue!.toDouble() -
                        filteredList[index].parameterValues!.minValue!.toDouble());
                String progressPercentage = (progress * 100).toStringAsFixed(1);

                return ListTile(
                  title: Text(filteredList[index].parameterName.toString()),
                  subtitle: Card(
                    elevation: 0.0,
                    color: Colors.white70,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 14,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(_getProgressColor(progress)),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied_sharp,
                              color: Colors.red,
                            ).px8(),
                            Expanded(
                              child: "${filteredList[index].parameterValues!.actualValue!.toString()}/${filteredList[index].parameterValues!.maxValue!.toString()}".text.black.make(),
                            ),
                            SizedBox(width: 8),
                            "${progressPercentage}%".text.black.lg.end.make(),
                            Icon(
                              Icons.sentiment_satisfied_alt_sharp,
                              color: Colors.green,
                            )..px8(),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Color _getProgressColor(double progress) {
  if (progress < 0.3) {
    return Colors.red;
  } else if (progress >= 0.3 && progress < 0.65) {
    return Colors.yellow;
  } else {
    return Colors.green;
  }
}
