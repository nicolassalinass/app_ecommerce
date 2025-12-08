import 'package:app_ecomerce/features/account_settings/presentation/admin/admin_account_screen.dart';
import 'package:app_ecomerce/features/account_settings/presentation/user/user_account_screen.dart';
import 'package:app_ecomerce/features/auth/presentation/login_screen.dart';
import 'package:app_ecomerce/features/auth/presentation/register_screen.dart';
import 'package:app_ecomerce/features/cart/presentation/cart_shopping_screen.dart';
import 'package:app_ecomerce/features/category/presentation/categories_screen.dart';
import 'package:app_ecomerce/features/favorites/presentation/favorites_screen.dart';
import 'package:app_ecomerce/features/history/presentation/history_screen.dart';
import 'package:app_ecomerce/features/home/presentation/admin/home_admin_screen.dart';
import 'package:app_ecomerce/features/home/presentation/user/screen/home_screen.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/presentation/admin/add_product_screen.dart';
import 'package:app_ecomerce/features/products/presentation/admin/admin_products_screen.dart';
import 'package:app_ecomerce/features/products/presentation/detail_product_screen.dart';
import 'package:app_ecomerce/features/users/presentation/screens/admin_users_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',

  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),

    /************** USER ROUTES ******************/
    GoRoute(
      path: '/homeUser',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/productDetails',
      builder: (context, state){
        final product = state.extra as Product;
        return DetailProductScreen(product: product);
      },
    ),
    GoRoute(
      path: '/category',
      builder: (context, state) => CategoriesScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => CartShoppingScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => FavoritesScreen(),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => HistoryScreen(),
    ),
    GoRoute(
      path: '/clientAccount',
      builder: (context, state) => UserAccountScreen(),
    ),


  /********************* ADMIN ROUTES ****************************/
    GoRoute(
      path: '/homeAdmin',
      builder: (context, state) => HomeAdminScreen(),
    ),
    GoRoute(
      path: '/cuentaAdmin',
      builder: (context, state) => AdminAccountScreen(),
    ),
    GoRoute(
      path: '/addProduct',
      builder: (context, state) => AddProductScreen(),
    ),


    GoRoute(
      path: '/adminProductScreen',
      builder: (context, state) => AdminProductsScreen(),
    ),

    GoRoute(
      path: '/adminUserScreen',
      builder: (context, state) => AdminUsersScreen(),
    ),
  ],
);
