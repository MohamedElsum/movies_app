import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetTicketsScreen extends StatefulWidget {
  String? movieTitle;
  String? releaseDate;

  GetTicketsScreen(
      {Key? key, required this.releaseDate, required this.movieTitle})
      : super(key: key);

  @override
  State<GetTicketsScreen> createState() => _GetTicketsScreenState();
}

class _GetTicketsScreenState extends State<GetTicketsScreen> {
  List<Widget> rowofSeats = [];

  void addRow() {
    for (int i = 1; i < 11; i++) {
      rowofSeats.add(Expanded(
        child: Row(
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                i.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              //height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.all(2),
                    color: Colors.blue,
                  );
                },
                itemCount: 26,
              ),
            ),
          ],
        ),
      ));
    }
  }

  @override
  void initState() {
    addRow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Column(
          children: [
            Text(
              widget.movieTitle.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'In Theaters ${widget.releaseDate}',
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            'Screen',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: rowofSeats,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.remove),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 20,
                height: 20,
                color: Colors.yellowAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Selected',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                width: 40,
              ),
              Container(
                width: 20,
                height: 20,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Not Available',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 20,
                height: 20,
                color: Colors.indigo,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'VIP (150\$)',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                width: 23,
              ),
              Container(
                width: 20,
                height: 20,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Regular (50 \$)',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
                child: Row(
                  children: const [
                    Text(
                      '4/3 row',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.close),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                width: 130,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
                child: Column(
                  children: const [
                    Text(
                      'Total Price',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\$ 50',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 170,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: const Text(
                      'Processed to Pay',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
