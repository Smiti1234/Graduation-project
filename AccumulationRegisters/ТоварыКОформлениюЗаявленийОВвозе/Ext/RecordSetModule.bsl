﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)

	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);

	БлокироватьДляИзменения = Истина;

	// Текущее состояние набора помещается во временную таблицу "ТоварыКОформлениюЗаявленийОВвозеПередЗаписью",
	// чтобы при записи получить изменение нового набора относительно текущего.
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ЭтоНовый",    ДополнительныеСвойства.СвойстваДокумента.ЭтоНовый);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Таблица.ДокументПоступления КАК ДокументПоступления,
	|	Таблица.Номенклатура КАК Номенклатура,
	|	Таблица.Характеристика КАК Характеристика,
	|	Таблица.Серия КАК Серия,
	|	Таблица.Склад КАК Склад,
	|	ВЫБОР
	|		КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|			ТОГДА Таблица.КОформлению
	|		ИНАЧЕ -Таблица.КОформлению
	|	КОНЕЦ КАК КОформлениюПередЗаписью,
	|	ВЫБОР
	|		КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|			ТОГДА Таблица.ФактурнаяСтоимость
	|		ИНАЧЕ -Таблица.ФактурнаяСтоимость
	|	КОНЕЦ КАК ФактурнаяСтоимостьПередЗаписью
	|ПОМЕСТИТЬ ТоварыКОформлениюЗаявленийОВвозеПередЗаписью
	|ИЗ
	|	РегистрНакопления.ТоварыКОформлениюЗаявленийОВвозе КАК Таблица
	|ГДЕ
	|	Таблица.Регистратор = &Регистратор
	|	И НЕ &ЭтоНовый";
	Запрос.Выполнить();

КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)

	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	// Рассчитывается изменение нового набора относительно текущего с учетом накопленных изменений
	// и помещается во временную таблицу.
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаИзменений.ДокументПоступления КАК ДокументПоступления,
	|	ТаблицаИзменений.Номенклатура КАК Номенклатура,
	|	ТаблицаИзменений.Характеристика КАК Характеристика,
	|	ТаблицаИзменений.Серия КАК Серия,
	|	ТаблицаИзменений.Склад КАК Склад,
	|	СУММА(ТаблицаИзменений.КОформлениюИзменение) КАК КОформлениюИзменение,
	|	СУММА(ТаблицаИзменений.ФактурнаяСтоимостьИзменение) КАК ФактурнаяСтоимостьИзменение
	|ПОМЕСТИТЬ ТоварыКОформлениюЗаявленийОВвозеИзменение
	|ИЗ
	|	(ВЫБРАТЬ
	|		Таблица.ДокументПоступления КАК ДокументПоступления,
	|		Таблица.Номенклатура КАК Номенклатура,
	|		Таблица.Характеристика КАК Характеристика,
	|		Таблица.Серия КАК Серия,
	|		Таблица.Склад КАК Склад,
	|		Таблица.КОформлениюПередЗаписью КАК КОформлениюИзменение,
	|		Таблица.ФактурнаяСтоимостьПередЗаписью КАК ФактурнаяСтоимостьИзменение
	|	ИЗ
	|		ТоварыКОформлениюЗаявленийОВвозеПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Таблица.ДокументПоступления,
	|		Таблица.Номенклатура,
	|		Таблица.Характеристика,
	|		Таблица.Серия,
	|		Таблица.Склад,
	|		ВЫБОР
	|			КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|				ТОГДА -Таблица.КОформлению
	|			ИНАЧЕ Таблица.КОформлению
	|		КОНЕЦ,
	|		ВЫБОР
	|			КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|				ТОГДА -Таблица.ФактурнаяСтоимость
	|			ИНАЧЕ Таблица.ФактурнаяСтоимость
	|		КОНЕЦ
	|	ИЗ
	|		РегистрНакопления.ТоварыКОформлениюЗаявленийОВвозе КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор) КАК ТаблицаИзменений
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.ДокументПоступления,
	|	ТаблицаИзменений.Номенклатура,
	|	ТаблицаИзменений.Характеристика,
	|	ТаблицаИзменений.Серия,
	|	ТаблицаИзменений.Склад
	|
	|ИМЕЮЩИЕ
	// По КОформлению к не правильному состоянию регистра приведет увеличение прихода и уменьшение расхода.
	|	(СУММА(ТаблицаИзменений.КОформлениюИзменение) <> 0 
	// По ФактурнаяСтоимость к не правильному состоянию регистра приведет любое изменение.
	|		ИЛИ СУММА(ТаблицаИзменений.ФактурнаяСтоимостьИзменение) <> 0) 
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ ТоварыКОформлениюЗаявленийОВвозеПередЗаписью";
	
	Выборка = Запрос.ВыполнитьПакет()[0].Выбрать();
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ТоварыКОформлениюЗаявленийОВвозеИзменение", Выборка.Следующий() И Выборка.Количество > 0);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
