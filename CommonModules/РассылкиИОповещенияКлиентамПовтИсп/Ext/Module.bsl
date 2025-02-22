﻿
////////////////////////////////////////////////////////////////////////////////
// Подсистема "Рассылки и оповещения клиентам".
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  Содержит функции, возвращающие повторные значения в течении сеанса,
//  для работы с функционалом рассылок и оповещений клиентам.
// 
#Область ПрограммныйИнтерфейс

// Определяет, используется ли тип события хотя бы в одном виде оповещений.
//
// Параметры:
//  ТипСобытия  -  ПеречислениеСсылка.ТипыСобытийОповещений - тип события, для которого проверяется использование.
//
// Возвращаемое значение:
//   Булево   - Истина, если используется. Ложь, если не используется.
//
Функция ТипСобытияИспользуется(ТипСобытия) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	ВидыОповещенийКлиентам.Ссылка
	|ИЗ
	|	Справочник.ВидыОповещенийКлиентам КАК ВидыОповещенийКлиентам
	|ГДЕ
	|	ВидыОповещенийКлиентам.ТипСобытия = &ТипСобытия
	|	И НЕ ВидыОповещенийКлиентам.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("ТипСобытия", ТипСобытия);
	
	Результат = Запрос.Выполнить();
	
	Возврат НЕ Результат.Пустой();
	
КонецФункции

// Определяет действующие виды оповещений по типу события.
//
// Параметры:
//  ТипСобытия  -  ПеречислениеСсылка.ТипыСобытийОповещений - тип события, для которого ищутся виды оповещений.
//
// Возвращаемое значение:
//   Массив   - действующие для вида события оповещения.
//
Функция ДействующиеВидыОповещенийПоТипуСобытия(ТипСобытия) Экспорт

	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ВидыОповещенийКлиентам.Ссылка
	|ИЗ
	|	Справочник.ВидыОповещенийКлиентам КАК ВидыОповещенийКлиентам
	|ГДЕ
	|	ВидыОповещенийКлиентам.ТипСобытия = &ТипСобытия
	|	И НЕ ВидыОповещенийКлиентам.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("ТипСобытия", ТипСобытия);
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");

КонецФункции

#КонецОбласти
