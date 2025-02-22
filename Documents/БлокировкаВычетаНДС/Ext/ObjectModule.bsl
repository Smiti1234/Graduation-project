﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		Если ДанныеЗаполнения.Свойство("Дата") Тогда
			Дата = ДанныеЗаполнения.Дата;
		КонецЕсли;
		
		Если ДанныеЗаполнения.Свойство("Организация") Тогда
			Организация = ДанныеЗаполнения.Организация;
		КонецЕсли;
		
		Если ДанныеЗаполнения.Свойство("Состояние") Тогда
			Состояние = ДанныеЗаполнения.Состояние;
		КонецЕсли;
		
		Если ДанныеЗаполнения.Свойство("СчетаФактуры") Тогда
			Для Каждого СтрокаСФ Из ДанныеЗаполнения.СчетаФактуры Цикл
				НоваяСтрока = СчетаФактуры.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаСФ);
			КонецЦикла;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НачалоПериода(&ДатаДокумента, МЕСЯЦ) КАК Месяц,
	|	&Организация КАК Организация,
	|	БлокировкаВычетаНДС.СчетФактура КАК СчетФактура
	|ПОМЕСТИТЬ БлокировкаВычетаНДСДоЗаписи
	|ИЗ
	|	&БлокировкаВычетаНДССчетаФактуры КАК БлокировкаВычетаНДС";
		
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц();
	Запрос.УстановитьПараметр("БлокировкаВычетаНДССчетаФактуры", СчетаФактуры);
	Запрос.УстановитьПараметр("ДатаДокумента", Дата);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.Выполнить();
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);
	ДополнительныеСвойства.Вставить("МенеджерТаблицБлокировкаВычетаНДСДоЗаписи", Запрос.МенеджерВременныхТаблиц);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НачалоПериода(БлокировкаВычетаНДС.Ссылка.Дата, МЕСЯЦ) КАК Месяц,
	|	БлокировкаВычетаНДС.Ссылка.Организация КАК Организация,
	|	БлокировкаВычетаНДС.СчетФактура КАК СчетФактура
	|ИЗ
	|	Документ.БлокировкаВычетаНДС.СчетаФактуры КАК БлокировкаВычетаНДС
	|ГДЕ
	|	БлокировкаВычетаНДС.Ссылка = &Ссылка
	|	
	|ОБЪЕДИНИТЬ
	|	
	|ВЫБРАТЬ
	|	БлокировкаВычетаНДСДоЗаписи.Месяц,
	|	БлокировкаВычетаНДСДоЗаписи.Организация,
	|	БлокировкаВычетаНДСДоЗаписи.СчетФактура
	|ИЗ
	|	БлокировкаВычетаНДСДоЗаписи
	|";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерТаблицБлокировкаВычетаНДСДоЗаписи;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	РегистрыСведений.ЗаданияКФормированиюДвиженийПоНДС.СоздатьЗаписиРегистраПоДаннымВыборки(Выборка);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
