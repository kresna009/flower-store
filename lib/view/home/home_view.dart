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
        onPressed: () => Get.toNamed('/planList'),
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
                      cardBunga(FlowerCard(
                        'assets/images/orchid.png',
                        "Orchid",
                        "Orchidaceae",
                        "Anggrek,(Orchidaceae) merupakan salah satu keluarga tumbuhan berbunga yang paling beragam dan besar, dengan ribuan spesies yang tersebar di seluruh dunia. Mereka dikenal karena keindahan dan kerumitan bunga mereka. Anggrek memiliki adaptasi yang unik, termasuk beragam bentuk dan warna bunga, serta interaksi yang kompleks dengan hewan penyerbuk, seperti lebah dan kupu-kupu. Selain itu, anggrek memiliki peran penting dalam industri hortikultura dan perdagangan bunga potong. Mereka juga menjadi simbol cinta, keindahan, dan kemewahan dalam banyak budaya, menjadikannya salah satu keluarga tumbuhan paling dihargai di seluruh dunia.",
                        "10k",
                      )),
                      cardBunga(FlowerCard(
                        'assets/images/rose.png',
                        "Rose",
                        "Rosa multiflora L.",
                        "Bunga yang sangat terkenal dan sering dianggap sebagai simbol cinta dan keindahan. Bunga mawar dikenal dengan berbagai warna, termasuk merah, putih, kuning, pink, dan oranye. Setiap warna mawar memiliki arti simbolisnya sendiri; misalnya, mawar merah sering dikaitkan dengan cinta dan gairah. Mawar juga dikenal dengan aroma harumnya yang khas dan daunnya yang tajam. Mawar umumnya digunakan dalam pengaturan bunga potong, parfum, dan pengobatan tradisional. Mawar juga sering ditanam sebagai tanaman hias di taman. Mawar adalah salah satu bunga paling ikonik dan dicintai di seluruh dunia.",
                        "10k",
                      )),
                      cardBunga(FlowerCard(
                        'assets/images/sunflower.png',
                        "Sunflower",
                        "Helianthus A L",
                        "Bunga yang dikenal dengan ciri khasnya yaitu kepala bunga besar yang mengikuti pergerakan matahari. Bunga matahari memiliki tangkai tinggi dan kepala bunga yang besar, yang terdiri dari petal kuning cerah yang tersusun dalam spiral. Bunga ini adalah simbol kebahagiaan dan kehangatan, serta sering dikaitkan dengan matahari dan keceriaan. Bunga matahari juga memiliki biji besar yang biasanya diambil dan dimakan sebagai camilan atau dihasilkan sebagai minyak biji matahari. Mereka sering ditanam sebagai tanaman hias dan digunakan dalam pengaturan bunga potong. Bunga matahari adalah tanda penghormatan terhadap matahari dan sumber inspirasi bagi banyak seniman dan penyair.",
                        "10k",
                      )),
                      cardBunga(FlowerCard(
                        'assets/images/tulip.png',
                        "Daisy",
                        "Tulipa",
                        "bunga yang terkenal dengan kelopaknya yang berbentuk seperti cawan dan tersedia dalam berbagai warna yang cerah, seperti merah, kuning, oranye, pink, dan ungu. Tulip sering dikaitkan dengan simbol cinta dan keindahan. Mereka berasal dari Asia Tengah dan menjadi salah satu bunga hias paling populer di dunia. Bunga tulip sering dijadikan tanda kebahagiaan dan kesempurnaan, dan mereka sering kali menjadi bagian penting dalam acara pernikahan, perayaan musim semi, dan taman hias. Tulip juga memiliki beberapa varietas yang berbeda, termasuk tulip Darwin yang besar dan berwarna-warni, serta tulip lili dengan bentuk kelopak yang lebih panjang dan ramping.",
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
