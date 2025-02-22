﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Номер           = Параметры.НомерДокументаОплаты;
	Дата            = Параметры.ДатаДокументаОплаты;
	Организация     = Параметры.Организация;
	Контрагент      = Параметры.Контрагент;
	ДокументПодтвержденияНДС = Параметры.СчетФактура;
	ВыбраннаяСтрока = Параметры.ВыбраннаяСтрока;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НомерПриИзменении(Элемент)
	
	ДокументПодтвержденияНДС = Неопределено;
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	ДокументПодтвержденияНДС = Неопределено;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	РеквизитыСчетФактуры = Новый Структура;
	РеквизитыСчетФактуры.Вставить("НомерДокументаОплаты", Номер);
	РеквизитыСчетФактуры.Вставить("ДатаДокументаОплаты", Дата);
	РеквизитыСчетФактуры.Вставить("СчетФактура", ДокументПодтвержденияНДС);
	РеквизитыСчетФактуры.Вставить("ВыбраннаяСтрока", ВыбраннаяСтрока);
	РеквизитыСчетФактуры.Вставить("БланкСтрогойОтчетности", Истина);
	
	Закрыть(РеквизитыСчетФактуры);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Модифицированность = Ложь;
	Закрыть();
	
КонецПроцедуры

#КонецОбласти