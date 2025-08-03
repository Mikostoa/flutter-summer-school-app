/// Строковые константы.
abstract class AppStrings {
  /// Онбординг.
  static const onboardingSkipButton = 'Пропустить';
  static const onboardingPage1Title = 'Добро пожаловать\nв Путеводитель';
  static const onboardingPage1Description =
      'Ищи новые локации и сохраняй\nсамые любимые.';
  static const onboardingPage2Title = 'Построй маршрут\nи отправляйся в путь';
  static const onboardingPage2Description =
      'Достигай цели максимально\nбыстро и комфортно.';
  static const onboardingPage3Title = 'Добавляй места,\nкоторые нашёл сам';
  static const onboardingPage3Description =
      'Делись самыми интересными\nи помоги нам стать лучше!';
  static const onboardingStartButton = 'На старт';
  static const onboardingNextButton = 'Далее';

  /// Список мест.
  static const placesScreenAppBarTitle = 'Список мест';
  static const placesScreenBottomNavPlaces = 'Места';
  static const placesScreenBottomNavFavorites = 'Избранное';
  static const placesScreenBottomNavSettings = 'Настройки';

  /// Детали места.
  static const placeDetailsRouteButton = 'ПОСТРОИТЬ МАРШРУТ';
  static const placeDetailsFavoritesButton = 'В Избранное';
  static const placeDetailsInFavoritesButton = 'В Избранном';

  /// Снэк-бары для действий с карточкой.
  static const cardTapSnackbar = 'Тап по карточке';
  static const likeTapSnackbar = 'Лайк для';

  /// Загрузка, ошибки
  static const placesLoading = 'Загрузка';
  static const placesError = 'Что-то пошло не так.\\n Ошибка: ';
  static const noPhoto = 'Нет фото';

  /// Заглушки
  static const favoritesStub = 'Избранное (заглушка)';
  static const settingsStub = 'Настройки (заглушка)';
  static const favoritesEmpty = 'Пусто';

  // Настройки
  static const settingsScreenTitle = 'Настройки';
  static const settingsAppearanceSection = 'Внешний вид';
  static const settingsThemeToggle = 'Темная тема';
  static const settingsResetOnboarding = 'Смотреть туториал';

  static const searchHint = 'Поиск мест...';
  static const searchInitialTitle = 'Начните поиск';
  static const searchInitialDescription =
      'Введите минимум 3 символа для поиска мест';
  static const searchEmptyTitle = 'Ничего не найдено';
  static const searchEmptyDescription = 'Попробуйте изменить параметры поиска';
  static const searchErrorTitle = 'Ошибка поиска';

  static const hotel = 'Отель';
  static const restaurant = 'Ресторан';
  static const other = 'Другое';
  static const park = 'Парк';
  static const museum = 'Музей';
  static const cafe = 'Кафе';

  static const categories = 'Категории';
  static const showResults = 'ПОКАЗАТЬ';
  static const distance = 'Расстояние';
}
