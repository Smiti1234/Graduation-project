﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ИспользованиеСоглашений = Параметры.ИспользованиеСоглашений;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("ЗаписатьИЗакрыть", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	
	ЗаписатьИЗакрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	
	Модифицированность = Ложь;
	Закрыть(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Результат = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт
	
	Модифицированность = Ложь;
	Закрыть(ИспользованиеСоглашений)
	
КонецПроцедуры

#КонецОбласти

