﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК Т
	|ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК Т1 
	|	ПО Т.АналитикаУчетаПоПартнерам = Т1.КлючАналитики
	|;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Т1.Организация)
	|	И ЗначениеРазрешено(Т1.Партнер)";
	
	Ограничение.ТекстДляВнешнихПользователей =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК ЭтотСписок
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК АналитикаУчетаПоПартнерам
	|	ПО АналитикаУчетаПоПартнерам.КлючАналитики = ЭтотСписок.АналитикаУчетаПоПартнерам
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВнешниеПользователи КАК ВнешниеПользователиПартнеры
	|	ПО ВнешниеПользователиПартнеры.ОбъектАвторизации = АналитикаУчетаПоПартнерам.Партнер
	|;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(ВнешниеПользователиПартнеры.Ссылка)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбновлениеИнформационнойБазы

// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
// Параметры:
// 	Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "РегистрыНакопления.РасчетыСКлиентами.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Версия = "11.5.15.15";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("489f7d26-6bd5-7943-a55c-3d06d445974a");
	Обработчик.Многопоточный = Истина;
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.РасчетыСКлиентами.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Порядок = Перечисления.ПорядокОбработчиковОбновления.Обычный;
	Обработчик.Комментарий = СтрШаблон(НСтр("ru = 'Добавляет записи по увеличению и уменьшению ""К оплате"" в накладные по заказам и по графику договора.
	|Исправляет период движений по ресурсу ""%1"".'"), Метаданные.РегистрыНакопления.РасчетыСКлиентами.Ресурсы.КОплате.Представление());
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.РегистрыНакопления.РасчетыСКлиентами.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Справочники.ДоговорыКонтрагентов.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ВзаимозачетЗадолженности.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыНакопления.РасчетыСКлиентами.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
	Блокируемые = Новый Массив;
	Блокируемые.Добавить(Метаданные.РегистрыНакопления.РасчетыСКлиентами.ПолноеИмя());
	Обработчик.БлокируемыеОбъекты = СтрСоединить(Блокируемые, ",");
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "РегистрыНакопления.РасчетыСКлиентами.УдалитьДвиженияПоПередачеНаХранение";
	Обработчик.Версия = "11.5.14.13";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("d94d592a-8ecb-44ac-82f0-b0fdfd1e49cf");
	Обработчик.Многопоточный = Истина;
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.РасчетыСКлиентами.ЗарегистрироватьЗаказыКУдалению";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Порядок = Перечисления.ПорядокОбработчиковОбновления.Обычный;
	Обработчик.Комментарий = НСтр("ru = 'Удаляет движения по заказам по передаче на хранение в регистре ""Расчеты с клиентами"".'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.Документы.ЗаказКлиента.ПолноеИмя());
	Читаемые.Добавить(Метаданные.РегистрыНакопления.РасчетыСКлиентами.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыНакопления.РасчетыСКлиентами.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
КонецПроцедуры

// Процедура регистрации данных для обработчика обновления ОбработатьДанныеДляПереходаНаВерсию.
// 
// Параметры:
//  Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра  = "РегистрНакопления.РасчетыСКлиентами";

	ПараметрыВыборки = Параметры.ПараметрыВыборки;
	ПараметрыВыборки.ПолныеИменаРегистров = ПолноеИмяРегистра;
	ПараметрыВыборки.ПоляУпорядочиванияПриРаботеПользователей.Добавить("Период УБЫВ");
	ПараметрыВыборки.ПоляУпорядочиванияПриОбработкеДанных.Добавить("Период УБЫВ");
	ПараметрыВыборки.СпособВыборки = ОбновлениеИнформационнойБазы.СпособВыборкиРегистраторыРегистра();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Регистр.Регистратор КАК Ссылка
	|ПОМЕСТИТЬ ВтНакладныеПоГрафикам
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК Регистр
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК Аналитика
	|			ПО Аналитика.КлючАналитики = Регистр.АналитикаУчетаПоПартнерам
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ДоговорыКонтрагентов КАК Договоры
	|			ПО Договоры.Ссылка = Аналитика.Договор
	|			И Договоры.ЗаданГрафикИсполнения
	|ГДЕ
	|	Регистр.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|	И Регистр.КОтгрузке > 0 
	|	И (Регистр.ПродажаПоЗаказу НЕ В (&ПустыеСсылкиНаЗаказы)
	|		ИЛИ Договоры.Ссылка ЕСТЬ НЕ NULL)
	|	И НЕ Регистр.Регистратор ССЫЛКА Документ.КорректировкаРегистров
	|ИНДЕКСИРОВАТЬ ПО
	|	Регистратор
	|;
	|ВЫБРАТЬ
	|	Накладные.Ссылка КАК Регистратор
	|ИЗ
	|	ВтНакладныеПоГрафикам КАК Накладные
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.РасчетыСКлиентами КАК ЗаписиКОплате
	|			ПО ЗаписиКОплате.Регистратор = Накладные.Ссылка
	|				И ЗаписиКОплате.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|				И ЗаписиКОплате.КОплате > 0
	|				И ЗаписиКОплате.ХозяйственнаяОПерация <> ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.РеализацияКлиентуРеглУчет)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.РасчетыСКлиентами КАК ЗаписиСумм
	|			ПО ЗаписиСумм.Регистратор = Накладные.Ссылка
	|				И ЗаписиСумм.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|				И ЗаписиСумм.Сумма > 0
	|ГДЕ
	|	ЗаписиКОплате.Регистратор ЕСТЬ NULL
	|	И (ЗаписиСумм.Регистратор ЕСТЬ НЕ NULL
	|		ИЛИ ВЫРАЗИТЬ(Накладные.Ссылка КАК Документ.РеализацияТоваровУслуг).Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыРеализацийТоваровУслуг.ВПути)
	|		ИЛИ ВЫРАЗИТЬ(Накладные.Ссылка КАК Документ.РеализацияУслугПрочихАктивов).Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыРеализацийТоваровУслуг.ВПути)
	|		ИЛИ ВЫРАЗИТЬ(Накладные.Ссылка КАК Документ.РеализацияТоваровУслуг).Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыРеализацийТоваровУслуг.КПредоплате))
	|
	// исправление кор.аналитики
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Расчеты.Регистратор КАК Регистратор
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК Расчеты
	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.РасчетыСКлиентами КАК КорРасчеты
	|	ПО Расчеты.Регистратор = КорРасчеты.Регистратор
	|		И Расчеты.КорАналитикаУчетаПоПартнерам = КорРасчеты.АналитикаУчетаПоПартнерам
	|		И Расчеты.КорОбъектРасчетов = КорРасчеты.ОбъектРасчетов
	|ГДЕ
	| 	Расчеты.Регистратор ССЫЛКА Документ.ВзаимозачетЗадолженности
	| 	И Расчеты.КорОбъектРасчетов <> ЗНАЧЕНИЕ(Справочник.ОбъектыРасчетов.ПустаяСсылка)
	|	И КорРасчеты.ОбъектРасчетов ЕСТЬ NULL
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Расчеты.Регистратор КАК Регистратор
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК Расчеты
	|ГДЕ
	| 	ТИПЗНАЧЕНИЯ(Расчеты.Регистратор) В (ТИП(Документ.ПередачаТоваровМеждуОрганизациями),
	|										ТИП(Документ.ОтчетПоКомиссииМеждуОрганизациями),
	|										ТИП(Документ.ОтчетПоКомиссииМеждуОрганизациямиОСписании),
	|										ТИП(Документ.РасходныйКассовыйОрдер),
	|										ТИП(Документ.СписаниеБезналичныхДенежныхСредств),
	|										ТИП(Документ.ОперацияПоПлатежнойКарте))
	| 	И Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|	И Расчеты.КОплате > 0
	|	И Расчеты.ИсключатьПриКонтроле = ЛОЖЬ
	|
	// исправление периода движения "К оплате"
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Расчеты.Регистратор КАК Регистратор
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК Расчеты
	|ГДЕ
	|	Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|	И Расчеты.КОплате > 0
	|	И НАЧАЛОПЕРИОДА(Расчеты.Период,ДЕНЬ) < НАЧАЛОПЕРИОДА(Расчеты.ДатаРегистратора,ДЕНЬ)
	|	И НЕ Расчеты.Регистратор ССЫЛКА Документ.ВводОстатков
	|	И НЕ Расчеты.Регистратор ССЫЛКА Документ.ВводОстатковВзаиморасчетов
	|";
	
	Запрос.УстановитьПараметр("ПустыеСсылкиНаЗаказы", ОперативныеВзаиморасчетыСервер.ПустыеСсылкиНаЗаказы());
	
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
		Параметры, 
		Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Регистратор"),
		ПолноеИмяРегистра);
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяОбъекта = "РегистрНакопления.РасчетыСКлиентами";
	ИмяОбъекта = СтрРазделить(ПолноеИмяОбъекта,".")[1];
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц();
	ПараметрыОбработки = ОбновлениеИнформационнойБазы.СоздатьВременнуюТаблицуРегистраторовРегистраДляОбработки(
		Параметры.Очередь,
		Неопределено, 
		ПолноеИмяОбъекта, 
		МенеджерВременныхТаблиц);
	
	Если НЕ ПараметрыОбработки.ЕстьДанныеДляОбработки Тогда
		Параметры.ОбработкаЗавершена = Истина;
		Возврат;
	КонецЕсли;
	Если НЕ ПараметрыОбработки.ЕстьЗаписиВоВременнойТаблице Тогда
		Параметры.ОбработкаЗавершена = Ложь;
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Регистр.Регистратор КАК Ссылка
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК Регистр
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК Аналитика
	|			ПО Аналитика.КлючАналитики = Регистр.АналитикаУчетаПоПартнерам
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ДоговорыКонтрагентов КАК Договоры
	|			ПО Договоры.Ссылка = Аналитика.Договор
	|			И Договоры.ЗаданГрафикИсполнения
	|ГДЕ
	|	Регистр.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|	И Регистр.КОтгрузке > 0 
	|	И (Регистр.ПродажаПоЗаказу НЕ В (&ПустыеСсылкиНаЗаказы)
	|		ИЛИ Договоры.Ссылка ЕСТЬ НЕ NULL)
	|	И Регистр.Регистратор В (ВЫБРАТЬ ВТДляОбработки.Регистратор ИЗ ВТДляОбработки)";
	Запрос.УстановитьПараметр("ПустыеСсылкиНаЗаказы", ОперативныеВзаиморасчетыСервер.ПустыеСсылкиНаЗаказы());
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ВТДляОбработки", ПараметрыОбработки.ИмяВременнойТаблицы);
	НакладныеПоГрафикам = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеРегистра.Регистратор КАК Регистратор,
	|
	|	ДанныеРегистра.ОбъектРасчетов КАК ОбъектРасчетов,
	|	ДанныеРегистра.АналитикаУчетаПоПартнерам КАК АналитикаУчетаПоПартнерам,
	|	КлючиАналитики.Организация КАК Организация,
	|	КлючиАналитики.Партнер КАК Партнер,
	|	КлючиАналитики.Контрагент КАК Контрагент,
	|	КлючиАналитики.Договор КАК Договор,
	|	КлючиАналитики.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|
	|	ДанныеРегистра.КорОбъектРасчетов КАК КорОбъектРасчетов,
	|	ДанныеРегистра.КорАналитикаУчетаПоПартнерам КАК КорАналитикаУчетаПоПартнерам,
	|	КорКлючиАналитики.Организация КАК КорОрганизация,
	|	КорКлючиАналитики.Партнер КАК КорПартнер,
	|	КорКлючиАналитики.Контрагент КАК КорКонтрагент,
	|	КорКлючиАналитики.Договор КАК КорДоговор,
	|	КорКлючиАналитики.НаправлениеДеятельности КАК КорНаправлениеДеятельности
	|ИЗ 
	|	РегистрНакопления.РасчетыСКлиентами КАК ДанныеРегистра
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТДляОбработки КАК СсылкиДляОбработки
	|		ПО ДанныеРегистра.Регистратор = СсылкиДляОбработки.Регистратор
	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК КлючиАналитики
	|		ПО ДанныеРегистра.АналитикаУчетаПоПартнерам = КлючиАналитики.КлючАналитики
	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК КорКлючиАналитики
	|		ПО ДанныеРегистра.КорАналитикаУчетаПоПартнерам = КорКлючиАналитики.КлючАналитики
	|ГДЕ
	| 	ДанныеРегистра.Регистратор ССЫЛКА Документ.ВзаимозачетЗадолженности
	|;
	|
	|ВЫБРАТЬ
	|	СсылкиДляОбработки.Регистратор КАК Регистратор
	|ИЗ 
	|	ВТДляОбработки КАК СсылкиДляОбработки
	|";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ВТДляОбработки", ПараметрыОбработки.ИмяВременнойТаблицы);
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	ПоляКлючаАналитики =  РезультатыЗапроса[0].Выгрузить();
	ПоляПоискаКорАналитики = "Регистратор,КорОбъектРасчетов,КорАналитикаУчетаПоПартнерам";
	ПоляПоискаАналитики = "Регистратор,ОбъектРасчетов,Организация,Контрагент,Договор,НаправлениеДеятельности";
	ПоляКлючаАналитики.Индексы.Добавить(ПоляПоискаКорАналитики);
	ПоляКлючаАналитики.Индексы.Добавить(ПоляПоискаАналитики);
	
	ОбновляемыеДанные =  РезультатыЗапроса[1].Выбрать();
	
	ПоляЗаполнения = "
		|Активность,Период,АналитикаУчетаПоПартнерам,Валюта,КОплате,
		|ХозяйственнаяОперация,ФормаОплаты,СчетНаОплату,
		|ПорядокОперации,ВалютаДокумента,ИдентификаторФинЗаписи";
	
	Пока ОбновляемыеДанные.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			
			ЭлементБлокировки = Блокировка.Добавить("РегистрНакопления.РасчетыСКлиентами.НаборЗаписей");
			ЭлементБлокировки.УстановитьЗначение("Регистратор", ОбновляемыеДанные.Регистратор);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			
			Блокировка.Заблокировать();
			
			НаборЗаписей = СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Регистратор.Установить(ОбновляемыеДанные.Регистратор);
			НаборЗаписей.Прочитать();
			ДанныеНабора = НаборЗаписей.Выгрузить();
			СтарыеДанныеНабора = НаборЗаписей.Выгрузить();
			ОтметитьОбработку = Истина;
			ЕстьИзменения = Ложь;
			
			Если НакладныеПоГрафикам.Найти(ОбновляемыеДанные.Регистратор) <> Неопределено Тогда
				
				ДатаРегистратора = Дата(1,1,1);
				ЕстьРасходКОплате = Ложь;
				ЗаписьСуммы = Неопределено;
				ЗаписьКОтгрузке = Неопределено;
				Для Каждого Запись Из ДанныеНабора Цикл
					Если Запись.Сумма > 0 
						И Запись.ВидДвижения = ВидДвиженияНакопления.Приход 
						И Запись.ХозяйственнаяОперация <> Перечисления.ХозяйственныеОперации.ПереносАванса
						И Запись.ХозяйственнаяОперация <> Перечисления.ХозяйственныеОперации.ПереносЗадолженностиМеждуФилиалами Тогда
						ЗаписьСуммы = Запись;
					КонецЕсли;
					Если НЕ ЗначениеЗаполнено(ДатаРегистратора) И ЗначениеЗаполнено(Запись.ДатаРегистратора) Тогда
						ДатаРегистратора = Запись.ДатаРегистратора;
					КонецЕсли;
					Если Запись.КОтгрузке <> 0 Тогда
						ЗаписьКОтгрузке = Запись;
					КонецЕсли;
					Если Запись.КОплате > 0 
						И Запись.ВидДвижения = ВидДвиженияНакопления.Расход 
						И Запись.ХозяйственнаяОперация <> Перечисления.ХозяйственныеОперации.ПереносАванса
						И Запись.ХозяйственнаяОперация <> Перечисления.ХозяйственныеОперации.ПереносЗадолженностиМеждуФилиалами Тогда
						ЕстьРасходКОплате = Истина;
					КонецЕсли;
				КонецЦикла;
				
				ЗаписьНакладной = ?(ЗаписьСуммы <> Неопределено, ЗаписьСуммы, ЗаписьКОтгрузке);
				
				Если Не ЕстьРасходКОплате И ЗаписьНакладной <> Неопределено Тогда
					
					Для Каждого Запись Из ДанныеНабора Цикл
						
						Если (Запись.Сумма > 0 
							//РТУ в статусе "В пути"
							ИЛИ Запись.КОтгрузке > 0 И ЗаписьСуммы = Неопределено)
							И Запись.ВидДвижения = ВидДвиженияНакопления.Приход 
							И Запись.ХозяйственнаяОперация <> Перечисления.ХозяйственныеОперации.ПереносАванса
							И Запись.ХозяйственнаяОперация <> Перечисления.ХозяйственныеОперации.ПереносЗадолженностиМеждуФилиалами Тогда
							КОплатеПриход = ДанныеНабора.Добавить();
							ЗаполнитьЗначенияСвойств(КОплатеПриход,ЗаписьНакладной,ПоляЗаполнения);
							КОплатеПриход.Период = КонецДня(Запись.ДатаПлатежа);
							КОплатеПриход.ВидДвижения = ВидДвиженияНакопления.Приход;
							КОплатеПриход.КОплате = ?(Запись.Сумма>0,Запись.Сумма,Запись.КОтгрузке);
							КОплатеПриход.ВариантОплаты = Запись.ВариантОплаты;
							КОплатеПриход.ДатаПлатежа = Запись.ДатаПлатежа;
							КОплатеПриход.ПродажаПоЗаказу = Запись.ПродажаПоЗаказу;
							КОплатеПриход.ИсключатьПриКонтроле = Запись.ИсключатьПриКонтроле;
							КОплатеПриход.ПорядокЗачетаПоДатеПлатежа = Запись.ПорядокЗачетаПоДатеПлатежа;
							КОплатеПриход.ОбъектРасчетов = Запись.ОбъектРасчетов;
							КОплатеПриход.ДатаРегистратора = ДатаРегистратора;
							Если НЕ ЗначениеЗаполнено(КОплатеПриход.ВариантОплаты) Тогда
								КОплатеПриход.ВариантОплаты = Перечисления.ВариантыКонтроляОплатыКлиентом.КредитПослеОтгрузки;
							КонецЕсли;
							ЕстьИзменения = Истина;
						КонецЕсли;
						Если Запись.КОтгрузке > 0
							И Запись.ВидДвижения = ВидДвиженияНакопления.Приход Тогда
							КОплатеРасход = ДанныеНабора.Добавить();
							ЗаполнитьЗначенияСвойств(КОплатеРасход,ЗаписьНакладной,ПоляЗаполнения);
							КОплатеРасход.Период = Запись.Период;
							КОплатеРасход.ВидДвижения = ВидДвиженияНакопления.Расход;
							КОплатеРасход.КОплате = Запись.КОтгрузке;
							КОплатеРасход.ПродажаПоЗаказу = Запись.ПродажаПоЗаказу;
							КОплатеРасход.ИсключатьПриКонтроле = Ложь;
							КОплатеРасход.ПорядокЗачетаПоДатеПлатежа = ЗаписьНакладной.ПорядокОперации;
							КОплатеРасход.ОбъектРасчетов = Запись.ОбъектРасчетов;
							КОплатеРасход.ДатаРегистратора = ДатаРегистратора;
							ЕстьИзменения = Истина;
						КонецЕсли;
					КонецЦикла;
						
				КонецЕсли;
			КонецЕсли;
			
			#Область ИсключатьПриКонтроле
			Если ТипЗнч(ОбновляемыеДанные.Регистратор) = Тип("ДокументСсылка.ПередачаТоваровМеждуОрганизациями") 
				ИЛИ ТипЗнч(ОбновляемыеДанные.Регистратор) = Тип("ДокументСсылка.ОтчетПоКомиссииМеждуОрганизациями") 
				ИЛИ ТипЗнч(ОбновляемыеДанные.Регистратор) = Тип("ДокументСсылка.ОтчетПоКомиссииМеждуОрганизациямиОСписании") 
				ИЛИ ТипЗнч(ОбновляемыеДанные.Регистратор) = Тип("ДокументСсылка.РасходныйКассовыйОрдер") 
				ИЛИ ТипЗнч(ОбновляемыеДанные.Регистратор) = Тип("ДокументСсылка.СписаниеБезналичныхДенежныхСредств") 
				ИЛИ ТипЗнч(ОбновляемыеДанные.Регистратор) = Тип("ДокументСсылка.ОперацияПоПлатежнойКарте")
			Тогда
				Для Каждого Запись Из ДанныеНабора Цикл
					Если Запись.ВидДвижения = ВидДвиженияНакопления.Приход
						И Запись.КОплате > 0 ИЛИ Запись.Сумма > 0 Тогда
						Запись.ИсключатьПриКонтроле = Истина;
						ЕстьИзменения = Истина;
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;
			#КонецОбласти
			
			#Область ИсправлениеКорАналитики
			ТаблицыДвижений = Неопределено;
			НовыеДанныеНабора = Неопределено;
			Для Каждого Запись Из ДанныеНабора Цикл
				
				Если ТипЗнч(ОбновляемыеДанные.Регистратор) <> Тип("ДокументСсылка.ВзаимозачетЗадолженности") Тогда
				 	Прервать;
				КонецЕсли;
				
				Если НЕ ЗначениеЗаполнено(Запись.КорОбъектРасчетов) Тогда
					Продолжить;
				КонецЕсли;
				
				Отбор = Новый Структура("АналитикаУчетаПоПартнерам,ОбъектРасчетов");
				Отбор.ОбъектРасчетов = Запись.КорОбъектРасчетов;
				Отбор.АналитикаУчетаПоПартнерам = Запись.КорАналитикаУчетаПоПартнерам;
				СтрокиКорЧасти = ДанныеНабора.НайтиСтроки(Отбор);
				Если СтрокиКорЧасти.Количество() <> 0 Тогда
					Продолжить;
				КонецЕсли;
				
				ОтборКорАналитики = Новый Структура(ПоляПоискаКорАналитики);
				ОтборКорАналитики.Регистратор = ОбновляемыеДанные.Регистратор;
				ОтборКорАналитики.КорОбъектРасчетов = Запись.КорОбъектРасчетов;
				ОтборКорАналитики.КорАналитикаУчетаПоПартнерам = Запись.КорАналитикаУчетаПоПартнерам;
				КорАналитика = ПоляКлючаАналитики.НайтиСтроки(ОтборКорАналитики);
				
				Если КорАналитика.Количество() = 0 Тогда
					ОтметитьОбработку = Ложь;
					Прервать;
				КонецЕсли;
				
				ОтборАналитики = Новый Структура(ПоляПоискаАналитики);
				ОтборАналитики.Регистратор = ОбновляемыеДанные.Регистратор;
				ОтборАналитики.ОбъектРасчетов = Запись.КорОбъектРасчетов;
				ОтборАналитики.Организация = КорАналитика[0].КорОрганизация;
				ОтборАналитики.Контрагент = КорАналитика[0].КорКонтрагент;
				ОтборАналитики.Договор = КорАналитика[0].КорДоговор;
				ОтборАналитики.НаправлениеДеятельности = КорАналитика[0].КорНаправлениеДеятельности;
			
				Аналитика = ПоляКлючаАналитики.НайтиСтроки(ОтборАналитики);
				Если Аналитика.Количество() = 1 Тогда
					Запись.КорАналитикаУчетаПоПартнерам = Аналитика[0].АналитикаУчетаПоПартнерам;
					ЕстьИзменения = Истина;
				Иначе
					Если ТаблицыДвижений = Неопределено Тогда
						ТаблицыДвижений = Документы.ВзаимозачетЗадолженности.ДанныеДокументаДляПроведения(ОбновляемыеДанные.Регистратор, ИмяОбъекта);
					КонецЕсли;
					НовыеДанныеНабора = ТаблицыДвижений.ТаблицаРасчетыСКлиентами;
					Для Каждого Строка Из НовыеДанныеНабора Цикл
						НоваяСтрока = СтарыеДанныеНабора.Добавить();
						ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
						НоваяСтрока.Сумма = -Строка.Сумма;
						НоваяСтрока.КОплате = -Строка.КОплате;
						НоваяСтрока.СуммаРегл = -Строка.СуммаРегл;
						НоваяСтрока.СуммаУпр = -Строка.СуммаУпр;
					КонецЦикла;
					КопияНабора = НовыеДанныеНабора.Скопировать();
					КопияНабора.Свернуть("АналитикаУчетаПоПартнерам,ОбъектРасчетов,Валюта","Сумма,КОплате,СуммаРегл,СуммаУпр");
					СтарыеДанныеНабора.Свернуть("АналитикаУчетаПоПартнерам,ОбъектРасчетов,Валюта","Сумма,КОплате,СуммаРегл,СуммаУпр");
					ОтборНулей = Новый Структура("Сумма,КОплате,СуммаРегл,СуммаУпр",0,0,0,0);
					СтрокиСНулями = СтарыеДанныеНабора.НайтиСтроки(ОтборНулей);
					Если СтрокиСНулями.Количество() <> КопияНабора.Количество() Тогда
						НовыеДанныеНабора = Неопределено;
						ОтметитьОбработку = Истина;
					КонецЕсли;
					Прервать;
				КонецЕсли;
				
			КонецЦикла;
			#КонецОбласти
			
			Для Каждого Запись Из ДанныеНабора Цикл
				Если Запись.ВидДвижения = ВидДвиженияНакопления.Приход
					И Запись.КОплате > 0 
					И НачалоДня(Запись.Период) < НачалоДня(Запись.ДатаРегистратора) 
					И НЕ ТипЗнч(ОбновляемыеДанные.Регистратор) = Тип("ДокументСсылка.ВводОстатков")
					И НЕ ТипЗнч(ОбновляемыеДанные.Регистратор) = Тип("ДокументСсылка.ВводОстатковВзаиморасчетов") Тогда
					Запись.Период = Запись.ДатаРегистратора;
					ЕстьИзменения = Истина
				КонецЕсли;
			КонецЦикла;
			
			Если НовыеДанныеНабора <> Неопределено Тогда
				НаборЗаписей.Загрузить(НовыеДанныеНабора);
			ИначеЕсли ЕстьИзменения Тогда
				НаборЗаписей.Загрузить(ДанныеНабора);
			КонецЕсли;
			
			Если НаборЗаписей.Модифицированность() Тогда
				ОбновлениеИнформационнойБазы.ЗаписатьДанные(НаборЗаписей);
			ИначеЕсли ОтметитьОбработку Тогда
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(НаборЗаписей);
			КонецЕсли;
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			ОбновлениеИнформационнойБазыУТ.СообщитьОНеудачнойОбработке(ИнформацияОбОшибке(), ОбновляемыеДанные.Регистратор);
			
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

// Процедура регистрации данных для обработчика обновления УдалитьДвиженияПоПередачеНаХранение.
// 
// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьЗаказыКУдалению(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.РасчетыСКлиентами";
	
	ПараметрыВыборки = Параметры.ПараметрыВыборки;
	ПараметрыВыборки.ПолныеИменаОбъектов = "Документ.ЗаказКлиента";
	ПараметрыВыборки.ПолныеИменаРегистров = ПолноеИмяРегистра;
	ПараметрыВыборки.ПоляУпорядочиванияПриРаботеПользователей.Добавить("Период УБЫВ");
	ПараметрыВыборки.ПоляУпорядочиванияПриОбработкеДанных.Добавить("Период УБЫВ");
	ПараметрыВыборки.СпособВыборки = ОбновлениеИнформационнойБазы.СпособВыборкиРегистраторыРегистра();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	РасчетыСКлиентами.Регистратор КАК Ссылка
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК РасчетыСКлиентами
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЗаказКлиента КАК ЗаказКлиента
	|			ПО РасчетыСКлиентами.Регистратор = ЗаказКлиента.Ссылка
	|ГДЕ
	|	ЗаказКлиента.ХозяйственнаяОперация = &ХозяйственнаяОперация";
	Запрос.УстановитьПараметр("ХозяйственнаяОперация", Перечисления.ХозяйственныеОперации.ПередачаНаХранениеСПравомПродажи);
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(Параметры, Регистраторы, ПолноеИмяРегистра);
	
КонецПроцедуры

Процедура УдалитьДвиженияПоПередачеНаХранение(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.РасчетыСКлиентами";
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазыУТ.ДополнительныеПараметрыПерезаписиДвиженийИзОчереди();
	ДополнительныеПараметры.ОбновляемыеДанные = Параметры.ОбновляемыеДанные;
	
	ДокументКОбновлению = "Документ.ЗаказКлиента";
	
	ОбработкаЗавершена = ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(ДокументКОбновлению,
																						ПолноеИмяРегистра,
																						Параметры.Очередь,
																						ДополнительныеПараметры);
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли