import 'package:flutter/material.dart';
import './theme/app_colors.dart';

class ClientIndividualsScreen extends StatefulWidget {
  final String clientName;
  const ClientIndividualsScreen({Key? key, required this.clientName})
      : super(key: key);

  @override
  _ClientIndividualsScreenState createState() =>
      _ClientIndividualsScreenState();
}

class _ClientIndividualsScreenState extends State<ClientIndividualsScreen> {
  // Replace this list with your actual data source for individuals
  final List<String> allIndividuals = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
    'Frank',
    'Grace',
    'Heidi',
    'Ivan',
    'Judy'
  ];

  List<String> filteredIndividuals = [];
  String selectedFilter = 'All';
  final List<String> filterOptions = ['All', 'A–M', 'N–Z'];

  @override
  void initState() {
    super.initState();
    // Initially, show all individuals.
    filteredIndividuals = allIndividuals;
  }

  void filterIndividuals(String query) {
    List<String> temp = allIndividuals.where((individual) {
      // Check if the individual name contains the search query.
      final matchesSearch =
          individual.toLowerCase().contains(query.toLowerCase());

      // Check filter based on the first letter of the individual's name.
      final firstLetter = individual[0].toUpperCase();
      final matchesFilter = selectedFilter == 'All' ||
          (selectedFilter == 'A–M' && firstLetter.compareTo('N') < 0) ||
          (selectedFilter == 'N–Z' && firstLetter.compareTo('N') >= 0);

      return matchesSearch && matchesFilter;
    }).toList();

    setState(() {
      filteredIndividuals = temp;
    });
  }

  void updateFilter(String? newFilter) {
    if (newFilter == null) return;
    setState(() {
      selectedFilter = newFilter;
    });
    // Reapply filter with the current search text (if any).
    filterIndividuals('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.clientName} - Individuals'),
      ),
      body: Column(
        children: [
          // Search bar and filter dropdown row.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Search bar.
                Expanded(
                  flex: 2,
                  child: TextField(
                    onChanged: filterIndividuals,
                    decoration: InputDecoration(
                      hintText: 'Search individuals...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Filter dropdown.
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
          // Display filtered list of individuals.
          Expanded(
            child: filteredIndividuals.isEmpty
                ? const Center(child: Text('No individuals found'))
                : ListView.builder(
                    itemCount: filteredIndividuals.length,
                    itemBuilder: (context, index) {
                      final individual = filteredIndividuals[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            individual,
                            style: const TextStyle(fontSize: 16),
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
