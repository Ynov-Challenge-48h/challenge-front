import 'dart:async';
import 'package:app_challenge_48h/client-infos/client_infos.dart';
import 'package:app_challenge_48h/nav-bar/nav_bar.dart';
import 'package:app_challenge_48h/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ClientListingService {
  Stream<List<String>> getClientNames() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield [
      'Client1',
      'Client2',
      'Client3',
      'Client4',
      'Client5',
      'Client6',
    ];
  }
}

class ClientListScreen extends StatefulWidget {
  ClientListScreen({Key? key}) : super(key: key);

  @override
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  final ClientListingService clientService = ClientListingService();
  List<String> allClients = [];
  List<String> filteredClients = [];
  late StreamSubscription<List<String>> subscription;

  String selectedFilter = 'All';
  final List<String> filterOptions = ['All', 'A–M', 'N–Z'];

  @override
  void initState() {
    super.initState();
    subscription = clientService.getClientNames().listen((data) {
      setState(() {
        allClients = data;
        filteredClients = data;
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void filterClients(String query) {
    List<String> temp = allClients.where((client) {
      final matchesSearch = client.toLowerCase().contains(query.toLowerCase());

      final firstLetter = client[0].toUpperCase();
      final matchesFilter = selectedFilter == 'All' ||
          (selectedFilter == 'A–M' && firstLetter.compareTo('N') < 0) ||
          (selectedFilter == 'N–Z' && firstLetter.compareTo('N') >= 0);

      return matchesSearch && matchesFilter;
    }).toList();

    setState(() {
      filteredClients = temp;
    });
  }

  void updateFilter(String? newFilter) {
    if (newFilter == null) return;
    setState(() {
      selectedFilter = newFilter;
    });
    filterClients(''); // Re-apply filter with current search
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
      ),
      body: Column(
        children: [
          // Search bar + dropdown filter in a row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Search bar
                Expanded(
                  flex: 2,
                  child: TextField(
                    onChanged: filterClients,
                    decoration: InputDecoration(
                      hintText: 'Search clients...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Filter dropdown
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: selectedFilter,
                    onChanged: updateFilter,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 14),
                    ),
                    items: filterOptions
                        .map((filter) =>
                            DropdownMenuItem(value: filter, child: Text(filter)))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          // List of clients
          Expanded(
            child: allClients.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : filteredClients.isEmpty
                    ? const Center(child: Text('No clients found'))
                    : ListView.builder(
                        itemCount: filteredClients.length,
                        itemBuilder: (context, index) {
                          final client = filteredClients[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    client,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ClientDetailScreen(
                                                  clientName: client),
                                        ),
                                      );
                                    },
                                    child: const Text('View'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ClientInfoPage()),
                                      );
                                    },
                                    child: const Text('get clients infos'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          )
        ],
      ),
      bottomNavigationBar: Navbar(),
      backgroundColor: AppColors.whiteBg,
    );
  }
}

class ClientDetailScreen extends StatelessWidget {
  final String clientName;
  const ClientDetailScreen({Key? key, required this.clientName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(clientName)),
      body: Center(
        child: Text(
          'Details for $clientName',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
