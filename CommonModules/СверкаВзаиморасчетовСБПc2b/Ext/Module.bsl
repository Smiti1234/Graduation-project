﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "ИнтернетПоддержкаПользователей.СверкаВзаиморасчетовСБПc2b".
// ОбщийМодуль.СверкаВзаиморасчетовСБПc2b.
//
// Серверные процедуры сверки взаиморасчетов с банками по операциям СБП:
//  - запрос отчета по сверки оборотов;
//  - запрос отчета по сверки операций;
//  - настройка выполнения сверки взаиморасчетов;
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ОбщегоНазначения

// Определяет доступность использования функциональности проведения сверки
// взаиморасчетов.
//
// Возвращаемое значение:
//  Булево - если Истина, сверка взаиморасчетов доступна.
//
Функция ДоступнаСверкаВзаиморасчетов() Экспорт
	
	Возврат ИнтеграцияСПлатежнымиСистемами.ИнтеграцияДоступна()
		И ПравоДоступа("ИнтерактивноеДобавление", Метаданные.Документы.СверкаВзаиморасчетовСБПc2b);
	
КонецФункции

// Формирует описание данных оплат на основании переданных параметров.
//
// Параметры:
//  СуммаОперации - Число - данные суммы операции;
//  ТипОперации - Строка - тип: Оплата или Возврат;
//  Выполнена - Булево - результат завершения операции.
//
// Возвращаемое значение:
//  Структура - описание данных операции.
//
Функция НовыйДанныеОперацийОплат(СуммаОперации, ТипОперации, Выполнена) Экспорт
	
	Возврат Новый Структура(
		"СуммаОперации, ТипОперации, Выполнена",
		СуммаОперации,
		ТипОперации,
		Выполнена);
	
КонецФункции

#КонецОбласти

#Область СверкаОборотов

// Получает данные отчета по сверке взаиморасчетов из сервиса участника СБП.
//
// Параметры:
//  НастройкаПодключения - СправочникСсылка.НастройкиИнтеграцииСПлатежнымиСистемами -
//   настройка выполнения операции;
//  НачалоПериода - Дата - дата начало выборки данных отчета;
//  КонецПериода - Дата - дата окончания выборки данных отчета;
//
// Возвращаемое значение:
//  Структура - данные сверки взаиморасчетов:
//    * ПараметрыЗапроса - Структура - данные для запроса статуса отчета:
//      ** ДатаЗапросаСтатуса - Дата - дата последнего запроса статуса отчета;
//      ** Идентификатор - Строка - идентификатор отчета;
//    * ДанныеОтчета - Структура - данные оборотов. Передается если статус операции "Выполнена".
//      ** СуммаВозвратов - Число - общая сумма возвратов за период по торговой точке;
//      ** СуммаОплат - Число - общая сумма оплат за период по торговой точке;
//      ** СуммаКомиссии - Число - рассчитанная сумма возвратов за период по торговой точке;
//    *СтатусОперации - Строка - текущее состояние операции оплаты:
//       - "Выполняется" - подтверждение оплаты от платежной системы не получено;
//       - "Отменена" - оплата по оплата по ранее сформированному QR-коду невозможна;
//       - "Выполнена" - платежная система подтвердила оплату;
//       - "Ошибка" - не удалось выполнить проверку оплаты из-за ошибки.
//    * КодОшибки - Строка - строковый код возникшей ошибки, который
//      может быть обработан вызывающим методом;
//    * СообщениеОбОшибке  - Строка, ФорматированнаяСтрока - сообщение об ошибке для пользователя;
//    * ИнформацияОбОшибке - Строка, ФорматированнаяСтрока - сообщение об ошибке для администратора.
//
Функция ЗапросОтчетПоСверкеОборотов(НастройкаПодключения, НачалоПериода, КонецПериода) Экспорт
	
	ПараметрыИнтеграции = ИнтеграцияСПлатежнымиСистемамиСлужебный.ПараметрыИнтеграции(
		НастройкаПодключения);
	
	ДатаЗапросаСтатуса = ТекущаяДатаСеанса();
	
	РезультатЗапроса = СервисИнтеграцииССБП.ЗапросОтчетаПоСверкеОборотов(
		ПараметрыИнтеграции,
		НачалоПериода,
		КонецПериода,
		ДатаЗапросаСтатуса);
	
	РезультатОперации = ИнтеграцияСПлатежнымиСистемамиСлужебный.НовыйРезультатДлительнойОперации();
	
	ДанныеОтчета = Новый Структура;
	ДанныеОтчета.Вставить("СуммаВозвратов", РезультатЗапроса.СуммаВозвратов);
	ДанныеОтчета.Вставить("СуммаОплат", РезультатЗапроса.СуммаОплат);
	ДанныеОтчета.Вставить("СуммаКомиссии", РезультатЗапроса.СуммаКомиссии);
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("Идентификатор", РезультатЗапроса.Идентификатор);
	ПараметрыЗапроса.Вставить("ДатаЗапросаСтатуса", ДатаЗапросаСтатуса);
	
	ЗаполнитьЗначенияСвойств(
		РезультатОперации,
		РезультатЗапроса,
		"СтатусОперации, КодОшибки, СообщениеОбОшибке, ИнформацияОбОшибке");
	
	РезультатОперации.Вставить("ДанныеОтчета", ДанныеОтчета);
	РезультатОперации.Вставить("ПараметрыЗапроса", ПараметрыЗапроса);
	
	Возврат РезультатОперации;
	
КонецФункции

// Получает статус и загружает данные отчета по сверке взаиморасчетов из сервиса участника СБП.
//
// Параметры:
//  НастройкаПодключения - СправочникСсылка.НастройкиИнтеграцииСПлатежнымиСистемами -
//   настройка выполнения операции;
//  ПараметрыЗапроса - Структура - данные для запроса статуса отчета:
//   * ДатаЗапросаСтатуса - Дата - дата последнего запроса статуса отчета;
//   * Идентификатор - Строка - идентификатор отчета;
//  ДлительностьОперации - Число - количество секунд ожидания формирования отчета.
//
// Возвращаемое значение:
//  Структура - данные сверки взаиморасчетов:
//    * ПараметрыЗапроса - Структура - данные для запроса статуса отчета:
//      ** ДатаЗапросаСтатуса - Дата - дата последнего запроса статуса отчета;
//      ** Идентификатор - Строка - идентификатор отчета;
//    * ДанныеОтчета - Структура - данные оборотов. Передается если статус операции "Выполнена".
//      ** СуммаВозвратов - Число - общая сумма возвратов за период по торговой точке;
//      ** СуммаОплат - Число - общая сумма оплат за период по торговой точке;
//      ** СуммаКомиссии - Число - рассчитанная сумма возвратов за период по торговой точке;
//    *СтатусОперации - Строка - текущее состояние операции оплаты:
//       - "Выполняется" - подтверждение оплаты от платежной системы не получено;
//       - "Отменена" - оплата по оплата по ранее сформированному QR-коду невозможна;
//       - "Выполнена" - платежная система подтвердила оплату;
//       - "Ошибка" - не удалось выполнить проверку оплаты из-за ошибки.
//    * КодОшибки - Строка - строковый код возникшей ошибки, который
//      может быть обработан вызывающим методом;
//    * СообщениеОбОшибке  - Строка, ФорматированнаяСтрока - сообщение об ошибке для пользователя;
//    * ИнформацияОбОшибке - Строка, ФорматированнаяСтрока - сообщение об ошибке для администратора.
//
Функция СостояниеОтчетаПоСверкеОборотов(НастройкаПодключения, ПараметрыЗапроса, ДлительностьОперации = 0) Экспорт
	
	ПараметрыИнтеграции = ИнтеграцияСПлатежнымиСистемамиСлужебный.ПараметрыИнтеграции(
		НастройкаПодключения);
	
	Если ДлительностьОперации <> 0 Тогда
		
		НастройкиВызова = ИнтеграцияСПлатежнымиСистемамиСлужебный.НовыйИтеративныйВызовОперации(
			ДлительностьОперации);
		
		Пока ИнтеграцияСПлатежнымиСистемамиСлужебный.ВозможенВызовОперации(НастройкиВызова) Цикл
			
			РезультатЗапроса = СервисИнтеграцииССБП.СостояниеОтчетаПоСверкеОборотов(
				ПараметрыИнтеграции,
				ПараметрыЗапроса.Идентификатор,
				ПараметрыЗапроса.ДатаЗапросаСтатуса);
			
			Если РезультатЗапроса.СтатусОперации <> ИнтеграцияСПлатежнымиСистемамиКлиентСервер.СтатусОперацииВыполняется() Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
	Иначе
		
		РезультатЗапроса = СервисИнтеграцииССБП.СостояниеОтчетаПоСверкеОборотов(
			ПараметрыИнтеграции,
			ПараметрыЗапроса.Идентификатор,
			ПараметрыЗапроса.ДатаЗапросаСтатуса);
		
	КонецЕсли;
	
	РезультатОперации = ИнтеграцияСПлатежнымиСистемамиСлужебный.НовыйРезультатДлительнойОперации();
	
	ДанныеОтчета = Новый Структура;
	ДанныеОтчета.Вставить("СуммаВозвратов", РезультатЗапроса.СуммаВозвратов);
	ДанныеОтчета.Вставить("СуммаОплат", РезультатЗапроса.СуммаОплат);
	ДанныеОтчета.Вставить("СуммаКомиссии", РезультатЗапроса.СуммаКомиссии);
	
	ПараметрыЗапросаРезультат = Новый Структура;
	ПараметрыЗапросаРезультат.Вставить("Идентификатор", ПараметрыЗапроса.Идентификатор);
	ПараметрыЗапросаРезультат.Вставить("ДатаЗапросаСтатуса", ПараметрыЗапроса.ДатаЗапросаСтатуса);
	
	ЗаполнитьЗначенияСвойств(
		РезультатОперации,
		РезультатЗапроса,
		"СтатусОперации, КодОшибки, СообщениеОбОшибке, ИнформацияОбОшибке");
	
	РезультатОперации.Вставить("ДанныеОтчета", ДанныеОтчета);
	РезультатОперации.Вставить("ПараметрыЗапроса", ПараметрыЗапросаРезультат);
	
	Возврат РезультатОперации;
	
КонецФункции

#КонецОбласти

#Область СверкаОпераций

// Получает данные операций проведенных за период.
//
// Параметры:
//  НастройкаПодключения - СправочникСсылка.НастройкиИнтеграцииСПлатежнымиСистемами -
//   настройка выполнения операции;
//  НачалоПериода - Дата - дата начало выборки данных отчета;
//  КонецПериода - Дата - дата окончания выборки данных отчета;
//
// Возвращаемое значение:
//  Структура - данные сверки взаиморасчетов:
//    * Идентификатор - Строка - идентификатор отчета;
//    * ДанныеОпераций - ТаблицаЗначений - данные операций участника СБП:
//     ** ТипОперации - Строка - тип операции, оплата или возврат;
//     ** ДатаОперации - Дата - дата первичного документа в 1С, который зарегистрировал операцию;
//     ** Сумма - Число - сумма операции в платежной системе;
//     ** СуммаКомиссии - Число - рассчитанная сумма комиссии;
//     ** Идентификатор - Строка - идентификатор операции в платежной системе;
//     ** ИдентификаторОплаты - Строка - идентификатор оплаты в платежной системе.
//    * СтатусОперации - Строка - текущее состояние операции оплаты:
//       - "Выполняется" - подтверждение оплаты от платежной системы не получено;
//       - "Отменена" - оплата по оплата по ранее сформированному QR-коду невозможна;
//       - "Выполнена" - платежная система подтвердила оплату;
//       - "Ошибка" - не удалось выполнить проверку оплаты из-за ошибки.
//    * КодОшибки - Строка - строковый код возникшей ошибки, который
//                 может быть обработан вызывающим методом;
//    * СообщениеОбОшибке  - Строка, ФорматированнаяСтрока - сообщение об ошибке для пользователя;
//    * ИнформацияОбОшибке - Строка, ФорматированнаяСтрока - сообщение об ошибке для администратора.
//
Функция ЗапросОтчетаПоСверкеОпераций(НастройкаПодключения, НачалоПериода, КонецПериода) Экспорт
	
	ПараметрыИнтеграции = ИнтеграцияСПлатежнымиСистемамиСлужебный.ПараметрыИнтеграции(
		НастройкаПодключения);
	
	ДатаЗапросаСтатуса = ТекущаяДатаСеанса();
	
	РезультатЗапроса = СервисИнтеграцииССБП.ЗапросОтчетаПоСверкеОпераций(
		ПараметрыИнтеграции,
		НачалоПериода,
		КонецПериода,
		ДатаЗапросаСтатуса);
	
	РезультатОперации = ИнтеграцияСПлатежнымиСистемамиСлужебный.НовыйРезультатДлительнойОперации();
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("Идентификатор", РезультатЗапроса.Идентификатор);
	ПараметрыЗапроса.Вставить("ДатаЗапросаСтатуса", ДатаЗапросаСтатуса);
	
	ЗаполнитьЗначенияСвойств(
		РезультатОперации,
		РезультатЗапроса,
		"СтатусОперации, КодОшибки, СообщениеОбОшибке, ИнформацияОбОшибке");
	
	РезультатОперации.Вставить("ДанныеОпераций", РезультатЗапроса.ДанныеОпераций);
	РезультатОперации.Вставить("ПараметрыЗапроса", ПараметрыЗапроса);
	
	Возврат РезультатОперации;
	
КонецФункции

// Получает статус и загружает данные отчета по сверке операций из сервиса платежной системы.
//
// Параметры:
//  НастройкаПодключения - СправочникСсылка.НастройкиИнтеграцииСПлатежнымиСистемами -
//   настройка выполнения операции;
//  ПараметрыЗапроса - Структура - данные для запроса статуса отчета:
//   * ДатаЗапросаСтатуса - Дата - дата последнего запроса статуса отчета;
//   * Идентификатор - Строка - идентификатор отчета;
//  ДлительностьОперации - Число - количество секунд ожидания формирования отчета.
//
// Возвращаемое значение:
//  Структура - данные сверки взаиморасчетов:
//    * ПараметрыЗапроса - Структура - данные для запроса статуса отчета:
//      ** ДатаЗапросаСтатуса - Дата - дата последнего запроса статуса отчета;
//      ** Идентификатор - Строка - идентификатор отчета;
//    * ДанныеОтчета - Структура - данные оборотов. Передается если статус операции "Выполнена".
//      ** СуммаВозвратов - Число - общая сумма возвратов за период по торговой точке;
//      ** СуммаОплат - Число - общая сумма оплат за период по торговой точке;
//      ** СуммаКомиссии - Число - рассчитанная сумма возвратов за период по торговой точке;
//    *СтатусОперации - Строка - текущее состояние операции оплаты:
//       - "Выполняется" - подтверждение оплаты от платежной системы не получено;
//       - "Отменена" - оплата по оплата по ранее сформированному QR-коду невозможна;
//       - "Выполнена" - платежная система подтвердила оплату;
//       - "Ошибка" - не удалось выполнить проверку оплаты из-за ошибки.
//    * КодОшибки - Строка - строковый код возникшей ошибки, который
//      может быть обработан вызывающим методом;
//    * СообщениеОбОшибке  - Строка, ФорматированнаяСтрока - сообщение об ошибке для пользователя;
//    * ИнформацияОбОшибке - Строка, ФорматированнаяСтрока - сообщение об ошибке для администратора.
//
Функция СостояниеОтчетаПоСверкеОпераций(НастройкаПодключения, ПараметрыЗапроса, ДлительностьОперации = 0) Экспорт
	
	ПараметрыИнтеграции = ИнтеграцияСПлатежнымиСистемамиСлужебный.ПараметрыИнтеграции(
		НастройкаПодключения);
	
	Если ДлительностьОперации <> 0 Тогда
		
		НастройкиВызова = ИнтеграцияСПлатежнымиСистемамиСлужебный.НовыйИтеративныйВызовОперации(
			ДлительностьОперации);
		
		Пока ИнтеграцияСПлатежнымиСистемамиСлужебный.ВозможенВызовОперации(НастройкиВызова) Цикл
			
			РезультатЗапроса = СервисИнтеграцииССБП.СостояниеОтчетаПоСверкеОпераций(
				ПараметрыИнтеграции,
				ПараметрыЗапроса.Идентификатор,
				ПараметрыЗапроса.ДатаЗапросаСтатуса);
			
			Если РезультатЗапроса.СтатусОперации <> ИнтеграцияСПлатежнымиСистемамиКлиентСервер.СтатусОперацииВыполняется() Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
	Иначе
		
		РезультатЗапроса = СервисИнтеграцииССБП.СостояниеОтчетаПоСверкеОпераций(
			ПараметрыИнтеграции,
			ПараметрыЗапроса.Идентификатор,
			ПараметрыЗапроса.ДатаЗапросаСтатуса);
		
	КонецЕсли;
	
	РезультатОперации = ИнтеграцияСПлатежнымиСистемамиСлужебный.НовыйРезультатДлительнойОперации();
	
	ПараметрыЗапросаРезультат = Новый Структура;
	ПараметрыЗапросаРезультат.Вставить("Идентификатор", ПараметрыЗапроса.Идентификатор);
	ПараметрыЗапросаРезультат.Вставить("ДатаЗапросаСтатуса", ПараметрыЗапроса.ДатаЗапросаСтатуса);
	
	ЗаполнитьЗначенияСвойств(
		РезультатОперации,
		РезультатЗапроса,
		"СтатусОперации, КодОшибки, СообщениеОбОшибке, ИнформацияОбОшибке");
	
	РезультатОперации.Вставить("ДанныеОпераций", РезультатЗапроса.ДанныеОпераций);
	РезультатОперации.Вставить("ПараметрыЗапроса", ПараметрыЗапросаРезультат);
	
	Возврат РезультатОперации;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ИнтеграцияСБиблиотекойСтандартныхПодсистем

// См. описание этой же процедуры в общем модуле
// ОчередьЗаданийПереопределяемый.
//
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
	
	СоответствиеИменПсевдонимам.Вставить(
		Метаданные.РегламентныеЗадания.ПроверкаГотовностиСверкиВзаиморасчетовСБПc2b.ИмяМетода);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбщегоНазначения

// Получает параметры выполнения сверки взаиморасчетов.
//
// Возвращаемое значение:
//  Структура - настройки выполнения сверки взаиморасчетов:
//    * ИспользоватьДокументСверки - Булево - определяет доступность использования документа "СверкаВзаиморасчетовСБПc2b";
//    * ИспользоватьСписаниеРасходов - Булево - определяет порядок списания комиссии при загрузки сверки оборотов.
//
Функция НастройкеСверкиВзаиморасчетов() Экспорт
	
	Настройки = Новый Структура;
	Настройки.Вставить("ИспользоватьДокументСверки", Ложь);
	Настройки.Вставить("ИспользоватьСписаниеРасходов", Ложь);
	
	ИнтеграцияПодсистемБИП.ПриНастройкеСверкиВзаиморасчетов(
		Настройки);
	СверкаВзаиморасчетовСБПc2bПереопределяемый.ПриНастройкеСверкиВзаиморасчетов(
		Настройки);
	
	Возврат Настройки;
	
КонецФункции

#КонецОбласти

#Область РегламентныеЗадания

// Добавляет новое задание проверки статуса сверки взаиморасчетов по оборотам.
//
// Параметры:
//  СверкаВзаиморасчетов - ДокументСсылка.СверкаВзаиморасчетовСБПc2b - документ для проверки статуса;
//  Идентификатор - Строка - идентификатор отчета в сервисе банка.
//
// Пример:
//
Процедура ДобавитьЗаданиеПроверкиСостоянияГотовностиСверки(СверкаВзаиморасчетов, Идентификатор)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Использование", Истина);
	ПараметрыЗадания.Вставить("Метаданные", Метаданные.РегламентныеЗадания.ПроверкаГотовностиСверкиВзаиморасчетовСБПc2b);
	ПараметрыЗадания.Вставить("Ключ", Строка(Идентификатор));
	
	ПараметрыМетода = Новый Массив;
	ПараметрыМетода.Добавить(СверкаВзаиморасчетов);
	ПараметрыЗадания.Вставить("Параметры", ПараметрыМетода);
	
	РегламентныеЗаданияСервер.ДобавитьЗадание(ПараметрыЗадания);
	
КонецПроцедуры

// Обработчик регламентного задания ПроверкаГотовностиСверкиВзаиморасчетов.
//
// Параметры:
//  СверкаВзаиморасчетов - ДокументСсылка.СверкаВзаиморасчетовСБПc2b - документ для проверки статуса.
//
Процедура ПроверкаГотовностиСверкиВзаиморасчетовСБПc2b(СверкаВзаиморасчетов) Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания(
		Метаданные.РегламентныеЗадания.ПроверкаГотовностиСверкиВзаиморасчетовСБПc2b);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СверкаВзаиморасчетовСБПc2b.Состояние КАК Состояние,
		|	СверкаВзаиморасчетовСБПc2b.НастройкаПодключения КАК НастройкаПодключения,
		|	СверкаВзаиморасчетовСБПc2b.НачалоПериода КАК НачалоПериода,
		|	СверкаВзаиморасчетовСБПc2b.КонецПериода КАК КонецПериода,
		|	СверкаВзаиморасчетовСБПc2b.Идентификатор КАК Идентификатор,
		|	СверкаВзаиморасчетовСБПc2b.ДатаЗапросаСтатуса КАК ДатаЗапросаСтатуса
		|ИЗ
		|	Документ.СверкаВзаиморасчетовСБПc2b КАК СверкаВзаиморасчетовСБПc2b
		|ГДЕ
		|	СверкаВзаиморасчетовСБПc2b.Ссылка = &СверкаВзаиморасчетов";
	
	Запрос.УстановитьПараметр("СверкаВзаиморасчетов", СверкаВзаиморасчетов);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	ВыборкаДетальныеЗаписи.Следующий();
	
	Если ВыборкаДетальныеЗаписи.Состояние <> Перечисления.СостояниеСверкиВзаиморасчетовСБПc2b.Готовится Тогда
		ОтменитьЗаданиеПроверкиГотовностиСверкиВзаиморасчетов(
			ВыборкаДетальныеЗаписи.Идентификатор);
		Возврат;
	КонецЕсли;
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("Идентификатор", ВыборкаДетальныеЗаписи.Идентификатор);
	ПараметрыЗапроса.Вставить("ДатаЗапросаСтатуса", ВыборкаДетальныеЗаписи.ДатаЗапросаСтатуса);
	
	РезультатОперации = СостояниеОтчетаПоСверкеОборотов(
		ВыборкаДетальныеЗаписи.НастройкаПодключения,
		ПараметрыЗапроса);
	
	Если ЗначениеЗаполнено(РезультатОперации.КодОшибки)
		Или РезультатОперации.СтатусОперации = ИнтеграцияСПлатежнымиСистемамиКлиентСервер.СтатусОперацииОшибка() Тогда
		// При ошибке подключения к сервису необходимо отменить регламентное задание,
		// при этом для документа устанавливается состояние "ОшибкаПодготовки"
		// для оповещения пользователя.
		// Далее пользователь проверяет состояние справки вручную.
		УстановитьСостояниеСверкиВзаиморасчетов(
			СверкаВзаиморасчетов,
			ТекущаяДатаСеанса(),
			Перечисления.СостояниеСверкиВзаиморасчетовСБПc2b.ОшибкаПодготовки);
		ОтменитьЗаданиеПроверкиГотовностиСверкиВзаиморасчетов(
			ВыборкаДетальныеЗаписи.Идентификатор);
		Возврат;
	КонецЕсли;
	
	Если РезультатОперации.СтатусОперации = ИнтеграцияСПлатежнымиСистемамиКлиентСервер.СтатусОперацииВыполнена() Тогда 
		
		ПараметрыЗаполнения = Новый Структура;
		ПараметрыЗаполнения.Вставить("Идентификатор",        ВыборкаДетальныеЗаписи.Идентификатор);
		ПараметрыЗаполнения.Вставить("СверкаВзаиморасчетов", СверкаВзаиморасчетов);
		ПараметрыЗаполнения.Вставить("НастройкаПодключения", ВыборкаДетальныеЗаписи.НастройкаПодключения);
		ПараметрыЗаполнения.Вставить("СуммаОплат",           РезультатОперации.ДанныеОтчета.СуммаОплат);
		ПараметрыЗаполнения.Вставить("СуммаВозвратов",       РезультатОперации.ДанныеОтчета.СуммаВозвратов);
		ПараметрыЗаполнения.Вставить("СуммаКомиссии",        РезультатОперации.ДанныеОтчета.СуммаКомиссии);
		ПараметрыЗаполнения.Вставить("НачалоПериода",        ВыборкаДетальныеЗаписи.НачалоПериода);
		ПараметрыЗаполнения.Вставить("КонецПериода",         ВыборкаДетальныеЗаписи.КонецПериода);
		
		ЗаполнитьСверкуВзаиморасчетов(ПараметрыЗаполнения);
		
		ОтменитьЗаданиеПроверкиГотовностиСверкиВзаиморасчетов(
			ВыборкаДетальныеЗаписи.Идентификатор);
	Иначе
		УстановитьСостояниеСверкиВзаиморасчетов(
			СверкаВзаиморасчетов,
			ТекущаяДатаСеанса(),
			Перечисления.СостояниеСверкиВзаиморасчетовСБПc2b.Готовится);
	КонецЕсли;
	
КонецПроцедуры

// Отменяет регламентное задание ПроверкаГотовностиСверкиВзаиморасчетов.
//
Процедура ОтменитьЗаданиеПроверкиГотовностиСверкиВзаиморасчетов(Ключ)
	
	УстановитьПривилегированныйРежим(Истина);
	Отбор = Новый Структура("Ключ", Строка(Ключ));
	Задания = РегламентныеЗаданияСервер.НайтиЗадания(Отбор);
	ТипЗадания = ТипЗнч(Задания);
	Если ТипЗадания = Тип("Массив") Тогда
		Если Задания.Количество() > 0 Тогда
			РегламентныеЗаданияСервер.УдалитьЗадание(Задания[0].УникальныйИдентификатор);
		КонецЕсли;
	ИначеЕсли ТипЗадания = Тип("ТаблицаЗначений") Тогда
		Если Задания.Количество() > 0 Тогда
			Если Задания.Колонки.Найти("УникальныйИдентификатор") <> Неопределено Тогда
				РегламентныеЗаданияСервер.УдалитьЗадание(Задания[0].УникальныйИдентификатор);
			ИначеЕсли Задания.Колонки.Найти("Идентификатор") <> Неопределено Тогда
				РегламентныеЗаданияСервер.УдалитьЗадание(Задания[0].Идентификатор);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ФормированиеСверкиПоОборотам

// Интерактивный запрос отчета банка по сверке взаиморасчетов оборотов.
//
// Параметры:
//  ПараметрыПроцедуры - Структура - параметры выполнения длительной операции;
//  АдресРезультата - Строка - адрес результата операции во временном хранилище.
//
Процедура СверкаВзаиморасчетовПоОборотамИнтерактивныйЗапрос(ПараметрыПроцедуры, АдресРезультата) Экспорт
	
	РезультатОперации = СлужебнаяСверкаВзаиморасчетовПоОборотам(
		ПараметрыПроцедуры.НастройкаПодключения,
		ПараметрыПроцедуры.НачалоПериода,
		ПараметрыПроцедуры.КонецПериода);
	
	ПоместитьВоВременноеХранилище(
		РезультатОперации,
		АдресРезультата);
	
КонецПроцедуры

// Запрос отчета по сверке оборотов и запись данных в базу данных.
//
// Параметры:
//  НастройкаИнтеграции - СправочникСсылка.НастройкиИнтеграцииСПлатежнымиСистемами -
//    настройка выполнения операции;
//  НачалоПериода - Дата - начало периода отчета по сверке взаиморасчетов;
//  КонецПериода - Дата - окончание периода отчета по сверке взаиморасчетов;
//
// Возвращаемое значение:
//  Структура - результат запроса, см. ИнтеграцияСПлатежнымиСистемамиСлужебный.НовыйРезультатОперации.
//
Функция СлужебнаяСверкаВзаиморасчетовПоОборотам(НастройкаПодключения, Знач НачалоПериода, Знач КонецПериода)
	
	РезультатОперации = ИнтеграцияСПлатежнымиСистемамиСлужебный.НовыйРезультатОперации();
	
	РезультатЗапроса = ЗапросОтчетПоСверкеОборотов(
		НастройкаПодключения,
		НачалоПериода,
		КонецПериода);
	
	Если ЗначениеЗаполнено(РезультатЗапроса.КодОшибки) Тогда
		ЗаполнитьЗначенияСвойств(
			РезультатОперации,
			РезультатЗапроса,
			"КодОшибки, СообщениеОбОшибке, ИнформацияОбОшибке");
		Возврат РезультатОперации;
	КонецЕсли;
	
	Если РезультатЗапроса.СтатусОперации = ИнтеграцияСПлатежнымиСистемамиКлиентСервер.СтатусОперацииОшибка() Тогда
		РезультатОперации.КодОшибки          = ИнтеграцияСПлатежнымиСистемамиСлужебный.КодОшибкиНеизвестнаяОшибка();
		РезультатОперации.СообщениеОбОшибке  = НСтр("ru = 'При получении данных сверки взаиморасчетов возникла ошибка.'");
		РезультатОперации.ИнформацияОбОшибке = НСтр("ru = 'При получении данных сверки взаиморасчетов возникла ошибка.'");
		Возврат РезультатОперации;
	КонецЕсли;
	
	ПараметрыЗаполнения = Новый Структура;
	ПараметрыЗаполнения.Вставить("Идентификатор",        РезультатЗапроса.ПараметрыЗапроса.Идентификатор);
	ПараметрыЗаполнения.Вставить("НастройкаПодключения", НастройкаПодключения);
	ПараметрыЗаполнения.Вставить("НачалоПериода",        НачалоПериода);
	ПараметрыЗаполнения.Вставить("КонецПериода",         КонецПериода);
	
	Если РезультатЗапроса.СтатусОперации = ИнтеграцияСПлатежнымиСистемамиКлиентСервер.СтатусОперацииВыполняется() Тогда
		
		НачатьТранзакцию();
		
		Попытка
			
			СверкаОбъект = НовыйДокументСверкаВзаиморасчетовПоОборотам(ПараметрыЗаполнения);
			СверкаОбъект.Записать();
			
			ДобавитьЗаданиеПроверкиСостоянияГотовностиСверки(
				СверкаОбъект.Ссылка,
				СверкаОбъект.Идентификатор);
			
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			ВызватьИсключение ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		КонецПопытки;
		
	ИначеЕсли РезультатЗапроса.СтатусОперации = ИнтеграцияСПлатежнымиСистемамиКлиентСервер.СтатусОперацииВыполнена() Тогда
		
		ПараметрыЗаполнения.Вставить("СуммаОплат", РезультатЗапроса.ДанныеОтчета.СуммаОплат);
		ПараметрыЗаполнения.Вставить("СуммаВозвратов", РезультатЗапроса.ДанныеОтчета.СуммаВозвратов);
		ПараметрыЗаполнения.Вставить("СуммаКомиссии", РезультатЗапроса.ДанныеОтчета.СуммаКомиссии);
		ПараметрыЗаполнения.Вставить("СверкаВзаиморасчетов", Неопределено);
		
		ЗаполнитьСверкуВзаиморасчетов(ПараметрыЗаполнения);
		
	КонецЕсли;
	
	Возврат РезультатОперации;
	
КонецФункции

// Формирует новый документ "Сверка взаиморасчетов СБП"
// на основании данных заполнения.
//
// Параметры:
//  ПараметрыЗаполнения - Структура - данные заполнения документа.
//
// Возвращаемое значение:
//  ДокументОбъект.СверкаВзаиморасчетовСБПc2b - сформированный документ.
//
Функция НовыйДокументСверкаВзаиморасчетовПоОборотам(ПараметрыЗаполнения)
	
	СверкаОбъект = Документы.СверкаВзаиморасчетовСБПc2b.СоздатьДокумент();
	СверкаОбъект.НастройкаПодключения = ПараметрыЗаполнения.НастройкаПодключения;
	СверкаОбъект.НачалоПериода = ПараметрыЗаполнения.НачалоПериода;
	СверкаОбъект.КонецПериода = ПараметрыЗаполнения.КонецПериода;
	СверкаОбъект.Дата = ТекущаяДатаСеанса();
	СверкаОбъект.ДатаЗапросаСтатуса = ТекущаяДатаСеанса();
	СверкаОбъект.Идентификатор = ПараметрыЗаполнения.Идентификатор;
	СверкаОбъект.Состояние = Перечисления.СостояниеСверкиВзаиморасчетовСБПc2b.Готовится;
	
	Возврат СверкаОбъект;
	
КонецФункции

// Обновляет статус подготовки отчета по сверке взаиморасчетов.
//
// Параметры:
//  ДатаЗапросаСтатуса - ДокументОбъект.СверкаВзаиморасчетовСБПc2b - объект для обновления;
//  ДатаЗапросаСтатуса - Дата - дата и время последнего запроса статуса;
//  Состояние - ПеречислениеСсылка.СостояниеСверкиВзаиморасчетовПлатежныеСистемы - новое состояние подготовки.
//
Процедура УстановитьСостояниеСверкиВзаиморасчетов(
		СверкаВзаиморасчетов,
		ДатаЗапросаСтатуса,
		Состояние)
	
	СверкаОбъект = СверкаВзаиморасчетов.ПолучитьОбъект();
	СверкаОбъект.Заблокировать();
	СверкаОбъект.Состояние = Состояние;
	СверкаОбъект.ДатаЗапросаСтатуса = ДатаЗапросаСтатуса;
	СверкаОбъект.Записать();
	
КонецПроцедуры

// Производит определение сумм оплат и возврат, проверяет суммы в отчете
// и списывает расходы комиссии.
//
// Параметры:
//  ПараметрыЗаполнения - Структура - данные заполнения.
//
Процедура ЗаполнитьСверкуВзаиморасчетов(ПараметрыЗаполнения)
	
	// Дата операции хранится в UTC, поэтому перед выборкой необходимо выполнить
	// преобразование начала и окончания периода выборки в UTC.
	ДокументыОплат = ИнтеграцияСПлатежнымиСистемамиСлужебный.ДокументыТорговойТочкиЗаПериод(
		ПараметрыЗаполнения.НастройкаПодключения,
		ИнтеграцияСПлатежнымиСистемамиСлужебный.ДатаВUTC(ПараметрыЗаполнения.НачалоПериода),
		ИнтеграцияСПлатежнымиСистемамиСлужебный.ДатаВUTC(ПараметрыЗаполнения.КонецПериода));
	
	Обороты = Новый Структура;
	Обороты.Вставить("СуммаОплат",     0);
	Обороты.Вставить("СуммаВозвратов", 0);
	
	СверкаВзаиморасчетовСБПc2bПереопределяемый.ПриОпределенииОборотов(
		ДокументыОплат,
		ПараметрыЗаполнения.НастройкаПодключения,
		Обороты);
	
	Обороты.СуммаОплат = ?(
		Обороты.СуммаОплат = Null Или Обороты.СуммаОплат = Неопределено,
		0,
		Обороты.СуммаОплат);
	Обороты.СуммаВозвратов = ?(
		Обороты.СуммаВозвратов = Null Или Обороты.СуммаВозвратов = Неопределено,
		0,
		Обороты.СуммаВозвратов);
	
	Если ПараметрыЗаполнения.СверкаВзаиморасчетов = Неопределено Тогда
		СверкаВзаиморасчетовОбъект = НовыйДокументСверкаВзаиморасчетовПоОборотам(
			ПараметрыЗаполнения);
	Иначе
		СверкаВзаиморасчетовОбъект = ПараметрыЗаполнения.СверкаВзаиморасчетов.ПолучитьОбъект();
		СверкаВзаиморасчетовОбъект.Заблокировать();
	КонецЕсли;
	
	СверкаВзаиморасчетовОбъект.Состояние = Перечисления.СостояниеСверкиВзаиморасчетовСБПc2b.Подготовлена;
	ЗаполнитьЗначенияСвойств(
		СверкаВзаиморасчетовОбъект,
		ПараметрыЗаполнения,
		"СуммаОплат, СуммаВозвратов, СуммаКомиссии");
	
	СверкаВзаиморасчетовОбъект.СуммаОплатКорректна
		= (ПараметрыЗаполнения.СуммаОплат = Обороты.СуммаОплат);
	СверкаВзаиморасчетовОбъект.СуммаВозвратовКорректна
		= (ПараметрыЗаполнения.СуммаВозвратов = Обороты.СуммаВозвратов);
	СверкаВзаиморасчетовОбъект.Проверена
		= (СверкаВзаиморасчетовОбъект.СуммаОплатКорректна И СверкаВзаиморасчетовОбъект.СуммаВозвратовКорректна);
	
	Настройки = НастройкеСверкиВзаиморасчетов();
	Если Настройки.ИспользоватьДокументСверки Тогда
		НачатьТранзакцию();
		Попытка
			Если СверкаВзаиморасчетовОбъект.Проверена
				И ПараметрыЗаполнения.СуммаКомиссии <> Неопределено
				И ПараметрыЗаполнения.СуммаКомиссии > 0 Тогда
				СверкаВзаиморасчетовОбъект.СписаниеРасходов = СлужебнаяСписанииРасходовКомиссии(
					ПараметрыЗаполнения.НастройкаПодключения,
					ПараметрыЗаполнения.НачалоПериода,
					ПараметрыЗаполнения.КонецПериода,
					ПараметрыЗаполнения.СуммаКомиссии);
			КонецЕсли;
			СверкаВзаиморасчетовОбъект.Записать();
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			ВызватьИсключение ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

// Списание комиссии банка за проведение операций.
//
// Параметры:
//  НастройкаИнтеграции - СправочникСсылка.НастройкиИнтеграцииСПлатежнымиСистемами -
//                  настройка выполнения операции;
//  НачалоПериода - Дата - начало периода отчета по сверке взаиморасчетов;
//  КонецПериода - Дата - окончание периода отчета по сверке взаиморасчетов;
//  СуммаКомиссии - Число - рассчитанная сумма комиссии.
//
// Возвращаемое значение:
//  ОпределяемыйТип.СписаниеРасходовБИП - документ списания расходов комиссии.
//
Функция СлужебнаяСписанииРасходовКомиссии(
		НастройкаИнтеграции,
		НачалоПериода,
		КонецПериода,
		СуммаКомиссии) Экспорт
	
	ПараметрыСписания = Новый Структура;
	ПараметрыСписания.Вставить("НастройкаПодключения", НастройкаИнтеграции);
	ПараметрыСписания.Вставить("НачалоПериода", НачалоПериода);
	ПараметрыСписания.Вставить("КонецПериода", КонецПериода);
	ПараметрыСписания.Вставить("СуммаКомиссии", СуммаКомиссии);
	
	ДокументСписания = Неопределено;
	СверкаВзаиморасчетовСБПc2bПереопределяемый.ПриСписанииРасходовКомиссии(
		ПараметрыСписания,
		ДокументСписания);
	
	Возврат ДокументСписания;
	
КонецФункции

#КонецОбласти

#Область ФормированиеСверкиПоОперациям

// Получает данные для формирования отчета Сверка операций СБП.
//
// Параметры:
//  СверкаВзаиморасчетов - ДокументСсылка.СверкаВзаиморасчетовСБПc2b - сверка взаиморасчетов
//                         для которой необходимо получить операции.
//
// Возвращаемое значение:
//  Структура - результат запроса операций.
//
Функция СверкаВзаиморасчетовПоОперациям(СверкаВзаиморасчетов) Экспорт
	
	Если Не ЗначениеЗаполнено(СверкаВзаиморасчетов) Тогда
		ВызватьИсключение НСтр("ru = 'Не корректные параметры функции СверкаВзаиморасчетовПоОперациям'");
	КонецЕсли;
	
	РезультатОперации = ИнтеграцияСПлатежнымиСистемамиСлужебный.НовыйРезультатОперации();
	РезультатОперации.Вставить("ДанныеОпераций", Неопределено);
	
	РеквизитыСверкиВзаиморасчетов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(
		СверкаВзаиморасчетов,
		"НачалоПериода, КонецПериода, НастройкаПодключения");
	
	ПараметрыИнтеграции = ИнтеграцияСПлатежнымиСистемамиСлужебный.ПараметрыИнтеграции(
		РеквизитыСверкиВзаиморасчетов.НастройкаПодключения);
	
	ДатаЗапросаСтатуса = ТекущаяДатаСеанса();
	РезультатЗапросаОтчета = ЗапросОтчетаПоСверкеОпераций(
		РеквизитыСверкиВзаиморасчетов.НастройкаПодключения,
		РеквизитыСверкиВзаиморасчетов.НачалоПериода,
		РеквизитыСверкиВзаиморасчетов.КонецПериода);
	
	Если ЗначениеЗаполнено(РезультатЗапросаОтчета.КодОшибки) Тогда
		ЗаполнитьЗначенияСвойств(
			РезультатОперации,
			РезультатЗапросаОтчета,
			"КодОшибки, СообщениеОбОшибке, ИнформацияОбОшибке");
		Возврат РезультатОперации;
	КонецЕсли;
	
	Если РезультатЗапросаОтчета.СтатусОперации <> ИнтеграцияСПлатежнымиСистемамиКлиентСервер.СтатусОперацииВыполнена() Тогда
		РезультатЗапросаОтчета = СостояниеОтчетаПоСверкеОпераций(
			РеквизитыСверкиВзаиморасчетов.НастройкаПодключения,
			РезультатЗапросаОтчета.ПараметрыЗапроса,
			180);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(РезультатЗапросаОтчета.КодОшибки) Тогда
		ЗаполнитьЗначенияСвойств(
			РезультатОперации,
			РезультатЗапросаОтчета,
			"КодОшибки, СообщениеОбОшибке, ИнформацияОбОшибке");
		Возврат РезультатОперации;
	КонецЕсли;
	
	// Дата операции хранится в UTC, поэтому перед выборкой необходимо выполнить
	// преобразование начала и окончания периода выборки в UTC.
	ОперацииИнформационнаяБаза = ИнтеграцияСПлатежнымиСистемамиСлужебный.ОперацииТорговойТочкиЗаПериод(
		РеквизитыСверкиВзаиморасчетов.НастройкаПодключения,
		ИнтеграцияСПлатежнымиСистемамиСлужебный.ДатаВUTC(РеквизитыСверкиВзаиморасчетов.НачалоПериода),
		ИнтеграцияСПлатежнымиСистемамиСлужебный.ДатаВUTC(РеквизитыСверкиВзаиморасчетов.КонецПериода));
	
	СуммыОперации = Новый Соответствие;
	СверкаВзаиморасчетовСБПc2bПереопределяемый.ПриОпределенииДанныхОпераций(
		ОперацииИнформационнаяБаза.ВыгрузитьКолонку("ДокументОперации"),
		РеквизитыСверкиВзаиморасчетов.НастройкаПодключения,
		СуммыОперации);
	
	ОперацииИнформационнаяБаза.Колонки.Добавить("Сумма",       ОбщегоНазначения.ОписаниеТипаЧисло(15,2));
	ОперацииИнформационнаяБаза.Колонки.Добавить("Выполнена",   Новый ОписаниеТипов("Булево"));
	ОперацииИнформационнаяБаза.Колонки.Добавить("ТипОперации", ОбщегоНазначения.ОписаниеТипаСтрока(15));
	
	Для Каждого Операция Из ОперацииИнформационнаяБаза Цикл
		Значение = СуммыОперации.Получить(Операция.ДокументОперации);
		Если Значение <> Неопределено Тогда 
			Операция.Сумма = Значение.СуммаОперации;
			Операция.Выполнена = Значение.Выполнена;
			Операция.ТипОперации = Значение.ТипОперации;
		КонецЕсли;
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДанныеОпераций.Идентификатор КАК ИдентификаторОплаты,
		|	ДанныеОпераций.ТипОперации КАК ТипОперации,
		|	ДанныеОпераций.ДатаОперации КАК ДатаОперации,
		|	ДанныеОпераций.Сумма КАК СуммаБанк,
		|	ДанныеОпераций.СуммаКомиссии КАК СуммаКомиссии,
		|	ДанныеОпераций.ИдентификаторОплаты КАК ИдентификаторПлатежнойСистемы
		|ПОМЕСТИТЬ ВТ_ОперацииВСервисе
		|ИЗ
		|	&ДанныеОпераций КАК ДанныеОпераций
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ОперацииИнформационнаяБаза.ДокументОперации КАК ДокументОперации,
		|	ОперацииИнформационнаяБаза.Выполнена КАК Выполнена,
		|	ОперацииИнформационнаяБаза.ТипОперации КАК ТипОперации,
		|	ОперацииИнформационнаяБаза.ИдентификаторПлатежнойСистемы КАК ИдентификаторПлатежнойСистемы,
		|	ОперацииИнформационнаяБаза.Сумма КАК Сумма1С
		|ПОМЕСТИТЬ ВТ_ОперацииВИнформационнойБазе
		|ИЗ
		|	&ОперацииИнформационнаяБаза КАК ОперацииИнформационнаяБаза
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ОперацииВИнформационнойБазе.ДокументОперации КАК ДокументОперации,
		|	ВЫБОР
		|		КОГДА ВТ_ОперацииВИнформационнойБазе.ИдентификаторПлатежнойСистемы ЕСТЬ NULL
		|			ТОГДА ВТ_ОперацииВСервисе.ИдентификаторПлатежнойСистемы
		|		ИНАЧЕ ВТ_ОперацииВИнформационнойБазе.ИдентификаторПлатежнойСистемы
		|	КОНЕЦ КАК ИдентификаторПлатежнойСистемы,
		|	ЕСТЬNULL(ВТ_ОперацииВИнформационнойБазе.Сумма1С, 0) КАК Сумма1С,
		|	ВЫБОР
		|		КОГДА ВТ_ОперацииВИнформационнойБазе.ТипОперации ЕСТЬ NULL
		|			ТОГДА ВТ_ОперацииВСервисе.ТипОперации
		|		ИНАЧЕ ВТ_ОперацииВИнформационнойБазе.ТипОперации
		|	КОНЕЦ КАК ТипОперации,
		|	ВТ_ОперацииВСервисе.ДатаОперации КАК ДатаОперации,
		|	ЕСТЬNULL(ВТ_ОперацииВСервисе.СуммаБанк, 0) КАК СуммаБанк,
		|	ЕСТЬNULL(ВТ_ОперацииВСервисе.СуммаКомиссии, 0) КАК СуммаКомиссии,
		|	ВТ_ОперацииВСервисе.ИдентификаторОплаты КАК ИдентификаторОплаты,
		|	ЕСТЬNULL(ВТ_ОперацииВСервисе.СуммаБанк, 0) <> ЕСТЬNULL(ВТ_ОперацииВИнформационнойБазе.Сумма1С, 0) КАК ЕстьРасхождения,
		|	ВТ_ОперацииВИнформационнойБазе.ИдентификаторПлатежнойСистемы КАК ИдентификаторПлатежнойСистемы1,
		|	ВТ_ОперацииВСервисе.ИдентификаторПлатежнойСистемы ЕСТЬ NULL
		|		ИЛИ ВТ_ОперацииВИнформационнойБазе.ДокументОперации ЕСТЬ NULL
		|		ИЛИ ВТ_ОперацииВИнформационнойБазе.Выполнена <> ИСТИНА КАК ОперацияНеОбнаружена
		|ИЗ
		|	ВТ_ОперацииВИнформационнойБазе КАК ВТ_ОперацииВИнформационнойБазе
		|		ПОЛНОЕ СОЕДИНЕНИЕ ВТ_ОперацииВСервисе КАК ВТ_ОперацииВСервисе
		|		ПО ВТ_ОперацииВИнформационнойБазе.ИдентификаторПлатежнойСистемы = ВТ_ОперацииВСервисе.ИдентификаторПлатежнойСистемы
		|
		|УПОРЯДОЧИТЬ ПО
		|	ДатаОперации";
	
	Запрос.УстановитьПараметр("ОперацииИнформационнаяБаза", ОперацииИнформационнаяБаза);
	Запрос.УстановитьПараметр("ДанныеОпераций", РезультатЗапросаОтчета.ДанныеОпераций);
	
	РезультатЗапроса = Запрос.Выполнить();
	РезультатОперации.ДанныеОпераций = РезультатЗапроса.Выгрузить();
	
	Возврат РезультатОперации;
	
КонецФункции

#КонецОбласти

#Область ПрочиеСлужебныеПроцедурыФункции

// Добавляет запись в журнал регистрации.
//
// Параметры:
//  СообщениеОбОшибке - Строка - комментарий к записи журнала регистрации;
//  Ошибка - Булево - если истина будет установлен уровень журнала регистрации "Ошибка".
//
Процедура ЗаписатьИнформациюВЖурналРегистрации(
		СообщениеОбОшибке,
		Ошибка = Истина) Экспорт
	
	УровеньЖР = ?(Ошибка, УровеньЖурналаРегистрации.Ошибка, УровеньЖурналаРегистрации.Информация);
	
	ЗаписьЖурналаРегистрации(
		ИмяСобытияЖурналаРегистрации(),
		УровеньЖР,
		,
		,
		Лев(СообщениеОбОшибке, 5120));
	
КонецПроцедуры

// Возвращает имя события для журнала регистрации, которое используется
// для записи событий загрузки данных из внешних систем.
//
// Возвращаемое значение:
//  Строка - имя события.
//
Функция ИмяСобытияЖурналаРегистрации()
	
	Возврат НСтр("ru = 'Сверка взаиморасчетов СБП (c2b)'",
		ОбщегоНазначения.КодОсновногоЯзыка());
	
КонецФункции

#КонецОбласти

#КонецОбласти
