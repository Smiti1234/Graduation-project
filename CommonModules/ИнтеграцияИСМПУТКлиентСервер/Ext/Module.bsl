﻿#Область ПрограммныйИнтерфейс

#Область АктыОРасхождениях

// Дополняет надпись состоянием кодов маркировки в документе.
//
// Параметры:
//  ТипДокумента - Тип - Тип документа.
//  НадписьРасхождения - Произвольный - элементы формы, в котором необходимо отобразить информационную надпись.
//  НадписьОформитьДокументы - Произвольный - элементы формы, в котором необходимо отобразить информационную надпись.
//  Товары - ТабличнаяЧасть - табличная часть акта о расхождениях.
//  ШтрихкодыУпаковокРасхождения - ТабличнаяЧасть - табличная часть штрихкоды упаковок расхождения.
//
Процедура ДополнитьНадписьСпособаОтраженияРасхождений(ТипДокумента, НадписьРасхождения, НадписьОформитьДокументы,
			Товары = Неопределено, ШтрихкодыУпаковокРасхождения = Неопределено) Экспорт
	
	Если ТипДокумента = Тип("ДокументСсылка.АктОРасхожденияхПослеОтгрузки") Тогда
		
		ТекстДействия = НСтр("ru = 'Требуется обработать коды маркировки.'");
		Если СтрЧислоВхождений(НадписьРасхождения.Заголовок, ТекстДействия) = 0 Тогда
			НадписьРасхождения.Заголовок = ТекстДействия +" " + НадписьРасхождения.Заголовок;
		КонецЕсли;
		
		Если СтрЧислоВхождений(НадписьОформитьДокументы.Заголовок, ТекстДействия) = 0 Тогда
			НадписьОформитьДокументы.Доступность = Ложь;
			НадписьОформитьДокументы.Заголовок = ТекстДействия + " " + НадписьОформитьДокументы.Заголовок;
		КонецЕсли;
		
	ИначеЕсли ТипДокумента = Тип("ДокументСсылка.АктОРасхожденияхПослеПриемки") Тогда
		
		Для Каждого ТекСтрока Из Товары Цикл
			
			Если ТекСтрока.КоличествоУпаковокРасхождения <> 0 И СтрокаАктаСодержитДействияТребующиеОбработки(ТекСтрока, ТипДокумента) Тогда
				Возврат;
			КонецЕсли;
			
		КонецЦикла;
		
		Если ШтрихкодыУпаковокРасхождения.Количество() Тогда
			ТекстРасхождений = НСтр("ru = 'Оформление расхождений по пересорту кодов маркировки в акте'");
			НадписьОформитьДокументы.Доступность = Истина;
			НадписьРасхождения.Заголовок = ТекстРасхождений;
		КонецЕсли;
		
	КонецЕсли;
		
	
КонецПроцедуры

Функция СтрокаАктаСодержитДействияТребующиеОбработки(ТекСтрока, ТипАкта)
	
	Если ТекСтрока.Действие <> ПредопределенноеЗначение("Перечисление.ВариантыДействийПоРасхождениямВАктеПослеПриемки.ВернутьПерепоставленноеБезОформления")
		И ТекСтрока.Действие <> ПредопределенноеЗначение("Перечисление.ВариантыДействийПоРасхождениямВАктеПослеПриемки.ОжидатьДопоставкуБезОформления") Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Устанавливает параметры выбора номенклатуры.
//
// Параметры:
//  ПараметрыВыбора - Массив - параметры выбора элемента формы "Номенклатура".
//  ВидПродукцииИС - ПеречислениеСсылка.ВидыПродукцииИС - Вид продукции ИС.
//
Процедура ЗаполнитьПараметрыВыбораНоменклатурыПоВидуПродукции(ПараметрыВыбора, ВидПродукцииИС) Экспорт
	
	ПараметрыВыбора.Добавить(Новый ПараметрВыбора("Отбор.ТипНоменклатуры", ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Товар")));
	
	ОсобенностьУчета = ИнтеграцияИСУТКлиентСервер.ОсобенностьУчетаПоВидуПродукции(ВидПродукцииИС);
	
	Если ОсобенностьУчета <> Неопределено Тогда
		ПараметрыВыбора.Добавить(Новый ПараметрВыбора("Отбор.ОсобенностьУчета", ОсобенностьУчета));
	КонецЕсли;
		
КонецПроцедуры

// Получает значение Признать определяемого типа ВариантДействийПоРасхождениямКодовМаркировкиИСМП
// 
// Возвращаемое значение:
//  ОпределяемыйТип.ВариантДействийПоРасхождениямКодовМаркировкиИСМП.
//
Функция ВариантДействийПоРасхождениямКодовМаркировкиИСМППризнать() Экспорт
	
	Возврат ПредопределенноеЗначение("Перечисление.ВариантыДействийПоРасхождениямКодовМаркировкиИСМП.Признать");

КонецФункции

// Получает значение НеПризнать определяемого типа ВариантДействийПоРасхождениямКодовМаркировкиИСМП
// 
// Возвращаемое значение:
//  ОпределяемыйТип.ВариантДействийПоРасхождениямКодовМаркировкиИСМП.
//
Функция ВариантДействийПоРасхождениямКодовМаркировкиИСМПНеПризнать() Экспорт
	
	Возврат ПредопределенноеЗначение("Перечисление.ВариантыДействийПоРасхождениямКодовМаркировкиИСМП.НеПризнать");

КонецФункции

//Параметры:
//	ПолноеИмяСтрокой - Строка
//Возвращаемое значение: 
//	Строка
Функция ИмяДокументаИзПолногоИмениОбъекта(ПолноеИмяСтрокой) Экспорт
	
	МассивИмен = СтрРазделить(ПолноеИмяСтрокой, ".");
	Если МассивИмен.Количество() = 2 Тогда
		Возврат МассивИмен[1];
	КонецЕсли;
	
	Возврат "";
	
КонецФункции

#Область Серии

//Подготовливает структуру, массив которых в дальнейшем будет передан в процедуру генерации серий.
//   Дополняется необходимыми полями, специфичными конкретному виду продукции.
//
//Параметры:
//   ВидМаркируемойПродукции - ПеречислениеСсылка.ВидыПродукцииИС - вид маркируемой продукции генерации серии
//Возвращаемое значение:
//   Структура - источник данных генерации серий с обязательными полями:
//    * Номенклатура - ОпределяемыйТип.Номенклатура - Номенклатура, для которой будет генерироваться серия.
//    * Серия        - ОпределяемыйТип.СерияНоменклатуры   - В данное значение будет записана сгенерированная серия.
//    * ЕстьОшибка   - Булево - Будет установлено в Истина, если по каким то причинам серия сгенерирована не будет.
//    * ТекстОшибки  - Строка - причина, по которой серия не генерировалась.
//
Функция СтруктураДанныхДляГенерацииСерии(ВидМаркируемойПродукции) Экспорт
	
	СтруктураДанных = Новый Структура;
	СтруктураДанных.Вставить("Номенклатура", Неопределено);
	СтруктураДанных.Вставить("Серия",        Неопределено);
	СтруктураДанных.Вставить("ЕстьОшибка",   Ложь);
	СтруктураДанных.Вставить("ТекстОшибки",  "");
	
	ДополнитьДанныеДляГенерацииСерииПоВидуПродукции(СтруктураДанных, ВидМаркируемойПродукции);
	
	Возврат СтруктураДанных;

КонецФункции

#КонецОбласти

#Область ПодключаемыеКомандыИС

// Заполняет структуру команд для динамического формирования доступных для создания документов на основании.
// 
// Параметры:
//  Команды - Структура - Исходящий, структура команд динамически формируемых для создания документов на основании.
//
Процедура КомандыМаркировкиТоваровИСМП(Команды) Экспорт 
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуОформить(Команды,"СборкаТоваров",                НСтр("ru = 'Сборку товаров'"),               "ИспользоватьСборкуРазборку");

	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды,"ПриобретениеТоваровУслуг",     НСтр("ru = 'Приобретение товаров и услуг'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды,"СборкаТоваров",                НСтр("ru = 'Сборку товаров'"),               "ИспользоватьСборкуРазборку");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды,"ПересчетТоваров",              НСтр("ru = 'Пересчет товаров'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ПроизводственнаяОперацияВЕТИС", НСтр("ru = 'Производственная операция ВетИС'"), "ВестиУчетПодконтрольныхТоваровВЕТИС");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ВходящаяТранспортнаяОперацияВЕТИС", НСтр("ru = 'Входящая транспортная операция ВетИС'"), "ВестиУчетПодконтрольныхТоваровВЕТИС");
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуОформить(Команды,"ПрочееОприходованиеТоваров",   НСтр("ru = 'Прочее оприходование товаров'"), "ИспользоватьПрочееОприходованиеТоваров");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды,"ПрочееОприходованиеТоваров",   НСтр("ru = 'Прочее оприходование товаров'"), "ИспользоватьПрочееОприходованиеТоваров");
	Возврат;
	
КонецПроцедуры

// Заполняет структуру команд для динамического формирования доступных для создания документов на основании.
// 
// Параметры:
//  Команды - Структура - Исходящий, структура команд динамически формируемых для создания документов на основании.
//
Процедура КомандыЗаказНаЭмиссиюКодовМаркировкиСУЗ(Команды) Экспорт 
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(
		Команды, "МаркировкаТоваровИСМП", НСтр("ru = 'Маркировка товаров ИС МП'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(
		Команды, "ПеремаркировкаТоваровИСМП", НСтр("ru = 'Перемаркировка товаров ИС МП'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(
		Команды, "ЗаказПоставщику", НСтр("ru = 'Заказ поставщику'"), "ИспользоватьЗаказыПоставщикам");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(
		Команды, "ЗаказНаСборку", НСтр("ru = 'Заказ на сборку'"), "ИспользоватьЗаказыНаСборку");
	Возврат;
	
КонецПроцедуры

// Заполняет структуру команд для динамического формирования доступных для создания документов на основании.
// 
// Параметры:
//  Команды - Структура - Исходящий, структура команд динамически формируемых для создания документов на основании.
//
Процедура КомандыВыводаИзОборотаИСМП(Команды) Экспорт 
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуОформить(Команды, "СписаниеНедостачТоваров",      НСтр("ru = 'Списание недостач товаров'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуОформить(Команды, "СборкаТоваров",                НСтр("ru = 'Разборку товаров'"),               "ИспользоватьСборкуРазборку");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуОформить(Команды, "ВнутреннееПотребление",        НСтр("ru = 'Внутреннее потребление'"),         "ИспользоватьВнутреннееПотребление");
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "РеализацияТоваровУслуг",       НСтр("ru = 'Реализацию товаров и услуг'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ОтчетОРозничныхПродажах",      НСтр("ru = 'Отчет о розничных продажах'"),     "ИспользоватьРозничныеПродажи");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ЧекККМ",                       НСтр("ru = 'Чек ККМ'"),                        "ИспользоватьРозничныеПродажи");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ВозвратТоваровПоставщику",     НСтр("ru = 'Возврат товаров поставщику'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ВнутреннееПотребление",        НСтр("ru = 'Внутреннее потребление'"),         "ИспользоватьВнутреннееПотребление");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "СписаниеНедостачТоваров",      НСтр("ru = 'Списание недостач товаров'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "СборкаТоваров",                НСтр("ru = 'Разборку товаров'"),               "ИспользоватьСборкуРазборку");
	
	
	
	Возврат;
	
КонецПроцедуры

// Заполняет структуру команд для динамического формирования доступных для создания документов на основании.
// 
// Параметры:
//  Команды - Структура - Исходящий, структура команд динамически формируемых для создания документов на основании.
//
Процедура КомандыОтгрузкиТоваровИСМП(Команды) Экспорт
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "РеализацияТоваровУслуг",            НСтр("ru = 'Реализацию товаров и услуг'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "КорректировкаРеализации",           НСтр("ru = 'Корректировку реализации'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ВозвратТоваровПоставщику",          НСтр("ru = 'Возврат товаров поставщику'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ПередачаТоваровМеждуОрганизациями", НСтр("ru = 'Передачу товаров между организациями'"), "ИспользоватьПередачиТоваровМеждуОрганизациями");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ВозвратТоваровМеждуОрганизациями",  НСтр("ru = 'Возврат товаров между организациями'"),  "ИспользоватьПередачиТоваровМеждуОрганизациями");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ПеремещениеТоваров",                НСтр("ru = 'Перемещение товаров'"),                  "ИспользоватьПеремещениеТоваров");
	Возврат;
	
КонецПроцедуры

// Заполняет структуру команд для динамического формирования доступных для создания документов на основании.
// 
// Параметры:
//  Команды - Структура - Исходящий, структура команд динамически формируемых для создания документов на основании.
//
Процедура КомандыПриемкиТоваровИСМП(Команды) Экспорт
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуОформить(Команды, "ПриобретениеТоваровУслуг", НСтр("ru = 'Приобретение товаров и услуг'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуОформить(Команды, "ВозвратТоваровОтКлиента",  НСтр("ru = 'Возврат товаров от клиента'"));
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ПриобретениеТоваровУслуг",          НСтр("ru = 'Приобретение товаров и услуг'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ВозвратТоваровОтКлиента",           НСтр("ru = 'Возврат товаров от клиента'"));
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ПередачаТоваровМеждуОрганизациями", НСтр("ru = 'Передачу товаров между организациями'"), "ИспользоватьПередачиТоваровМеждуОрганизациями");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ВозвратТоваровМеждуОрганизациями",  НСтр("ru = 'Возврат товаров между организациями'"),  "ИспользоватьПередачиТоваровМеждуОрганизациями");
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ПеремещениеТоваров",                НСтр("ru = 'Перемещение товаров'"),                  "ИспользоватьПеремещениеТоваров");
	Возврат;
	
КонецПроцедуры

// Заполняет структуру команд для динамического формирования доступных для создания документов на основании.
// 
// Параметры:
//  Команды - Структура - Исходящий, структура команд динамически формируемых для создания документов на основании.
//
Процедура КомандыСписанияКодовМаркировкиИСМП(Команды) Экспорт 
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ЗаказНаЭмиссиюКодовМаркировкиСУЗ", НСтр("ru = 'Заказ на эмиссию кодов маркировки'"));
	Возврат;
	
КонецПроцедуры

Процедура КомандыУточненияСведенийОКодахМаркировкиИСМП(Команды) Экспорт 
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(
		Команды, "МаркировкаТоваровИСМП", НСтр("ru = 'Маркировка товаров ИС МП'"));
	Возврат;
	
КонецПроцедуры

// Заполняет структуру команд для динамического формирования доступных для создания документов на основании.
// 
// Параметры:
//  Команды - Структура - Исходящий, структура команд динамически формируемых для создания документов на основании.
//
Процедура КомандыВозвратаВОборотИСМП(Команды) Экспорт 
	
	Возврат;
	
КонецПроцедуры

// Заполняет структуру команд для динамического формирования доступных для создания документов на основании.
// 
// Параметры:
//  Команды - Структура - Исходящий, структура команд динамически формируемых для создания документов на основании.
//
Процедура КомандыПеремаркировкиТоваровИСМП(Команды) Экспорт
	
	ПодключаемыеКомандыИСКлиентСервер.ДобавитьКомандуВыбрать(Команды, "ВозвратТоваровОтКлиента", НСтр("ru = 'Возврат товаров от клиента'"));
	Возврат;
	
КонецПроцедуры

Процедура УправлениеВидимостьюКомандЗаказаНаЭмиссию(Форма, Команды) Экспорт
	
	Если ПодключаемыеКомандыИСКлиентСервер.УправлениеВидимостьюПоУмолчанию(Форма) Тогда
		Возврат;
	КонецЕсли;
	
	СпособВводаВОборот = Форма.Объект.СпособВводаВОборот;
	ВидПродукции = Форма.Объект.ВидПродукции;
	
	Для Каждого КлючИЗначение Из Форма.ВидимостьПодключаемыхКоманд Цикл
		
		ИмяМетаданных = КлючИЗначение.Значение.ИмяМетаданных;
		Элемент       = Форма.Элементы[КлючИЗначение.Ключ];
		
		Если ИмяМетаданных = "МаркировкаТоваровИСМП" Тогда
			Элемент.Видимость = Истина;
		ИначеЕсли ИмяМетаданных = "ПеремаркировкаТоваровИСМП" Тогда
			Элемент.Видимость = ИнтеграцияИСКлиентСервер.ВидПродукцииПодлежитПеремаркировке(ВидПродукции);
		ИначеЕсли СпособВводаВОборот = ПредопределенноеЗначение("Перечисление.СпособыВводаВОборотСУЗ.МаркировкаОстатков") Тогда
			Элемент.Видимость = Ложь;
		ИначеЕсли СпособВводаВОборот = ПредопределенноеЗначение("Перечисление.СпособыВводаВОборотСУЗ.Импорт") Тогда
			Элемент.Видимость = (ИмяМетаданных = "ЗаказПоставщику");
		ИначеЕсли СпособВводаВОборот = ПредопределенноеЗначение("Перечисление.СпособыВводаВОборотСУЗ.Производство") Тогда
			Элемент.Видимость = (ИмяМетаданных = "ЗаказНаПроизводство2_2"
					//++ Устарело_Переработка24
					Или ИмяМетаданных = "ЗаказПереработчику"
					//-- Устарело_Переработка24
					Или ИмяМетаданных = "ЗаказНаСборку"
					Или ИмяМетаданных = "ЗаказПереработчику2_5");
		ИначеЕсли СпособВводаВОборот = ПредопределенноеЗначение("Перечисление.СпособыВводаВОборотСУЗ.ТрансграничнаяТорговля") Тогда
			Элемент.Видимость = (ИмяМетаданных = "ЗаказПоставщику");
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура УправлениеВидимостьюКомандМаркировкиТоваров(Форма, Команды) Экспорт
	
	Если ПодключаемыеКомандыИСКлиентСервер.УправлениеВидимостьюПоУмолчанию(Форма) Тогда
		Возврат;
	КонецЕсли;
	
	Операция     = Форма.Объект.Операция;
	ВидПродукции = Форма.Объект.ВидПродукции;
	
	Для Каждого КлючИЗначение Из Форма.ВидимостьПодключаемыхКоманд Цикл
		
		ИмяМетаданных = КлючИЗначение.Значение.ИмяМетаданных;
		Элемент       = Форма.Элементы[КлючИЗначение.Ключ];
		Если Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.Агрегация") Тогда
			Элемент.Видимость = Ложь;
		ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукцияПодконтрольнаяВЕТИС") Тогда
			Если Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотПроизводствоВнеЕАЭС")
				Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотТрансграничнаяТорговля") Тогда
				Элемент.Видимость = ИмяМетаданных = "ВходящаяТранспортнаяОперацияВЕТИС";
			Иначе
				Элемент.Видимость = ИмяМетаданных = "ПроизводственнаяОперацияВЕТИС";
			КонецЕсли;
		ИначеЕсли ИмяМетаданных = "ПроизводственнаяОперацияВЕТИС"
			Или ИмяМетаданных = "ВходящаяТранспортнаяОперацияВЕТИС" Тогда
			Элемент.Видимость = Ложь;
		ИначеЕсли Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотПроизводствоВнеЕАЭС")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотПолучениеПродукцииОтФизическихЛиц")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотТрансграничнаяТорговля")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотИмпортСФТС") Тогда
			Элемент.Видимость = ИмяМетаданных = "ПриобретениеТоваровУслуг";
		ИначеЕсли Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотПроизводствоРФ")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотПроизводствоРФПоДоговору")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотПроизводствоРФПоДоговоруНаСторонеЗаказчика") Тогда
			Если ИмяМетаданных = "СборкаТоваров" Тогда
				Элемент.Видимость = Форма.Объект.Товары.Количество() <= 1;
			Иначе
				Элемент.Видимость = (ИмяМетаданных = "ПроизводствоБезЗаказа"
					Или ИмяМетаданных = "ПрочееОприходованиеТоваров"
					//++ Устарело_Переработка24
					Или ИмяМетаданных = "ПоступлениеОтПереработчика"
					//-- Устарело_Переработка24
					Или ИмяМетаданных = "ПоступлениеТоваровОтХранителя"
					Или ИмяМетаданных = "ПроизводствоБезЗаказа"
					Или ИмяМетаданных = "ЭтапПроизводства2_2");
			КонецЕсли;
		ИначеЕсли Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВводВОборотМаркировкаОстатков") Тогда
			Элемент.Видимость = ИмяМетаданных = "ПересчетТоваров";
		ИначеЕсли Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ПодтверждениеПоступленияКИЗ") Тогда
			Элемент.Видимость = ИмяМетаданных = "ПриобретениеТоваровУслуг";
		Иначе
			Элемент.Видимость = Истина;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура УправлениеВидимостьюКомандВыводаВОборота(Форма, Команды) Экспорт
	
	Если ПодключаемыеКомандыИСКлиентСервер.УправлениеВидимостьюПоУмолчанию(Форма) Тогда
		Возврат;
	КонецЕсли;
	
	Операция = Форма.Объект.Операция;
	
	Для Каждого КлючИЗначение Из Форма.ВидимостьПодключаемыхКоманд Цикл
		
		ИмяМетаданных = КлючИЗначение.Значение.ИмяМетаданных;
		Элемент       = Форма.Элементы[КлючИЗначение.Ключ];
		
		Если Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаВозвратФизическомуЛицу") Тогда
			Элемент.Видимость = ИмяМетаданных = "ВозвратТоваровПоставщику";
		ИначеЕсли Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаБезвозмезднаяПередача") Тогда
			Элемент.Видимость = ИмяМетаданных = "ВнутреннееПотребление";
		ИначеЕсли Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаВПроцессеРеализацииПоДоговоруРассрочки")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаКредитныйДоговор")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаРеализацияКонфискованныхТоваров")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаРеализацияПоДоговоруРассрочки")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаЭкспортВСтраныЕАЭС")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаЭкспортЗаПределыСтранЕАЭС") Тогда
			Элемент.Видимость = ИмяМетаданных = "РеализацияТоваровУслуг";
		ИначеЕсли Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаКонфискацияТовара")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаЛиквидацияПредприятия")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаУничтожениеТовара")
			Или Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаУтратаПовреждениеТовара") Тогда
			Элемент.Видимость = ИмяМетаданных = "СписаниеНедостачТоваров";
		ИначеЕсли Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ВыводИзОборотаРозничнаяПродажа") Тогда
			Элемент.Видимость = (ИмяМетаданных = "РеализацияТоваровУслуг"
				Или ИмяМетаданных = "ОтчетОРозничныхПродажах"
				Или ИмяМетаданных = "ЧекККМ");
		Иначе
			Элемент.Видимость = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура УправлениеВидимостьюКомандСписанияКодовМаркировки(Форма, Команды) Экспорт
	
	Если ПодключаемыеКомандыИСКлиентСервер.УправлениеВидимостьюПоУмолчанию(Форма) Тогда
		Возврат;
	КонецЕсли;
	
	Операция = Форма.Объект.Операция;
	Для Каждого КлючИЗначение Из Форма.ВидимостьПодключаемыхКоманд Цикл
		
		ИмяМетаданных = КлючИЗначение.Значение.ИмяМетаданных;
		Элемент       = Форма.Элементы[КлючИЗначение.Ключ];
		
		Если Операция = ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.СписаниеЭмитированныхКодовМаркировкиПриПоступлении") Тогда
			Элемент.Видимость = ИмяМетаданных = "ЗаказНаЭмиссиюКодовМаркировкиСУЗ";
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура УправлениеВидимостьюКомандУточнениеСведенийОКодахМаркировки(Форма, Команды) Экспорт
	
	Если ПодключаемыеКомандыИСКлиентСервер.УправлениеВидимостьюПоУмолчанию(Форма) Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура УправлениеВидимостьюКомандВозвратаВОборот(Форма, Команды) Экспорт
	
	Если ПодключаемыеКомандыИСКлиентСервер.УправлениеВидимостьюПоУмолчанию(Форма) Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура УправлениеВидимостьюКомандПеремаркировкиТоваров(Форма, Команды) Экспорт
	
	Если ПодключаемыеКомандыИСКлиентСервер.УправлениеВидимостьюПоУмолчанию(Форма) Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура УправлениеВидимостьюКомандОтгрузкиТоваров(Форма, Команды) Экспорт
	
	Если ПодключаемыеКомандыИСКлиентСервер.УправлениеВидимостьюПоУмолчанию(Форма) Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура УправлениеВидимостьюКомандПриемкиТоваров(Форма, Команды) Экспорт
	
	Если ПодключаемыеКомандыИСКлиентСервер.УправлениеВидимостьюПоУмолчанию(Форма) Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Серии

Процедура ДополнитьДанныеДляГенерацииСерииПоВидуПродукции(СтруктураДанных, ВидМаркируемойПродукции)

	Если ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак") Тогда
		СтруктураДанных.Вставить("МРЦ", 0);
	ИначеЕсли ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукцияПодконтрольнаяВЕТИС") Тогда
		СтруктураДанных.Вставить("ГоденДо", '00010101');
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

Функция ТекстПредставленияПотребительскаяУпаковкаОтсутствует(ВСкобках = Ложь, НачалоСтроки = Ложь) Экспорт
	
	Если ВСкобках Тогда
		Шаблон = "%1";
	Иначе
		Шаблон = "<%1>";
	КонецЕсли;
	
	Если НачалоСтроки Тогда
		Текст = НСтр("ru = 'Отсутствует'");
	Иначе
		Текст = НСтр("ru = 'отсутствует'");
	КонецЕсли;
	
	Возврат СтрШаблон(Шаблон, Текст);
	
КонецФункции

Функция ДополнительноеОписаниеВидовУпаковокНоменклатуры(ОсобенностьУчета, ПотребительскаяУпаковка, СубпотребительскаяУпаковка, ЕдиницаХранения) Экспорт
	
	ВидПродукции = ИнтеграцияИСУТКлиентСервер.ОсобенностьУчетаПоВидуПродукции(ОсобенностьУчета);
	
	ТекстПояснения = Неопределено;
	
	Если ИнтеграцияИСКлиентСерверПовтИсп.ПоддерживаетсяЧастичноеВыбытие(ВидПродукции) Тогда
		
		Если ЗначениеЗаполнено(СубпотребительскаяУпаковка) Тогда
			ТекстПояснения = СтрШаблон(
				"%1: %2",
				ИнтеграцияИСМПВызовСервера.ПредставлениеЧастичногоВыбытияПоВидуПродукции(ВидПродукции),
				СубпотребительскаяУпаковка);
		ИначеЕсли ЗначениеЗаполнено(ПотребительскаяУпаковка) Тогда
			ТекстПояснения = СтрШаблон(
				"%1: %2",
				ИнтеграцияИСМПВызовСервера.ПредставлениеЧастичногоВыбытияПоВидуПродукции(ВидПродукции),
				ЕдиницаХранения);
		Иначе
			ТекстПояснения = СтрШаблон(
				"%1: %2",
				ИнтеграцияИСМПВызовСервера.ПредставлениеЧастичногоВыбытияПоВидуПродукции(ВидПродукции),
				НСтр("ru = 'не настроена'"));
		КонецЕсли;
	
	КонецЕсли;
	
	Возврат ТекстПояснения;
	
КонецФункции

Функция ИсточникДанныхПоВидамУпаковок(ИсточникДанных) Экспорт
	Если ТипЗнч(ИсточникДанных) = Тип("ФормаКлиентскогоПриложения") Тогда
		ИсточникНабора = ИсточникДанных.Объект;
		СсылкаНаОбъект = ИсточникНабора.Ссылка;
	Иначе
		ИсточникНабора = ИсточникДанных;
		СсылкаНаОбъект = ИсточникДанных.Ссылка;
	КонецЕсли;
	Если ТипЗнч(СсылкаНаОбъект) = Тип("СправочникСсылка.Номенклатура")
		И ИспользуетсяОбщийНаборУпаковок(ИсточникНабора) Тогда
		СсылкаНаОбъект = ИсточникНабора.НаборУпаковок;
	КонецЕсли;
	Возврат СсылкаНаОбъект;
КонецФункции

Функция ИспользуетсяОбщийНаборУпаковок(ДанныеФормыОбъект) Экспорт
	Возврат (ДанныеФормыОбъект.ИспользоватьУпаковки
		И ДанныеФормыОбъект.НаборУпаковок <> ПредопределенноеЗначение("Справочник.НаборыУпаковок.ИндивидуальныйДляНоменклатуры"));
КонецФункции

Процедура НастройкаЭлементовВидаУпаковки(Форма, ПользовательРазрешилРедактирование = Ложь, ИспользоватьСерверныйВызов = Истина) Экспорт
	
	Объект          = Форма.Объект;
	Элементы        = Форма.Элементы;
	ЭтоНоменклатура = ТипЗнч(Форма.Объект.Ссылка) = Тип("СправочникСсылка.Номенклатура");
	ИспользуетсяОбщийНабор = Ложь;
	Если ЭтоНоменклатура Тогда
		ИспользуетсяОбщийНабор = ИспользуетсяОбщийНаборУпаковок(Объект);
	КонецЕсли;
	
	Если ИспользоватьСерверныйВызов Тогда
		Форма.ЭтоМернаяЕдиницаИСМП = ИнтеграцияИСВызовСервераУТ.ЭтоМернаяЕдиницаХранения(Объект.ЕдиницаИзмерения);
	КонецЕсли;
	
	ДоступностьКнопки    = Ложь;
	ДоступностьЭлементов = (Не ИспользуетсяОбщийНабор);
	Если (ЭтоНоменклатура
		И ДоступностьЭлементов
		И Не Объект.ИспользоватьУпаковки) Тогда
		ДоступностьЭлементов = Ложь;
	КонецЕсли;
	Если ПользовательРазрешилРедактирование Тогда
		
		Элементы.ПотребительскаяУпаковкаИСМП.ТолькоПросмотр      = Ложь;
		Элементы.ИспользуетсяЧастичноеВыбытиеИСМП.ТолькоПросмотр = Ложь;
		Элементы.УпаковкаЧастичногоВыбытияИСМП.ТолькоПросмотр    = Ложь;
		
		Если ЭтоНоменклатура
			И Не ИспользуетсяОбщийНабор Тогда
			ДоступностьКнопки                                                = Истина;
			Элементы.КомандаЗаполнитьУпаковкуЧастичногоВыбытияИСМП.Видимость = Истина;
		КонецЕсли;
		
	Иначе
		Элементы.ПотребительскаяУпаковкаИСМП.ТолькоПросмотр      = Истина;
		Элементы.УпаковкаЧастичногоВыбытияИСМП.ТолькоПросмотр    = Истина;
		Элементы.ИспользуетсяЧастичноеВыбытиеИСМП.ТолькоПросмотр = Истина;
	КонецЕсли;
	
	Если ЭтоНоменклатура Тогда
		Элементы.ПотребительскаяУпаковкаИСМП.Доступность                   = ДоступностьЭлементов;
		Элементы.УпаковкаЧастичногоВыбытияИСМП.Доступность                 = ДоступностьЭлементов;
		Элементы.ИспользуетсяЧастичноеВыбытиеИСМП.Доступность              = ДоступностьЭлементов;
		Элементы.КомандаЗаполнитьУпаковкуЧастичногоВыбытияИСМП.Доступность = ДоступностьКнопки;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Форма.ПотребительскаяУпаковкаИСМП) Тогда
		Если Форма.ЭтоМернаяЕдиницаИСМП
			Или Не ЗначениеЗаполнено(Объект.ЕдиницаИзмерения) Тогда
			Элементы.УпаковкаЧастичногоВыбытияИСМП.ПодсказкаВвода = ИнтеграцияИСМПУТКлиентСервер.ТекстПредставленияПотребительскаяУпаковкаОтсутствует(Истина, Истина);
		Иначе
			Элементы.УпаковкаЧастичногоВыбытияИСМП.ПодсказкаВвода = Объект.ЕдиницаИзмерения;
		КонецЕсли;
	Иначе
		Если Форма.ЭтоМернаяЕдиницаИСМП
			Или Не ЗначениеЗаполнено(Объект.ЕдиницаИзмерения) Тогда
			Элементы.ПотребительскаяУпаковкаИСМП.ПодсказкаВвода = ИнтеграцияИСМПУТКлиентСервер.ТекстПредставленияПотребительскаяУпаковкаОтсутствует(Истина, Истина);
		Иначе
			Элементы.ПотребительскаяУпаковкаИСМП.ПодсказкаВвода = Объект.ЕдиницаИзмерения;
		КонецЕсли;
		Элементы.УпаковкаЧастичногоВыбытияИСМП.ПодсказкаВвода = ИнтеграцияИСМПУТКлиентСервер.ТекстПредставленияПотребительскаяУпаковкаОтсутствует(Истина, Истина);
	КонецЕсли;
	
	ВидимостьУпаковкиЧастичногоВыбытия = (Форма.ИспользуетсяЧастичноеВыбытиеИСМП
		                                  И Элементы.ИспользуетсяЧастичноеВыбытиеИСМП.Видимость);
	Элементы.УпаковкаЧастичногоВыбытияИСМП.Видимость = ВидимостьУпаковкиЧастичногоВыбытия;
	Если ЭтоНоменклатура Тогда
		Элементы.КомандаЗаполнитьУпаковкуЧастичногоВыбытияИСМП.Видимость = ВидимостьУпаковкиЧастичногоВыбытия;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаИзмененияПолейУпаковок(Форма, ИмяЭлемента) Экспорт
	
	Объект          = Форма.Объект;
	ЕдиницаХранения = Объект.ЕдиницаИзмерения;
	
	Если ИмяЭлемента = "ПотребительскаяУпаковкаИСМП" Тогда
		
		Если ЗначениеЗаполнено(Форма.ПотребительскаяУпаковкаИСМП) Тогда
			
			Если Форма.ПотребительскаяУпаковкаИСМП = Форма.УпаковкаЧастичногоВыбытияИСМП Тогда
				Если Форма.ЭтоМернаяЕдиницаИСМП Тогда
					Форма.УпаковкаЧастичногоВыбытияИСМП = ЕдиницаХранения;
				Иначе
					Форма.УпаковкаЧастичногоВыбытияИСМП = Неопределено;
				КонецЕсли;
			КонецЕсли;
		
		ИначеЕсли Форма.ЭтоМернаяЕдиницаИСМП Тогда
			
			Форма.УпаковкаЧастичногоВыбытияИСМП = ЕдиницаХранения;
			
		Иначе
			
			Форма.ПотребительскаяУпаковкаИСМП = ЕдиницаХранения;
			
		КонецЕсли;
		
	ИначеЕсли ИмяЭлемента = "УпаковкаЧастичногоВыбытияИСМП" Тогда
		
		Если ЗначениеЗаполнено(Форма.УпаковкаЧастичногоВыбытияИСМП) Тогда
		
			Если Форма.ПотребительскаяУпаковкаИСМП = Форма.УпаковкаЧастичногоВыбытияИСМП Тогда
				Если Форма.ЭтоМернаяЕдиницаИСМП Тогда
					Форма.ПотребительскаяУпаковкаИСМП = Неопределено;
				Иначе
					Форма.ПотребительскаяУпаковкаИСМП = ЕдиницаХранения;
				КонецЕсли;
			КонецЕсли;
		
		ИначеЕсли ЗначениеЗаполнено(Форма.ПотребительскаяУпаковкаИСМП) Тогда
			
			Если Форма.ПотребительскаяУпаковкаИСМП <> ЕдиницаХранения Тогда
				Форма.УпаковкаЧастичногоВыбытияИСМП = ЕдиницаХранения;
			КонецЕсли;
			
		КонецЕсли;
	
	ИначеЕсли ИмяЭлемента = "ИспользуетсяЧастичноеВыбытиеИСМП" Тогда
		
		Если Форма.ИспользуетсяЧастичноеВыбытиеИСМП Тогда
			
			Если Форма.ЭтоМернаяЕдиницаИСМП Тогда
				Форма.УпаковкаЧастичногоВыбытияИСМП = ЕдиницаХранения;
				Если Форма.ПотребительскаяУпаковкаИСМП = ЕдиницаХранения Тогда
					Форма.ПотребительскаяУпаковкаИСМП = Неопределено;
				КонецЕсли;
			ИначеЕсли ЗначениеЗаполнено(Форма.ПотребительскаяУпаковкаИСМП)
				И Форма.ПотребительскаяУпаковкаИСМП <> ЕдиницаХранения Тогда
				Форма.УпаковкаЧастичногоВыбытияИСМП = ЕдиницаХранения;
			КонецЕсли;
		
		Иначе
			Форма.УпаковкаЧастичногоВыбытияИСМП = Неопределено;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура УправлениеРеквизитамиУпаковокПриПереключенииИспользованияНабораУпаковок(Форма, РедактированиеРеквизитовРазрешено) Экспорт
	
	Форма.ИспользуетсяЧастичноеВыбытиеИСМП = Ложь;
	Форма.ПотребительскаяУпаковкаИСМП      = Неопределено;
	Форма.УпаковкаЧастичногоВыбытияИСМП    = Неопределено;
	
	НастройкаЭлементовВидаУпаковки(Форма, РедактированиеРеквизитовРазрешено);
	
КонецПроцедуры

Процедура УправлениеПризнакомИспользованияЧастичногоВыбытия(Форма) Экспорт
	
	Если Не Форма.Объект.ИспользоватьУпаковки Тогда
		Форма.ИспользуетсяЧастичноеВыбытиеИСМП = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
