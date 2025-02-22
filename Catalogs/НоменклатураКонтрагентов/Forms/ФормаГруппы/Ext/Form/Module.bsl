﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		// Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		Если Параметры.Свойство("Владелец") Тогда
			Объект.Владелец = Параметры.Владелец;
		КонецЕсли;
		
	КонецЕсли;
	
	УстановитьСвойстваПереопределяемыхЭлементовФормы();

	СопоставлениеНоменклатурыКонтрагентовПереопределяемый.ПриСозданииНаСервере_ФормаГруппыНоменклатурыКонтрагентов(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	//++ НЕ ГОСИС
	НоменклатураПартнеровКлиент.Подключаемый_ВыполнитьПереопределяемуюКоманду_НоменклатурыКонтрагентов(ЭтотОбъект, Команда);
	//-- НЕ ГОСИС
	
КонецПроцедуры
#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьСвойстваПереопределяемыхЭлементовФормы()

	МетаданныеСопоставления = СопоставлениеНоменклатурыКонтрагентовСлужебный.МетаданныеСопоставленияНоменклатуры();
	
	Заголовок = МетаданныеСопоставления.НоменклатураКонтрагентаПредставлениеОбъекта;
	
	Элементы.Владелец.Заголовок = МетаданныеСопоставления.ВладелецНоменклатурыПредставлениеОбъекта;
	
КонецПроцедуры

#КонецОбласти


