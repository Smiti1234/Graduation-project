﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ЗакрыватьПриВыборе	= Ложь;
	
	Если Параметры.Свойство("ЗначенияЗаполнения") Тогда
		ЗаполнитьЗначенияСвойств(ЭтаФорма, Параметры.ЗначенияЗаполнения);
	КонецЕсли;
	
	
	Элементы.НастроитьПараметрыСпринтер.Видимость	= ЗначениеЗаполнено(Организация);
	
	Если НЕ ПравоДоступа("Изменение", Метаданные.Справочники.Организации) Тогда
		Элементы.ГруппаКоды.Доступность = Ложь;
		Элементы.ВидОбменаСКонтролирующимиОрганами.Доступность = Ложь;
		Элементы.ГруппаНастройки.Доступность = Ложь;
		Элементы.ОК.Доступность = Ложь;
	КонецЕсли;
	
	Если ПолучитьФункциональнуюОпцию("УправлениеТорговлей") Тогда
		Элементы.КодОрганаФСГС.КнопкаВыбора = Неопределено;
	КонецЕсли;
	
	УправлениеФормой(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИЗакрыть", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы,, ТекстПредупреждения);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидОбменаСКонтролирующимиОрганамиПриИзменении(Элемент)
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НастроитьПараметрыСпринтер(Команда)
	
	ПараметрыФормы = Новый Структура("ОрганизацияСсылка", Организация);

КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	Если ПроверитьЗаполнение() Тогда
		СохранитьИЗакрыть();
		Закрыть();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Элементы	= Форма.Элементы;
	
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИЗакрыть() Экспорт
	 
	Модифицированность	= Ложь;
	
	ЗначениеВыбора	= Новый Структура;
	ЗначениеВыбора.Вставить("ВидОбменаСКонтролирующимиОрганами", ВидОбменаСКонтролирующимиОрганами);
	ЗначениеВыбора.Вставить("УчетнаяЗаписьОбмена", УчетнаяЗаписьОбмена);
	ЗначениеВыбора.Вставить("КодНалоговогоОрганаПолучателя", КодНалоговогоОрганаПолучателя);
	ЗначениеВыбора.Вставить("КодОрганаФСГС", КодОрганаФСГС);	
		
	ОповеститьОВыборе(ЗначениеВыбора);
	
КонецПроцедуры

&НаКлиенте
Процедура КодОрганаФСГСНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
		
	
	Возврат; // В УТ не требуется
	
КонецПроцедуры


&НаКлиенте
Процедура ОбработкаВыбораКодОрганаФСГСПолучателя(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	
	Если ВыбранноеЗначение <> Неопределено Тогда
		КодОрганаФСГС    = ВыбранноеЗначение.КодТОГС;
		НаименованиеТОГС = ВыбранноеЗначение.НаименованиеТОГС;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
