import 'package:app_ecomerce/features/auth/presentation/provider/auth_provider.dart';
import 'package:app_ecomerce/features/home/presentation/admin/widget/card_view.dart';
import 'package:app_ecomerce/features/home/presentation/admin/widget/grafic_linear.dart';
import 'package:app_ecomerce/features/home/presentation/admin/widget/manage_list.dart';
import 'package:app_ecomerce/features/home/presentation/admin/widget/selection_period.dart';
import 'package:app_ecomerce/features/products/presentation/providers/product_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeAdminScreen extends ConsumerWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Panel",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),
        ),
        scrolledUnderElevation: 0,
        bottomOpacity: 0,
        actions: [
          Text(
              "${ref.watch(authProvider).userData?.name}".toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          InkWell(
            onTap: (){
              context.push('/cuentaAdmin');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).colorScheme.onSecondaryContainer
                ),
                child: Icon(Icons.person_outline, size: 24,),
              ),
            ),
          )
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 16,
                children: [
                  CardView(
                      icon: Icons.attach_money_outlined,
                      data: "Gs. 1.250.000",
                      descripcion: "Total ventas",
                      colorIcon: Colors.blue
                  ),
                  CardView(
                      icon: CupertinoIcons.cube_box,
                      data: "12 Ordenes",
                      descripcion: "Ordenes pendientes",
                      colorIcon: Colors.orange
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                spacing: 16,
                children: [
                  CardView(
                      icon: Icons.inventory_2_outlined,
                      data: "5 Productos",
                      descripcion: "Stock bajo",
                      colorIcon: Colors.yellow.shade600
                  ),
                  CardView(
                      icon: Icons.person_add_alt_outlined,
                      data: "+3 Hoy",
                      descripcion: "Nuevos usuarios",
                      colorIcon: Colors.green
                  ),
                ],
              ),
              SizedBox(height: 16,),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     //border: Border.all(color: Colors.grey.shade100),
              //       color: Theme.of(context).colorScheme.onPrimaryContainer
              //   ),
              //   padding: EdgeInsets.all(16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Resumen de Ventas",
              //         style: TextStyle(
              //             fontSize: 18,
              //           fontWeight: FontWeight.w700
              //         ),
              //       ),
              //       SizedBox(height: 16,),
              //       SelectionPeriod(),
              //       SizedBox(height: 16,),
              //       Text(
              //         "Gs. 34.125.500",
              //         style: TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold
              //         ),
              //       ),
              //       Row(
              //         spacing: 20,
              //         children: [
              //           Text(
              //               "Ultimos 7 dias",
              //             style: TextStyle(
              //               color: Colors.grey.shade500,
              //             ),
              //           ),
              //           Text(
              //             "+15.2%",
              //             style: TextStyle(
              //               color: Colors.green.shade400
              //             ),
              //           ),
              //         ],
              //       ),
              //       SizedBox(height: 16,),
              //       GraficLinear()
              //     ],
              //   ),
              // ),

              /********************* Administracion de prducto, orden y usuario **************/
              SizedBox(height: 16,),
              Text(
                  "Administrar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
              SizedBox(height: 16,),
              ManageList(
                  icon: Icons.inventory_2_outlined,
                  title: "Productos",
                  route: "/adminProductScreen",
              ),
              SizedBox(height: 16,),
              ManageList(
                  icon: Icons.paste_rounded,
                  title: "Ordenes",
                route: "",
              ),
              SizedBox(height: 16,),
              ManageList(icon: Icons.group, title: "Usuarios", route: "/adminUserScreen",),
            ],
          ),
        ),
      ),
    );
  }
}
