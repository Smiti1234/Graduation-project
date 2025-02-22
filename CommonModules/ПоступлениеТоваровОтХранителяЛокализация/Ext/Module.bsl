﻿
#Область ПрограммныйИнтерфейс

#Область Проведение

// Описывает учетные механизмы используемые в документе для регистрации в механизме проведения.
//
// Параметры:
//  МеханизмыДокумента - Массив - список имен учетных механизмов, для которых будет выполнена
//              регистрация в механизме проведения.
//
Процедура ЗарегистрироватьУчетныеМеханизмы(МеханизмыДокумента) Экспорт
	
	//++ Локализация


	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то будет выполнен отказ от продолжения работы после выполнения проверки заполнения.
//  ПроверяемыеРеквизиты - Массив - Массив путей к реквизитам, для которых будет выполнена проверка заполнения.
//
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты) Экспорт
	
	//++ Локализация
	
		УчетПрослеживаемыхТоваровЛокализация.ПроверитьЗаполнениеКоличестваПоРНПТ(Объект, Отказ, Неопределено);
		УчетПрослеживаемыхТоваровЛокализация.ПроверитьДанныеПрослеживаемостиНомеровГТД(Объект, Объект.Товары, Объект.Дата);
	
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект.
//  ДанныеЗаполнения - Произвольный - Значение, которое используется как основание для заполнения.
//  СтандартнаяОбработка - Булево - В данный параметр передается признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, СтандартнаяОбработка) Экспорт
	
	//++ Локализация

	ТипДанныхЗаполнения = ТипЗнч(ДанныеЗаполнения);
	
	Если ТипДанныхЗаполнения = Тип("ДокументСсылка.ОформлениеСДИЗЗЕРНО") Тогда
		
		ИнтеграцияЗЕРНОУТ.ЗаполнитьПоступлениеТоваровОтХранителяНаОснованииОформленияСДИЗЗЕРНО(
			Объект, 
			ДанныеЗаполнения);
		
	КонецЕсли;
	
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//  РежимЗаписи - РежимЗаписиДокумента - В параметр передается текущий режим записи документа. Позволяет определить в теле процедуры режим записи.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ПередЗаписью(Объект, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый документ.
//  Отказ - Булево - Признак проведения документа.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то проведение документа выполнено не будет.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ОбработкаПроведения(Объект, Отказ, РежимПроведения) Экспорт
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//
Процедура ОбработкаУдаленияПроведения(Объект, Отказ) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина, то запись выполнена не будет и будет вызвано исключение.
//
Процедура ПриЗаписи(Объект, Отказ) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  ОбъектКопирования - ДокументОбъект - Исходный документ, который является источником копирования.
//
Процедура ПриКопировании(Объект, ОбъектКопирования) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// Добавляет команду создания документа "Авансовый отчет".
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
Процедура ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	
КонецПроцедуры

// Определяет список команд создания на основании.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	
КонецПроцедуры

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.КомандыОтчетов
//   Параметры - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.Параметры
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	
КонецПроцедуры

// Заполняет список команд печати.
//
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	//++ Локализация
	
	// Приходный ордер (М-4)
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.МенеджерПечати = "Обработка.ПечатьОбщихФорм";
	КомандаПечати.Идентификатор = "М4";
	КомандаПечати.Представление = НСтр("ru = 'Приходный ордер (М-4)'");
	КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
	
	// МХ-3
	СписокХО = Новый Массив();
	СписокХО.Добавить(Перечисления.ХозяйственныеОперации.ВозвратОтХранителя);
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.МенеджерПечати = "Обработка.ПечатьОбщихФорм";
	КомандаПечати.Идентификатор = "МХ3";
	КомандаПечати.Представление = НСтр("ru = 'Акт о возврате ТМЦ, сданных на хранение (МХ-3)'");
	КомандаПечати.Порядок = 41;
	КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
	УправлениеПечатью.ДобавитьУсловиеВидимостиКоманды(
		КомандаПечати,
		"ХозяйственнаяОперация",
		СписокХО,
		ВидСравнения.ВСписке);
	
	
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область Печать

// Формирует печатные формы.
//
// Параметры:
//  МассивОбъектов  - Массив    - ссылки на объекты, которые нужно распечатать;
//  ПараметрыПечати - Структура - дополнительные настройки печати;
//  КоллекцияПечатныхФорм - ТаблицаЗначений - сформированные табличные документы (выходной параметр)
//  ОбъектыПечати         - СписокЗначений  - значение - ссылка на объект;
//                                            представление - имя области в которой был выведен объект (выходной параметр);
//  ПараметрыВывода       - Структура       - дополнительные параметры сформированных табличных документов (выходной параметр).
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	
КонецПроцедуры

//++ Локализация


// Функция получает данные для формирования печатной формы  М - 4
//
// Параметры:
//  ПараметрыПечати - Структура - структура дополнительных параметров печати,
//  МассивОбъектов  - Массив    - массив ссылок на объекты которые нужно распечатать.
//
// Возвращаемое значение:
//  Структура - структура с данными для печати формы М - 4, содержит ключи:
//   * РезультатПоШапке          - РезультатЗапроса -
//   * РезультатПоТабличнойЧасти - РезультатЗапроса -
//
Функция ПолучитьДанныеДляПечатнойФормыМ4(ПараметрыПечати, МассивОбъектов) Экспорт
	
	КолонкаКодов = ФормированиеПечатныхФорм.ДополнительнаяКолонкаПечатныхФормДокументов().ИмяКолонки;
	Если Не ЗначениеЗаполнено(КолонкаКодов) Тогда
		КолонкаКодов = "Код";
	КонецЕсли;
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ДанныеДокументов.ВозвратПереданнойМногооборотнойТары КАК ВернутьМногооборотнуюТару,
	|	ДанныеДокументов.Склад	КАК Склад,
	|	ДанныеДокументов.Ссылка	КАК Ссылка,
	|	ДанныеДокументов.Дата	КАК Дата,
	|	ДанныеДокументов.Валюта	КАК Валюта
	|
	|ПОМЕСТИТЬ ТаблицаДанныхДокументов
	|ИЗ
	|	Документ.ПоступлениеТоваровОтХранителя КАК ДанныеДокументов
	|
	|ГДЕ
	|	ДанныеДокументов.Ссылка В (&МассивОбъектов)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|;";
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	Запрос.Выполнить();
	
	ПоместитьВременнуюТаблицуТоваров(МенеджерВременныхТаблиц);
	
	Запрос.Текст = "
	|////////////////////////////////////////////////////////////////////////////
	|// ЗАПРОС ПО ШАПКЕ
	|
	|ВЫБРАТЬ
	|	ПоступлениеТоваровОтХранителя.Ссылка                         КАК Ссылка,
	|	ПоступлениеТоваровОтХранителя.Номер                          КАК Номер,
	|	ПоступлениеТоваровОтХранителя.Дата                           КАК Дата,
	|	ПоступлениеТоваровОтХранителя.Дата                           КАК ДатаСоставления,
	|	ПоступлениеТоваровОтХранителя.НомерВходящегоДокумента        КАК НомерСопроводительногоДокумента,
	|	ПоступлениеТоваровОтХранителя.Контрагент                     КАК Поставщик,
	|	ПоступлениеТоваровОтХранителя.Организация                    КАК Организация,
	|	ПоступлениеТоваровОтХранителя.Организация.Префикс            КАК Префикс,
	|	ЗНАЧЕНИЕ(Справочник.БанковскиеСчетаОрганизаций.ПустаяСсылка) КАК БанковскийСчетОрганизации,
	|	ПоступлениеТоваровОтХранителя.Организация                    КАК Грузоотправитель,
	|	ПоступлениеТоваровОтХранителя.Подразделение                  КАК Подразделение,
	|	ПоступлениеТоваровОтХранителя.Подразделение.Наименование     КАК ПредставлениеПодразделения,
	|	ПоступлениеТоваровОтХранителя.Валюта                         КАК Валюта,
	|	ЗНАЧЕНИЕ(Справочник.ФизическиеЛица.ПустаяСсылка)             КАК МОЛ,
	|	""""                                                         КАК ДолжностьМОЛ
	|
	|ИЗ
	|	Документ.ПоступлениеТоваровОтХранителя КАК ПоступлениеТоваровОтХранителя
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ТаблицаДанныхДокументов КАК ДанныеДокументов
	|	ПО
	|		ПоступлениеТоваровОтХранителя.Ссылка = ДанныеДокументов.Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////
	|// ЗАПРОС ПО ТАБЛИЧНЫМ ЧАСТЯМ
	|
	|ВЫБРАТЬ
	|	ТаблицаТоваров.Ссылка                                  КАК Ссылка,
	|	ТаблицаТоваров.Склад                                   КАК Склад,
	|	ТаблицаТоваров.Склад.Наименование                      КАК СкладНаименование,
	|	ТаблицаТоваров.Номенклатура                            КАК Номенклатура,
	|	ТаблицаТоваров.Номенклатура.НаименованиеПолное         КАК ТоварНаименование,
	|	
	|	ВЫБОР КОГДА &КолонкаКодов = ""Артикул"" ТОГДА
	|		ТаблицаТоваров.Номенклатура.Артикул
	|	ИНАЧЕ
	|		ТаблицаТоваров.Номенклатура.Код
	|	КОНЕЦ                                                  КАК ТоварКод,
	|	
	|	ТаблицаТоваров.ЕдиницаИзмерения.Представление          КАК ЕдиницаИзмеренияНаименование,
	|	ТаблицаТоваров.ЕдиницаИзмерения.Код                    КАК ЕдиницаИзмеренияКод,
	|	ТаблицаТоваров.Характеристика.НаименованиеПолное       КАК Характеристика,
	|
	|	ВЫБОР КОГДА ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки, 1) = 1 ТОГДА
	|		НЕОПРЕДЕЛЕНО
	|	ИНАЧЕ
	|		ТаблицаТоваров.Упаковка
	|	КОНЕЦ                                                  КАК Упаковка,
	|
	|	ТаблицаТоваров.КоличествоУпаковок                      КАК Количество,
	|	ТаблицаТоваров.КоличествоУпаковок                      КАК КоличествоПринято,
	|	ВЫБОР КОГДА ТаблицаТоваров.Количество <> 0 ТОГДА 
	|		ТаблицаТоваров.СуммаБезНДС / ТаблицаТоваров.КоличествоУпаковок
	|	ИНАЧЕ
	|		0
	|	КОНЕЦ                                                  КАК Цена,
	|	ТаблицаТоваров.СуммаБезНДС                             КАК СуммаБезНДС,
	|	ТаблицаТоваров.СуммаНДС                                КАК СуммаНДС,
	|	ТаблицаТоваров.СуммаБезНДС + ТаблицаТоваров.СуммаНДС   КАК СуммаСНДС,
	|	ТаблицаТоваров.ЭтоВозвратнаяТара                       КАК ЭтоВозвратнаяТара
	|
	|ИЗ
	|	ТаблицаТоваров КАК ТаблицаТоваров
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка,
	|	ТаблицаТоваров.НомерСтроки
	|
	|ИТОГИ ПО
	|	Ссылка, Склад
	|";
	Запрос.УстановитьПараметр("КолонкаКодов", КолонкаКодов);
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст,
		"&ТекстЗапросаКоэффициентУпаковки",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
		"ТаблицаТоваров.Упаковка",
		"ТаблицаТоваров.Номенклатура"));
		
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	Возврат Новый Структура("РезультатПоШапке, РезультатПоТабличнойЧасти", МассивРезультатов[0], МассивРезультатов[1]);
	
КонецФункции

// Формирует временную таблицу, содержащую табличную часть по таблице данных документов.
//
// Параметры:
//	МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - Менеджер временных таблиц, содержащий таблицу ТаблицаДанныхДокументов с полями:
//		Ссылка,
//		Валюта.
//
//	ПересчитыватьВВалютуРегл - Булево - Признак необходимости пересчета сумм табличной части в валюте регламентированного учета.
//
Процедура ПоместитьВременнуюТаблицуТоваров(МенеджерВременныхТаблиц, ПересчитыватьВВалютуРегл = Истина) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("ПересчитыватьВВалютуРегл", ПересчитыватьВВалютуРегл);
	
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ТаблицаТоваров.Ссылка                КАК Ссылка,
	|	ТаблицаТоваров.Номенклатура          КАК Номенклатура,
	|	ТаблицаТоваров.Характеристика        КАК Характеристика,
	|	СУММА(ТаблицаТоваров.Сумма)          КАК Сумма,
	|	МАКСИМУМ(ТаблицаТоваров.НомерСтроки) КАК НомерСтроки
	|
	|ПОМЕСТИТЬ СтрокиТоваров
	|
	|ИЗ
	|	Документ.ПоступлениеТоваровОтХранителя.Товары КАК ТаблицаТоваров
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ТаблицаДанныхДокументов КАК ДанныеДокументов
	|	ПО
	|		ТаблицаТоваров.Ссылка = ДанныеДокументов.Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаТоваров.Ссылка,
	|	ТаблицаТоваров.Номенклатура,
	|	ТаблицаТоваров.Характеристика
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ТаблицаТоваров.Ссылка,
	|	ТаблицаТоваров.Номенклатура,
	|	ТаблицаТоваров.Характеристика
	|;
	|/////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеДокументов.Склад                      КАК Склад,
	|	ТаблицаДокумента.Ссылка                     КАК Ссылка,
	|	СтрокиТоваров.НомерСтроки                   КАК НомерСтроки,
	|	АналитикаУчетаНоменклатуры.Номенклатура     КАК Номенклатура,
	|	&ТекстЗапросаЕдиницаИзмерения               КАК ЕдиницаИзмерения,
	|	АналитикаУчетаНоменклатуры.Характеристика   КАК Характеристика,
	|	НЕОПРЕДЕЛЕНО                                КАК НомерГТД,
	|	НЕОПРЕДЕЛЕНО                                КАК СтавкаНДС,
	|	СУММА(ТаблицаДокумента.Количество)          КАК Количество,
	|	СУММА(ТаблицаДокумента.Количество)          КАК КоличествоУпаковок,
	|	СУММА(ЕСТЬNULL(СуммыДокументовВВалютахУчета.СуммаБезНДСРегл, СтрокиТоваров.Сумма)) КАК СуммаБезНДС,
	|	0                                           КАК СуммаНДС,
	|	ИСТИНА                                      КАК ЭтоТовар,
	|	ВЫБОР КОГДА ДанныеДокументов.ВернутьМногооборотнуюТару
	|				И АналитикаУчетаНоменклатуры.Номенклатура.ТипНоменклатуры = ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара) ТОГДА
	|		ИСТИНА
	|	ИНАЧЕ
	|		ЛОЖЬ
	|	КОНЕЦ                                       КАК ЭтоВозвратнаяТара,
	|	ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка) КАК Упаковка
	|
	|ПОМЕСТИТЬ ТаблицаТоваров
	|
	|ИЗ
	|	Документ.ПоступлениеТоваровОтХранителя.ВидыЗапасов КАК ТаблицаДокумента
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ТаблицаДанныхДокументов КАК ДанныеДокументов
	|	ПО
	|		ТаблицаДокумента.Ссылка = ДанныеДокументов.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрСведений.СуммыДокументовВВалютахУчета КАК СуммыДокументовВВалютахУчета
	|	ПО
	|		ТаблицаДокумента.Ссылка = СуммыДокументовВВалютахУчета.Регистратор
	|		И ТаблицаДокумента.ИдентификаторСтроки = СуммыДокументовВВалютахУчета.ИдентификаторСтроки
	|		И СуммыДокументовВВалютахУчета.Активность
	|		И &ПересчитыватьВВалютуРегл
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		СтрокиТоваров КАК СтрокиТоваров
	|	ПО
	|		ТаблицаДокумента.Ссылка     = СтрокиТоваров.Ссылка
	|		И АналитикаУчетаНоменклатуры.Номенклатура    = СтрокиТоваров.Номенклатура
	|		И АналитикаУчетаНоменклатуры.Характеристика  = СтрокиТоваров.Характеристика
	|
	|СГРУППИРОВАТЬ ПО
	|	ВЫБОР КОГДА ДанныеДокументов.ВернутьМногооборотнуюТару
	|				И АналитикаУчетаНоменклатуры.Номенклатура.ТипНоменклатуры = ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара) ТОГДА
	|		ИСТИНА
	|	ИНАЧЕ
	|		ЛОЖЬ
	|	КОНЕЦ,
	|	ДанныеДокументов.Склад,
	|	ТаблицаДокумента.Ссылка,
	|	СтрокиТоваров.НомерСтроки,
	|	АналитикаУчетаНоменклатуры.Номенклатура,
	|	АналитикаУчетаНоменклатуры.Характеристика
	|
	|;
	|/////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ СтрокиТоваров
	|";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ТекстЗапросаЕдиницаИзмерения",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаЗначениеРеквизитаЕдиницыИзмерения(
			"Ссылка",
			"ВЫРАЗИТЬ(ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка) КАК Справочник.УпаковкиЕдиницыИзмерения)",
			"АналитикаУчетаНоменклатуры.Номенклатура"));
			
	Запрос.Выполнить();
	
КонецПроцедуры

//-- Локализация

#КонецОбласти


// Заполняет массив допустимых наименований входящих документов.
//
// Параметры:
//  МассивНаименований	 - Массив - массив наименования входящих документов.
//
Процедура ДополнитьНаименованияВходящихДокументов(МассивНаименований) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  Запрос - Запрос - Общий запрос проведения документа.
//  ТекстыЗапроса - СписокЗначений - Список текстов запроса проведения.
//  Регистры - Строка, Структура - Список регистров проведения документа через запятую или в ключах структуры.
//
Процедура ДополнитьТекстыЗапросовПроведения(Запрос, ТекстыЗапроса, Регистры) Экспорт
	
	//++ Локализация


	//-- Локализация
	
КонецПроцедуры

//++ Локализация


//-- Локализация

#КонецОбласти

#Область Прочее

#КонецОбласти

//++ Локализация


//-- Локализация

#КонецОбласти
