﻿#Область ПрограммныйИнтерфейс

// В процедуре требуется реализовать открытие формы нового документа инвентаризации (пересчета товаров).
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - форма запущенной обработки корректировки остатков,
//   ТорговыйОбъект - ОпределяемыйТип.ТорговыйОбъектЕГАИС - склад пересчета.
//
Процедура СоздатьПриказНаПроведениеИнвентаризации(Форма, ТорговыйОбъект) Экспорт
	
	//++ НЕ ГОСИС
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("Склад", ТорговыйОбъект);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	
	ОткрытьФорму("Документ.ПересчетТоваров.ФормаОбъекта",
		ПараметрыФормы,
		Форма,
		Форма.УникальныйИдентификатор);
	//-- НЕ ГОСИС
	
	Возврат;
	
КонецПроцедуры

// В процедуре требуется реализовать открытие формы списка документов инвентаризации (пересчета товаров).
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - форма запущенной обработки корректировки остатков,
//   ТорговыйОбъект - ОпределяемыйТип.ТорговыйОбъектЕГАИС - склад пересчета.
//
Процедура ОткрытьСписокИнвентаризаций(Форма, ТорговыйОбъект) Экспорт
	
	//++ НЕ ГОСИС
	СтруктураБыстрогоОтбора = Новый Структура;
	СтруктураБыстрогоОтбора.Вставить("Склад", ТорговыйОбъект);
	
	ПараметрыФормы = Новый Структура("СтруктураБыстрогоОтбора", СтруктураБыстрогоОтбора);
	
	ОткрытьФорму("Документ.ПересчетТоваров.ФормаСписка",
		ПараметрыФормы,
		Форма,
		Форма.УникальныйИдентификатор);
	//-- НЕ ГОСИС
	
	Возврат;
	
КонецПроцедуры

// Формирует отчет по излишкам/недостачам для переданного торгового объекта.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - форма запущенной обработки корректировки остатков,
//   ТорговыйОбъект - ОпределяемыйТип.ТорговыйОбъектЕГАИС - склад пересчета.
//
Процедура СформироватьОтчетПоИзлишкамНедостачам(Форма, ТорговыйОбъект) Экспорт
	
	//++ НЕ ГОСИС
	Отбор = Новый Структура("Склад", ТорговыйОбъект);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отбор",                       Отбор);
	ПараметрыФормы.Вставить("КлючНазначенияИспользования", "ОформлениеИзлишковНедостачКонтекст");
	ПараметрыФормы.Вставить("КлючВарианта",                "ОформлениеИзлишковНедостачКонтекст");
	ПараметрыФормы.Вставить("СформироватьПриОткрытии",     Истина);
	
	ОткрытьФорму("Отчет.ОформлениеИзлишковНедостачТоваров.Форма",
		ПараметрыФормы,
		Форма,
		Форма.УникальныйИдентификатор);
	//-- НЕ ГОСИС
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти