﻿#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	УчетНДС.ПривестиПустоеИзмерениеИсправленныйСчетФактура(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли