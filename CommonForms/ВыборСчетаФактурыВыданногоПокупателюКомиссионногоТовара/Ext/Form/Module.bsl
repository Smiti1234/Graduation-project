﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "Организация", Параметры.Организация);
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "Дата",        Параметры.Дата);
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "Покупатель",  Параметры.Покупатель);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОбработатьВыбор(ВыбраннаяСтрока);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	ТекущаяСтрока = Элементы.Список.ТекущаяСтрока;
	
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОбработатьВыбор(ТекущаяСтрока);
	
КонецПроцедуры

&НаКлиенте
Процедура Изменить(Команда)
	
	ТекущаяСтрока = Элементы.Список.ТекущаяСтрока;
	
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Ссылка = Элементы.Список.ДанныеСтроки(ТекущаяСтрока).Ссылка;
	ПоказатьЗначение(, Ссылка);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработатьВыбор(ИдентификаторСтроки) 
	
	Ссылка = Элементы.Список.ДанныеСтроки(ИдентификаторСтроки).Ссылка;
	ОповеститьОВыборе(Ссылка);
	
КонецПроцедуры

#КонецОбласти