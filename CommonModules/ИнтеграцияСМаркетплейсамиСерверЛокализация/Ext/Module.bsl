﻿#Область СлужебныйПрограммныйИнтерфейс

// Возвращает имя регламентного задания.
// 
// Возвращаемое значение:
//    Строка - имя регламентного задания.
//
Функция ИмяРегламентногоЗадания() Экспорт
	
	ИмяРегламентногоЗадания = "";
	
	//++ Локализация
	ИмяРегламентногоЗадания = "ИнтеграцияСЯндексМаркетСервер.ЗагрузитьРекомендованныеЦеныЯндексМаркет";
	//-- Локализация
	
	Возврат ИмяРегламентногоЗадания;
	
КонецФункции    

// Возвращает имя формы выбора.
// 
// Возвращаемое значение:
//    Строка - имя формы выбора.
//
Функция ИмяФормыВыбора() Экспорт

	ИмяФормыВыбора = "";

	//++ Локализация
	ИмяФормыВыбора = НСтр("ru = 'Справочник.УчетныеЗаписиМаркетплейсов.Форма.ВыборЗагружаемыхВидовЦен'");
	//-- Локализация

	Возврат ИмяФормыВыбора;

КонецФункции

// Возвращает значение функциональной опции ИспользоватьИнтеграциюСЯндексМаркет для функционала, который не локализуется.
// 
// Возвращаемое значение:
//   Булево - значение функциональной опции ИспользоватьИнтеграциюСЯндексМаркет.
//
Функция ФункциональнаяОпцияИспользоватьИнтеграциюСЯндексМаркет() Экспорт
	
	ИспользоватьИнтеграциюСЯндексМаркет = Ложь;
	
	//++ Локализация
	ИспользоватьИнтеграциюСЯндексМаркет = ПолучитьФункциональнуюОпцию("ИспользоватьИнтеграциюСЯндексМаркет");
	//-- Локализация
	
	Возврат ИспользоватьИнтеграциюСЯндексМаркет;
	
КонецФункции

// Возвращает значение функциональной опции ИспользоватьИнтеграциюСOzon для функционала, который не локализуется.
// 
// Возвращаемое значение:
//   Булево - значение функциональной опции ИспользоватьИнтеграциюСOzon.
//
Функция ФункциональнаяОпцияИспользоватьИнтеграциюСOzon() Экспорт
	
	ИспользоватьИнтеграциюСOzon = Ложь;
	
	//++ Локализация
	ИспользоватьИнтеграциюСOzon = ПолучитьФункциональнуюОпцию("ИспользоватьИнтеграциюСOzon");
	//-- Локализация
	
	Возврат ИспользоватьИнтеграциюСOzon;
	
КонецФункции

// Возвращает настройки по способу задания цены.
//
// Возвращаемое значение:
//   Структура:
//     * ИмяПараметра      - Строка - имя параметра; 
//     * СписокВыбора      - Строка - список выбора (строка с разделителем);
//     * ЗначениеПараметра - Строка - значение параметра.
//
Функция НастройкиПоСпособуЗаданияЦеныЯндексМаркет() Экспорт
	
	НастройкиПоСпособуЗаданияЦены = Неопределено;
	
	//++ Локализация
	НастройкиПоСпособуЗаданияЦены = ИнтеграцияСЯндексМаркетСервер.СтруктураПараметровСпособаЗаданияЦены();
	//-- Локализация
	
	Возврат НастройкиПоСпособуЗаданияЦены;
	
КонецФункции

// Вызывает локализуемую процедуру ЗагрузитьРекомендованныеЦеныЯндексМаркет.
//
// Параметры:
//   УчетнаяЗапись           - СправочникСсылка.УчетныеЗаписиМаркетплейсов - учетная запись подключения к сервису;
//                           - Неопределено - выполнить регламентное задание по всем учетным записям, с которыми разрешен обмен данными.
//   ДополнительныеПараметры - Произвольный - произвольные данные, переданные в функцию;
//                           - Структура - возможные ключи дополнительных параметров:
//     * ПоРасписанию          - Булево - признак автоматического или ручного запуска регламентного задания;
//     * ТаблицаВидовЦен       - ТаблицаЗначений - загружаемые виды цен:
//       ** ВидЦены              - СправочникСсылка.ВидыЦен - вид цены.
//
Процедура ЗагрузитьРекомендованныеЦеныЯндексМаркет(УчетнаяЗапись, ДополнительныеПараметры) Экспорт
	
	//++ Локализация
	ИнтеграцияСЯндексМаркетСервер.ЗагрузитьРекомендованныеЦеныЯндексМаркет(УчетнаяЗапись, ДополнительныеПараметры);
	//-- Локализация
	
КонецПроцедуры

// Вызывает локализуемую процедуру ЗагрузитьЦеныOzon
//
// Параметры:
//   УчетнаяЗаписьМаркетплейса - СправочникСсылка.УчетныеЗаписиМаркетплейсов - учетная запись для загрузки;
//   ВидыЦен                   - Массив Из СправочникСсылка.ВидыЦен - загружаемые цены.
//
Процедура ЗагрузитьЦеныOzon(УчетнаяЗаписьМаркетплейса, ВидыЦен) Экспорт

	//++ Локализация
	ТаблицаТоваров = ИнтеграцияСМаркетплейсомOzonСервер.СведенияОВыгруженныхДанных();
	ИнтеграцияСМаркетплейсомOzonСервер.ЗагрузитьЦеныТоваров(УчетнаяЗаписьМаркетплейса, ТаблицаТоваров, ВидыЦен);
	//-- Локализация

КонецПроцедуры

// Возвращает настройки по способу задания цены
//
// Возвращаемое значение:
//                         Структура:
//                                   *ИмяПараметра - Строка - имя параметра 
//                                   *СписокВыбора - Строка - список выбора (строка с разделителем)
//                                   *ЗначениеПараметра - Строка - значение параметра
Функция НастройкиПоСпособуЗаданияЦеныOzon() Экспорт
	
	НастройкиПоСпособуЗаданияЦены = Неопределено;
	
	//++ Локализация
	НастройкиПоСпособуЗаданияЦены = ИнтеграцияСМаркетплейсомOzonСервер.СтруктураПараметровСпособаЗаданияЦены();
	//-- Локализация
	
	Возврат НастройкиПоСпособуЗаданияЦены;
	
КонецФункции

// Возвращает список значений выбора для способа задания цены
//
// Возвращаемое значение:
//                         СписокЗначений:
//                                   *Значение - Строка - идентификатор формулы 
//                                   *Представление - Строка - значение для списка выбора
//
Функция ЗагружаемыеТипыЦенНаOzon() Экспорт
	
	СписокТиповЦенНаOzon = Новый СписокЗначений;
	
	//++ Локализация
	СписокТиповЦенНаOzon = ИнтеграцияСМаркетплейсомOzonСервер.ЗагружаемыеТипыЦенНаOzon();
	//-- Локализация
	
	Возврат СписокТиповЦенНаOzon;
	
КонецФункции

// Возвращает детальную информацию по типам цен, используемым учетными записями Ozon.
//
// Параметры:
//  ВключатьВыгружаемые - Булево - Признак включения в результат функции выгружаемых типов цен.
//  ВключатьЗагружаемые - Булево - Признак включения в результат функции загружаемых типов цен.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - см. описание в ИнтеграцияСМаркетплейсомOzonСервер.ТипыЦенOzon.
//
Функция ТипыЦенOzon(ВключатьВыгружаемые = Истина, ВключатьЗагружаемые = Истина) Экспорт

	СписокТиповЦенНаOzon = Новый СписокЗначений;
	
	//++ Локализация
	СписокТиповЦенНаOzon = ИнтеграцияСМаркетплейсомOzonСервер.ТипыЦенOzon(ВключатьВыгружаемые, ВключатьЗагружаемые);
	//-- Локализация
	
	Возврат СписокТиповЦенНаOzon;

КонецФункции

// Возвращает список настроек подключения к маркетплейсу Ozon.
//
// Возвращаемое значение:
//   СписокЗначений Из СправочникСсылка.УчетныеЗаписиМаркетплейсов - не помеченные на удаление учетные записи Ozon.
//
Функция СписокНастроекПодключенияКСервису() Экспорт
	
	СписокНастроек = Новый СписокЗначений;
	
	//++ Локализация
	СписокНастроек = ИнтеграцияСМаркетплейсомOzonСервер.СписокНастроекПодключенияКСервису();
	//-- Локализация
	
	Возврат СписокНастроек;
	
КонецФункции  

// Возвращает типы цен, для которых необходима детализация по учетной записи.
//
// Возвращаемое значение:
//   Массив Из Строка - наименования загружаемых типов цен для учетных записей.
//
Функция ПолучитьТипыЦенНаOzonДляУчетныхЗаписей() Экспорт

	ТипыЦенНаOzonДляУчетныхЗаписей = Новый Массив;
	
	//++ Локализация
	ТипыЦенНаOzonДляУчетныхЗаписей = ИнтеграцияСМаркетплейсомOzonСервер.ПолучитьТипыЦенНаOzonДляУчетныхЗаписей();
	//-- Локализация
	
	Возврат ТипыЦенНаOzonДляУчетныхЗаписей;

КонецФункции

// Вызывает локализуемую процедуру ДобавитьЗаполнитьУчетнуюЗапись.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - изменяемая форма.
//
Процедура ДобавитьЗаполнитьУчетнуюЗапись(Форма) Экспорт

	//++ Локализация
	Если Форма.Параметры.Свойство("УчетнаяЗаписьМаркетплейса") Тогда
		ИнтеграцияСМаркетплейсомOzonСервер.ДобавитьЗаполнитьУчетнуюЗапись(Форма);
	КонецЕсли;
	//-- Локализация

КонецПроцедуры

// Вызывает локализуемую процедуру ДобавитьЗаполнитьУчетнуюЗапись
//
// Параметры:
//  СтруктураНастроек - Структура - данные, структура настроек.
//  Компоновщик       - КомпоновщикНастроек - компоновщик макета компоновки данных.
//
Процедура ЗаполнитьУчетнуюЗапись(СтруктураНастроек, Компоновщик) Экспорт

	//++ Локализация
	ИнтеграцияСМаркетплейсомOzonСервер.ЗаполнитьУчетнуюЗапись(СтруктураНастроек, Компоновщик);
	//-- Локализация

КонецПроцедуры

// Заполняет учетную запись в настройках компоновщика данных.
//
// Параметры:
//  Форма                 - ФормаКлиентскогоПриложения - Изменяемая форма.
//  НастройкиКомпоновщика - НастройкиКомпоновкиДанных - настройки компоновки данных.
//
Процедура УстановитьУчетнуюЗапись(Форма, НастройкиКомпоновщика) Экспорт

	//++ Локализация
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "УчетнаяЗаписьМаркетплейса") Тогда
		КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкиКомпоновщика, "УчетнаяЗаписьМаркетплейса", Форма.УчетнаяЗаписьМаркетплейса);
	КонецЕсли;
	//-- Локализация

КонецПроцедуры

// Добавляет учетную запись в структуру настроек.
//
// Параметры:
//  Форма             - ФормаКлиентскогоПриложения - Изменяемая форма.
//  СтруктураНастроек - Структура - данные, структура настроек.
//
Процедура ДополнитьСтруктуруНастроекДляМаркетплейсов(Форма, СтруктураНастроек) Экспорт

	//++ Локализация
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "УчетнаяЗаписьМаркетплейса") Тогда
		СтруктураНастроек.Вставить("УчетнаяЗаписьМаркетплейса", Форма.УчетнаяЗаписьМаркетплейса);
	КонецЕсли;
	//-- Локализация

КонецПроцедуры

// Дополняет текст запроса СКД для ценообразования. Вызывается из обработки ПодборТоваровПоОтбору.
//
// Параметры:
//  СхемаКомпоновкиДанных - СхемаКомпоновкиДанных - Модифицируемая схема.
//
Процедура ДополнитьСКДДляМаркетплейсов(Форма, СхемаКомпоновкиДанных) Экспорт

	//++ Локализация
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "УчетнаяЗаписьМаркетплейса") Тогда
		ИнтеграцияСМаркетплейсомOzonСервер.ДополнитьСКДДляМаркетплейсов(СхемаКомпоновкиДанных);
	КонецЕсли;
	//-- Локализация

КонецПроцедуры

// Дополняет текст запроса для подбора товаров. Вызывается из обработки ПодборТоваровВДокументПродажи.
//
// Параметры:
//  ШаблонТекстЗапроса - Строка - Текст запроса для динамического списка;
//  ТипСписка          - Строка - Может принимать значения: СписокНоменклатура, СписокХарактеристики, СписокНоменклатураПартнера.
//
Процедура ДополнитьТекстЗапросаДляМаркетплейсов(Форма, ШаблонТекстЗапроса, ТипСписка) Экспорт

	//++ Локализация
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "УчетнаяЗаписьМаркетплейса") Тогда
		ИнтеграцияСМаркетплейсомOzonСервер.ДополнитьТекстЗапросаДляМаркетплейсов(ШаблонТекстЗапроса, ТипСписка);
	КонецЕсли;
	//-- Локализация

КонецПроцедуры

// Дополняет условное оформление динамического списка.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Изменяемая форма.
//
Процедура УстановитьУсловноеОформлениеДинамическихСписков(Форма) Экспорт

	//++ Локализация
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "УчетнаяЗаписьМаркетплейса") Тогда
		ИнтеграцияСМаркетплейсомOzonСервер.УстановитьУсловноеОформлениеДинамическихСписков(Форма);
	КонецЕсли;
	//-- Локализация

КонецПроцедуры

// Устанавливает параметры динамических списков формы подбора номенклатуры.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Изменяемая форма.
//  СписокНоменклатура - ДинамическийСписок - реквизит формы СписокНоменклатура.
//  СписокХарактеристики - ДинамическийСписок - реквизит формы СписокХарактеристики.
//
Процедура УстановитьПараметрыДинамическогоСписка(Форма, СписокНоменклатура, СписокХарактеристики) Экспорт

	//++ Локализация
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "УчетнаяЗаписьМаркетплейса") Тогда
		ПодборТоваровКлиентСервер.УстановитьПараметрДинамическогоСписка(СписокНоменклатура, "УчетнаяЗаписьМаркетплейса", Форма.УчетнаяЗаписьМаркетплейса);
		ПодборТоваровКлиентСервер.УстановитьПараметрДинамическогоСписка(СписокХарактеристики, "УчетнаяЗаписьМаркетплейса", Форма.УчетнаяЗаписьМаркетплейса);
	КонецЕсли;
	//-- Локализация

КонецПроцедуры

// Сведения о выгруженных данных
//
// Возвращаемое значение:
//  ТаблицаЗначений - пустая таблица для заполнения выгруженными данными.
//
Функция СведенияОВыгруженныхДанных() Экспорт

	ТаблицаТоваров = Новый ТаблицаЗначений;

	//++ Локализация
	ТаблицаТоваров = ИнтеграцияСМаркетплейсомOzonСервер.СведенияОВыгруженныхДанных();
	//-- Локализация

	Возврат ТаблицаТоваров;

КонецФункции

// Вызывает локализуемую процедуру ЗагрузитьЦеныТоваров
//
// Параметры:
//   УчетнаяЗаписьМаркетплейса - СправочникСсылка.УчетныеЗаписиМаркетплейсов - учетная запись для загрузки.
//   ТаблицаТоваров            - ТаблицаЗначений - обрабатываемые товарные позиции, см. СведенияОВыгруженныхДанных.
//   ВидыЦен                   - Массив Из СправочникСсылка.ВидыЦен - загружаемые цены.
//
Процедура ЗагрузитьЦеныТоваров(УчетнаяЗаписьМаркетплейса, ТаблицаТоваров, ВидыЦен = Неопределено) Экспорт

	//++ Локализация
	ИнтеграцияСМаркетплейсомOzonСервер.ЗагрузитьЦеныТоваров(УчетнаяЗаписьМаркетплейса, ТаблицаТоваров, ВидыЦен);
	//-- Локализация

КонецПроцедуры

// Возвращает значение произвольного типа параметра способа задания цены.
//
// Возвращаемое значение:
//   СправочникСсылка.УчетныеЗаписиМаркетплейсов, Неопределено - значение пустая ссылка или Неопределено.
//
Функция ПараметрыСпособаЗаданияЦеныПроизвольныйТипПоУмолчанию() Экспорт

	ЗначениеПоУмолчанию = Неопределено;

	//++ Локализация
	ЗначениеПоУмолчанию = ПредопределенноеЗначение("Справочник.УчетныеЗаписиМаркетплейсов.ПустаяСсылка");
	//-- Локализация

	Возврат ЗначениеПоУмолчанию;

КонецФункции

// Возвращает признак использования интеграции хотя бы с одним маркетплейсом.
//
// Возвращаемое значение:
//  Булево - Признак использования интеграции.
//
Функция ИспользуетсяИнтеграцияСМаркетплейсами() Экспорт
	
	ИспользуетсяИнтеграцияСМаркетплейсами = Ложь;
	
	//++ Локализация
	ИспользуетсяИнтеграцияСМаркетплейсами = ИнтеграцияСМаркетплейсамиСервер.ИспользуетсяИнтеграцияСМаркетплейсами();
	//-- Локализация
	
	Возврат ИспользуетсяИнтеграцияСМаркетплейсами;
	
КонецФункции

#КонецОбласти
