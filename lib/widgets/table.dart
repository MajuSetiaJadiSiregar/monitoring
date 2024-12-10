part of 'widgets.dart';



class CustomTable extends StatelessWidget {
  final List<Inspeksi> inspeksi;
  final bool isActivity;
  const CustomTable({super.key, required this.inspeksi, required this.isActivity});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: HexColor('#000000'),
        width: 2,
      ),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      children:  [
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSize.paddingSmall),
                child: const Center(
                  child: Label(label: 'Tanggal Pelaksanaan', color: '#000000', fontWeight: 6, fontSize: AppSize.fontSizeSmall,),
                ),
              ),
            ),

            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSize.paddingSmall),
                child: Center(
                  child: Label(label: isActivity ? 'Badan Usaha' : 'Kegiatan', color: '#000000', fontWeight: 6, fontSize: AppSize.fontSizeSmall,),
                ),
              ),
            ),
          ],
        ),
        
        ...inspeksi.map((Inspeksi i) {
          return TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppSize.paddingSmall, horizontal: 4),
                  child: Center(
                    child: Label(label: i.pelaksaan(), color: '#000000', fontWeight: 6, fontSize: AppSize.fontSizeSmall,),
                  ),
                ),
              ),

              TableCell(
                child: GestureDetector(
                  onDoubleTap: () {
                    Get.to(() => DetailInspectorView(), transition: Transition.rightToLeft);
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: AppSize.paddingSmall),
                        child: Center(
                          child: Label(
                            label: i.badanUsaha,
                            color: '#000000',
                            fontWeight: 6,
                            fontSize: AppSize.fontSizeSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList()
      ],
    );
  }
}
