part of 'view.dart';

class DetailInspectorView extends StatelessWidget {
  final DetailInspectorController controller = Get.put(DetailInspectorController());
  DetailInspectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSize.marginSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Label(label: 'Inspector', fontSize: AppSize.fontSizeExtraLarge, fontWeight: 6,),
                        const SizedBox(height: AppSize.marginSmall,),
                        Row(
                          children: [
                            _button(title: 'Main'),
                            const SizedBox(width: AppSize.paddingSmall,),
                            _button(title: 'Sync', onClick: () {
                              print('abc');
                              controller.startProgress();
                              controller.showCustomLoading(context);
                            })
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _itemIcons(Icons.fire_truck, title: 'PT Rumah koding'),
                      _itemIcons(Icons.person_pin, title: 'KTT : Aditya Winarmo')
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSize.marginMedium,),
            Container(
                margin: const EdgeInsets.all(AppSize.marginSmall),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Label(label: 'Temuan', fontWeight: 6, fontSize: AppSize.fontSizeExtraLarge),
                    GestureDetector(
                      onTap: () {
                        controller.addTemuan();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: HexColor(AppSize.blue),
                            borderRadius: BorderRadius.circular(AppSize.borderRadiusMedium)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: AppSize.paddingSmall),
                        child: const Label(label: '+', fontWeight: 6, fontSize: AppSize.fontSizeLarge, color: '#FFFFFF',),
                      ),
                    ),

                  ],
                )
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.temuans.length,
                itemBuilder: (BuildContext context, int i) {
                  return _accordion(context, controller.temuans[i]);
                },
              );
            }),


          ],
        ),
      ),
    );
  }

  Widget _button({String title="", Function? onClick}) {
    return GestureDetector(
      onTap: (){
        if(onClick != null) {
          onClick();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium, vertical: AppSize.paddingSmall),
        decoration: BoxDecoration(
          color: HexColor(AppSize.blue),
          borderRadius: BorderRadius.circular(AppSize.borderRadiusMedium)
        ),
        child: Label(label: title, color: '#ffffff', fontWeight: 6,),
      ),
    );
  }

  Widget _itemIcons(IconData icon, {String title=''}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.brown,
          size: 20.0,
        ),
        const SizedBox(width: AppSize.marginSmall,),
        Label(label: title, fontSize: AppSize.fontSizeMedium,)
      ],
    );
  }

  Widget _accordion(BuildContext context, Temuan temuan) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSize.marginSmall),
      child: ExpansionTile(
        enabled: temuan.isEdit,
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSize.paddingSmall, horizontal: AppSize.paddingSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.borderRadiusMedium),
            border: Border.all(
              color: HexColor(AppSize.brown), // Warna border
              width: 1.0,         // Ketebalan border
            ),
          ),
          child: Label(label: 'Temuan : ${temuan.temuan}',),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blue, // Warna border
            width: 2, // Ketebalan border
            style: BorderStyle.solid, // Gaya border (solid, dashed, etc.)
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)), // Radius sudut untuk border melengkung
        ),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: Input(hintText: 'Input Lokasi', onClick: (){},),
          ),

          const SizedBox(height: AppSize.marginMedium,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: _inputArea(context),
          ),
          const SizedBox(height: AppSize.marginMedium,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: _inputAspek(),
          ),
          const SizedBox(height: AppSize.marginMedium,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: _inputRekomendasi(),
          ),

          const SizedBox(height: AppSize.marginMedium,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: Padding(
              padding: EdgeInsets.all(0), // Berikan padding jika diperlukan
              child: Align(
                alignment: Alignment.centerLeft, // Mengarahkan ke kiri
                child: Label(
                  label: 'Temuan :',
                  fontWeight: 6,
                  fontSize: AppSize.fontSizeMedium,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: Label(label: temuan.temuan,),
          ),


          const SizedBox(height: AppSize.marginMedium,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: Padding(
              padding: EdgeInsets.all(0), // Berikan padding jika diperlukan
              child: Align(
                alignment: Alignment.centerLeft, // Mengarahkan ke kiri
                child: Label(
                  label: 'Rekomendasi :',
                  fontWeight: 6,
                  fontSize: AppSize.fontSizeMedium,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: Label(label: 'Mengkaji ulang, memperbaiki, menetapkan dan mensosialisasikan form pemeriksaan dan pengecekan harian unit alat angkut agar',),
          ),

          const SizedBox(height: AppSize.marginMedium,),

          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: Padding(
              padding: EdgeInsets.all(0), // Berikan padding jika diperlukan
              child: Align(
                alignment: Alignment.centerLeft, // Mengarahkan ke kiri
                child: Label(
                  label: 'Bukti :',
                  fontWeight: 6,
                  fontSize: AppSize.fontSizeMedium,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSize.marginMedium,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
            child: _inputBukti()
          ),






        ],
      ),
    );
  }

  Widget _inputAspek(){
    return  Obx(() {
      if (controller.aspeks.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return DropdownSearch<Aspek>(
        items: (f, cs) => controller.aspeks,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            labelText: "Aspek Teknik Pertambangan", // Placeholder
            // hintText: "Choose one...", // Placeholder tambahan
            border: OutlineInputBorder(),
          )
        ),
        compareFn: (Aspek? item, Aspek? itemTwo) {
          if (item == null || itemTwo == null) {
            return false;
          } else {
            return item.id == itemTwo.id;
          }
        },
        itemAsString: (Aspek? aspek) => aspek?.aspek ?? '',
        popupProps: PopupProps.dialog(
          title: Container(
            decoration: BoxDecoration(color: HexColor(AppSize.blue)),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Label(label: 'Aspek', fontWeight: 6, color: '#ffffff', fontSize: AppSize.fontSizeLarge),
          ),
          dialogProps: DialogProps(
            clipBehavior: Clip.antiAlias,
            shape: OutlineInputBorder(
              borderSide: BorderSide(width: 0),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        onChanged: (Aspek? selectedAspek) {
          if (selectedAspek != null) {

            // _category.selectCategory(selectedCategory);
            // _inputLaporanController.IsJenis(selectedCategory);
            //
            //
            // print('Selected Unit: ${selectedCategory.text}');
          }
        },
      );
    });
  }

  Widget _inputRekomendasi(){
    return  Obx(() {
      if (controller.rekomendasi.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return DropdownSearch<Rekomendasi>(
        items: (f, cs) => controller.rekomendasi,
        decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: "Jenis Rekomendasi", // Placeholder
              // hintText: "Choose one...", // Placeholder tambahan
              border: OutlineInputBorder(),
            )
        ),
        compareFn: (Rekomendasi? item, Rekomendasi? itemTwo) {
          if (item == null || itemTwo == null) {
            return false;
          } else {
            return item.id == itemTwo.id;
          }
        },
        itemAsString: (Rekomendasi? rekomendasi) => rekomendasi?.rekomendasi ?? '',
        popupProps: PopupProps.dialog(
          title: Container(
            decoration: BoxDecoration(color: HexColor(AppSize.blue)),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Label(label: 'Aspek', fontWeight: 6, color: '#ffffff', fontSize: AppSize.fontSizeLarge),
          ),
          dialogProps: DialogProps(
            clipBehavior: Clip.antiAlias,
            shape: OutlineInputBorder(
              borderSide: BorderSide(width: 0),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        onChanged: (Rekomendasi? selectedRekomendasi) {
          if (selectedRekomendasi != null) {

            // _category.selectCategory(selectedCategory);
            // _inputLaporanController.IsJenis(selectedCategory);
            //
            //
            // print('Selected Unit: ${selectedCategory.text}');
          }
        },
      );
    });
  }

  Widget _inputArea(BuildContext context){
    return  Obx(() {
      if (controller.areas.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return Row(
        children: [
          Expanded(child: DropdownSearch<Area>(
            items: (f, cs) => controller.areas,
            decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  labelText: "Area/Objek/Ceklist", // Placeholder
                  // hintText: "Choose one...", // Placeholder tambahan
                  border: OutlineInputBorder(),
                )
            ),
            compareFn: (Area? item, Area? itemTwo) {
              if (item == null || itemTwo == null) {
                return false;
              } else {
                return item.id == itemTwo.id;
              }
            },
            itemAsString: (Area? area) => area?.area ?? '',
            popupProps: PopupProps.dialog(
              title: Container(
                decoration: BoxDecoration(color: HexColor(AppSize.blue)),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Label(label: 'Aspek', fontWeight: 6, color: '#ffffff', fontSize: AppSize.fontSizeLarge),
              ),
              dialogProps: DialogProps(
                clipBehavior: Clip.antiAlias,
                shape: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            onChanged: (Area? selectedArea) {
              if (selectedArea != null) {

                // _category.selectCategory(selectedCategory);
                // _inputLaporanController.IsJenis(selectedCategory);
                //
                //
                // print('Selected Unit: ${selectedCategory.text}');
              }
            },
          )),
          const SizedBox(width: AppSize.paddingSmall,),
          GestureDetector(
            onTap: () {
              // controller.addArea(area)
              showCustomDialog(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: AppSize.paddingMedium, horizontal: AppSize.paddingSmall),
              decoration: BoxDecoration(
                color: HexColor(AppSize.blue),
                borderRadius: BorderRadius.circular(AppSize.borderRadiusMedium)
              ),
              child: Label(label: 'Tambah',color: '#ffffff', fontWeight: 6,),
            ),
          )
        ],
      );
    });
  }

  Widget _inputBukti() {
    return Column(
      children: [
        Obx(() {
          return Stack(
            children: [
              if (controller.imageFile.value != null)
                Image.file(
                  controller.imageFile.value!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),

              if (controller.imageFile.value != null)
                Positioned(
                  top: AppSize.paddingSmall,
                  right: AppSize.paddingSmall,
                  child: GestureDetector(
                    onTap: () {
                      controller.imageFile.value = null; // Hapus gambar
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(AppSize.paddingSmall),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: controller.openCamera,
          child: Column(
            children: [
              Icon(Icons.camera_alt_rounded, color: HexColor(AppSize.blue),),
              const Label(label: 'Camera',)
            ],
          ),
        ),
      ],
    );
  }


  Widget _inputAreaAdd(BuildContext context){
    return  Obx(() {
      if (controller.areasAdd.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return DropdownSearch<Area>(
        items: (f, cs) => controller.areasAdd,
        decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: "Area/Objek/Ceklist", // Placeholder
              // hintText: "Choose one...", // Placeholder tambahan
              border: OutlineInputBorder(),
            )
        ),
        compareFn: (Area? item, Area? itemTwo) {
          if (item == null || itemTwo == null) {
            return false;
          } else {
            return item.id == itemTwo.id;
          }
        },
        itemAsString: (Area? area) => area?.area ?? '',
        popupProps: PopupProps.dialog(
          title: Container(
            decoration: BoxDecoration(color: HexColor(AppSize.blue)),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Label(label: 'Aspek', fontWeight: 6, color: '#ffffff', fontSize: AppSize.fontSizeLarge),
          ),
          dialogProps: DialogProps(
            clipBehavior: Clip.antiAlias,
            shape: OutlineInputBorder(
              borderSide: BorderSide(width: 0),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        onChanged: (Area? selectedArea) {
          if (selectedArea != null) {
            // print('maj');
            // print(selectedArea);
            controller.chooseAreaAdd(selectedArea);
          }
        },
      );
    });
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Dialog(
          elevation: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Label(label: 'Tambah Ceklist', fontSize: AppSize.fontSizeMedium, fontWeight: 6,),
                const SizedBox(height: AppSize.marginSmall,),
                _inputAreaAdd(context),
                const SizedBox(height: AppSize.marginSmall,),
                Input(hintText: 'ceklist baru', onClick: (){},),
                const SizedBox(height: AppSize.marginSmall,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){Navigator.pop(context, 'Cancel');},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: AppSize.paddingSmall, vertical: AppSize.paddingSmall),
                        child: const Label(label: "Cancel", fontWeight: 6, color: AppSize.brown, fontSize: AppSize.fontSizeMedium),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        controller.addArea();
                        Navigator.pop(context, 'Tambah');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: HexColor(AppSize.blue),
                          borderRadius: BorderRadius.circular(AppSize.borderRadiusSmall)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: AppSize.paddingSmall, vertical: AppSize.paddingSmall),
                        child: const Label(label: "Tambah", fontWeight: 6, color: '#ffffff', fontSize: AppSize.fontSizeMedium),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

}