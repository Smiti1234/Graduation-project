﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов


// Получает контакты для документов взаимодействий согласно списку участников 
//
// Параметры:
//  Ссылка  - СправочникСсылка.Претензии - претензия по которой получаются контакты.
//
// Возвращаемое значение:
//   Массив   - массив, содержащий контакты.
//
Функция ПолучитьКонтакты(Ссылка) Экспорт
	
	Возврат СделкиСервер.ПолучитьУчастниковПоТабличнойЧастиПредметаВзаимодействия(Ссылка);
	
КонецФункции

#КонецОбласти

#КонецЕсли
