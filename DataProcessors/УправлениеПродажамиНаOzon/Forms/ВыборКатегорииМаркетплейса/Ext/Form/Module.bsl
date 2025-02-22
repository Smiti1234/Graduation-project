﻿
#Область ОписаниеПеременных

&НаКлиенте
Перем ЭтоЗакрытиеФормы;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Параметры.Свойство("УчетнаяЗаписьМаркетплейса", УчетнаяЗаписьМаркетплейса);
	Параметры.Свойство("ИдентификаторКатегорииМаркетплейса", ИдентификаторКатегорииМаркетплейса);
	Параметры.Свойство("Категория1С", Категория1С);

	УстановитьУсловноеОформление();

	ШаблонЗаголовкаФормы = НСтр("ru = 'Выбор категории маркетплейса для категории 1С <%1>'");
	Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонЗаголовкаФормы, Категория1С);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ЗаполнитьДеревоКатегорий();

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)

	ЭтоЗакрытиеФормы = Истина;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоКатегорийМаркетплейса

&НаКлиенте
Процедура ДеревоКатегорийВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	ЗавершитьВыборКатегории(ВыбраннаяСтрока);

КонецПроцедуры 

&НаКлиенте
Процедура ДеревоКатегорийПриАктивизацииСтроки(Элемент)

	ДанныеПоКатегорииМаркетплейса = Новый ТабличныйДокумент;

	ТекущиеДанные = Элементы.ДеревоКатегорийМаркетплейса.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено
		Или ТекущиеДанные.ИдентификаторКатегорииМаркетплейса = ИдентификаторКатегорииМаркетплейса Тогда
		Возврат;
	КонецЕсли;

	ИдентификаторКатегорииМаркетплейса = ТекущиеДанные.ИдентификаторКатегорииМаркетплейса;

	ДанныеТекущейСтрокиДереваКатегорий = Новый Структура("ИдентификаторКатегорииМаркетплейса,
			|НаименованиеКатегорииМаркетплейса,
			|НаименованиеРодителяКатегорииМаркетплейса");
	ЗаполнитьЗначенияСвойств(ДанныеТекущейСтрокиДереваКатегорий, ТекущиеДанные);

	ИдентификаторКэшаКатегории = "Категория_" + ДанныеТекущейСтрокиДереваКатегорий.ИдентификаторКатегорииМаркетплейса;

	Если ТекущиеДанные.ЭтоГруппа Тогда  
		Элементы.СтраницыЭлементовДлительногоОжиданияАтрибутов.ТекущаяСтраница = Элементы.СтраницаПустаяАтрибутов;
		Возврат;
	КонецЕсли;

	Элементы.СтраницыЭлементовДлительногоОжиданияАтрибутов.ТекущаяСтраница = Элементы.СтраницаДлительногоОжиданияАтрибутов;

	Шаблон = НСтр("ru = 'Данные по категории маркетплейса <%1>:'");

	ЗаголовокТабличногоДокументаАтрибутов =
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Шаблон, ТекущиеДанные.НаименованиеКатегорииМаркетплейса);

	ПодключитьОбработчикОжидания("Подключаемый_ЗаполнитьИнформациюПоАтрибутамКатегории", 0.1, Истина);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)

	ЗавершитьВыборКатегории();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДеревоКатегорий()

	Элементы.СтраницыЭлементовДлительногоОжидания.ТекущаяСтраница = Элементы.СтраницаДлительногоОжидания;
	Элементы.СтраницыЭлементовДлительногоОжиданияАтрибутов.ТекущаяСтраница = Элементы.СтраницаПустаяАтрибутов;

	ИдентификаторКэшаКатегорий = "ДеревоКатегорий";

	ДанныеКэша = ИнтеграцияСМаркетплейсомOzonКлиент.ПолучитьДанныеИзКэшаКатегорий(ИдентификаторКэшаКатегорий);
	ДлительнаяОперация = ПолучитьКатегорииМаркетплейсаНаСервере(ДанныеКэша);

	ОповещениеОЗавершении = Новый ОписаниеОповещения("ЗаполнитьДеревоКатегорийМаркетплейсаЗавершение", ЭтотОбъект);
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);

КонецПроцедуры

&НаСервере
Функция ПолучитьКатегорииМаркетплейсаНаСервере(ДанныеКэша)

	ИмяМетода = "ИнтеграцияСМаркетплейсомOzonСервер.ЗаполнитьДеревоКатегорий";
	НаименованиеФоновогоЗадания = НСтр("ru = 'Ozon. Получение категорий маркетплейса'");

	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.ЗапуститьВФоне = Истина;
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НаименованиеФоновогоЗадания;

	ДеревоКатегорийМаркетплейсаФормы = РеквизитФормыВЗначение("ДеревоКатегорийМаркетплейса");
	ДеревоКатегорийМаркетплейсаФормы.Строки.Очистить();  

	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения, ИмяМетода,
				УчетнаяЗаписьМаркетплейса, ДеревоКатегорийМаркетплейсаФормы, ДанныеКэша);

КонецФункции

&НаКлиенте
Процедура ЗаполнитьДеревоКатегорийМаркетплейсаЗавершение(Результат, ДополнительныеПараметры) Экспорт

	ОчиститьСообщения();

	Если Результат <> Неопределено И Результат.Статус = "Выполнено" Тогда
		ДанныеКэша = Неопределено;
		ЗаполнитьДеревоКатегорийМаркетплейсаНаСервере(Результат.АдресРезультата, ДанныеКэша);

		Если ЗначениеЗаполнено(ДанныеКэша) Тогда
			ИнтеграцияСМаркетплейсомOzonКлиент.СохранитьДанныеВКэшКатегорий(ДанныеКэша, ИдентификаторКэшаКатегорий);
			ДанныеКэша = Неопределено;
		КонецЕсли;
	ИначеЕсли ЭтоЗакрытиеФормы <> Истина Тогда
		ШаблонОшибки = НСтр("ru = 'Не удалось получить категории маркетплейса по причине: %1. Подробнее см. журнал регистрации.'");
		ПредставлениеНеизвестнойОшибки = НСтр("ru = 'Неизвестная ошибка выполнения операции'");
		ПодробноеПредставлениеОшибки = ?(Результат = Неопределено, ПредставлениеНеизвестнойОшибки, Результат.ПодробноеПредставлениеОшибки);
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				ШаблонОшибки,
				ПодробноеПредставлениеОшибки);
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстОшибки);
	КонецЕсли;

	Элементы.СтраницыЭлементовДлительногоОжидания.ТекущаяСтраница = Элементы.СтраницаПустая;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоКатегорийМаркетплейсаНаСервере(АдресХранилища, ДанныеКэша)

	Результат = ПолучитьИзВременногоХранилища(АдресХранилища);
	УдалитьИзВременногоХранилища(АдресХранилища);

	ДеревоКатегорий = Результат.ДеревоКатегорий;
	ДанныеКэша = Результат.ДанныеКэша;

	Если ДеревоКатегорий = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ЗначениеВРеквизитФормы(ДеревоКатегорий, "ДеревоКатегорийМаркетплейса");

	Если ЗначениеЗаполнено(ИдентификаторКатегорииМаркетплейса) Тогда
		ИдентификаторТекущейСтроки = 0;
		ОбщегоНазначенияКлиентСервер.ПолучитьИдентификаторСтрокиДереваПоЗначениюПоля(
				"ИдентификаторКатегорииМаркетплейса", ИдентификаторТекущейСтроки,
				ДеревоКатегорийМаркетплейса.ПолучитьЭлементы(), ИдентификаторКатегорииМаркетплейса, Ложь);
		Элементы.ДеревоКатегорийМаркетплейса.ТекущаяСтрока = ИдентификаторТекущейСтроки;
		ИдентификаторКатегорииМаркетплейса = "";
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоКатегорийРекурсивно(СтрокаРодитель, ДанныеЗаполнения)

	Для Каждого Соответствие Из ДанныеЗаполнения Цикл 
		НоваяСтрока = СтрокаРодитель.Строки.Добавить();
		НоваяСтрока.ИдентификаторКатегорииМаркетплейса = Формат(Соответствие["category_id"], "ЧГ=");
		НоваяСтрока.НаименованиеКатегорииМаркетплейса = Соответствие["title"];
		ЗаполнитьДеревоКатегорийРекурсивно(НоваяСтрока, Соответствие["children"]);
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьВыборКатегории(ИдентификаторСтроки = Неопределено)

	Если ЗначениеЗаполнено(ИдентификаторСтроки) Тогда
		СтрокаДерева = ДеревоКатегорийМаркетплейса.НайтиПоИдентификатору(ИдентификаторСтроки);
	Иначе
		СтрокаДерева = Элементы.ДеревоКатегорийМаркетплейса.ТекущиеДанные;
	КонецЕсли;

	Если СтрокаДерева = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если СтрокаДерева.ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;

	ПараметрЗакрытия = Новый Структура("ИдентификаторКатегорииМаркетплейса, НаименованиеКатегорииМаркетплейса");
	ЗаполнитьЗначенияСвойств(ПараметрЗакрытия, СтрокаДерева);
	Закрыть(ПараметрЗакрытия);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЗаполнитьИнформациюПоАтрибутамКатегории()

	ДанныеКэша = ИнтеграцияСМаркетплейсомOzonКлиент.ПолучитьДанныеИзКэшаКатегорий(ИдентификаторКэшаКатегории);

	ДлительнаяОперация = ЗаполнитьИнформациюПоАтрибутамКатегорииНаСервере(ДанныеКэша);

	ДополнительныеПараметры = Новый Структура("ИдентификаторЗадания", ИдентификаторКэшаКатегории);
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ЗаполнитьИнформациюПоАтрибутамКатегорииЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);

КонецПроцедуры

&НаСервере
Функция ЗаполнитьИнформациюПоАтрибутамКатегорииНаСервере(ДанныеКэша = Неопределено)

	ИмяМетода = "ИнтеграцияСМаркетплейсомOzonСервер.ЗаполнитьИнформациюПоАтрибутамКатегории";
	НаименованиеФоновогоЗадания = НСтр("ru = 'Ozon. Заполнение данных атрибутов категории ""%1""'");

	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.ЗапуститьВФоне = Истина;
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НаименованиеФоновогоЗадания,
			ДанныеТекущейСтрокиДереваКатегорий.НаименованиеКатегорииМаркетплейса);

	ПараметрыЗаполнения = Новый Структура;
	ПараметрыЗаполнения.Вставить("ИдентификаторКатегорииМаркетплейса", ДанныеТекущейСтрокиДереваКатегорий.ИдентификаторКатегорииМаркетплейса);
	ПараметрыЗаполнения.Вставить("НаименованиеКатегорииМаркетплейса", ДанныеТекущейСтрокиДереваКатегорий.НаименованиеКатегорииМаркетплейса);
	ПараметрыЗаполнения.Вставить("НаименованиеРодителяКатегорииМаркетплейса",
			ДанныеТекущейСтрокиДереваКатегорий.НаименованиеРодителяКатегорииМаркетплейса);

	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения, ИмяМетода,
			ПараметрыЗаполнения, УчетнаяЗаписьМаркетплейса, ДанныеКэша);

КонецФункции

&НаКлиенте
Процедура ЗаполнитьИнформациюПоАтрибутамКатегорииЗавершение(Результат, Параметры) Экспорт

	ОчиститьСообщения();

	Если Результат <> Неопределено И Результат.Статус = "Выполнено" Тогда
		ДанныеКэша = Неопределено;
		ЗаполнитьИнформациюПоАтрибутамКатегорииЗавершениеНаСервере(Результат.АдресРезультата, Параметры.ИдентификаторЗадания, ДанныеКэша);

		Если ЗначениеЗаполнено(ДанныеКэша) Тогда
			ИнтеграцияСМаркетплейсомOzonКлиент.СохранитьДанныеВКэшКатегорий(ДанныеКэша, Параметры.ИдентификаторЗадания);
			ДанныеКэша = Неопределено;
		КонецЕсли;
	ИначеЕсли ЭтоЗакрытиеФормы <> Истина Тогда
		ШаблонОшибки = НСтр("ru = 'Не удалось получить атрибуты категории ""%1"" по причине: %2. Подробнее см. журнал регистрации.'");
		ПредставлениеНеизвестнойОшибки = НСтр("ru = 'Неизвестная ошибка выполнения операции'");
		ПодробноеПредставлениеОшибки = ?(Результат = Неопределено, ПредставлениеНеизвестнойОшибки, Результат.ПодробноеПредставлениеОшибки);
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				ШаблонОшибки,
				ДанныеТекущейСтрокиДереваКатегорий.НаименованиеКатегорииМаркетплейса,
				ПодробноеПредставлениеОшибки);
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстОшибки);
	КонецЕсли;

	Если Параметры.ИдентификаторЗадания = ИдентификаторКэшаКатегории Тогда
		Элементы.СтраницыЭлементовДлительногоОжиданияАтрибутов.ТекущаяСтраница = Элементы.СтраницаАтрибутов;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьИнформациюПоАтрибутамКатегорииЗавершениеНаСервере(АдресХранилища, ИдентификаторЗадания, ДанныеКэша)

	Результат = ПолучитьИзВременногоХранилища(АдресХранилища);
	УдалитьИзВременногоХранилища(АдресХранилища);

	ТабличныйДокумент = Результат.ТабличныйДокумент;
	ДанныеКэша = Результат.ДанныеКэша;
	ИнформацияОСопоставленныхКатегориях1С = Результат.ИнформацияОСопоставленныхКатегориях1С;

	Если ИдентификаторЗадания = ИдентификаторКэшаКатегории Тогда
		ДанныеПоКатегорииМаркетплейса.Вывести(ТабличныйДокумент);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
