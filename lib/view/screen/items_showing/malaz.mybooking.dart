
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBookingsWidget extends StatefulWidget {
  const MyBookingsWidget({super.key});


  @override
  State<MyBookingsWidget> createState() => _MyBookingsWidgetState();
}

class _MyBookingsWidgetState extends State<MyBookingsWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final dummyTrips = [
    {
      'propertyImage': 'Assets/images/CoustomLogo.png',
      'propertyAddress': '123 Beach Road, Miami',
      'tripBeginDate': DateTime(2025, 7, 25),
      'tripEndDate': DateTime(2025, 7, 30),
      'tripTotal': 350.0,
      'isUpcoming': true,
    },
    {
      'propertyImage': 'Assets/images/CoustomLogo.png',
      'propertyAddress': '456 Mountain View, Colorado',
      'tripBeginDate': DateTime(2025, 6, 10),
      'tripEndDate': DateTime(2025, 6, 15),
      'tripTotal': 500.0,
      'isUpcoming': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Bookings'),
        leading: BackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.teal,
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTripsList(upcoming: true),
                _buildTripsList(upcoming: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsList({required bool upcoming}) {
    final trips = dummyTrips.where((trip) => trip['isUpcoming'] == upcoming).toList();

    if (trips.isEmpty) {
      return Center(child: Text('No trips found'));
    }

    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return _TripCard(trip: trip);
      },
    );
  }
}

class _TripCard extends StatelessWidget {
  final Map<String, dynamic> trip;

  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              trip['propertyImage'],
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${DateFormat("MMMEd").format(trip['tripBeginDate'])} - ${DateFormat("MMMEd").format(trip['tripEndDate'])}",
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(trip['propertyAddress'])),
                    Text('\$${trip['tripTotal']}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
