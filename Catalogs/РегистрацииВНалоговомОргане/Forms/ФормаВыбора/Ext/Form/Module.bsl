﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("Владелец") Тогда
		Параметры.Отбор.Свойство("Владелец", Организация);
		Если ЗначениеЗаполнено(Организация) Тогда
			Организация = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Организация, "ГоловнаяОрганизация");
			Параметры.Отбор.Владелец = Организация;
		КонецЕсли;
	КонецЕсли;
	
	Элементы.Владелец.Видимость = НЕ ЗначениеЗаполнено(Организация);
	Элементы.Организация.Видимость = ЗначениеЗаполнено(Организация);
	
КонецПроцедуры

#КонецОбласти
