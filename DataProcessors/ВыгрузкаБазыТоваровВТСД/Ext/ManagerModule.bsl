﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда


// Функция возвращает пустую структуру настроек
// 
// Параметры: 
//  Нет
// 
// Возвращаемое значение: 
//  Структура - структура настроек.
Функция СтруктураНастроек() Экспорт
	
	СтруктураНастроек = Новый Структура;
	СтруктураНастроек.Вставить("ОбязательныеПоля",               Новый Массив);
	СтруктураНастроек.Вставить("КомпоновщикНастроек",            Неопределено);
	СтруктураНастроек.Вставить("ИмяМакетаСхемыКомпоновкиДанных", Неопределено);
	
	Возврат СтруктураНастроек;
	
КонецФункции

Функция УстановитьЗначениеПараметраСКД(КомпоновщикНастроек, ИмяПараметра, ЗначениеПараметра, ИспользоватьНеЗаполненный = Истина)
	
	ПараметрУстановлен = Ложь;
	
	ПараметрКомпоновкиДанных = Новый ПараметрКомпоновкиДанных(ИмяПараметра);
	ЗначениеПараметраКомпоновкиДанных = КомпоновщикНастроек.Настройки.ПараметрыДанных.НайтиЗначениеПараметра(ПараметрКомпоновкиДанных);
	Если ЗначениеПараметраКомпоновкиДанных <> Неопределено Тогда
		
		ЗначениеПараметраКомпоновкиДанных.Значение = ЗначениеПараметра;
		ЗначениеПараметраКомпоновкиДанных.Использование = ?(ИспользоватьНеЗаполненный, Истина, ЗначениеЗаполнено(ЗначениеПараметраКомпоновкиДанных.Значение));
		
		ПараметрУстановлен = Истина;
		
	КонецЕсли;
	
	Возврат ПараметрУстановлен;
	
КонецФункции

// Функция подготавливает структуру данных, необходимую для печати ценников и этикеток.
//
// Возвращаемое значение:
//  Структура - данные, необходимые для печати этикеток и ценников.
//
Функция ПодготовитьСтруктуруДанных(СтруктураНастроек) Экспорт
	
	////////////////////////////////////////////////////////////////////////////////
	// ПОДГОТОВКА СХЕМЫ КОМПОНОВКИ ДАННЫХ И КОМПОНОВЩИКА НАСТРОЕК СКД
	
	// Схема компоновки.
	СхемаКомпоновкиДанных = Обработки.ВыгрузкаБазыТоваровВТСД.ПолучитьМакет(СтруктураНастроек.ИмяМакетаСхемыКомпоновкиДанных);
	
	// Подготовка компоновщика макета компоновки данных.
	Компоновщик = Новый КомпоновщикНастроекКомпоновкиДанных;
	Компоновщик.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаКомпоновкиДанных));
	Компоновщик.ЗагрузитьНастройки(СхемаКомпоновкиДанных.НастройкиПоУмолчанию);
	Компоновщик.Настройки.Отбор.Элементы.Очистить();
	
	// Отбор компоновщика настроек.
	Если СтруктураНастроек.КомпоновщикНастроек <> Неопределено Тогда
		КомпоновкаДанныхКлиентСервер.СкопироватьЭлементы(Компоновщик.Настройки.Отбор, СтруктураНастроек.КомпоновщикНастроек.Настройки.Отбор);
	КонецЕсли;
	
	// Выбранные поля компоновщика настроек.
	Для Каждого ОбязательноеПоле Из СтруктураНастроек.ОбязательныеПоля Цикл
		ПолеСКД = КомпоновкаДанныхСервер.НайтиПолеСКДПоПолномуИмени(Компоновщик.Настройки.Выбор.ДоступныеПоляВыбора.Элементы, ОбязательноеПоле);
		Если ПолеСКД <> Неопределено Тогда
			ВыбранноеПоле = Компоновщик.Настройки.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
			ВыбранноеПоле.Поле = ПолеСКД.Поле;
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого ПараметрДанных Из СтруктураНастроек.ПараметрыДанных Цикл
		УстановитьЗначениеПараметраСКД(Компоновщик, ПараметрДанных.Ключ, ПараметрДанных.Значение);
	КонецЦикла;
	
	ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных.НаборДанных.Запрос;
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
		"&ТекстЗапросаКоэффициентУпаковки1",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
		"ЦеныНоменклатуры.Упаковка",
		"ЦеныНоменклатуры.Номенклатура"));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
		"&ТекстЗапросаКоэффициентУпаковки2",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
		"ИсходныеДанныеПоследнийЗапрос.Упаковка",
		"ИсходныеДанныеПоследнийЗапрос.Номенклатура"));
	СхемаКомпоновкиДанных.НаборыДанных.НаборДанных.Запрос = ТекстЗапроса;
	
	// Компоновка макета компоновки данных.
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновкиДанных = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Компоновщик.Настройки,,,Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	
	////////////////////////////////////////////////////////////////////////////////
	// ВЫПОЛНЕНИЕ ЗАПРОСА
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновкиДанных);
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	
	Таблица = Новый ТаблицаЗначений();
	ПроцессорВывода.УстановитьОбъект(Таблица);
	ДанныеОтчета = ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	Возврат Таблица;
	
КонецФункции

#КонецЕсли