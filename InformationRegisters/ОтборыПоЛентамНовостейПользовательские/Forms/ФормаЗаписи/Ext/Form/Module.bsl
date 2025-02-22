﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Элементы.КатегорияНовостей.СписокВыбора.ЗагрузитьЗначения(ПолучитьРазрешенныеКатегорииНовостейДляЭтойЛентыНовостей(Запись.ЛентаНовостей));

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Функция возвращает массив доступных категорий для ленты новостей.
// 
// Параметры:
//  лкЛентаНовостей - СправочникСсылка.ЛентыНовостей.
//
// Возвращаемое значение:
//  Массив.
//
&НаСервереБезКонтекста
Функция ПолучитьРазрешенныеКатегорииНовостейДляЭтойЛентыНовостей(Знач лкЛентаНовостей)

	Результат = Новый Массив;

	Если НЕ лкЛентаНовостей.Пустая() Тогда
		Результат = лкЛентаНовостей.ДоступныеКатегорииНовостей.Выгрузить(, "КатегорияНовостей").ВыгрузитьКолонку("КатегорияНовостей");
	КонецЕсли;

	Возврат Результат;

КонецФункции

&НаКлиенте
Процедура ЛентаНовостейПриИзменении(Элемент)

	Элементы.КатегорияНовостей.СписокВыбора.ЗагрузитьЗначения(ПолучитьРазрешенныеКатегорииНовостейДляЭтойЛентыНовостей(Запись.ЛентаНовостей));

КонецПроцедуры

#КонецОбласти
