﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка
		Или РасчетСебестоимостиПрикладныеАлгоритмы.ДвиженияЗаписываютсяРасчетомПартийИСебестоимости(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ РасчетСебестоимостиПрикладныеАлгоритмы.ФормироватьДвиженияРегистровУчетаСебестоимости(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	РасчетСебестоимостиПрикладныеАлгоритмы.СохранитьДвиженияСформированныеРасчетомПартийИСебестоимости(ЭтотОбъект, Замещение);
	
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	// Текущее состояние набора помещается во временную таблицу,
	// чтобы при записи получить изменение нового набора относительно текущего.
	
	ТекстыЗапросовДляПолученияТаблицыИзменений = 
		ЗакрытиеМесяцаСервер.ТекстыЗапросовДляПолученияТаблицыИзмененийРегистра(Метаданные(), Отбор);
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.Текст = ТекстыЗапросовДляПолученияТаблицыИзменений.ТекстВыборкиНачальныхДанных;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	
	Запрос.Выполнить();
	
	ДополнительныеСвойства.Вставить("ТекстВыборкиТаблицыИзменений", ТекстыЗапросовДляПолученияТаблицыИзменений.ТекстВыборкиТаблицыИзменений);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства)
		Или РасчетСебестоимостиПрикладныеАлгоритмы.ДвиженияЗаписываютсяРасчетомПартийИСебестоимости(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ РасчетСебестоимостиПрикладныеАлгоритмы.ФормироватьДвиженияРегистровУчетаСебестоимости(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = ДополнительныеСвойства.ТекстВыборкиТаблицыИзменений;
	
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	
	Запрос.Выполнить();
	
	Если ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
	
		Запрос.Текст =
		"ВЫБРАТЬ
		|	ТаблицаИзменений.Организация,
		|	ТаблицаИзменений.Подразделение,
		|	ТаблицаИзменений.СтатьяРасходов,
		|	ТаблицаИзменений.АналитикаРасходов,
		|	ТаблицаИзменений.НаправлениеДеятельности,
		|	СУММА(ТаблицаИзменений.Сумма) КАК СуммаИзменение,
		|	СУММА(ТаблицаИзменений.СуммаБезНДС) КАК СуммаБезНДСИзменение,
		|	СУММА(ТаблицаИзменений.СуммаРегл) КАК СуммаРеглИзменение,
		|	СУММА(ТаблицаИзменений.ПостояннаяРазница) КАК ПостояннаяРазницаИзменение,
		|	СУММА(ТаблицаИзменений.ВременнаяРазница) КАК ВременнаяРазницаИзменение
		|ПОМЕСТИТЬ ДвиженияПрочиеРасходыИзменение
		|ИЗ
		|	ТаблицаИзмененийПрочиеРасходы КАК ТаблицаИзменений
		|
		|СГРУППИРОВАТЬ ПО
		|	ТаблицаИзменений.Подразделение,
		|	ТаблицаИзменений.СтатьяРасходов,
		|	ТаблицаИзменений.Организация,
		|	ТаблицаИзменений.АналитикаРасходов,
		|	ТаблицаИзменений.НаправлениеДеятельности
		|
		|ИМЕЮЩИЕ
		|	СУММА(ТаблицаИзменений.Сумма) <> 0
		|	ИЛИ СУММА(ТаблицаИзменений.СуммаБезНДС) <> 0
		|	ИЛИ СУММА(ТаблицаИзменений.СуммаРегл) <> 0
		|	ИЛИ СУММА(ТаблицаИзменений.ПостояннаяРазница) <> 0
		|	ИЛИ СУММА(ТаблицаИзменений.ВременнаяРазница) <> 0";
	
		Выборка = Запрос.Выполнить().Выбрать();
		ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
			"ДвиженияПрочиеРасходыИзменение", Выборка.Следующий() И Выборка.Количество > 0);
		
	КонецЕсли;
	
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
