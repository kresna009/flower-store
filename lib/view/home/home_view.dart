import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flower_store/controllers/controller.dart';

class FlowerCard {
  final String image;
  final String name;
  final String scientificName;
  final String description;
  final String price;

  FlowerCard(
      this.image, this.name, this.scientificName, this.description, this.price);
}

class HomeView extends StatelessWidget {
  final FlowerController homeController = Get.put(FlowerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/addImage'),
        child: const Icon(Icons.add_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              // Header...
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.format_list_bulleted_rounded,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(
                height: 30,
              ),

              const Text(
                "Welcome to Griya Flower",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Populer"),
                  Text("Recomended"),
                  Text("Indor"),
                  Text("Outdor"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      cardBunga(
                        FlowerCard(
                          'assets/images/daisy.png',
                          "Daisy",
                          "Bellis perennis",
                          "Bunga daisy, atau yang juga dikenal sebagai bunga matahari, adalah jenis bunga yang populer dan mudah dikenali karena memiliki kepala bunga berbentuk cakram dengan kelopak bunga berwarna putih dan pusat berwarna kuning. Bunga ini biasanya memiliki tangkai yang panjang dan daun berbentuk daun lanset. Bunga daisy sering dianggap sebagai simbol kesucian, kepolosan, dan kebahagiaan. Mereka biasanya tumbuh di berbagai kondisi cuaca dan tanah, membuatnya cocok untuk taman dan pot bunga. Daisy juga dapat digunakan dalam pengaturan bunga segar atau dijadikan hiasan dalam berbagai perayaan dan acara.",
                          "10k",
                        ),
                      ),
                      cardBunga(FlowerCard(
                        'assets/images/lily.png',
                        "Lili",
                        "Lilium",
                        "Bunga lily adalah jenis bunga yang terkenal dengan bentuk kelopaknya yang indah dan aroma harumnya yang khas. Mereka biasanya memiliki tangkai tinggi dengan bunga yang besar dan berbentuk lonceng atau terbuka seperti cangkir. Lily memiliki berbagai variasi warna, termasuk putih, merah, oranye, kuning, dan pink. Bunga ini sering dianggap sebagai simbol keindahan, kemurnian, dan kesuburan. Lily sering digunakan dalam pengaturan bunga potong, taman hias, dan sering kali menjadi elemen penting dalam banyak upacara dan perayaan, termasuk pernikahan dan pemakaman. Beberapa varietas lily juga dianggap beracun bagi hewan peliharaan, sehingga perlu ditempatkan dengan hati-hati di lingkungan di mana hewan dapat mengonsumsinya.",
                        "10k",
                      )),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardBunga(FlowerCard flowerCard) {
  return Container(
    width: FlowerController.i.size.width,
    margin: const EdgeInsets.only(
      bottom: 15,
    ),
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        Positioned(
          left: -10,
          top: 10,
          bottom: -30,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(flowerCard.image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          flowerCard.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "( ${flowerCard.scientificName} )",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        flowerCard.description,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                flowerCard.price,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
