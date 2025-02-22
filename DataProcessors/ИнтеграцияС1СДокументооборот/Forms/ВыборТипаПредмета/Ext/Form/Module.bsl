﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Дерево = РеквизитФормыВЗначение("ДеревоВариантов");
	
	// Самостоятельные типы предметов.
	ДобавитьСтроку(Дерево, "ФайлСДиска", НСтр("ru = 'Файл с диска'"));
	
	Если (Параметры.Свойство("ПроцессТип") И Параметры.ПроцессТип = "DMBusinessProcessIssuesSolution")
			Или (Параметры.Свойство("Тип") И Параметры.Тип = "DMBusinessProcessIssuesSolution") Тогда
		ДоступноДобавлениеДругихПредметов = Ложь;
	Иначе
		ДоступноДобавлениеДругихПредметов = Истина;
	КонецЕсли;
	
	Если ДоступноДобавлениеДругихПредметов Тогда
		
		// Предметы в ИС.
		Запрос = Новый Запрос(
			"ВЫБРАТЬ
			|	Правила.ТипОбъектаИС КАК ТипОбъекта,
			|	ВЫРАЗИТЬ(Правила.ПредставлениеОбъектаИС КАК СТРОКА(100)) КАК Вариант,
			|	Правила.Ссылка КАК Правило,
			|	КлючевыеРеквизиты.ИмяРеквизитаОбъектаИС КАК КлючОтбора,
			|	КлючевыеРеквизиты.ЗначениеРеквизитаИС КАК ЗначениеОтбора
			|ИЗ
			|	Справочник.ПравилаИнтеграцииС1СДокументооборотом КАК Правила
			|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПравилаИнтеграцииС1СДокументооборотом.ПравилаЗаполненияРеквизитовИС КАК КлючевыеРеквизиты
			|		ПО Правила.Ссылка = КлючевыеРеквизиты.Ссылка
			|			И (КлючевыеРеквизиты.Ключевой)
			|			И (НЕ КлючевыеРеквизиты.ЭтоДополнительныйРеквизитИС)
			|ГДЕ
			|	НЕ Правила.ПометкаУдаления
			|
			|УПОРЯДОЧИТЬ ПО
			|	Вариант
			|ИТОГИ ПО
			|	Правило");
		ВыборкаПравила = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Если ВыборкаПравила.Количество() <> 0 Тогда
			НаименованиеИС = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'В %1'"),
				ИнтеграцияС1СДокументооборотБазоваяФункциональность.СокращенноеНаименованиеКонфигурации());
			ЗаголовокИС = ДобавитьЗаголовок(Дерево, НаименованиеИС);
			Пока ВыборкаПравила.Следующий() Цикл
				Отбор = Новый СписокЗначений;
				ВыборкаКлючевыеРеквизиты = ВыборкаПравила.Выбрать();
				Пока ВыборкаКлючевыеРеквизиты.Следующий() Цикл
					Если ЗначениеЗаполнено(ВыборкаКлючевыеРеквизиты.КлючОтбора) Тогда
						Отбор.Добавить(ВыборкаКлючевыеРеквизиты.ЗначениеОтбора, ВыборкаКлючевыеРеквизиты.КлючОтбора);
					КонецЕсли;
				КонецЦикла;
				ДобавитьСтроку(ЗаголовокИС, ВыборкаПравила.ТипОбъекта, ВыборкаПравила.Вариант, Отбор);
			КонецЦикла;
		КонецЕсли;
		
		// Предметы в ДО.
		ЗаголовокДО = ДобавитьЗаголовок(Дерево, НСтр("ru = 'В 1С:Документообороте'"));
		ДобавитьСтроку(ЗаголовокДО, "DMFile", НСтр("ru = 'Файл'"));
		ДобавитьСтроку(ЗаголовокДО, "DMInternalDocument", НСтр("ru = 'Внутренний документ'"));
		ДобавитьСтроку(ЗаголовокДО, "DMIncomingDocument", НСтр("ru = 'Входящий документ'"));
		ДобавитьСтроку(ЗаголовокДО, "DMOutgoingDocument", НСтр("ru = 'Исходящий документ'"));
		Если ИнтеграцияС1СДокументооборотБазоваяФункциональностьПовтИсп.ДоступенФункционалВерсииСервиса("1.3.2.3.CORP") Тогда
			ДобавитьСтроку(ЗаголовокДО, "DMProject", НСтр("ru = 'Проект'"));
		КонецЕсли;
		Если ИнтеграцияС1СДокументооборотПовтИсп.ИспользоватьТерминКорреспонденты() Тогда
			ДобавитьСтроку(ЗаголовокДО, "DMCorrespondent", НСтр("ru = 'Корреспондент'"));
		Иначе
			ДобавитьСтроку(ЗаголовокДО, "DMCorrespondent", НСтр("ru = 'Контрагент'"));
		КонецЕсли;
		
	КонецЕсли;
	
	ЗначениеВДанныеФормы(Дерево, ДеревоВариантов);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДеревоВариантовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ВыбратьВариант();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаВыбрать(Команда)
	
	ВыбратьВариант();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	
	Закрыть(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбратьВариант()
	
	ТекущиеДанные = Элементы.ДеревоВариантов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Или ТекущиеДанные.ЭтоЗаголовок Тогда
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("Вариант", ТекущиеДанные.Вариант);
	Результат.Вставить("Отбор", ТекущиеДанные.Отбор);
	Закрыть(Результат);
	
КонецПроцедуры

&НаСервере
Функция ДобавитьСтроку(Дерево, Вариант, Представление, Отбор = Неопределено)
	
	Строка = Дерево.Строки.Добавить();
	Строка.Вариант = Вариант;
	Строка.Представление = Представление;
	Строка.Отбор = Отбор;
	
	Возврат Строка;
	
КонецФункции

&НаСервере
Функция ДобавитьЗаголовок(Дерево, Представление)
	
	Строка = Дерево.Строки.Добавить();
	Строка.Представление = Строка(Представление);
	Строка.ЭтоЗаголовок = Истина;
	
	Возврат Строка;
	
КонецФункции

#КонецОбласти