part of '../pages.dart';

class DashboardAdminSection extends StatefulWidget {
  const DashboardAdminSection({Key? key}) : super(key: key);

  @override
  State<DashboardAdminSection> createState() => _DashboardAdminSectionState();
}

class _DashboardAdminSectionState extends State<DashboardAdminSection> {
  List<Map<String, dynamic>> dummyData = [
    {
      'ID': 1,
      'First name': 'John',
      'Last name': 'Doe',
      'Maiden name': '',
      'Age': 30,
      'Gender': 'Male',
      'Email': 'john.doe@example.com',
    },
    {
      'ID': 2,
      'First name': 'Jane',
      'Last name': 'Smith',
      'Maiden name': 'Doe',
      'Age': 25,
      'Gender': 'Female',
      'Email': 'jane.smith@example.com',
    },
    // Tambahkan data lainnya di sini sesuai kebutuhan Anda
  ];

  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;

  bool _isLoading = true;

  void setLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    fetch();
  }

  void fetch() async {
    createDataSource();

    setLoading();
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "First name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Last name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Maiden name", columnFlex: 2),
      ExpandableColumn<int>(columnTitle: "Age", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Gender", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Email", columnFlex: 4),
    ];

    rows = dummyData.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<int>(columnTitle: "ID", value: e['ID']),
        ExpandableCell<String>(
            columnTitle: "First name", value: e["First name"]),
        ExpandableCell<String>(columnTitle: "Last name", value: e['Last name']),
        ExpandableCell<String>(
            columnTitle: "Maiden name", value: e['Maiden name']),
        ExpandableCell<int>(columnTitle: "Age", value: e['Age']),
        ExpandableCell<String>(columnTitle: "Gender", value: e['Gender']),
        ExpandableCell<String>(columnTitle: "Email", value: e['Email']),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !_isLoading
          ? LayoutBuilder(builder: (context, constraints) {
              int visibleCount = 3;
              if (constraints.maxWidth < 600) {
                visibleCount = 1;
              } else if (constraints.maxWidth < 800) {
                visibleCount = 2;
              } else if (constraints.maxWidth < 1000) {
                visibleCount = 3;
              } else {
                visibleCount = 3;
              }

              return GridView.count(
                crossAxisCount: visibleCount,
                children: List.generate(6, (index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 100,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor3,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#8954798',
                              style: AppTheme.primaryTextStyle
                                  .copyWith(fontWeight: AppTheme.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor2,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Menunggu Persetujuan',
                                style: AppTheme.blackTextStyle
                                    .copyWith(fontWeight: AppTheme.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hidayatullah Dayat',
                          style: AppTheme.blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: AppTheme.medium),
                        ),
                        Text(
                          'Dibuat pada 8 Feb 2024',
                          style: AppTheme.blackTextStyle.copyWith(fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Buku Hilal',
                            style: AppTheme.primaryTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                            children: [
                              TextSpan(
                                  text: ' x 3 = ',
                                  style: AppTheme.softgreyTextStyle),
                              TextSpan(
                                  text: '${AppMethods.currency('1200000')}',
                                  style: AppTheme.softgreyTextStyle),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        PrimaryButton(
                          onTap: () {},
                          titleButton: 'Lihat pesanan',
                          fontSize: 14,
                        ),
                      ],
                    ),
                  );
                }),
              );
            })
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildEditDialog(
      ExpandableRow row, Function(ExpandableRow) onSuccess) {
    return AlertDialog(
      title: SizedBox(
        height: 300,
        child: TextButton(
          child: const Text("Change name"),
          onPressed: () {
            row.cells[1].value = "x3";
            onSuccess(row);
          },
        ),
      ),
    );
  }
}
