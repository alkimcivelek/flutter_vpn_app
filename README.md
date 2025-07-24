Flutter ile geliştirilmiş, temiz mimari prensipleri ve modern state management çözümleri kullanılarak inşa edilmiştir. 
Tema desteği içerir.

Kurulum ve Kullanım:

1. Repository'yi Klonlayın
git clone https://github.com/alkimcivelek/flutter_vpn_app.git
cd flutter_vpn_app

2. Dependencies'leri Yükleyin
flutter pub get

3. Platform Kurulumu
Android
Android için ek kurulum gerekmez

iOS
cd ios
pod install
cd ..

4. Projeyi Çalıştırın
flutter run

5. Test Komutları
Unit testleri çalıştır
flutter test

Mimari Kararlar:
Proje MVVM prensiplerini takip eder:

State Management Strategy
Hibrit Yaklaşım: GetX + Riverpod
GetX: Ana business logic ve navigation

Riverpod: UI-specific state management

Design Patterns:
Repository Pattern
Dependency Injection Pattern
Observer Pattern

Responsive Design:
ScreenUtil ile responsive tasarım

Kullanılan Kütüphaneler ve Açıklamaları:
get: state management, dependency injection, route management, snackbar yönetimi
flutter_riverpod: type-safe state management
animate_do: hazır animasyonlar için kullanıldı
shimmer: loading iskeleti için kullanıldı, daha iyi bir ux için tercih edildi
lottie: daha kapsamlı animasyonlar için kullanıldı
flutter_screenutil: responsive tasarım ve kolay yönetim için kullanıldı
flutter_svg: svg görsellerini işlemek için kullanıldı
dio: http client için eklendi
shared_preferences: key-value tabanlı depolama, tema yönetimi
intl: tarih, numara formatlama
equatable: nesne karşılaştırma
cupertino_icons: ios icon
json_annotation: json serialization
freezed, freezed_annotation: immutable sınıflar için
mockito: mock nesneler oluşturmak için
build_runner: kod oluşturma motoru
json_serializable: json-dart dönüşümü
flutter_lints: kod kalitesi kuralları, best practices
