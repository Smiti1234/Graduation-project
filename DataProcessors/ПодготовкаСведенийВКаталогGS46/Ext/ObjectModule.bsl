﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	СтранаМираРоссия = Справочники.СтраныМира.Россия;
	Продукция = Новый Массив();
	
	Для Каждого СтрокаТЧ Из Товары Цикл
		Если Продукция.Найти(СтрокаТЧ.Номенклатура) = Неопределено Тогда
			Продукция.Добавить(СтрокаТЧ.Номенклатура);
		КонецЕсли;
	
		Если СтрокаТЧ.СтранаПроизводства = СтранаМираРоссия Тогда
			АдресОшибки = " " + СтрШаблон(НСтр("ru='в строке %1 списка ""Товары""'"), СтрокаТЧ.НомерСтроки);
			
			Если ПустаяСтрока(СтрокаТЧ.Цвет) Тогда
				ПолеОшибки  = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Товары", СтрокаТЧ.НомерСтроки, "Цвет");
				ТекстОшибки = НСтр("ru='Не заполнена колонка ""Цвет""'");
				ОбщегоНазначения.СообщитьПользователю(ТекстОшибки + АдресОшибки,, ПолеОшибки, "Объект", Отказ);
			КонецЕсли;
			
			Если ПустаяСтрока(СтрокаТЧ.Размер) Тогда
				ПолеОшибки  = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Товары", СтрокаТЧ.НомерСтроки, "Размер");
				ТекстОшибки = НСтр("ru='Не заполнена колонка ""Размер""'");
				ОбщегоНазначения.СообщитьПользователю(ТекстОшибки + АдресОшибки,, ПолеОшибки, "Объект", Отказ);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;

	Артикулы = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(Продукция, "Артикул");
	
	Для Каждого Артикул Из Артикулы Цикл
		Если Не ЗначениеЗаполнено(Артикул.Значение) Тогда
			СтрокаТЧ    = Товары.Найти(Артикул.Ключ, "Номенклатура");
			АдресОшибки = " " + СтрШаблон(НСтр("ru='в строке %1 списка ""Товары""'"), СтрокаТЧ.НомерСтроки);
			ТекстОшибки = СтрШаблон(НСтр("ru='Не заполнен артикул номенклатуры ""%1""'"), СтрокаТЧ.Номенклатура);
			ПолеОшибки  = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Товары", СтрокаТЧ.НомерСтроки, "Номенклатура");
			ОбщегоНазначения.СообщитьПользователю(ТекстОшибки + АдресОшибки,, ПолеОшибки, "Объект", Отказ);
		КонецЕсли;
	КонецЦикла;

	МассивНепроверяемыхРеквизитов.Добавить("Товары.Цвет");
	МассивНепроверяемыхРеквизитов.Добавить("Товары.Размер");
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли