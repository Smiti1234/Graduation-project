﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область Системные

// Возвращает номер версии библиотеки подключаемого оборудования
//
// Возвращаемое значение:
//  Строка.
//
Функция ВерсияБиблиотеки() Экспорт
	
	ВерсияБиблиотекиБПО = "3.1.10.48";
	Возврат ВерсияБиблиотекиБПО;
	
КонецФункции

// Ведется учет ИСМП в конфигурации
// 
// Возвращаемое значение:
//  Булево - Ведется учет ИСМП в конфигурации.
//
Функция ВедетсяУчетПродукцииИСМП() Экспорт
	
	СтандартнаяОбработка = Истина;
	УчетПродукцииИСМП = Ложь;
	МенеджерОборудованияВызовСервераПереопределяемый.ВедетсяУчетПродукцииИСМП(УчетПродукцииИСМП, СтандартнаяОбработка);
	Результат = ?(Не СтандартнаяОбработка, УчетПродукцииИСМП, Ложь); 
	Возврат Результат;
	
КонецФункции

// Заполняет данные о макетах
// Параметры:
//   ИмяДрайвера - Строка- 
//   ИмяМакетаДрайвера - Строка- 
//   МакетДоступен - Булево- 
//   ШаблонЛокализации - Строка- 
//   КодЯзыка - Строка- 
//
Процедура ЗаполнитьДанныеМакетов(ИмяДрайвера, ИмяМакетаДрайвера, МакетДоступен, ШаблонЛокализации, КодЯзыка) Экспорт
	
	ИмяМакетаДрайвера = ?(ПустаяСтрока(ИмяМакетаДрайвера), ИмяДрайвера, ИмяМакетаДрайвера);    
	МакетДрайвера = Метаданные.ОбщиеМакеты.Найти(ИмяМакетаДрайвера);                                                            
	
	Если МакетДрайвера <> Неопределено И МакетДрайвера.ТипМакета = Метаданные.СвойстваОбъектов.ТипМакета.ВнешняяКомпонента Тогда
		МакетДоступен = Истина;                 
		Если Не ПустаяСтрока(КодЯзыка) Тогда // Проверяем файл с наличием локализации
			МакетШаблонЛокализации = ИмяМакетаДрайвера + "_" + КодЯзыка;   
			МакетШаблон = Метаданные.ОбщиеМакеты.Найти(МакетШаблонЛокализации);
			Если МакетШаблон <> Неопределено И МакетШаблон.ТипМакета = Метаданные.СвойстваОбъектов.ТипМакета.ТекстовыйДокумент Тогда
				ШаблонЛокализации = ПолучитьОбщийМакет(МакетШаблонЛокализации).ПолучитьТекст();
			КонецЕсли;              
		КонецЕсли;              
	Иначе // Проверяем наличие драйвера по маске типа "*_ru"
		Если Не ПустаяСтрока(КодЯзыка) Тогда
			ИмяМакетаДрайвера = ИмяМакетаДрайвера + "_" + КодЯзыка;   
			МакетШаблон = Метаданные.ОбщиеМакеты.Найти(ИмяМакетаДрайвера);
			МакетДоступен = МакетШаблон <> Неопределено И МакетШаблон.ТипМакета = Метаданные.СвойстваОбъектов.ТипМакета.ВнешняяКомпонента;
		КонецЕсли;              
	КонецЕсли;              
	ИмяМакетаДрайвера = "ОбщийМакет." + ИмяМакетаДрайвера;     
	
КонецПроцедуры

#КонецОбласти

#Область Интеграция

// Вызывается из процедуры РегламентныеЗаданияПереопределяемый.ПриОпределенииНастроекРегламентныхЗаданий
// для установки доступности регламентного задания, определяет зависимость от функциональных опций.
// 
// Параметры:
//  Настройки - ТаблицаЗначений
//  ФункциональнаяОпция - ОбъектМетаданныхФункциональнаяОпция
Процедура ПриОпределенииНастроекРегламентныхЗаданий(Настройки, ФункциональнаяОпция) Экспорт
	
	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.ОчисткаИсторииПлатежныхОпераций;
	Настройка.ФункциональнаяОпция = ФункциональнаяОпция;
	
	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.ОчисткаИсторииФискальныхОпераций;
	Настройка.ФункциональнаяОпция = ФункциональнаяОпция;

	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.ОчисткаИсторииОперацийОчередиЧеков;
	Настройка.ФункциональнаяОпция = ФункциональнаяОпция;

	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.РассылкаЭлектронныхЧеков;
	Настройка.ФункциональнаяОпция = ФункциональнаяОпция;
	
КонецПроцедуры

// См. ОчередьЗаданийПереопределяемый.ПриПолученииСпискаШаблонов
Процедура ПриПолученииСпискаШаблонов(ШаблоныЗаданий) Экспорт
	
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.РассылкаЭлектронныхЧеков.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ОчисткаИсторииПлатежныхОпераций.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ОчисткаИсторииФискальныхОпераций.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ОчисткаИсторииОперацийОчередиЧеков.Имя);
	
КонецПроцедуры

// См. ОчередьЗаданийПереопределяемый.ПриОпределенииПсевдонимовОбработчиков
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
	
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.РассылкаЭлектронныхЧеков.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.ОчисткаИсторииПлатежныхОпераций.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.ОчисткаИсторииФискальныхОпераций.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.ОчисткаИсторииОперацийОчередиЧеков.ИмяМетода);
	
КонецПроцедуры

#КонецОбласти

#Область ОбновлениеДрайверов

// Обновить поставляемые драйвера БПО.
//
Процедура ОбновитьПоставляемыеДрайвера() Экспорт
	
	МодулиОбновления = Новый Массив();
	Если МенеджерОборудованияВызовСервера.ИспользуетсяУстройстваВвода() Тогда
		МодулиОбновления.Добавить(ОбщегоНазначения.ОбщийМодуль("ОборудованиеУстройстваВводаОбновление"));       
	КонецЕсли;
	Если МенеджерОборудованияВызовСервера.ИспользуетсяЧекопечатающиеУстройства() Тогда
		МодулиОбновления.Добавить(ОбщегоНазначения.ОбщийМодуль("ОборудованиеЧекопечатающиеУстройстваОбновление"));       
	КонецЕсли;
	Если МенеджерОборудованияВызовСервера.ИспользуетсяПлатежныеСистемы() Тогда
		МодулиОбновления.Добавить(ОбщегоНазначения.ОбщийМодуль("ОборудованиеПлатежныеСистемыОбновление"));       
	КонецЕсли;          
	Если МенеджерОборудованияВызовСервера.ИспользуетсяДисплеиПокупателя() Тогда
		МодулиОбновления.Добавить(ОбщегоНазначения.ОбщийМодуль("ОборудованиеДисплеиПокупателяОбновление"));       
	КонецЕсли;
	Если МенеджерОборудованияВызовСервера.ИспользуетсяВесовоеОборудование() Тогда
		МодулиОбновления.Добавить(ОбщегоНазначения.ОбщийМодуль("ОборудованиеВесовоеОборудованиеОбновление"));       
	КонецЕсли;
	Если МенеджерОборудованияВызовСервера.ИспользуетсяТерминалыСбораДанных() Тогда
		МодулиОбновления.Добавить(ОбщегоНазначения.ОбщийМодуль("ОборудованиеТерминалыСбораДанныхОбновление"));       
	КонецЕсли;
	Если МенеджерОборудованияВызовСервера.ИспользуетсяПринтерыЭтикеток() Тогда
		МодулиОбновления.Добавить(ОбщегоНазначения.ОбщийМодуль("ОборудованиеПринтерыЭтикетокОбновление"));       
	КонецЕсли;
	Если МенеджерОборудованияВызовСервера.ИспользуетсяСчитывательRFID() Тогда
		МодулиОбновления.Добавить(ОбщегоНазначения.ОбщийМодуль("ОборудованиеСчитывательRFIDОбновление"));       
	КонецЕсли;

	ДрайвераОборудования = НоваяТаблицаПоставляемыхДрайверовОборудования();
	Для Каждого МодульОбновления Из МодулиОбновления Цикл
		МодульОбновления.ОбновитьПоставляемыеДрайвера(ДрайвераОборудования);
	КонецЦикла;
	
	Справочники.ДрайверыОборудования.ПриНачальномЗаполненииЭлементов(ДрайвераОборудования);
	
	УдалитьУстаревшиеДрайвера();
	
КонецПроцедуры

// Обновить установленные драйвера.
//
Процедура ОбновитьУстановленныеДрайвера() Экспорт
	
	// ККТ с передачей данных ОФД
	ОбновитьУстановленныеДрайвераПоТипу(Перечисления.ТипыПодключаемогоОборудования.ККТ);
	// Конец ККТ с передачей данных ОФД.
	
	// Принтеры чеков
	ОбновитьУстановленныеДрайвераПоТипу(Перечисления.ТипыПодключаемогоОборудования.ПринтерЭтикеток);
	// Конец Принтеры чеков.
	
	// Сканеры штрихкода
	ОбновитьУстановленныеДрайвераПоТипу(Перечисления.ТипыПодключаемогоОборудования.СканерШтрихкода);
	// Конец Сканеры штрихкода
	
КонецПроцедуры

// Записывает изменения в переданном объекте.
// Для использования в обработчиках обновления.
//
// Параметры:
//   Данные                            - Произвольный - объект, набор записей или менеджер константы, который
//                                                      необходимо записать.
//   РегистрироватьНаУзлахПлановОбмена - Булево       - включает регистрацию на узлах планов обмена при записи объекта.
//   ВключитьБизнесЛогику              - Булево       - включает бизнес-логику при записи объекта.
//
Процедура ЗаписатьДанные(Знач Данные, Знач РегистрироватьНаУзлахПлановОбмена = Ложь, Знач ВключитьБизнесЛогику = Ложь) Экспорт
	
	Данные.ОбменДанными.Загрузка = Не ВключитьБизнесЛогику;
	Если Не РегистрироватьНаУзлахПлановОбмена Тогда
		Данные.ДополнительныеСвойства.Вставить("ОтключитьМеханизмРегистрацииОбъектов");
		Данные.ОбменДанными.Получатели.АвтоЗаполнение = Ложь;
	КонецЕсли;
	
	Данные.Записать();
	
КонецПроцедуры

// Устанавливает признак необходимости переустановки оборудования для подключаемого оборудования на рабочем месте.
//
// Параметры:
//  РабочееМесто - СправочникСсылка.РабочиеМеста.
//  ДрайверОборудования - СправочникСсылка.ДрайверыОборудования. 
//  Признак - Булево - требуется переустановить драйвер
//
Процедура УстановитьПризнакПереустановкиДрайвера(РабочееМесто, ДрайверОборудования, Признак) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ  
	|	ПодключаемоеОборудование.Ссылка
	|ИЗ
	|	Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
	|ГДЕ
	|	ПодключаемоеОборудование.РабочееМесто = &РабочееМесто
	|	И ПодключаемоеОборудование.ДрайверОборудования = &ДрайверОборудования
	|	И НЕ ПодключаемоеОборудование.ТребуетсяПереустановка = &ТребуетсяПереустановка"); 
	
	Запрос.УстановитьПараметр("РабочееМесто", РабочееМесто);
	Запрос.УстановитьПараметр("ДрайверОборудования", ДрайверОборудования);
	Запрос.УстановитьПараметр("ТребуетсяПереустановка", Признак);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
		СправочникОбъект.ТребуетсяПереустановка = Признак;
		ЗаписатьДанные(СправочникОбъект)
	КонецЦикла;
	
КонецПроцедуры

// Обновить установленные драйвера по справочнику подключаемого оборудования.
//
// Параметры:
//  ТипОборудования - ПеречисленияСсылка.ТипыПодключаемогоОборудования
Процедура ОбновитьУстановленныеДрайвераПоТипу(ТипОборудования) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("ВЫБРАТЬ
							|	ПодключаемоеОборудование.Ссылка
							|ИЗ
							|	Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
							|ГДЕ
							|	(ПодключаемоеОборудование.ТипОборудования = &ТипОборудования)");
							
	Запрос.УстановитьПараметр("ТипОборудования", ТипОборудования);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
		СправочникОбъект.ТребуетсяПереустановка = Истина;
		ЗаписатьДанные(СправочникОбъект)
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ПанельАдминистрирования

// Создает новый раздел на форме Панели администрирования.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения
//  ИмяГруппы - Строка
//  Родитель - ГруппаФормы
//           - Неопределено
//  Элемент - ГруппаФормы
//          - Неопределено
//
// Возвращаемое значение:
//  ГруппаФормы
Функция НоваяГруппаПанелиАдминистрирования(Форма, ИмяГруппы, Родитель = Неопределено, Элемент = Неопределено) Экспорт
	
	Элементы = Форма.Элементы;
	Если Элемент = Неопределено Тогда
		Если Родитель = Неопределено Тогда
			Группа = Элементы.Вставить(ИмяГруппы, Тип("ГруппаФормы"), , Элементы.ГруппаДополнительно);
		Иначе
			Группа = Элементы.Вставить(ИмяГруппы, Тип("ГруппаФормы"), Родитель);
		КонецЕсли;
	Иначе
		Группа = Элементы.Вставить(ИмяГруппы, Тип("ГруппаФормы"), Родитель, Элемент);
	КонецЕсли;
	Группа.Вид                   = ВидГруппыФормы.ОбычнаяГруппа;
	Группа.Поведение             = ПоведениеОбычнойГруппы.Свертываемая;
	Группа.ОтображениеУправления = ОтображениеУправленияОбычнойГруппы.Картинка;
	Группа.Отображение = ОтображениеОбычнойГруппы.ОбычноеВыделение;
	Группа.ОтображатьОтступСлева = Истина;
	Группа.Скрыть();
	Возврат Группа;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Функция возвращает Истина, если внедрена Библиотека стандартных подсистем
//
// Возвращаемое значение:
//  Булево.
Функция ИспользуетсяБСП() Экспорт
	// СтандартныеПодсистемы.Пользователи - одна из обязательных подсистем БСП при внедрении
	Возврат ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Пользователи");
КонецФункции

Процедура ЗаписатьОшибкуВЖурналРегистрации(ИмяСобытия, Комментарий = Неопределено, Метаданные = Неопределено) Экспорт
	#Если НЕ МобильноеПриложениеСервер Тогда
		Если Комментарий = Неопределено Тогда
			Комментарий = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		КонецЕсли;
		ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, Метаданные, ,Комментарий);
	#КонецЕсли
КонецПроцедуры

#Область ЛогированиеОпераций

// Выполнят очистку истории платежных операций
//
Процедура ОчисткаИсторииПлатежныхОпераций() Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания(Метаданные.РегламентныеЗадания.ОчисткаИсторииПлатежныхОпераций);
	
	Если Не МенеджерОборудованияВызовСервера.ДоступноЛогированиеПлатежныхОпераций() Тогда
		Возврат;
	КонецЕсли;
	
	ПериодХранения = ПериодХраненияИсторииПлатежныхОпераций();
	ДатаОчистки    = ОпределитьДатуОчисткиОпераций(ПериодХранения);
	Если ДатаОчистки = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РегистрыСведений.ПлатежныеОперации.ОчиститьРегистрЗаПрошлыеМесяцы(ДатаОчистки);
	РегистрыСведений.ПлатежныеОперации.ОчиститьРегистрЗаТекущийМесяц (ДатаОчистки);
	
КонецПроцедуры

// Выполнят очистку истории фискальных операций
//
Процедура ОчисткаИсторииФискальныхОпераций() Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания(Метаданные.РегламентныеЗадания.ОчисткаИсторииФискальныхОпераций);
	
	ПериодХранения = ПериодХраненияИсторииФискальныхОпераций();
	ДатаОчистки    = ОпределитьДатуОчисткиОпераций(ПериодХранения);
	Если ДатаОчистки = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РегистрыСведений.ФискальныеОперации.ОчиститьРегистрДоДаты(ДатаОчистки);
	
КонецПроцедуры

// Выполнят очистку истории операций очереди чеков
//
Процедура ОчисткаИсторииОперацийОчередиЧеков() Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания(Метаданные.РегламентныеЗадания.ОчисткаИсторииОперацийОчередиЧеков);
	
	ПериодХранения = ПериодХраненияИсторииОперацийОчередиЧеков();
	ДатаОчистки    = ОпределитьДатуОчисткиОпераций(ПериодХранения);
	Если ДатаОчистки = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РегистрыСведений.ОчередьЧековККТ.ОчиститьРегистрДоДаты(ДатаОчистки);
	
КонецПроцедуры

#КонецОбласти

#Область ПанельАдминистрирования

// Вызывается из модуля формы Панель администрирования, формирует команды на форме
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения
//
Процедура ПанельАдминистрированияПриСозданииНаСервере(Форма) Экспорт
	
	ДанныеФормы = ДанныеФормы(Форма);
	ПараметрыРазмещения = Новый Структура();
	ПараметрыРазмещения.Вставить("ГруппаКомандЛево", Форма.Элементы.ГруппаДополнительноЛево);
	ПараметрыРазмещения.Вставить("ГруппаКомандПраво", Форма.Элементы.ГруппаДополнительноПраво);
	
	Если ДанныеФормы.ФункциональныеОпции.Количество() > 0 Тогда
		Форма.УстановитьПараметрыФункциональныхОпцийФормы(ДанныеФормы.ФункциональныеОпции);
	КонецЕсли;
	
	Команды = ДанныеФормы.Команды.Скопировать();
	ВывестиКоманды(Форма, Команды, ПараметрыРазмещения);
	
КонецПроцедуры

// Возвращает описание команды по имени элемента формы.
// 
// Параметры:
//  ИмяКомандыВФорме - Строка - Имя команды в форме
//  АдресНастроек - Строка - Адрес настроек
// 
// Возвращаемое значение:
//  ФиксированнаяСтруктура:
//   * Идентификатор - Строка
//   * Представление - Строка
//   * Подсказка - Строка
//   * ГруппаФормы - Неопределено, 
//                 - ГруппаФормы
//   * Важность - Строка
//   * Порядок - Число
//   * ФункциональныеОпции - Строка
//   * Менеджер - Строка
//   * Обработчик - Строка
//   * ДополнительныеПараметры - Структура
//   * ИмяФормы - Строка
//   * ПараметрыФормы - Структура, Неопределено
//   * ИмяПараметраФормы - Строка
//   * ПорядокВажности - Число
//   * ИмяВФорме - Строка
//
Функция ОписаниеКомандыПанелиАдминистрирования(ИмяКомандыВФорме, АдресНастроек) Экспорт
	
	Команды = ПолучитьИзВременногоХранилища(АдресНастроек);
	Команда = Команды.Найти(ИмяКомандыВФорме, "ИмяВФорме");
	Если Команда = Неопределено Тогда
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Сведения о команде ""%1"" не существуют.'"),
			ИмяКомандыВФорме);
	КонецЕсли;
	ОписаниеКоманды = ОбщегоНазначения.СтрокаТаблицыЗначенийВСтруктуру(Команда);
	
	Если ЗначениеЗаполнено(ОписаниеКоманды.ИмяФормы) Тогда
		ОписаниеКоманды.Вставить("Серверная", Ложь);
		МассивПодстрок = СтрРазделить(ОписаниеКоманды.ИмяФормы, ".");
		КоличествоПодстрок = МассивПодстрок.Количество();
		Если КоличествоПодстрок = 1
			Или (КоличествоПодстрок = 2 И ВРег(МассивПодстрок[0]) <> "ОБЩАЯФОРМА") Тогда
			ОписаниеКоманды.ИмяФормы = ОписаниеКоманды.Менеджер + "." + ОписаниеКоманды.ИмяФормы;
		КонецЕсли;
	Иначе
		ОписаниеКоманды.Вставить("Серверная", Истина);
		Если ЗначениеЗаполнено(ОписаниеКоманды.Обработчик) Тогда
			Если Не ПустаяСтрока(ОписаниеКоманды.Менеджер) И СтрНайти(ОписаниеКоманды.Обработчик, ".") = 0 Тогда
				ОписаниеКоманды.Обработчик = ОписаниеКоманды.Менеджер + "." + ОписаниеКоманды.Обработчик;
			КонецЕсли;
			Если СтрНачинаетсяС(ОписаниеКоманды.Обработчик, "e1cib") Тогда
				ОписаниеКоманды.Серверная = Ложь;
			ИначеЕсли СтрНайти(ОписаниеКоманды.Обработчик, "://")>0 Тогда
				ОписаниеКоманды.Серверная = Ложь;
			Иначе
				Если СтрНачинаетсяС(ВРег(ОписаниеКоманды.Обработчик), ВРег("ОбщийМодуль.")) Тогда
					ПозицияТочки = СтрНайти(ОписаниеКоманды.Обработчик, ".");
					ОписаниеКоманды.Обработчик = Сред(ОписаниеКоманды.Обработчик, ПозицияТочки + 1);
				КонецЕсли;
				МассивПодстрок = СтрРазделить(ОписаниеКоманды.Обработчик, ".");
				КоличествоПодстрок = МассивПодстрок.Количество();
				Если КоличествоПодстрок = 2 Тогда
					ИмяМодуля = МассивПодстрок[0];
					ОбъектМетаданныхОбщийМодуль = Метаданные.ОбщиеМодули.Найти(ИмяМодуля);
					Если ОбъектМетаданныхОбщийМодуль = Неопределено Тогда
						ВызватьИсключение СтрШаблон(
							НСтр("ru = 'Общий модуль ""%1"" не существует.'"),
							ИмяМодуля);
					КонецЕсли;
					Если ОбъектМетаданныхОбщийМодуль.КлиентУправляемоеПриложение Тогда
						ОписаниеКоманды.Серверная = Ложь;
					КонецЕсли;
				Иначе
					Вид = ВРег(МассивПодстрок[0]);
					ВидВоМножественномЧисле = ВидОбъектаМетаданныхВоМножественномЧисле(Вид);
					Если ВидВоМножественномЧисле <> Неопределено Тогда
						МассивПодстрок.Установить(0, ВидВоМножественномЧисле);
						ОписаниеКоманды.Обработчик = СтрСоединить(МассивПодстрок, ".");
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	ОписаниеКоманды.Удалить("Менеджер");
	ОписаниеКоманды.Удалить("ГруппаФормы");
	
	Возврат Новый ФиксированнаяСтруктура(ОписаниеКоманды);   
	
КонецФункции

// Обработчик команды формы, требующей контекстного вызова сервера.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - форма, из которой выполняется команда.
//   ПараметрыВызова - Структура
//   Источник - ТаблицаФормы
//            - ДанныеФормыСтруктура - объект или список формы с полем "Ссылка".
//   Результат - Структура - результат выполнения команды.
//
Процедура ВыполнитьКомандуПанелиАдминистрирования(Знач Форма, Знач ПараметрыВызова, Знач Источник, Результат = Неопределено) Экспорт
	
	Если ТипЗнч(ПараметрыВызова) <> Тип("Структура")
		Или ПараметрыВызова.Количество() <> 3
		Или ТипЗнч(Форма) <> Тип("ФормаКлиентскогоПриложения") Тогда
		Возврат;
	КонецЕсли;
	
	АдресНастроек = Форма.ПараметрыПодключаемыхКоманд.АдресТаблицыКоманд;
	ОписаниеКоманды = ОписаниеКомандыПанелиАдминистрирования(ПараметрыВызова.ИмяКомандыВФорме, АдресНастроек);
	
	ПараметрыВыполнения = ПараметрыВыполненияКоманды();
	ПараметрыВыполнения.ОписаниеКоманды = Новый Структура(ОписаниеКоманды);
	ПараметрыВыполнения.Форма = Форма;
	ПараметрыВыполнения.ЭтоФормаОбъекта = ТипЗнч(Источник) = Тип("ДанныеФормыСтруктура");
	ПараметрыВыполнения.Источник = Источник;
	
	ПараметрыЭкспортнойПроцедуры = Новый Массив;
	ПараметрыЭкспортнойПроцедуры.Добавить(ПараметрыВызова.ПараметрКоманды);
	ПараметрыЭкспортнойПроцедуры.Добавить(ПараметрыВыполнения);
	
	Обработчик = ОписаниеКоманды.Обработчик;
	ПрефиксОбщегоМодуля = НРег("ОбщийМодуль.");
	Если СтрНачинаетсяС(НРег(Обработчик), ПрефиксОбщегоМодуля) Тогда
		Обработчик = Сред(Обработчик, СтрДлина(ПрефиксОбщегоМодуля) + 1);
	КонецЕсли;
	
	ОбщегоНазначения.ВыполнитьМетодКонфигурации(Обработчик, ПараметрыЭкспортнойПроцедуры);
	
	Результат = ПараметрыВыполнения.Результат;
	ПараметрыВызова.Результат = ПараметрыВыполнения.Результат;
	
КонецПроцедуры

#КонецОбласти

// Возвращает пустую таблицу поставляемых драйверов оборудования. 
//
// Возвращаемое значение:
//  ТаблицаЗначений:
//   * ТипОборудования - ПеречислениеСсылка.ТипыПодключаемогоОборудования - тип оборудования
//   * Наименование - Строка - наименование оборудования
//   * ИдентификаторОбъекта - Строка - уникальный идентификатор объекта
//   * ИмяДрайвера - Строка - внутреннее имя драйвера
//   * ИмяМакетаДрайвера - Строка - имя макета драйвера, если оно отличается от имени драйвера
//   * ВерсияДрайвера - Строка
//   * СнятСПоддержки - Булево - признак того, что драйвер снят с поддержки
//   * СпособПодключения - ПеречислениеСсылка.СпособПодключенияДрайвера
//   * ЛокальныйРежим - Булево - признак локальности драйвера
//   * СетевойРежим - Булево - признак работы в сетевом режиме
//   * СерверныйРежим - Булево
//
Функция НоваяТаблицаПоставляемыхДрайверовОборудования() Экспорт
	
	ДрайвераОборудования = Новый ТаблицаЗначений;
	// Общие свойства.
	ДрайвераОборудования.Колонки.Добавить("ТипОборудования"     , Новый ОписаниеТипов("ПеречислениеСсылка.ТипыПодключаемогоОборудования"));
	ДрайвераОборудования.Колонки.Добавить("Наименование"        , Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("ИдентификаторОбъекта", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("ИмяДрайвера"         , Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("ИмяМакетаДрайвера"   , Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("ВерсияДрайвера"      , Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("СнятСПоддержки"      , Новый ОписаниеТипов("Булево"));
	ДрайвераОборудования.Колонки.Добавить("СпособПодключения"   , Новый ОписаниеТипов("ПеречислениеСсылка.СпособПодключенияДрайвера"));
	// Параметры работы
	ДрайвераОборудования.Колонки.Добавить("ЛокальныйРежим", Новый ОписаниеТипов("Булево"));
	ДрайвераОборудования.Колонки.Добавить("СетевойРежим"  , Новый ОписаниеТипов("Булево"));
	ДрайвераОборудования.Колонки.Добавить("СерверныйРежим", Новый ОписаниеТипов("Булево"));   
	Возврат ДрайвераОборудования;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура УдалитьУстаревшиеДрайвера()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДрайверыОборудования.Ссылка КАК Ссылка,
		|	ДрайверыОборудования.Представление КАК Представление
		|ИЗ
		|	Справочник.ДрайверыОборудования КАК ДрайверыОборудования
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
		|		ПО ДрайверыОборудования.Ссылка = ПодключаемоеОборудование.ДрайверОборудования
		|ГДЕ
		|	ДрайверыОборудования.ТипОборудования = ЗНАЧЕНИЕ(Перечисление.ТипыПодключаемогоОборудования.ПустаяСсылка)
		|	И ПодключаемоеОборудование.Ссылка ЕСТЬ NULL";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		УстаревшийДрайверОбъект = Выборка.Ссылка.ПолучитьОбъект();
		Попытка
			УстаревшийДрайверОбъект.Заблокировать();
			УстаревшийДрайверОбъект.ОбменДанными.Загрузка = Истина;
			УстаревшийДрайверОбъект.ОбменДанными.Получатели.АвтоЗаполнение = Ложь;
			УстаревшийДрайверОбъект.ДополнительныеСвойства.Вставить("ОтключитьМеханизмРегистрацииОбъектов");
			УстаревшийДрайверОбъект.Удалить();
		Исключение
			ТекстОшибки = СтрШаблон(НСтр("ru = 'Не удается заблокировать удаляемый драйвер %1.'", 
				ОбщегоНазначения.КодОсновногоЯзыка()), Выборка.Представление);
			МенеджерОборудования.ЗаписатьОшибкуВЖурналРегистрации(ТекстОшибки);
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

#Область ЛогированиеОпераций

// Возвращает период хранения фискальных операций в регистре сведений
//
// Возвращаемое значение:
//   ПериодХранения - ПеречислениеСсылка.ПериодХраненияИсторииПлатежныхОпераций
Функция ПериодХраненияИсторииФискальныхОпераций()
	
	ПериодХранения = Неопределено;
	Если МенеджерОборудованияВызовСервера.ИспользуетсяЧекопечатающиеУстройства() Тогда
		МодульОборудованиеЧекопечатающиеУстройстваВызовСервера = ОбщегоНазначения.ОбщийМодуль("ОборудованиеЧекопечатающиеУстройстваВызовСервера");
		ПериодХранения = МодульОборудованиеЧекопечатающиеУстройстваВызовСервера.ПериодХраненияИсторииФискальныхОпераций();
	КонецЕсли;
	Возврат ПериодХранения;
	
КонецФункции

// Возвращает период хранения фискальных операций в регистре сведений
//
// Возвращаемое значение:
//   ПериодХранения - ПеречислениеСсылка.ПериодХраненияИсторииПлатежныхОпераций
Функция ПериодХраненияИсторииОперацийОчередиЧеков()
	
	ПериодХранения = Неопределено;
	Если МенеджерОборудованияВызовСервера.ИспользуетсяЧекопечатающиеУстройства() Тогда
		МодульОборудованиеЧекопечатающиеУстройстваВызовСервера = ОбщегоНазначения.ОбщийМодуль("ОборудованиеЧекопечатающиеУстройстваВызовСервера");
		ПериодХранения = МодульОборудованиеЧекопечатающиеУстройстваВызовСервера.ПериодХраненияИсторииОперацийОчередиЧеков();
	КонецЕсли;
	Возврат ПериодХранения;
	
КонецФункции

// Возвращает период хранения платежных операций в регистре сведений
//
// Возвращаемое значение:
//   ПериодХранения - ПеречислениеСсылка.ПериодХраненияИсторииПлатежныхОпераций
Функция ПериодХраненияИсторииПлатежныхОпераций()
	
	ПериодХранения = Неопределено;
	Если МенеджерОборудованияВызовСервера.ИспользуетсяПлатежныеСистемы() Тогда
		МодульОборудованиеПлатежныеСистемыВызовСервера = ОбщегоНазначения.ОбщийМодуль("ОборудованиеПлатежныеСистемыВызовСервера");
		ПериодХранения = МодульОборудованиеПлатежныеСистемыВызовСервера.ПериодХраненияИсторииПлатежныхОпераций();
	КонецЕсли;
	Возврат ПериодХранения;
	
КонецФункции

Функция ОпределитьДатуОчисткиОпераций(ПериодХранения)
	
	ТекущаяДата = МенеджерОборудованияВызовСервера.ДатаСеанса();
	Если ПериодХранения = Перечисления.ПериодХраненияИсторииПлатежныхОпераций.День Тогда
		ОдинДеньСекунды = 60*60*24*1;
		ДатаОчистки = ТекущаяДата - ОдинДеньСекунды;
	ИначеЕсли ПериодХранения = Перечисления.ПериодХраненияИсторииПлатежныхОпераций.Неделя Тогда
		НеделяСекунды = 60*60*24*7;
		ДатаОчистки = ТекущаяДата - НеделяСекунды;
	ИначеЕсли ПериодХранения = Перечисления.ПериодХраненияИсторииПлатежныхОпераций.Декада Тогда
		ДекадаСекунды = 60*60*24*10;
		ДатаОчистки = ТекущаяДата - ДекадаСекунды;
	ИначеЕсли ПериодХранения = Перечисления.ПериодХраненияИсторииПлатежныхОпераций.Месяц Тогда
		ДатаОчистки = ДобавитьМесяц(ТекущаяДата, -1);
	ИначеЕсли ПериодХранения = Перечисления.ПериодХраненияИсторииПлатежныхОпераций.Квартал Тогда
		ДатаОчистки = ДобавитьМесяц(ТекущаяДата, -3);
	ИначеЕсли ПериодХранения = Перечисления.ПериодХраненияИсторииПлатежныхОпераций.Полугодие Тогда
		ДатаОчистки = ДобавитьМесяц(ТекущаяДата, -6);
	ИначеЕсли ПериодХранения = Перечисления.ПериодХраненияИсторииПлатежныхОпераций.Год Тогда
		ДатаОчистки = ДобавитьМесяц(ТекущаяДата, -12);
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат ДатаОчистки;
	
КонецФункции

#КонецОбласти

#Область ПанельАдминистрирования

// Кэш формы, в которой будут выводиться подключаемые команды.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения
//
// Возвращаемое значение:
//  Структура:
//   * Команды - см. ТаблицаКоманд.
//   * ФункциональныеОпции - Структура
Функция ДанныеФормы(Форма)
	
	// Добавить команды
	Команды  = ТаблицаКоманд();
	ДанныеФормы = Новый Структура;
	ДанныеФормы.Вставить("Команды", Команды);
	ДанныеФормы.Вставить("ФункциональныеОпции", Новый Структура);
	
	МенеджерОборудованияВызовСервераПереопределяемый.ПриЗаполненииКомандПанелиАдминистрирования(Форма, Команды);
	
	Количество = Команды.Количество();
	Для Номер = 1 По Количество Цикл
		Команда = Команды[Количество - Номер];
		
		// Фильтр по функциональным опциям.
		ФункциональныеОпции = СтрРазделить(Команда.ФункциональныеОпции, ",", Ложь);
		ВидимостьКоманды = ФункциональныеОпции.Количество() = 0;
		Для Каждого ИмяОпции Из ФункциональныеОпции Цикл
			Если ПолучитьФункциональнуюОпцию(СокрЛП(ИмяОпции)) Тогда
				ВидимостьКоманды = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		Если Не ВидимостьКоманды Тогда
			Команды.Удалить(Команда);
			Продолжить;
		КонецЕсли;
		Команда.ПорядокВажности = ?(Команда.Важность = "Важное", 1, ?(Команда.Важность = "СмТакже", 3, 2));
		
		Если ПустаяСтрока(Команда.Идентификатор) Тогда
			Команда.Идентификатор = "Авто_" + ОбщегоНазначения.КонтрольнаяСуммаСтрокой(Команда.Менеджер + "/" + Команда.ИмяФормы + "/" + Команда.Обработчик);
		КонецЕсли;
	КонецЦикла;
	
	Возврат ДанныеФормы;
	
КонецФункции

// Свойства второго параметра обработчика подключаемой команды, выполняемой на сервере.
//
// Возвращаемое значение:
//  Структура:
//   * ОписаниеКоманды - Структура - состав свойств совпадает с колонками таблицы значений параметра Команды процедуры
///                                  ПодключаемыеКомандыПереопределяемый.ПриОпределенииКомандПодключенныхКОбъекту.
//                                   Ключевые свойства:
//      ** Идентификатор  - Строка - идентификатор команды.
//      ** Представление  - Строка - представление команды в форме.
//      ** Имя            - Строка - имя команды в форме.
//      ** ДополнительныеПараметры - Структура - дополнительные свойства, состав которых определяется видом 
//                                   конкретной команды.
//   * Форма - ФормаКлиентскогоПриложения - форма, из которой вызвана команда.
//   * ЭтоФормаОбъекта - Булево - Истина, если команда вызвана из формы объекта.
//   * Источник - ТаблицаФормы
//              - ДанныеФормыСтруктура - объект или список формы с полем "Ссылка".
//
Функция ПараметрыВыполненияКоманды()
	ПараметрыВыполнения = МенеджерОборудованияКлиентСервер.ПараметрыВыполненияКомандыПанелиАдминистрирования();
	
	// Служебные параметры.
	Результат = Новый Структура;
	Результат.Вставить("Текст",    "");
	Результат.Вставить("Подробно", "");
	ПараметрыВыполнения.Вставить("Результат", Результат);
	Возврат ПараметрыВыполнения;
	
КонецФункции

// Шаблон таблицы подключаемых команд.
//
// Возвращаемое значение:
//  ТаблицаЗначений:
//   * Идентификатор - Строка
//   * Представление - Строка
//   * Подсказка - Строка
//   * ГруппаФормы - Неопределено, 
//                 - ГруппаФормы
//   * Важность - Строка
//   * Порядок - Число
//   * ФункциональныеОпции - Строка
//   * Менеджер - Строка
//   * Обработчик - Строка
//   * ДополнительныеПараметры - Структура
//   * ИмяФормы - Строка
//   * ПараметрыФормы - Структура
//                    - Неопределено
//   * ИмяПараметраФормы - Строка
//   * ИмяВФорме - Строка
//
Функция ТаблицаКоманд()
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	
	// Настройки внешнего вида:
	Таблица.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Таблица.Колонки.Добавить("Подсказка", Новый ОписаниеТипов("Строка"));
	Таблица.Колонки.Добавить("ГруппаФормы", Новый ОписаниеТипов);
	Таблица.Колонки.Добавить("Важность", Новый ОписаниеТипов("Строка"));
	Таблица.Колонки.Добавить("Порядок", Новый ОписаниеТипов("Число"));
	// Настройки видимости и доступность:
	Таблица.Колонки.Добавить("ФункциональныеОпции", Новый ОписаниеТипов("Строка"));
	// Настройки обработчика:
	Таблица.Колонки.Добавить("Менеджер", Новый ОписаниеТипов("Строка"));
	Таблица.Колонки.Добавить("Обработчик", Новый ОписаниеТипов("Строка"));
	Таблица.Колонки.Добавить("ДополнительныеПараметры", Новый ОписаниеТипов("Структура"));
	Таблица.Колонки.Добавить("ИмяФормы", Новый ОписаниеТипов("Строка"));
	Таблица.Колонки.Добавить("ПараметрыФормы"); // Структура или Неопределено.
	Таблица.Колонки.Добавить("ИмяПараметраФормы", Новый ОписаниеТипов("Строка"));
	// Служебные:
	Таблица.Колонки.Добавить("ПорядокВажности", Новый ОписаниеТипов("Число"));
	Таблица.Колонки.Добавить("ИмяВФорме", Новый ОписаниеТипов("Строка"));
	
	Возврат Таблица;
КонецФункции

// Размещает подключенные команды в форме.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - форма, в которой необходимо разместить команды.
//   Команды - см. ТаблицаКоманд
//   ПараметрыРазмещения - см. ПараметрыРазмещения
//
Процедура ВывестиКоманды(Форма, Команды, ПараметрыРазмещения)
	
	ПодключенныеКоманды = ПодключенныеКоманды(Форма);
	ГруппаПоУмолчаниюЛево = ПараметрыРазмещения.ГруппаКомандЛево;
	ГруппаПоУмолчаниюПраво = ПараметрыРазмещения.ГруппаКомандПраво;
	
	Элементы = Форма.Элементы;
	
	// Вывод команд.
	Команды.Сортировать("ПорядокВажности Возр, Порядок Возр, Представление Возр");
	СчетчикКомандСАвтогенерируемымИменем = 0;
	НомерКомандыВГруппеПоУмолчанию = 0;
	Для Каждого Команда Из Команды Цикл 
		
		ГруппаФормы = Команда.ГруппаФормы; // ГруппаФормы
		Если Команда.ГруппаФормы = Неопределено Тогда
			Если НомерКомандыВГруппеПоУмолчанию%2=0 Тогда
				ГруппаФормы = ГруппаПоУмолчаниюЛево;
			Иначе
				ГруппаФормы = ГруппаПоУмолчаниюПраво;
			КонецЕсли;
			НомерКомандыВГруппеПоУмолчанию = НомерКомандыВГруппеПоУмолчанию + 1;
		КонецЕсли;
		
		Команда.ИмяВФорме = ОпределитьИмяКоманды(Форма, ГруппаФормы.Имя, Команда.Идентификатор, СчетчикКомандСАвтогенерируемымИменем);
		
		КомандаФормы = Форма.Команды.Добавить(Команда.ИмяВФорме);
		КомандаФормы.Действие = "Подключаемый_ВыполнитьКоманду";
		КомандаФормы.Заголовок = Команда.Представление;
		КомандаФормы.Подсказка   = КомандаФормы.Подсказка;
		
		
		КнопкаФормы = Элементы.Добавить(Команда.ИмяВФорме, Тип("КнопкаФормы"), ГруппаФормы);
		КнопкаФормы.Вид = ВидКнопкиФормы.Гиперссылка;
		Если Команда.ПорядокВажности = 1 Тогда
			КнопкаФормы.Шрифт = Новый Шрифт(КнопкаФормы.Шрифт,,,Истина);
		КонецЕсли;
		КнопкаФормы.ИмяКоманды = Команда.ИмяВФорме;
		Если ЗначениеЗаполнено(Команда.Подсказка) Тогда
			КнопкаФормы.РасширеннаяПодсказка.Заголовок = Команда.Подсказка; 
			КнопкаФормы.ОтображениеПодсказки = ОтображениеПодсказки.ОтображатьСнизу;
		КонецЕсли;
		КнопкаФормы.Ширина = 39;
		КнопкаФормы.РастягиватьПоГоризонтали = Ложь;
		
	КонецЦикла;
	
	ПодключенныеКоманды.АдресТаблицыКоманд = ПоместитьВоВременноеХранилище(Команды, Форма.УникальныйИдентификатор);
	
КонецПроцедуры

// Возвращает структуру параметров подключаемых команд из реквизита формы и при необходимости создает 
// реквизит формы ПараметрыПодключаемыхКоманд
//
// Возвращаемое значение:
//  Структура:
//   * АдресТаблицыКоманд - Строка
Функция ПодключенныеКоманды(Форма)
	
	ЗначенияСвойств = Новый Структура("ПараметрыПодключаемыхКоманд", Null);
	ЗаполнитьЗначенияСвойств(ЗначенияСвойств, Форма);

	Результат = ЗначенияСвойств.ПараметрыПодключаемыхКоманд;
	
	Если ТипЗнч(Результат) <> Тип("Структура") Тогда
		Если Результат = Null Тогда
			ДобавляемыеРеквизиты = Новый Массив;
			ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("ПараметрыПодключаемыхКоманд", Новый ОписаниеТипов));
			Форма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
		КонецЕсли;
		
		Результат = Новый Структура;
		Результат.Вставить("АдресТаблицыКоманд", Неопределено);
		
		Форма.ПараметрыПодключаемыхКоманд = Результат;
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

// Возвращает имя команды по имени группы и идентификатору, если имя не задано имя генерируется автоматически.
//
// Параметры:
//  Форма - Форма
//  ИмяГруппы - Строка
//  ИдентификаторКоманды - Строка
//  СчетчикКомандСАвтогенерируемымИменем - Число
//
// Возвращаемое значение:
//  Строка.
Функция ОпределитьИмяКоманды(Форма, ИмяГруппы, ИдентификаторКоманды, СчетчикКомандСАвтогенерируемымИменем)
	Если ИмяСоответствуетТребованиямИменованияСвойств(ИдентификаторКоманды) Тогда
		ИмяКоманды = ИмяГруппы + "_" + ИдентификаторКоманды;
	Иначе
		СчетчикКомандСАвтогенерируемымИменем = СчетчикКомандСАвтогенерируемымИменем + 1;
		ИмяКоманды = ИмяГруппы + "_" + Формат(СчетчикКомандСАвтогенерируемымИменем, "ЧН=; ЧГ=");
	КонецЕсли;
	Пока Форма.Элементы.Найти(ИмяКоманды) <> Неопределено
		Или Форма.Команды.Найти(ИмяКоманды) <> Неопределено Цикл
		СчетчикКомандСАвтогенерируемымИменем = СчетчикКомандСАвтогенерируемымИменем + 1;
		ИмяКоманды = ИмяГруппы + "_" + Формат(СчетчикКомандСАвтогенерируемымИменем, "ЧН=; ЧГ=");
	КонецЦикла;
	Возврат ИмяКоманды;
КонецФункции

Функция ИмяСоответствуетТребованиямИменованияСвойств(Имя)
	// АПК:163-выкл - особенности алгоритма
	Буквы = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ";
	// АПК:163-вкл
	Цифры = "1234567890";
	
	Если Имя = "" Или СтрНайти(Буквы + "_", ВРег(Лев(Имя, 1))) = 0 Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат СтрРазделить(ВРег(Имя), Буквы + Цифры + "_", Ложь).Количество() = 0;
КонецФункции

// Возвращает вид объекта во множественном числе.
Функция ВидОбъектаМетаданныхВоМножественномЧисле(Знач Вид)
	Вид = ВРег(СокрЛП(Вид));
	Если Вид = "ПЛАНОБМЕНА" Тогда
		Возврат "ПланыОбмена";
	ИначеЕсли Вид = "СПРАВОЧНИК" Тогда
		Возврат "Справочники";
	ИначеЕсли Вид = "ДОКУМЕНТ" Тогда
		Возврат "Документы";
	ИначеЕсли Вид = "ЖУРНАЛДОКУМЕНТОВ" Тогда
		Возврат "ЖурналыДокументов";
	ИначеЕсли Вид = "ПЕРЕЧИСЛЕНИЕ" Тогда
		Возврат "Перечисления";
	ИначеЕсли Вид = "ОТЧЕТ" Тогда
		Возврат "Отчеты";
	ИначеЕсли Вид = "ОБРАБОТКА" Тогда
		Возврат "Обработки";
	ИначеЕсли Вид = "ПЛАНВИДОВХАРАКТЕРИСТИК" Тогда
		Возврат "ПланыВидовХарактеристик";
	ИначеЕсли Вид = "ПЛАНСЧЕТОВ" Тогда
		Возврат "ПланыСчетов";
	ИначеЕсли Вид = "ПЛАНВИДОВРАСЧЕТА" Тогда
		Возврат "ПланыВидовРасчета";
	ИначеЕсли Вид = "РЕГИСТРСВЕДЕНИЙ" Тогда
		Возврат "РегистрыСведений";
	ИначеЕсли Вид = "РЕГИСТРНАКОПЛЕНИЯ" Тогда
		Возврат "РегистрыНакопления";
	ИначеЕсли Вид = "РЕГИСТРБУХГАЛТЕРИИ" Тогда
		Возврат "РегистрыБухгалтерии";
	ИначеЕсли Вид = "РЕГИСТРРАСЧЕТА" Тогда
		Возврат "РегистрыРасчета";
	ИначеЕсли Вид = "ПЕРЕРАСЧЕТ" Тогда
		Возврат "Перерасчеты";
	ИначеЕсли Вид = "БИЗНЕСПРОЦЕСС" Тогда
		Возврат "БизнесПроцессы";
	ИначеЕсли Вид = "ЗАДАЧА" Тогда
		Возврат "Задачи";
	ИначеЕсли Вид = "КОНСТАНТА" Тогда
		Возврат "Константы";
	ИначеЕсли Вид = "ПОСЛЕДОВАТЕЛЬНОСТЬ" Тогда
		Возврат "Последовательности";
	Иначе
		Возврат Неопределено;
	КонецЕсли;
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли
