﻿////////////////////////////////////////////////////////////////////////////////
// Общие процедуры и функции планирования, результат которых кэшируется
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Рассчитывает дату начала периода по указанной дате и периодичности
//
// Параметры:
//  Дата			 - Дата							 - дата, к которой будет рассчитана дата начала периода
//  Периодичность	 - ПеречислениеСсылка.Периодичность	 - значение перечисления "Периодичность".
// 
// Возвращаемое значение:
//  Дата - Дата начала периода
//
Функция РассчитатьДатуНачалаПериода(Знач Дата, Знач Периодичность) Экспорт
	
	Возврат ПланированиеКлиентСервер.РассчитатьДатуНачалаПериода(Дата, Периодичность);
	
КонецФункции

// Рассчитывает дату окончания периода по указанной дате и периодичности
//
// Параметры:
//  Дата			 - Дата							 - дата, к которой будет рассчитана дата окончания периода
//  Периодичность	 - ПеречислениеСсылка.Периодичность	 - значение перечисления "Периодичность".
// 
// Возвращаемое значение:
//  Дата - Дата окончания периода.
//
Функция РассчитатьДатуОкончанияПериода(Знач Дата, Знач Периодичность) Экспорт
	
	Возврат ПланированиеКлиентСервер.РассчитатьДатуОкончанияПериода(Дата, Периодичность);
	
КонецФункции

#КонецОбласти
