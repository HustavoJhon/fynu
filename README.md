# 🎬 Fynu - App de Películas

Aplicación Flutter para gestionar tu colección de películas con una arquitectura limpia (Clean Architecture + MVVM).

## 📋 Características

- ✅ **Arquitectura limpia** con separación de capas (Domain, Data, Presentation)
- ✅ **MVVM ligero** usando Provider
- ✅ **3 Tabs principales**:
  - 🏠 **Inicio**: Descubre películas populares y tendencias desde TMDB API
  - 📚 **Mi Colección**: Gestiona tus películas guardadas (Quiero ver, Me gustó)
  - 💕 **Con mi novia**: Películas para ver juntos
- ✅ **Tema estilo Netflix** (oscuro y minimalista)
- ✅ **Guardado local** con SharedPreferences
- ✅ **Inyección de dependencias** con GetIt

## 🚀 Configuración Inicial

### 1. Instalar dependencias

```bash
flutter pub get
```

### 2. Configurar API Key de TMDB

Para que la app funcione correctamente, necesitas obtener una API key gratuita de The Movie Database:

1. Ve a [https://www.themoviedb.org/](https://www.themoviedb.org/)
2. Crea una cuenta (es gratis)
3. Ve a [Configuración de API](https://www.themoviedb.org/settings/api)
4. Solicita una API Key (selecciona "Developer")
5. Copia tu API Key

Una vez que tengas tu API Key, edita el archivo:

```
lib/core/utils/network_utils.dart
```

Y reemplaza `'TU_API_KEY_AQUI'` con tu API key real:

```dart
options.queryParameters['api_key'] = 'TU_API_KEY_AQUI';
```

### 3. Ejecutar la aplicación

```bash
flutter run
```

## 📁 Estructura del Proyecto

```
lib/
├── core/
│   ├── constants/          # Constantes de la app y API
│   ├── theme/              # Tema personalizado (estilo Netflix)
│   ├── utils/              # Utilidades (formateo, network)
│   ├── errors/             # Clases de error
│   └── dependency_injection.dart
│
├── data/
│   ├── models/             # Modelos de datos (JSON)
│   ├── datasources/         # Fuentes de datos (API y Local)
│   └── repositories_impl/      # Implementación de repositorios
│
├── domain/
│   ├── entities/            # Entidades de negocio
│   ├── repositories/         # Interfaces de repositorios
│   └── usecases/             # Casos de uso
│
├── presentation/
│   ├── pages/                # Pantallas principales
│   ├── viewmodels/           # ViewModels (estado)
│   ├── widgets/              # Widgets reutilizables
│   └── routes/                # Rutas de navegación
│
└── main.dart
```

## 🎨 Funcionalidades

### Tab 1: Inicio
- Consume la API de TMDB para mostrar películas populares y en tendencia
- Filtros por categorías: Todas, Populares, Tendencias
- Carrusel horizontal tipo Netflix
- Grid de películas con detalles
- Al tocar una película, se muestra el detalle completo

### Tab 2: Mi Colección
- **"Quiero ver"**: Películas que quieres ver después
- **"Me gustó"**: Películas que te gustaron
- Botón para agregar películas manualmente
- Formulario para agregar películas personalizadas

### Tab 3: Con mi novia
- Lista de películas marcadas para ver juntos
- Se agregan desde el detalle de película usando el botón ❤️

### Detalle de Película
- Banner e imagen principal
- Título, año, duración, rating
- Sinopsis completa
- Géneros
- **4 botones de acción**:
  - ⭐ Visto y me gustó
  - ❤️ Para ver con mi novia
  - 👁️ Para ver más tarde
  - 👎 No me gustó

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework multiplataforma
- **Provider**: Gestión de estado (MVVM)
- **Dio**: Cliente HTTP para peticiones API
- **GetIt**: Inyección de dependencias
- **Equatable**: Comparación de objetos
- **Cached Network Image**: Carga y caché de imágenes
- **Google Fonts**: Tipografía moderna (Poppins)
- **Shared Preferences**: Almacenamiento local

## 📱 Requisitos

- Flutter SDK: ^3.9.2
- Dart SDK: ^3.9.2

## 🎯 Próximas Mejoras

- [ ] Búsqueda de películas
- [ ] Sincronización con backend
- [ ] Filtros avanzados
- [ ] Recomendaciones personalizadas
- [ ] Compartir lista con amigos
- [ ] Modo offline

## 📝 Notas

- La app guarda los datos localmente usando SharedPreferences
- Las imágenes se cargan desde TMDB y se cachean automáticamente
- El tema está configurado con estilo oscuro tipo Netflix
- La arquitectura permite escalar fácilmente agregando nuevas funcionalidades

## 🤝 Contribuir

Siéntete libre de hacer fork y contribuir al proyecto.

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.

---

**¡Disfruta de tu app de películas! 🎬**
