# 🎨 Guía de UI/UX - Componentes y Pantallas

## Índice
1. [Sistema de Diseño](#sistema-de-diseño)
2. [Navegación](#navegación)
3. [Pantallas de Usuario](#pantallas-de-usuario)
4. [Pantallas de Administrador](#pantallas-de-administrador)
5. [Componentes Reutilizables](#componentes-reutilizables)
6. [Widgets Personalizados](#widgets-personalizados)
7. [Animaciones y Transiciones](#animaciones-y-transiciones)
8. [Responsive Design](#responsive-design)

---

## Sistema de Diseño

### Paleta de Colores

#### Tema Claro
```dart
// Colores principales
scaffoldBackgroundColor: Colors.grey.shade100
primary: Colors.blue
secondary: Colors.blue.shade100
onPrimaryContainer: Colors.white
onSecondaryContainer: Colors.grey.shade100

// Colores de componentes
appBarBackground: Colors.white
navigationBarBackground: Colors.white
navigationBarIndicator: Color(0xFF3190FD)
```

#### Tema Oscuro
```dart
// Colores principales
scaffoldBackgroundColor: Color(0xFF0B132B)
primary: Colors.blue
secondary: Color(0xFF162553)
onPrimaryContainer: Colors.white10
onSecondaryContainer: Colors.white12
```

### Tipografía

```dart
// Títulos
headline1: fontSize: 32, fontWeight: FontWeight.bold
headline2: fontSize: 24, fontWeight: FontWeight.bold
headline3: fontSize: 20, fontWeight: FontWeight.bold

// Cuerpo
bodyLarge: fontSize: 16, fontWeight: FontWeight.normal
bodyMedium: fontSize: 14, fontWeight: FontWeight.normal

// Botones y etiquetas
labelLarge: fontSize: 16, fontWeight: FontWeight.bold
labelMedium: fontSize: 14, fontWeight: FontWeight.bold
```

### Espaciado

```dart
// Padding estándar
small: 8.0
medium: 16.0
large: 24.0
extraLarge: 32.0

// Border radius
small: 8.0
medium: 12.0
large: 16.0
circular: 50.0 (completamente redondeado)
```

### Elevación y Sombras

```dart
// Elevation
card: 0 (flat design)
appBar: 0
button: 2

// Shadow
cardShadow: Colors.grey.shade200
```

---

## Navegación

### Estructura de Navegación

```
Login Screen
    │
    ├─→ Register Screen
    │
    └─→ Home (según rol)
         │
         ├─→ Usuario: Home Screen (con NavigationBar)
         │    ├─→ Inicio (HomeContent)
         │    ├─→ Categorías
         │    ├─→ Carrito
         │    ├─→ Favoritos
         │    └─→ Perfil
         │
         └─→ Admin: Home Admin Screen
              ├─→ Dashboard
              ├─→ Gestión de Productos
              ├─→ Gestión de Usuarios
              └─→ Cuenta Admin
```

### NavigationBar (Usuario)

```dart
NavigationBar(
  selectedIndex: _selectedIndex,
  destinations: [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Inicio',
    ),
    NavigationDestination(
      icon: Icon(Icons.category_outlined),
      selectedIcon: Icon(Icons.category_rounded),
      label: 'Categorías',
    ),
    NavigationDestination(
      icon: Icon(Icons.shopping_cart_outlined),
      selectedIcon: Icon(Icons.shopping_cart),
      label: 'Carrito',
    ),
    NavigationDestination(
      icon: Icon(Icons.favorite_border),
      selectedIcon: Icon(Icons.favorite),
      label: 'Favoritos',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Perfil',
    ),
  ],
)
```

---

## Pantallas de Usuario

### 1. Login Screen

**Ruta**: `/login`

#### Componentes
- Logo de la aplicación
- Campo de email
- Campo de contraseña
- Botón de "Iniciar Sesión"
- Link a "Registrarse"

#### Layout
```dart
Scaffold(
  body: SafeArea(
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Image.asset('assets/logo.png', height: 120),
          SizedBox(height: 32),
          
          // Email field
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          SizedBox(height: 16),
          
          // Password field
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(height: 24),
          
          // Login button
          ElevatedButton(
            onPressed: _handleLogin,
            child: Text('Iniciar Sesión'),
          ),
          
          // Register link
          TextButton(
            onPressed: () => context.push('/register'),
            child: Text('¿No tienes cuenta? Regístrate'),
          ),
        ],
      ),
    ),
  ),
)
```

### 2. Home Screen (Usuario)

**Ruta**: `/homeUser`

#### Estructura
```dart
Scaffold(
  appBar: AppBar(
    title: Text(titulos[_selectedIndex]),
    centerTitle: true,
  ),
  body: IndexedStack(
    index: _selectedIndex,
    children: [
      HomeContent(),
      CategoriesScreen(),
      CartShoppingScreen(),
      FavoritesScreen(),
      UserAccountScreen(),
    ],
  ),
  bottomNavigationBar: NavigationBar(...),
)
```

### 3. Home Content

#### Secciones
1. **SearchBar**: Búsqueda de productos
2. **Categorías**: Chips horizontales con categorías
3. **Productos Destacados**: Grid de productos

```dart
Column(
  children: [
    // Search bar
    Padding(
      padding: EdgeInsets.all(16),
      child: SearchBar(
        hintText: 'Buscar productos...',
        leading: Icon(Icons.search),
      ),
    ),
    
    // Categories
    SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: selectedCategory == index,
              onSelected: (selected) {
                setState(() => selectedCategory = index);
              },
            ),
          );
        },
      ),
    ),
    
    // Products grid
    Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    ),
  ],
)
```

### 4. Detail Product Screen

**Ruta**: `/productDetails`

#### Layout
```dart
Scaffold(
  body: CustomScrollView(
    slivers: [
      // Image in app bar
      SliverAppBar(
        expandedHeight: 300,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
            product.imagen,
            fit: BoxFit.cover,
          ),
        ),
      ),
      
      // Product details
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nombre
              Text(
                product.nombre,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              
              // Precio
              Text(
                'Gs. ${formatCurrency(product.precio)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 16),
              
              // Stock
              Row(
                children: [
                  Icon(Icons.inventory),
                  SizedBox(width: 8),
                  Text('Stock: ${product.stock}'),
                ],
              ),
              SizedBox(height: 16),
              
              // Descripción
              Text(
                'Descripción',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Text(product.descripcion),
              
              SizedBox(height: 24),
              
              // Botones de acción
              Row(
                children: [
                  // Favoritos
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () => addToFavorites(),
                  ),
                  SizedBox(width: 8),
                  
                  // Agregar al carrito
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.shopping_cart),
                      label: Text('Agregar al Carrito'),
                      onPressed: () => addToCart(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)
```

### 5. Cart Shopping Screen

**Ruta**: `/cart`

#### Estructura
```dart
Scaffold(
  appBar: AppBar(title: Text('Carrito')),
  body: Column(
    children: [
      // Lista de items
      Expanded(
        child: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            return CardProductCart(item: cartItems[index]);
          },
        ),
      ),
      
      // Resumen de compra
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal:'),
                Text('Gs. ${formatCurrency(subtotal)}'),
              ],
            ),
            SizedBox(height: 8),
            
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Gs. ${formatCurrency(total)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Botón de checkout
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => checkout(),
                child: Text('Proceder al Pago'),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
)
```

### 6. Favorites Screen

**Ruta**: `/favorites`

#### Layout
```dart
Scaffold(
  appBar: AppBar(title: Text('Favoritos')),
  body: favoriteProducts.isEmpty
    ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No tienes productos favoritos'),
          ],
        ),
      )
    : ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          return FavoriteProductCard(
            product: favoriteProducts[index],
          );
        },
      ),
)
```

### 7. Categories Screen

**Ruta**: `/category`

#### Grid de Categorías
```dart
GridView.builder(
  padding: EdgeInsets.all(16),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 1.5,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
  ),
  itemCount: categories.length,
  itemBuilder: (context, index) {
    return InkWell(
      onTap: () => navigateToCategoryProducts(categories[index]),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(categoryIcons[index], size: 48),
            SizedBox(height: 8),
            Text(
              categories[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  },
)
```

### 8. User Account Screen

**Ruta**: `/clientAccount`

#### Opciones de Usuario
```dart
ListView(
  children: [
    // Header con info del usuario
    Container(
      padding: EdgeInsets.all(24),
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          SizedBox(height: 16),
          Text(
            userName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            userEmail,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    ),
    
    // Opciones
    ListTile(
      leading: Icon(Icons.person),
      title: Text('Editar Perfil'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    ),
    ListTile(
      leading: Icon(Icons.history),
      title: Text('Historial de Pedidos'),
      trailing: Icon(Icons.chevron_right),
      onTap: () => context.push('/history'),
    ),
    ListTile(
      leading: Icon(Icons.settings),
      title: Text('Configuración'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    ),
    ListTile(
      leading: Icon(Icons.logout),
      title: Text('Cerrar Sesión'),
      onTap: () => logout(),
    ),
  ],
)
```

---

## Pantallas de Administrador

### 1. Home Admin Screen

**Ruta**: `/homeAdmin`

#### Dashboard
```dart
SingleChildScrollView(
  padding: EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Tarjetas de estadísticas
      Row(
        children: [
          Expanded(
            child: CardView(
              icon: Icons.attach_money_outlined,
              data: "Gs. 1.250.000",
              descripcion: "Total ventas",
              colorIcon: Colors.blue,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: CardView(
              icon: Icons.cube_box,
              data: "12 Ordenes",
              descripcion: "Ordenes pendientes",
              colorIcon: Colors.orange,
            ),
          ),
        ],
      ),
      SizedBox(height: 16),
      
      // Más estadísticas
      Row(
        children: [
          Expanded(
            child: CardView(
              icon: Icons.people,
              data: "150",
              descripcion: "Clientes",
              colorIcon: Colors.green,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: CardView(
              icon: Icons.inventory,
              data: "85",
              descripcion: "Productos",
              colorIcon: Colors.purple,
            ),
          ),
        ],
      ),
      SizedBox(height: 24),
      
      // Selector de período
      SelectionPeriod(
        onPeriodChanged: (period) => updateCharts(period),
      ),
      SizedBox(height: 16),
      
      // Gráfico
      Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ventas del Período',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: GraficLinear(data: salesData),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 16),
      
      // Lista de gestión
      ManageList(),
    ],
  ),
)
```

### 2. Admin Products Screen

**Ruta**: `/adminProductScreen`

#### Lista de Productos con CRUD
```dart
Scaffold(
  appBar: AppBar(
    title: Text('Gestión de Productos'),
    actions: [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => context.push('/addProduct'),
      ),
    ],
  ),
  body: productsAsync.when(
    data: (products) => ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCardAdmin(
          product: products[index],
          onEdit: () => editProduct(products[index]),
          onDelete: () => deleteProduct(products[index].id),
        );
      },
    ),
    loading: () => Center(child: CircularProgressIndicator()),
    error: (error, stack) => Center(child: Text('Error: $error')),
  ),
)
```

### 3. Add/Update Product Screen

**Ruta**: `/addProduct`

#### Formulario de Producto
```dart
Form(
  key: _formKey,
  child: ListView(
    padding: EdgeInsets.all(16),
    children: [
      // Image upload
      ImageUploadBox(
        onImageSelected: (path) => setState(() => imagePath = path),
      ),
      SizedBox(height: 16),
      
      // Nombre
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Nombre del Producto',
          prefixIcon: Icon(Icons.shopping_bag),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese un nombre';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      
      // Descripción
      TextFormField(
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'Descripción',
          prefixIcon: Icon(Icons.description),
        ),
      ),
      SizedBox(height: 16),
      
      // Precio
      TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [GuaraniInputFormatter()],
        decoration: InputDecoration(
          labelText: 'Precio',
          prefixIcon: Icon(Icons.attach_money),
          prefix: Text('Gs. '),
        ),
      ),
      SizedBox(height: 16),
      
      // Stock
      TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Stock',
          prefixIcon: Icon(Icons.inventory),
        ),
      ),
      SizedBox(height: 16),
      
      // Categoría
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Categoría',
          prefixIcon: Icon(Icons.category),
        ),
        items: categories.map((category) {
          return DropdownMenuItem(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (value) => setState(() => selectedCategory = value),
      ),
      SizedBox(height: 16),
      
      // Switch activo
      SwitchListTile(
        title: Text('Producto Activo'),
        value: isActive,
        onChanged: (value) => setState(() => isActive = value),
      ),
      SizedBox(height: 24),
      
      // Botón guardar
      ElevatedButton(
        onPressed: _saveProduct,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Guardar Producto'),
        ),
      ),
    ],
  ),
)
```

### 4. Admin Users Screen

**Ruta**: `/adminUserScreen`

#### Lista de Usuarios
```dart
Scaffold(
  appBar: AppBar(
    title: Text('Gestión de Usuarios'),
    actions: [
      IconButton(
        icon: Icon(Icons.person_add),
        onPressed: () => context.push('/addUser'),
      ),
    ],
  ),
  body: usersAsync.when(
    data: (users) => ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserCardAdmin(
          user: users[index],
          onEdit: () => editUser(users[index]),
          onDelete: () => deleteUser(users[index].id),
        );
      },
    ),
    loading: () => Center(child: CircularProgressIndicator()),
    error: (error, stack) => Center(child: Text('Error: $error')),
  ),
)
```

---

## Componentes Reutilizables

### 1. Product Card

```dart
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () {
          context.push('/productDetails', extra: product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                product.imagen,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre
                  Text(
                    product.nombre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  
                  // Precio
                  Text(
                    'Gs. ${formatCurrency(product.precio)}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  
                  // Stock
                  if (product.stock < 10)
                    Text(
                      '¡Últimas unidades!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
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
}
```

### 2. Card Product Cart

```dart
class CardProductCart extends StatelessWidget {
  final Item item;
  final VoidCallback? onRemove;
  final Function(int)? onQuantityChanged;

  const CardProductCart({
    required this.item,
    this.onRemove,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.imagen,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            
            // Info del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Gs. ${formatCurrency(item.product.precio)}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  // Controles de cantidad
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (item.quantity > 1) {
                            onQuantityChanged?.call(item.quantity - 1);
                          }
                        },
                      ),
                      Text(
                        '${item.quantity}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          onQuantityChanged?.call(item.quantity + 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Botón eliminar
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3. Favorite Button

```dart
class FavoriteButton extends ConsumerWidget {
  final Product product;

  const FavoriteButton({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.contains(product.id);

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        ref.read(favoritesProvider.notifier).toggle(product);
      },
    );
  }
}
```

### 4. Image Upload Box

```dart
class ImageUploadBox extends StatefulWidget {
  final Function(String) onImageSelected;
  final String? initialImage;

  const ImageUploadBox({
    required this.onImageSelected,
    this.initialImage,
  });

  @override
  State<ImageUploadBox> createState() => _ImageUploadBoxState();
}

class _ImageUploadBoxState extends State<ImageUploadBox> {
  String? _imagePath;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() => _imagePath = image.path);
      widget.onImageSelected(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _imagePath != null || widget.initialImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _imagePath != null
                  ? Image.file(File(_imagePath!), fit: BoxFit.cover)
                  : Image.network(widget.initialImage!, fit: BoxFit.cover),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate, size: 64, color: Colors.grey),
                SizedBox(height: 8),
                Text('Seleccionar Imagen'),
              ],
            ),
      ),
    );
  }
}
```

### 5. Card View (Dashboard)

```dart
class CardView extends StatelessWidget {
  final IconData icon;
  final String data;
  final String descripcion;
  final Color colorIcon;

  const CardView({
    required this.icon,
    required this.data,
    required this.descripcion,
    required this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorIcon.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: colorIcon, size: 32),
            ),
            SizedBox(height: 12),
            Text(
              data,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              descripcion,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Widgets Personalizados

### Loading Widget

```dart
class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          if (message != null) ...[
            SizedBox(height: 16),
            Text(message!),
          ],
        ],
      ),
    );
  }
}
```

### Error Widget

```dart
class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorDisplayWidget({
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Oops!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

### Empty State Widget

```dart
class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyStateWidget({
    required this.message,
    this.icon = Icons.inbox,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          if (onAction != null && actionLabel != null) ...[
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: onAction,
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
```

---

## Animaciones y Transiciones

### Page Transitions

```dart
// Configurar en Go Router
GoRoute(
  path: '/details',
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      child: DetailScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  },
)
```

### Hero Animations

```dart
// En la lista de productos
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.imagen),
)

// En el detalle
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.imagen),
)
```

### Animated List

```dart
AnimatedList(
  key: _listKey,
  initialItemCount: items.length,
  itemBuilder: (context, index, animation) {
    return SlideTransition(
      position: animation.drive(
        Tween(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOut)),
      ),
      child: ItemWidget(items[index]),
    );
  },
)
```

---

## Responsive Design

### Breakpoints

```dart
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}
```

### Responsive Grid

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final crossAxisCount = constraints.maxWidth < Breakpoints.mobile
        ? 2
        : constraints.maxWidth < Breakpoints.tablet
            ? 3
            : 4;
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) => ProductCard(...),
    );
  },
)
```

### Responsive Padding

```dart
MediaQuery.of(context).size.width < Breakpoints.mobile
  ? EdgeInsets.all(16)
  : EdgeInsets.all(24)
```

---

## Buenas Prácticas de UI/UX

1. **Feedback Visual**: Siempre mostrar indicadores de carga
2. **Estados Vacíos**: Diseñar pantallas para cuando no hay datos
3. **Manejo de Errores**: Mensajes claros y opciones de recuperación
4. **Accesibilidad**: Usar Semantics para lectores de pantalla
5. **Temas Consistentes**: Respetar los colores y tipografía del tema
6. **Navegación Intuitiva**: Breadcrumbs y botones de retroceso claros
7. **Validación de Formularios**: Feedback inmediato en campos
8. **Animaciones Sutiles**: No abusar de las transiciones
9. **Touch Targets**: Botones de al menos 48x48 pixels
10. **Imágenes Optimizadas**: Usar placeholders y manejo de errores

---

**Última actualización**: Diciembre 2025

