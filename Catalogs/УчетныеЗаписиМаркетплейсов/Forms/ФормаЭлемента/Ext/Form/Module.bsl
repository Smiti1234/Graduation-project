﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Не ЗначениеЗаполнено(Параметры.Ключ) Тогда
		Возврат;// Создание новых элементов из формы списка не предусмотрено.
	КонецЕсли;

	Элементы.ДекорацияАктивнаяУчетнаяЗапись.Видимость = НЕ Объект.ПометкаУдаления;
	Элементы.ДекорацияАрхивнаяУчетнаяЗапись.Видимость = Объект.ПометкаУдаления;
	Элементы.ВалютаУчета.Доступность = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют");
	Элементы.НеОбновлятьДанныеТорговойПлощадки.ТолькоПросмотр = НЕ Пользователи.ЭтоПолноправныйПользователь(, Ложь, Ложь);

	ЭтоOzon         = (Объект.ВидМаркетплейса = ПредопределенноеЗначение("Перечисление.ВидыМаркетплейсов.МаркетплейсOzon"));
	ЭтоЯндексМаркет = (Объект.ВидМаркетплейса = ПредопределенноеЗначение("Перечисление.ВидыМаркетплейсов.МаркетплейсЯндексМаркет"));

	Если ЭтоOzon Тогда
		Элементы.ИдентификаторАккаунта.Видимость = Ложь;
		Элементы.ИдентификаторКабинета.Видимость = Ложь;
		Элементы.ИдентификаторМагазина.Видимость = Ложь;
		Элементы.СхемаРаботы.Видимость           = Ложь;
		
	ИначеЕсли ЭтоЯндексМаркет Тогда
		Элементы.ВалютаУчета.Видимость = Ложь;

		Элементы.ДекорацияАктивнаяУчетнаяЗапись.Заголовок    = НСтр("ru = 'Учетная запись активна. Основные настройки заполняются в форме настроек магазина.'");
		Элементы.ДекорацияАрхивнаяУчетнаяЗапись.Заголовок    = НСтр("ru = 'Магазин отсутствует в кабинете торговой площадки.'");
		Элементы.НеОбновлятьДанныеТорговойПлощадки.Заголовок = НСтр("ru = 'Запрещен обмен данными с магазином'");
		Элементы.ИдентификаторАккаунта.Заголовок             = НСтр("ru = 'Аккаунт подключения'");
		Элементы.ИдентификаторМагазина.Заголовок             = НСтр("ru = 'Идентификатор кампании'");
		Элементы.ИдентификаторКлиента.Заголовок              = НСтр("ru = 'Номер магазина'");
	КонецЕсли;

	Если Объект.ПометкаУдаления Тогда
		ЭтотОбъект.ТолькоПросмотр = Истина;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

	Если ЭтоOzon Тогда
		ПараметрыФормыСопоставленияКатегорий = Новый Структура;
		ПараметрыФормыСопоставленияКатегорий.Вставить("УчетнаяЗаписьМаркетплейса", Объект.Ссылка);
		ПараметрыФормыСопоставленияКатегорий.Вставить("ИсточникКатегории",         Объект.ИсточникКатегории);
		
		ОповеститьОбИзменении(Объект.Ссылка);
		Оповестить("ИсточникКатегорииИзменен", ПараметрыФормыСопоставленияКатегорий);
		Оповестить("Запись_УчетныеЗаписиМаркетплейсов", Объект.Ссылка);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
