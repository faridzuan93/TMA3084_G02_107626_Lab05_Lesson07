import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 05 - DataTable',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CarTableScreen(),
    );
  }
}

class CarTableScreen extends StatefulWidget {
  const CarTableScreen({super.key});

  @override
  State<CarTableScreen> createState() => _CarTableScreenState();
}

class _CarTableScreenState extends State<CarTableScreen> {
  final List<Map<String, dynamic>> cars = [
    {'make': 'Toyota', 'model': 'Vios', 'price': 89000},
    {'make': 'Honda', 'model': 'City', 'price': 95000},
    {'make': 'Perodua', 'model': 'Myvi', 'price': 46000},
    {'make': 'Proton', 'model': 'Saga', 'price': 40000},
    {'make': 'BMW', 'model': '320i', 'price': 250000},
    {'make': 'Mercedes-Benz', 'model': 'C200', 'price': 280000},
    {'make': 'Mazda', 'model': 'Mazda 3', 'price': 150000},
    {'make': 'Nissan', 'model': 'Almera', 'price': 85000},
  ];

  String searchQuery = '';

  int? sortColumnIndex;
  bool sortAscending = true;

  void sortCars(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;

      if (columnIndex == 0) {
        cars.sort((a, b) => a['make'].compareTo(b['make']));
      } else if (columnIndex == 1) {
        cars.sort((a, b) => a['model'].compareTo(b['model']));
      } else if (columnIndex == 2) {
        cars.sort((a, b) => a['price'].compareTo(b['price']));
      }

      if (!ascending) {
        cars.sort((a, b) {
          if (columnIndex == 0) {
            return b['make'].compareTo(a['make']);
          } else if (columnIndex == 1) {
            return b['model'].compareTo(a['model']);
          } else {
            return b['price'].compareTo(a['price']);
          }
        });
      }
    });
  }

  List<Map<String, dynamic>> get filteredCars {
    return cars.where((car) {
      final make = car['make'].toString().toLowerCase();
      final model = car['model'].toString().toLowerCase();
      final query = searchQuery.toLowerCase();

      return make.contains(query) || model.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayedCars = filteredCars;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Car List'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search car make or model',
                hintText: 'Enter car make or model',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: displayedCars.isEmpty
                  ? const Center(
                      child: Text(
                        'No cars found.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        sortColumnIndex: sortColumnIndex,
                        sortAscending: sortAscending,
                        columns: [
                          DataColumn(
                            label: const Text('Car Make'),
                            onSort: (columnIndex, ascending) {
                              sortCars(columnIndex, ascending);
                            },
                          ),
                          DataColumn(
                            label: const Text('Model'),
                            onSort: (columnIndex, ascending) {
                              sortCars(columnIndex, ascending);
                            },
                          ),
                          DataColumn(
                            label: const Text('Price (RM)'),
                            numeric: true,
                            onSort: (columnIndex, ascending) {
                              sortCars(columnIndex, ascending);
                            },
                          ),
                        ],
                        rows: displayedCars.map((car) {
                          return DataRow(
                            cells: [
                              DataCell(Text(car['make'])),
                              DataCell(Text(car['model'])),
                              DataCell(Text(car['price'].toString())),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}