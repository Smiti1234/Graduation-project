﻿#Область ОписаниеПеременных

&НаКлиенте
Перем КэшированныеЗначения;

&НаКлиенте
Перем ПараметрыДляЗаписи Экспорт;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат формы для анализа
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	// Обработчик механизма "ВерсионированиеОбъектов"
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииСозданииНаСервере();
	КонецЕсли;
	
	СписокРеквизитов = Новый Массив;
	Для каждого МетаданныеРеквизита Из Метаданные.Документы.Бронирование.ТабличныеЧасти.Операции.Реквизиты Цикл
		СписокРеквизитов.Добавить(МетаданныеРеквизита.Имя);
	КонецЦикла;
	РеквизитыКорректировок = СтрСоединить(СписокРеквизитов, ",");
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборотБазоваяФункциональность.ПриСозданииНаСервере(ЭтаФорма);
	// Конец ИнтеграцияС1СДокументооборотом
	
	// Обработчик подсистемы "Свойства"
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Объект", Объект);
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтаФорма, ДополнительныеПараметры);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	// СтандартныеПодсистемы.РаботаСФайлами
	ПараметрыГиперссылки = РаботаСФайлами.ГиперссылкаФайлов();
	ПараметрыГиперссылки.Размещение = "КоманднаяПанель";
	РаботаСФайлами.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыГиперссылки);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	// СтандартныеПодсистемы.РаботаСФайлами
	РаботаСФайламиКлиент.ПриОткрытии(ЭтотОбъект, Отказ);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ПриЧтенииСозданииНаСервере();

	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	
	СобытияФорм.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	СтрокиПокупка = Объект.Операции.НайтиСтроки(
		Новый Структура("ТипОперации", ПредопределенноеЗначение("Перечисление.ТипыОперацийСБилетами.Покупка")));
	Если СтрокиПокупка.Количество() И Не ЗначениеЗаполнено(СтрокиПокупка[0].Сумма) Тогда
		ТекстОшибки = НСтр("ru = 'Поле ""Сумма"" не заполнено'");
		ОбщегоНазначения.СообщитьПользователю(
			ТекстОшибки,, "Элементы.Операции.ТекущиеДанные.Сумма",, Отказ);
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтаФорма, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	СтрокиПокупка = Объект.Операции.НайтиСтроки(
		Новый Структура("ТипОперации", ПредопределенноеЗначение("Перечисление.ТипыОперацийСБилетами.Покупка")));
	Если СтрокиПокупка.Количество() Тогда
		СтрокиПокупка[0].Дата = Объект.Дата;
	КонецЕсли;
	
	СобытияФормКлиент.ПередЗаписью(ЭтотОбъект, Отказ, ПараметрыЗаписи);
	
	Если НеВыполнятьПроверкуПередЗаписью Тогда
		НеВыполнятьПроверкуПередЗаписью = Ложь;
		Возврат;
	Иначе
		Если Объект.ДатаОтправления < НачалоДня(Объект.Дата) Тогда
			ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Дата отправления не может быть раньше даты покупки билета.'"), Объект.Ссылка, "Объект.ДатаОтправления",,Отказ);
		КонецЕсли;
	КонецЕсли;
	
	ОбщегоНазначенияУТКлиент.ЗаписатьОбъектПриНеобходимости(ЭтотОбъект, ПараметрыЗаписи, Отказ);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// Обработчик подсистемы "Свойства"
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект);
	
	МодификацияКонфигурацииПереопределяемый.ПередЗаписьюНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ОбновитьЗаголовокФормы();
	
	НастроитьЗависимыеЭлементыФормыНаСервере();
	
	МодификацияКонфигурацииПереопределяемый.ПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);
	
	СобытияФорм.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_Бронирование", ПараметрыЗаписи, Объект.Ссылка);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	МодификацияКонфигурацииКлиентПереопределяемый.ПослеЗаписи(ЭтаФорма, ПараметрыЗаписи);
	
	ОбщегоНазначенияУТКлиент.ВыполнитьДействияПослеЗаписи(ЭтаФорма, Объект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ПринудительноЗакрытьФорму = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтаФорма, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	СобытияФормКлиент.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	
	// СтандартныеПодсистемы.РаботаСФайлами
	РаботаСФайламиКлиент.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ХозяйственнаяОперацияПриИзменении(Элемент)
	
	ХозяйственнаяОперацияПриИзмененииНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ХозяйственнаяОперацияПриИзмененииНаСервере()
	
	Объект.Договор = Неопределено;
	
	Если Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.БронированиеЧерезАгента
		Или Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.БронированиеУПоставщика Тогда
		Если Не ПолучитьФункциональнуюОпцию("ИспользоватьДоговорыСПоставщиками") Тогда
			ТекстСообщения = НСтр("ru = 'Для отражения покупки билета через агента или у перевозчика 
				|необходимо указать договор - включить использование договоров с поставщиками в разделе ""Закупки"".'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
			Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.БронированиеЧерезПодотчетноеЛицо;
		КонецЕсли;
	КонецЕсли;
	
	ЗаполнитьПодчиненныеСвойстваПоСтатистике("ХозяйственнаяОперация");
	
	УправлениеЭлементамиФормы();
	НастроитьЗависимыеЭлементыФормыНаСервере("ХозяйственнаяОперация");
	
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ОрганизацияПриИзмененииСервер();
	ОбновитьТекстАвансовыйОтчет();
	
КонецПроцедуры

&НаСервере
Процедура ОрганизацияПриИзмененииСервер()
	
	Если Не ЗначениеЗаполнено(Объект.Валюта) Тогда
		Объект.Валюта = ЗначениеНастроекПовтИсп.ВалютаРегламентированногоУчетаОрганизации(Объект.Организация);
	КонецЕсли;
	
	Объект.АвансовыйОтчет = Неопределено;
	
	ПерезаполнитьСтавкуНДС();
	ЗаполнитьПодчиненныеСвойстваПоСтатистике("Организация");
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПокупкиПриИзменении(Элемент)
	ДатаПокупкиПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ДатаПокупкиПриИзмененииНаСервере()
	
	ПерезаполнитьСтавкуНДС();
	ОпределитьПечатьЕдиногоАвансовогоОтчета();
	НастроитьЗависимыеЭлементыФормыНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПеревозчикПриИзменении(Элемент)
	
	ПеревозчикПриИзмененииНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПеревозчикПриИзмененииНаСервере()
	
	ПартнерыИКонтрагенты.ЗаполнитьКонтрагентаПартнераПоУмолчанию(Объект.Перевозчик, Объект.КонтрагентПеревозчик);
	
	Если Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.БронированиеУПоставщика Тогда
		
		ДопПараметры = ЗакупкиСервер.ДополнительныеПараметрыОтбораДоговоров();
		ДопПараметры.ВалютаВзаиморасчетов = Объект.Валюта;
		
		ПараметрыДоговора = Новый Структура;
		ПараметрыДоговора.Вставить("Партнер",     Объект.Перевозчик);
		ПараметрыДоговора.Вставить("Договор",     Объект.Договор);
		ПараметрыДоговора.Вставить("Контрагент",  Объект.КонтрагентПеревозчик);
		ПараметрыДоговора.Вставить("Организация", Объект.Организация);
		
		Объект.Договор = ЗакупкиСервер.ПолучитьДоговорПоУмолчанию(
			ПараметрыДоговора, Перечисления.ХозяйственныеОперации.ЗакупкаУПоставщика, ДопПараметры);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура АгентПриИзменении(Элемент)
	
	АгентПриИзмененииНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура АгентПриИзмененииНаСервере()
	
	ПартнерыИКонтрагенты.ЗаполнитьКонтрагентаПартнераПоУмолчанию(Объект.Агент, Объект.КонтрагентАгент);
	
	Если Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.БронированиеЧерезАгента Тогда
		
		ДопПараметры = ЗакупкиСервер.ДополнительныеПараметрыОтбораДоговоров();
		ДопПараметры.ВалютаВзаиморасчетов = Объект.Валюта;
		
		ПараметрыДоговора = Новый Структура;
		ПараметрыДоговора.Вставить("Партнер",     Объект.Агент);
		ПараметрыДоговора.Вставить("Договор",     Объект.Договор);
		ПараметрыДоговора.Вставить("Контрагент",  Объект.КонтрагентАгент);
		ПараметрыДоговора.Вставить("Организация", Объект.Организация);
		
		Объект.Договор = ЗакупкиСервер.ПолучитьДоговорПоУмолчанию(
			ПараметрыДоговора, Перечисления.ХозяйственныеОперации.ЗакупкаУПоставщика, ДопПараметры);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПодотчетноеЛицоПриИзменении(Элемент)
	ПодотчетноеЛицоПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПодотчетноеЛицоПриИзмененииНаСервере()
	Объект.ПодразделениеПодотчетногоЛица = ФизическиеЛицаУТ.ПодразделениеФизическогоЛица(Объект.ПодотчетноеЛицо);
КонецПроцедуры

&НаКлиенте
Процедура СуммаДокументаПриИзменении(Элемент)
	РассчитатьНДС();
КонецПроцедуры

&НаКлиенте
Процедура СтавкаНДСПриИзменении(Элемент)
	РассчитатьНДС();
КонецПроцедуры

&НаКлиенте
Процедура СуммаНДСПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Операции.ТекущиеДанные;
	
	ЗначениеСтавкиНДС = УчетНДСУПКлиентСервер.ЗначениеСтавкиНДС(ТекущаяСтрока.СтавкаНДС);
	
	Если ЗначениеСтавкиНДС <> 0 Тогда
		ОблагаемаяСумма = ТекущаяСтрока.СуммаНДС / ЗначениеСтавкиНДС * 100;
		ТекущаяСтрока.СуммаНеОблагаемаяНДС = ТекущаяСтрока.Сумма - ОблагаемаяСумма - ТекущаяСтрока.СуммаНДС;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СуммаНеОблагаемаяНДСПриИзменении(Элемент)
	РассчитатьНДС();
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьНДС()
	
	ТекущаяСтрока = Элементы.Операции.ТекущиеДанные;
	
	ДанныеСтроки = Новый Структура;
	ДанныеСтроки.Вставить("СтавкаНДС", ТекущаяСтрока.СтавкаНДС);
	ДанныеСтроки.Вставить("СуммаНДС", ТекущаяСтрока.СуммаНДС);
	ДанныеСтроки.Вставить("Сумма", ТекущаяСтрока.Сумма - ТекущаяСтрока.СуммаНеОблагаемаяНДС);
	
	ПараметрыПересчетаНДС = Новый Структура("ЦенаВключаетНДС", Истина);
	СтруктураДействий = Новый Структура("ПересчитатьСуммуНДС", ПараметрыПересчетаНДС);
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ДанныеСтроки, СтруктураДействий, КэшированныеЗначения);
	
	ТекущаяСтрока.СуммаНДС = ДанныеСтроки.СуммаНДС;
	
КонецПроцедуры

&НаКлиенте
Процедура ТекстАвансовыйОтчетОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОчиститьАвансовыйОтчет" Тогда
		
		СтандартнаяОбработка = Ложь;
		Объект.АвансовыйОтчет = Неопределено;
		Модифицированность = Истина;
		ТекстАвансовыйОтчет = Новый ФорматированнаяСтрока(НСтр("ru = 'Включить в авансовый отчет'"),,,, "ВключитьВАвансовыйОтчет");
		
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "ВключитьВАвансовыйОтчет" Тогда
		
		СтандартнаяОбработка = Ложь;
		
		Отбор = Новый Структура;
		Отбор.Вставить("Организация", Объект.Организация);
		Отбор.Вставить("Подразделение", Объект.ПодразделениеПодотчетногоЛица);
		Отбор.Вставить("ПодотчетноеЛицо", Объект.ПодотчетноеЛицо);
		
		ПараметрыФормы = Новый Структура("Отбор", Отбор);
		ПараметрыФормы.Вставить("Дата", Объект.Дата);
		ПараметрыФормы.Вставить("ДокументЗакупки", Объект.Ссылка);
		
		Оповещение = Новый ОписаниеОповещения("ПослеВыбораАвансовогоОтчета", ЭтотОбъект);
		
		ОткрытьФорму("Документ.АвансовыйОтчет.Форма.ФормаВыбораСоздания", ПараметрыФормы, ЭтотОбъект,,,, Оповещение);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораАвансовогоОтчета(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		Объект.АвансовыйОтчет = Результат;
		Модифицированность = Истина;
		ОбновитьТекстАвансовыйОтчет();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура Подключаемый_ЗакрытьФорму()
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбработатьЗаписьОбъекта()
	
	ОбщегоНазначенияУТКлиент.ОбработатьЗаписьОбъектаВФорме(ЭтотОбъект, ПараметрыДляЗаписи);
	
КонецПроцедуры

// СтандартныеПодсистемы.РаботаСФайлами
&НаКлиенте
Процедура Подключаемый_КомандаПанелиПрисоединенныхФайлов(Команда)
	 РаботаСФайламиКлиент.КомандаУправленияПрисоединеннымиФайлами(ЭтотОбъект, Команда);
КонецПроцедуры
// Конец СтандартныеПодсистемы.РаботаСФайлами

// СтандартныеПодсистемы.РаботаСФайлами
&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	 РаботаСФайламиКлиент.ПолеПредпросмотраПроверкаПеретаскивания(ЭтотОбъект, Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.РаботаСФайлами

// СтандартныеПодсистемы.РаботаСФайлами
&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	 РаботаСФайламиКлиент.ПолеПредпросмотраПеретаскивание(ЭтотОбъект, Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.РаботаСФайлами

// СтандартныеПодсистемы.РаботаСФайлами
&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраНажатие(Элемент, СтандартнаяОбработка)
	 РаботаСФайламиКлиент.ПолеПредпросмотраНажатие(ЭтотОбъект, Элемент, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.РаботаСФайлами

&НаКлиенте
Процедура ПровестиДокумент(Команда)
	
	ОбщегоНазначенияУТКлиент.Провести(ЭтаФорма, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПровестиИЗакрыть(Команда)
	
	ОбщегоНазначенияУТКлиент.ПровестиИЗакрыть(ЭтаФорма, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьДокумент(Команда)
	
	ОбщегоНазначенияУТКлиент.Записать(ЭтаФорма, Истина);
	
КонецПроцедуры

// ИнтеграцияС1СДокументооборотом
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	ИнтеграцияС1СДокументооборотБазоваяФункциональностьКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(Команда, ЭтаФорма, Объект);
	
КонецПроцедуры
//Конец ИнтеграцияС1СДокументооборотом

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ИнформацияОКорректировкахОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ИдСтроки = Число(Сред(НавигационнаяСсылкаФорматированнойСтроки, СтрНайти(НавигационнаяСсылкаФорматированнойСтроки, "=")+1));
	
	Если СтрНайти(НавигационнаяСсылкаФорматированнойСтроки, "Удалить") Тогда
		СтрокаКорректировки = Объект.Операции.НайтиПоИдентификатору(ИдСтроки);
		Если СтрокаКорректировки <> Неопределено Тогда
			Объект.Операции.Удалить(СтрокаКорректировки);
			ВывестиКорректировки();
			Модифицированность = Истина;
		КонецЕсли;
	ИначеЕсли СтрНайти(НавигационнаяСсылкаФорматированнойСтроки, "Изменить") Тогда
		РедактироватьКорректировку(ИдСтроки);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВвестиДоплату(Команда)
	
	НоваяКорректировка = Объект.Операции.Добавить();
	НоваяКорректировка.Дата = ТекущаяДата();
	НоваяКорректировка.ТипОперации = ПредопределенноеЗначение("Перечисление.ТипыОперацийСБилетами.Доплата");
	НоваяКорректировка.СтавкаНДС = ПредопределенноеЗначение("Справочник.СтавкиНДС.БезНДС");
	
	РедактироватьКорректировку(НоваяКорректировка.ПолучитьИдентификатор(), Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ВвестиВозврат(Команда)
	
	СуммаВозврата = 0;
	Для каждого СтрокаТЧ Из Объект.Операции Цикл
		Если СтрокаТЧ.ТипОперации = ПредопределенноеЗначение("Перечисление.ТипыОперацийСБилетами.Покупка")
			Или СтрокаТЧ.ТипОперации = ПредопределенноеЗначение("Перечисление.ТипыОперацийСБилетами.Доплата") Тогда
			СуммаВозврата = СуммаВозврата + СтрокаТЧ.Сумма;
		ИначеЕсли СтрокаТЧ.ТипОперации = ПредопределенноеЗначение("Перечисление.ТипыОперацийСБилетами.Возврат") Тогда
			СуммаВозврата = СуммаВозврата - СтрокаТЧ.Сумма;
		КонецЕсли;
	КонецЦикла;
	
	НоваяКорректировка = Объект.Операции.Добавить();
	НоваяКорректировка.Дата = ТекущаяДата();
	НоваяКорректировка.ТипОперации = ПредопределенноеЗначение("Перечисление.ТипыОперацийСБилетами.Возврат");
	НоваяКорректировка.СтавкаНДС = Объект.СтавкаНДС;
	НоваяКорректировка.Сумма = СуммаВозврата;
	НоваяКорректировка.СуммаНДС = Объект.СуммаНДС;
	НоваяКорректировка.СуммаНеОблагаемаяНДС = Объект.СуммаНеОблагаемаяНДС;
	
	РедактироватьКорректировку(НоваяКорректировка.ПолучитьИдентификатор(), Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьКорректировку(ИдСтроки, НоваяСтрока = Ложь)
	
	ЗначенияРеквизитов = Новый Структура(РеквизитыКорректировок);
	ЗаполнитьЗначенияСвойств(ЗначенияРеквизитов, Объект.Операции.НайтиПоИдентификатору(ИдСтроки));
	ЗначенияРеквизитов.Вставить("Организация", Объект.Организация);
	
	ДопПараметры = Новый Структура("ИдСтроки, НоваяСтрока", ИдСтроки, НоваяСтрока);
	
	ОткрытьФорму("Документ.Бронирование.Форма.ВводКорректировки",
		Новый Структура("ЗначенияРеквизитов, РеквизитыКорректировок", ЗначенияРеквизитов, РеквизитыКорректировок),
		,,,,
		Новый ОписаниеОповещения("ПослеВводаКорректировки", ЭтотОбъект, ДопПараметры),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВводаКорректировки(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат = КодВозвратаДиалога.Отмена Тогда
		
		Если ДополнительныеПараметры.НоваяСтрока Тогда
			СтрокаКорректировки = Объект.Операции.НайтиПоИдентификатору(ДополнительныеПараметры.ИдСтроки);
			Если СтрокаКорректировки <> Неопределено Тогда
				Объект.Операции.Удалить(СтрокаКорректировки);
			КонецЕсли;
			Модифицированность = Ложь;
		КонецЕсли;
	Иначе
		СтрокаКорректировки = Объект.Операции.НайтиПоИдентификатору(ДополнительныеПараметры.ИдСтроки);
		Если СтрокаКорректировки <> Неопределено Тогда
			ЗаполнитьЗначенияСвойств(СтрокаКорректировки, Результат, РеквизитыКорректировок);
		КонецЕсли;
		Модифицированность = Истина;
		ВывестиКорректировки();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Свойства

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область УправлениеЭлементамиФормы

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	
	ДатаНачалаПечатиЕдиногоАвансовогоОтчета = Константы.ДатаНачалаПечатиЕдиногоАвансовогоОтчета.Получить();
	ЕдиныйАвансовыйОтчетБезусловно = Не Константы.ВидимостьДатыНачалаПечатиЕдиногоАвансовогоОтчета.Получить();
	ОпределитьПечатьЕдиногоАвансовогоОтчета();
	ДенежныеСредстваСервер.УправлениеЭлементамиФормыПриЧтенииСозданииНаСервере(ЭтотОбъект);
	
	ИнициализироватьОперации();
	
	ОбновитьЗаголовокФормы();
	ВывестиКорректировки();
	ОбновитьТекстАвансовыйОтчет();
	УправлениеЭлементамиФормы();
	
	НастроитьЗависимыеЭлементыФормыНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьЗависимыеЭлементыФормыНаСервере(ИзмененныйРеквизит = "")
	
	ДенежныеСредстваКлиентСервер.НастроитьЭлементыФормы(ЭтаФорма, ИзмененныйРеквизит, РеквизитыФормы(ЭтаФорма));
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция РеквизитыФормы(Форма)
	
	РеквизитыФормы = Новый Структура;
	РеквизитыФормы.Вставить("ПечатьЕдиногоАвансовогоОтчета");
	
	ЗаполнитьЗначенияСвойств(РеквизитыФормы, Форма);
	
	Возврат РеквизитыФормы;
	
КонецФункции

&НаСервере
Процедура УправлениеЭлементамиФормы()
	
	СписокВыбораТипаУслуги = Элементы.ТипУслуги.СписокВыбора;
	СписокВыбораТипаУслуги.Очистить();
	
	Если Объект.ТипБронирования = Перечисления.ТипыБронирования.ЭлектронныйБилет Тогда
		СписокВыбораТипаУслуги.Добавить(Перечисления.ТипыУслугБронирования.Авиабилет);
		СписокВыбораТипаУслуги.Добавить(Перечисления.ТипыУслугБронирования.ЖДБилет);
		СписокВыбораТипаУслуги.Добавить(Перечисления.ТипыУслугБронирования.Трансфер);
		СписокВыбораТипаУслуги.Добавить(Перечисления.ТипыУслугБронирования.Прочее);
	Иначе
		СписокВыбораТипаУслуги.Добавить(Перечисления.ТипыУслугБронирования.Отель);
		СписокВыбораТипаУслуги.Добавить(Перечисления.ТипыУслугБронирования.Трансфер);
		СписокВыбораТипаУслуги.Добавить(Перечисления.ТипыУслугБронирования.Прочее);
	КонецЕсли;
	
	Связи = Новый Массив;
	Связи.Добавить(Новый СвязьПараметраВыбора("Отбор.Организация", "Объект.Организация"));
	Связи.Добавить(Новый СвязьПараметраВыбора("Отбор.ВалютаВзаиморасчетов", "Объект.Валюта"));
	Если Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.БронированиеЧерезАгента Тогда
		Связи.Добавить(Новый СвязьПараметраВыбора("Отбор.Контрагент", "Объект.КонтрагентАгент"));
	ИначеЕсли Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.БронированиеУПоставщика Тогда
		Связи.Добавить(Новый СвязьПараметраВыбора("Отбор.Контрагент", "Объект.КонтрагентПеревозчик"));
	КонецЕсли;
	Элементы.Договор.СвязиПараметровВыбора = Новый ФиксированныйМассив(Связи);
	
КонецПроцедуры

&НаСервере
Процедура ВывестиКорректировки()
	
	ШаблонДоплата = НСтр("ru='%1 от %2 на сумму %3 %4'");
	ШаблонВозврат = НСтр("ru='%1 от %2 на сумму %3 %4 Штраф %5 %6'");
	
	СтрокаКорректировок = "";
	
	Для каждого СтрокаТЧ Из Объект.Операции Цикл
		
		Если СтрокаТЧ.ТипОперации = Перечисления.ТипыОперацийСБилетами.Покупка Тогда
			Продолжить;
		ИначеЕсли СтрокаТЧ.ТипОперации = Перечисления.ТипыОперацийСБилетами.Доплата Тогда
			СтрокаСсылка = СтрШаблон(ШаблонДоплата,
				СтрокаТЧ.ТипОперации, Формат(СтрокаТЧ.Дата, "ДЛФ=Д"), СтрокаТЧ.Сумма, Объект.Валюта);
		ИначеЕсли СтрокаТЧ.ТипОперации = Перечисления.ТипыОперацийСБилетами.Возврат Тогда
			СтрокаСсылка = СтрШаблон(ШаблонВозврат,
				СтрокаТЧ.ТипОперации, Формат(СтрокаТЧ.Дата, "ДЛФ=Д"), СтрокаТЧ.Сумма, Объект.Валюта, СтрокаТЧ.СуммаШтрафа, Объект.Валюта);
		КонецЕсли;
		
		СтрокаКорректировок = СтрокаКорректировок
			+ "<a href = ""Изменить=" + Строка(СтрокаТЧ.ПолучитьИдентификатор()) + ">" + СтрокаСсылка + "</a>"
			+ "<a href = ""Удалить=" + Строка(СтрокаТЧ.ПолучитьИдентификатор()) + "><img src=""Очистить""></a>" + Символы.ПС;
	КонецЦикла;
	
	ИнформацияОКорректировках = СтроковыеФункции.ФорматированнаяСтрока(СтрокаКорректировок);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьЗаголовокФормы()
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Шаблон = НСтр("ru='%1 %2 от %3'");
		Заголовок = СтрШаблон(Шаблон, Объект.ТипБронирования, Объект.НомерБилета, Объект.Дата);
	Иначе
		Шаблон = НСтр("ru='%1 (создание)'");
		Заголовок = СтрШаблон(Шаблон, Объект.ТипБронирования);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьОперации()
	
	СтрокиПокупка = Объект.Операции.НайтиСтроки(Новый Структура("ТипОперации", Перечисления.ТипыОперацийСБилетами.Покупка));
	
	Если Не СтрокиПокупка.Количество() Тогда
		НоваяСтрока = Объект.Операции.Добавить();
		НоваяСтрока.ТипОперации = Перечисления.ТипыОперацийСБилетами.Покупка;
		Элементы.Операции.ТекущаяСтрока = НоваяСтрока.ПолучитьИдентификатор();
	Иначе
		Элементы.Операции.ТекущаяСтрока = СтрокиПокупка[0].ПолучитьИдентификатор();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьТекстАвансовыйОтчет()
	
	ТекстАвансовыйОтчет = АвансовыйОтчетЛокализация.ТекстАвансовыйОтчет(Объект.АвансовыйОтчет);
	
КонецПроцедуры

&НаСервере
Процедура ОпределитьПечатьЕдиногоАвансовогоОтчета()
	
	Если ЗначениеЗаполнено(ДатаНачалаПечатиЕдиногоАвансовогоОтчета) Тогда
		Если ЗначениеЗаполнено(Объект.Дата) Тогда
			ПечатьЕдиногоАвансовогоОтчета = (Объект.Дата >= ДатаНачалаПечатиЕдиногоАвансовогоОтчета);
		Иначе
			ПечатьЕдиногоАвансовогоОтчета = (ТекущаяДатаСеанса() >= ДатаНачалаПечатиЕдиногоАвансовогоОтчета);
		КонецЕсли;
	Иначе
		ПечатьЕдиногоАвансовогоОтчета = ЕдиныйАвансовыйОтчетБезусловно;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ПерезаполнитьСтавкуНДС()
	
	// Заполним ставку с учетом текущей даты документа. Пересчитываем связанные реквизиты табличной части.
	ПараметрыПересчетаНДС = Новый Структура("ЦенаВключаетНДС", Истина);
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ЗаполнитьСтавкуНДС", ОбработкаТабличнойЧастиКлиентСервер.ПараметрыЗаполненияСтавкиНДС(Объект));
	СтруктураДействий.Вставить("ПересчитатьСуммуНДС", ПараметрыПересчетаНДС);
	
	ОбработкаТабличнойЧастиСервер.ОбработатьТЧ(Объект.Операции, СтруктураДействий, Неопределено);
	
КонецПроцедуры

&НаСервере
Функция ЗаполнитьПодчиненныеСвойстваПоСтатистике(ИмяРеквизитаРодителя)
	Возврат ЗаполнениеОбъектовПоСтатистике.ЗаполнитьПодчиненныеРеквизитыОбъекта(Объект, ИмяРеквизитаРодителя);
КонецФункции

#КонецОбласти
