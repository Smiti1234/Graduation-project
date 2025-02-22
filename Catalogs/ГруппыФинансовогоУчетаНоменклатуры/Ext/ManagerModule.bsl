﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Функция определяет группу финансового учета по умолчанию.
// Возвращает группу финансового учета, если найден один элемент справочника.
// Возвращает ПустуюСсылку в противном случае.
//
// Возвращаемое значение:
//	СправочникСсылка.ГруппыФинансовогоУчетаНоменклатуры - Группа фин. учета по умолчанию.
//
Функция ПолучитьГруппуФинансовогоУчетаПоУмолчанию() Экспорт
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 2
	|	ДанныеСправочника.Ссылка КАК ГруппаФинансовогоУчета
	|ИЗ
	|	Справочник.ГруппыФинансовогоУчетаНоменклатуры КАК ДанныеСправочника
	|ГДЕ
	|	НЕ ДанныеСправочника.ПометкаУдаления
	|	И НЕ ДанныеСправочника.ЭтоГруппа
	|");
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Количество() = 1 
	   И Выборка.Следующий()
	Тогда
		ГруппаФинансовогоУчета = Выборка.ГруппаФинансовогоУчета;
	Иначе
		ГруппаФинансовогоУчета = Справочники.ГруппыФинансовогоУчетаНоменклатуры.ПустаяСсылка();
	КонецЕсли;
	
	Возврат ГруппаФинансовогоУчета;

КонецФункции

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт

КонецПроцедуры

#Область ДляВызоваИзДругихПодсистем

// Заполняет реквизиты параметров настройки счетов учета номенклатуры (в т.ч. номенклатуры переданной), которые влияют на настройку,
// 	соответствующими им именам реквизитов аналитики учета.
//
// Параметры:
// 	СоответствиеИмен - Соответствие - ключом выступает имя реквизита, используемое в настройке счетов учета,
// 		значением является соответствующее имя реквизита аналитики учета.
// 
Процедура ЗаполнитьСоответствиеРеквизитовНастройкиСчетовУчета(СоответствиеИмен) Экспорт
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

#КонецЕсли

