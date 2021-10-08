import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_app/blocs/getImage/getimage_cubit.dart';
import 'package:demo_app/model/image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = [
    "business",
    "popularity",
    "techcrunch",
    "Cars",
    "Space",
    "Boooks",
  ];
  int index = 0;
  void changeIndex(int val) {
    index = val;
    setState(() {});
  }

  int filterindex = 0;
  void changeFilterIndex(int val) {
    filterindex = val;
    // context.read<GetimageCubit>().getData(filters[index]);
    setState(() {});
  }

  @override
  void initState() {
    context.read<GetimageCubit>().getData(filters[index]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {},
          child: const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: bottombar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // appBar: AppBar(),
        body: Builder(builder: (context) {
          return BlocBuilder<GetimageCubit, GetimageState>(
            builder: (context, state) {
              if (state is GetimageSuccess) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        header(),
                        const SizedBox(
                          height: 10,
                        ),
                        optionChips(),
                        const SizedBox(
                          height: 10,
                        ),
                        productFilter(),
                        const SizedBox(
                          height: 20,
                        ),
                        if (state.images == null || state.images!.isEmpty)
                          const Center(
                            child: Text("Nothing to dsiply"),
                          ),
                        if (state.images != null &&
                            state.images!.isNotEmpty) ...[
                          GridView.count(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 8.0,
                              children:
                                  List.generate(state.images!.length, (index) {
                                return Center(
                                  child: ItemCard(image: state.images![index]),
                                );
                              }))
                        ],
                      ],
                    ),
                  ),
                );
              }
              if (state is GetimageFailure) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text("Loading error"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<GetimageCubit>().getData(filters[index]);
                        },
                        child: const Text("Retry"))
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }));
  }

  bottombar() => BottomAppBar(
        elevation: 2,
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                iconSize: 30,
                padding: const EdgeInsets.only(left: 0),
                icon: Icon(
                  Icons.home,
                  color: (index == 0) ? Colors.black : Colors.grey,
                ),
                onPressed: () {
                  changeIndex(0);
                },
              ),
              IconButton(
                iconSize: 30,
                padding: const EdgeInsets.only(right: 0),
                icon: Icon(
                  Icons.search,
                  color: (index == 1) ? Colors.black : Colors.grey,
                ),
                onPressed: () {
                  changeIndex(1);
                },
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                iconSize: 30,
                padding: const EdgeInsets.only(left: 0),
                icon: Icon(
                  Icons.settings_outlined,
                  color: (index == 2) ? Colors.black : Colors.grey,
                ),
                onPressed: () {
                  changeIndex(2);
                },
              ),
              IconButton(
                iconSize: 30,
                padding: const EdgeInsets.only(right: 0),
                icon: Icon(
                  Icons.person_pin_circle_outlined,
                  color: (index == 3) ? Colors.black : Colors.grey,
                ),
                onPressed: () {
                  changeIndex(3);
                },
              ),
            ],
          ),
        ),
        color: Colors.white70,
      );

  Widget header() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Top Rated",
            style: TextStyle(
                fontSize: size.width * .08, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.format_align_right,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget optionChips() => SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              changeFilterIndex(index);
            },
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: filterindex == index
                        ? Colors.black
                        : Colors.grey.withOpacity(.05)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_alarm,
                        color:
                            filterindex != index ? Colors.black : Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        filters[index],
                        style: TextStyle(
                            color: filterindex != index
                                ? Colors.black
                                : Colors.white),
                      )
                    ],
                  ),
                )),
          ),
        ),
      );

  Widget productFilter() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "147 products",
            style: TextStyle(fontSize: 10),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              value: "Most popular",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.black),
              items: <String>[
                'Most popular',
                'Recent uploads',
                'Most rating',
                'Pricing'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          )
        ],
      );
}

class ItemCard extends StatelessWidget {
  final ImageModel image;
  const ItemCard({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
          // width: 100,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(.05)),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        color: Colors.amber,
                        width: size.width / 4,
                        // height: size.width / 3.5,
                        child: Image.network(
                          image.urlToImage ??
                              "https://images.pexels.com/photos/1987301/pexels-photo-1987301.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                          fit: BoxFit.fill,
                          // height: size.width / 5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      image.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(TextSpan(
                            text: "\$",
                            children: [
                              TextSpan(
                                  text: "256.00",
                                  style: TextStyle(color: Colors.black))
                            ],
                            style: TextStyle(color: Colors.yellow))),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text("5")
                          ],
                        )
                      ],
                    ),
                  ]))),
    );
  }
}
