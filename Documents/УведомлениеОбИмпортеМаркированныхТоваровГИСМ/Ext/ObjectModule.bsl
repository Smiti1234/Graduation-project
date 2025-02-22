﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ИнтеграцияГИСМПереопределяемый.ОбработкаЗаполненияУведомленияОбИмпортеГИСМ(ЭтотОбъект, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	ИнтеграцияГИСМПереопределяемый.УведомлениеОбИмпортеОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	
	Если ЭтоНовый() И ЗначениеЗаполнено(Основание) Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = "
		|ВЫБРАТЬ
		|	СтатусыИнформированияГИСМ.ТекущееУведомление
		|ИЗ
		|	РегистрСведений.СтатусыИнформированияГИСМ КАК СтатусыИнформированияГИСМ
		|ГДЕ
		|	СтатусыИнформированияГИСМ.Документ = &Основание
		|	И НЕ СтатусыИнформированияГИСМ.Статус В (
		|		ЗНАЧЕНИЕ(Перечисление.СтатусыИнформированияГИСМ.ОтклоненоГИСМ)
		|		)
		|	И НЕ СтатусыИнформированияГИСМ.ТекущееУведомление = ЗНАЧЕНИЕ(Документ.УведомлениеОбИмпортеМаркированныхТоваровГИСМ.ПустаяСсылка)
		|	И  СтатусыИнформированияГИСМ.ТекущееУведомление <> НЕОПРЕДЕЛЕНО ";
		
		Запрос.УстановитьПараметр("Основание", Основание);
		
		Результат = Запрос.Выполнить();
		
		Если Не Результат.Пустой() Тогда
			Выборка = Результат.Выбрать();
			Выборка.Следующий();
			
			ТекстОшибки = НСтр("ru='Для документа %1 уже существует текущая %2.'");
				ТекстОшибки =  СтрШаблон(ТекстОшибки, Основание, Выборка.ТекущееУведомление);
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
					ТекстОшибки,
					ЭтотОбъект,
					,
					,
					Отказ);
			
				КонецЕсли;
				
	КонецЕсли;
	
	ПроверитьВыпущенныеНомераКиз(Отказ);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты,МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Товары.Очистить();
	Основание = Неопределено;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоНовый() Тогда
		ДополнительныеСвойства.Вставить("ЗаписьНового", Истина);
	КонецЕсли;
	
	ИнтеграцияИСПереопределяемый.ПередЗаписьюОбъекта(ЭтотОбъект, Отказ, РежимЗаписи, РежимПроведения);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьВыпущенныеНомераКиз(Отказ)
	
	Запрос = Новый Запрос();
	
	Запрос.Текст = "ВЫБРАТЬ
	|	НомераКиЗ.НомерКиЗ КАК НомерКиЗ,
	|	НомераКиЗ.КлючСвязи КАК КлючСвязи
	|ПОМЕСТИТЬ НомераКиЗ1
	|ИЗ
	|	&НомераКиЗ КАК НомераКиЗ
	|;
	|ВЫБРАТЬ
	|	Товары.НомерСтроки КАК НомерСтроки,
	|	Товары.КлючСвязи КАК КлючСвязи
	|ПОМЕСТИТЬ Товары
	|ИЗ
	|	&Товары КАК Товары
	|;
	|ВЫБРАТЬ
	|	НомераКиЗ.НомерКиЗ КАК НомерКиЗ,
	|	НомераКиЗ.КлючСвязи КАК КлючСвязи,
	|	Товары.НомерСтроки КАК НомерСтроки
	|ПОМЕСТИТЬ НомераКиЗ
	|ИЗ
	|	НомераКиЗ1 КАК НомераКиЗ
	|ЛЕВОЕ СОЕДИНЕНИЕ
	|	Товары
	|ПО
	|	НомераКиЗ.КлючСвязи = Товары.КлючСвязи
	|;
	|ВЫБРАТЬ
	|	НомераКиЗ.НомерСтроки КАК НомерСтроки,
	|	НомераКиЗ.НомерКиЗ КАК НомерКиЗ,
	|	ВыпущенныеКиЗ.НомерКиЗ КАК ВыпущенныйНомерКиЗ
	|ПОМЕСТИТЬ ВыпущенныеКиЗ
	|ИЗ
	|	НомераКиЗ КАК НомераКиЗ
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЗаявкаНаВыпускКиЗГИСМ.ВыпущенныеКиЗ КАК ВыпущенныеКиЗ
	|		ПО (НомераКиЗ.НомерКиЗ = ВыпущенныеКиЗ.НомерКиЗ)
	|			И (ВыпущенныеКиЗ.СостояниеПодтверждения = ЗНАЧЕНИЕ(Перечисление.СостоянияОтправкиПодтвержденияГИСМ.ПринятоГИСМ))
	|			И (ВыпущенныеКиЗ.Ссылка.ПометкаУдаления = ЛОЖЬ)
	|;
	|ВЫБРАТЬ
	|	ВыпущенныеКиЗ.НомерСтроки КАК НомерСтроки,
	|	ВыпущенныеКиЗ.НомерКиЗ КАК НомерКиЗ
	|ИЗ
	|	ВыпущенныеКиЗ КАК ВыпущенныеКиЗ
	|ГДЕ
	|	ВыпущенныеКиЗ.ВыпущенныйНомерКиЗ ЕСТЬ NULL
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки ВОЗР
	|";
	
	Запрос.УстановитьПараметр("НомераКиЗ", ЭтотОбъект.НомераКиЗ.Выгрузить());
	Запрос.УстановитьПараметр("Товары", ЭтотОбъект.Товары.Выгрузить());
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			СтрШаблон(НСтр("ru='Номер КиЗ %1 не выпущен в строке %2 списка ""Товары""'"), Выборка.НомерКиЗ, Выборка.НомерСтроки),
			ЭтотОбъект,
			ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Товары", Выборка.НомерСтроки, "Количество"),
			,
			Отказ);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
