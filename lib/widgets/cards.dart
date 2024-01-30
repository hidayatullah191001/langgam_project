part of 'widgets.dart';

class LayananCard extends StatefulWidget {
  final int index;
  final String imagePath;
  final String titleLayanan;
  final String descriptionLayanan;

  LayananCard({
    required this.index,
    required this.imagePath,
    required this.titleLayanan,
    required this.descriptionLayanan,
  });

  @override
  _LayananCardState createState() => _LayananCardState();
}

class _LayananCardState extends State<LayananCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: Container(
        width: 260,
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: isHovered ? 0.0 : -15.0,
              bottom: isHovered ? 0.0 : -15.0,
              left: isHovered ? 0.0 : -15.0,
              right: isHovered ? 0.0 : -15.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isHovered ? 0.5 : 0.0,
              child: Container(
                color: Colors.black,
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.titleLayanan,
                      style: AppTheme.blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: AppTheme.semiBold,
                      ),
                    ),
                  ),
                  isHovered
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 12,
                        )
                      : AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 0,
                        ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: Text(
                      widget.descriptionLayanan,
                      style: AppTheme.whiteTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}

class LayananPopulerCard extends StatefulWidget {
  final dynamic data;
  const LayananPopulerCard({Key? key, this.data}) : super(key: key);

  @override
  State<LayananPopulerCard> createState() => _LayananPopulerCardState();
}

class _LayananPopulerCardState extends State<LayananPopulerCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: 300,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    widget.data['gambar']['data']['attributes']['url']
                        .toString(),
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 0.5 : 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child:
                                    ModalInformationCart(context, widget.data),
                              );
                            },
                          );
                        }, // Button add item to cart
                        child: Container(
                          width: 50,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.whiteColor, width: 2),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.cartShopping,
                            color: AppColors.whiteColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Text(
                widget.data['judul'],
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppMethods.currency(widget.data['harga'].toString()),
                  style: AppTheme.primaryTextStyle.copyWith(
                    fontWeight: AppTheme.semiBold,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.data['satuan'].toString(),
                  style: AppTheme.greyTextStyle.copyWith(
                    fontWeight: AppTheme.medium,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget ModalInformationCart(BuildContext context, dynamic data) {
    final controller = context.watch<CartController>();
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                        '${Constant.host}${data['gambar']['data']['attributes']['url']}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data['judul'],
                    style: AppTheme.blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: AppTheme.medium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.remover();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.primaryColor,
                            size: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        color: Colors.blue.withOpacity(0.1),
                        child: Text(
                          controller.itemsCount.toString(),
                          style: AppTheme.blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: AppTheme.medium,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.add();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.primaryColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Harga', style: AppTheme.blackTextStyle),
              Text(
                AppMethods.currency(controller.total(data['harga']).toString()),
                style: AppTheme.primaryTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomFormUser(title: 'Provinsi'),
          const SizedBox(
            height: 10,
          ),
          CustomFormUser(title: 'Kota'),
          const SizedBox(
            height: 10,
          ),
          CustomFormUser(title: 'Kecamatan'),
          const SizedBox(
            height: 12,
          ),
          PrimaryButton(
            onTap: () {
              final productItem = {
                'product': {
                  'judul': data['judul'],
                  'harga': data['harga'],
                  'satuan': data['satuan'],
                  'gambar': data['gambar']['data']['attributes']['url'],
                },
                'provinsi': 'Jakarta',
                'Kota': 'Jakarta Timur',
                'Kecamatan': 'Pulo Gadung',
                'item': controller.itemsCount.toString(),
                'totalHarga': controller.totalHarga.toString(),
              };
              print(productItem);
              controller.addToCart(productItem);
              CoolAlert.show(
                context: context,
                width: MediaQuery.of(context).size.width * 0.3,
                type: CoolAlertType.success,
                text: 'Product berhadil ditambahkan kedalam keranjang',
              );

              print(controller.carts);
            },
            titleButton: 'Tambahkan Ke Keranjang',
          ),
        ],
      ),
    );
  }

  void _handleHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}

class UpdateCard extends StatelessWidget {
  const UpdateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.18,
      height: MediaQuery.of(context).size.width * 0.22,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
              image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ2kxB8JDD63E_xsfOFEje7eWSkvri0295El8holhZGkwJxB4KDIuG8M6LrJhquZEleys&usqp=CAU'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 18,
              ),
              child: Text(
                'Gempa Berkekuatan 6.5 Skala Richter Guncang Selatan Jawa ',
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                  fontSize: 18,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemLayananCardList extends StatelessWidget {
  final LayananModel data;
  final String id;
  const ItemLayananCardList({
    super.key,
    required this.data,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${Constant.host}${data.gambar}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButtonHovered(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/layanan/detail',
                          arguments: id,
                        );
                      },
                      text: data.judul.toString(),
                      styleBeforeHovered: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                      ),
                      styleHovered: AppTheme.greyTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppMethods.currency(data.harga.toString()),
                          style: AppTheme.primaryTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          data.satuan != null
                              ? data.satuan.toString()
                              : '/ hari',
                          style: AppTheme.greyTextStyle.copyWith(
                            fontWeight: AppTheme.medium,
                            fontSize: 18,
                            color: AppColors.softgreyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.intro.toString(),
                      style: AppTheme.greyTextStyle.copyWith(
                        fontWeight: AppTheme.medium,
                        height: 1.5,
                      ),
                    ),
                    PrimaryButton(
                      onTap: () {},
                      titleButton: 'TAMBAH KE KERANJANG',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
