﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Отбор")
	 И Параметры.Отбор.Свойство("Номенклатура")
	 И ЗначениеЗаполнено(Параметры.Отбор.Номенклатура) Тогда
		
		Список.КомпоновщикНастроек.Настройки.Отбор.Элементы.Очистить();
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(
			Список.КомпоновщикНастроек.Настройки.Отбор,
			"Номенклатура",
			ВидСравненияКомпоновкиДанных.Равно,
			Параметры.Отбор.Номенклатура,
			Неопределено,
			Истина,
			РежимОтображенияЭлементаНастройкиКомпоновкиДанных.БыстрыйДоступ);
		Параметры.Отбор.Удалить("Номенклатура");	
	КонецЕсли;

КонецПроцедуры
