﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбщегоНазначенияУТ.НастроитьПодключаемоеОборудование(ЭтаФорма);
	
	Склад     = Параметры.Склад;
	Помещение = Параметры.Помещение;
	
	ИдентификаторСкладаПомещения = Строка(Склад.УникальныйИдентификатор()) + Строка(Помещение.УникальныйИдентификатор());
	
	Настройки = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("ФормаУказанияЯчейкиНастройкиФормы"+ИдентификаторСкладаПомещения, "");
 	Если Настройки <> Неопределено Тогда
 		Если Настройки.Свойство("ИсторияВыбораЯчеек") Тогда	
			Элементы.Ячейка.СписокВыбора.ЗагрузитьЗначения(Настройки.ИсторияВыбораЯчеек);		
		КонецЕсли;
 		Если Настройки.Свойство("ВыбраннаяЯчейка") Тогда	
			Ячейка = Настройки.ВыбраннаяЯчейка; 	
		КонецЕсли;
    КонецЕсли;

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	МенеджерОборудованияКлиент.НачатьПодключениеОборудованиеПриОткрытииФормы(Неопределено, ЭтаФорма, "СканерШтрихкода");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПриЗакрытииФормы(Неопределено, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование" И ВводДоступен() Тогда
		Если ИмяСобытия = "ScanData" И МенеджерОборудованияУТКлиент.ЕстьНеобработанноеСобытие() Тогда
			ОбработатьШтрихкоды(МенеджерОборудованияУТКлиент.ПреобразоватьДанныеСоСканераВСтруктуру(Параметр));
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ОчиститьСообщения();
	
	Если Не ЗначениеЗаполнено(Ячейка) Тогда
		ТекстСообщения = НСтр("ru = 'Укажите ячейку.'");
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"Ячейка");
	Иначе
		ИдентификаторСкладаПомещения = Строка(Склад.УникальныйИдентификатор()) + Строка(Помещение.УникальныйИдентификатор());
		
		СпискиВыбораКлиентСервер.ОбновитьСписокВыбора(Элементы.Ячейка.СписокВыбора, Ячейка, 7);
		ПараметрыЗакрытия = Новый Структура;
		ПараметрыЗакрытия.Вставить("ИсторияВыбораЯчеек", Элементы.Ячейка.СписокВыбора.ВыгрузитьЗначения());
		ПараметрыЗакрытия.Вставить("ВыбраннаяЯчейка", Ячейка);
		
		ХранилищеОбщихНастроекСохранить(ИдентификаторСкладаПомещения, ПараметрыЗакрытия);
		Закрыть(Ячейка);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ХранилищеОбщихНастроекСохранить(ИдентификаторСкладаПомещения, ПараметрыЗакрытия)
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ФормаУказанияЯчейкиНастройкиФормы" + ИдентификаторСкладаПомещения, "", ПараметрыЗакрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть(Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ШтрихкодыИТорговоеОборудование

&НаСервере
Процедура ОбработатьШтрихкоды(Данные)
	
	Менеджеры = Новый Массив();
	Менеджеры.Добавить(Справочники.СкладскиеЯчейки);
	МассивСсылок = ШтрихкодированиеПечатныхФорм.ПолучитьСсылкуПоШтрихкодуТабличногоДокумента(Данные.Штрихкод, Менеджеры);
	
	Если МассивСсылок.Количество() > 0 Тогда
    	Ячейка = МассивСсылок[0];
	Иначе
		ТекстСообщения = НСтр("ru = 'Складская ячейка со штрихкодом %Штрихкод% не найдена'");
	    ТекстСообщения = СтрЗаменить(ТекстСообщения,"%Штрихкод%",Данные.Штрихкод);
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
