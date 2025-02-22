﻿
#Область ПроцедурыОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Если Объект.Ссылка.Пустая() Тогда
		ЗаполнитьФормуПоОбъекту();
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	ДанныеОбъекта = РеквизитФормыВЗначение("Объект");
	ДанныеОбъекта.ПроверитьУникальность(Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьФормуПоОбъекту()
	
	ЗаполнитьЗначенияСвойств(Объект, Параметры.ЗначенияЗаполнения);
	
КонецПроцедуры

#КонецОбласти


