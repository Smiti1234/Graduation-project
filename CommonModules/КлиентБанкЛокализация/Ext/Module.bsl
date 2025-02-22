﻿
#Область ПрограммныйИнтерфейс

// Вызывается при открытии формы Банковский счет организации.
// Позволяет добавить дополнительные форматы обмена.
// При добавление нового формата обмена будут вызываться следующие процедуры:
// - при выгрузке: КлиентБанкЛокализация.ВыгрузитьПлатежи
// - при загрузке: КлиентБанкЛокализация.ЗагрузитьПлатежи.
// 
// Параметры:
// 	ФорматыОбмена - Массив из Строка
// 
//@skip-warning реализуется партнером при необходимости.
Процедура ПриЗаполненииФорматовОбмена(ФорматыОбмена) Экспорт
	
КонецПроцедуры

// Выгружает платежи согласно переданным параметрам
// 
// Параметры:
//      ТаблицаДокументов - см. Обработки.КлиентБанк.ТабличныеЧасти.ДокументыКВыгрузке.
//      ФорматОбмена - Строка - значение формата из ПриЗаполненииФорматовОбмена().
//        Пример реализации в процедуре ВыгрузитьПлатежиВISO20022 модуля менеджера обработки КлиентБанк.
//     
//     ДвоичныеДанныеФайла - ДвоичныеДанные - файл, содержащий выгруженные для банка платежные документы. 
//
//@skip-warning реализуется партнером при необходимости.
Процедура ВыгрузитьДокументыВФайл(ТаблицаДокументов, ФорматОбмена, ДвоичныеДанныеФайла) Экспорт
	
КонецПроцедуры

// Читает данные выписки из файла.
// 
// Параметры:
//     ДвоичныеДанныеФайла - ДвоичныеДанные - данные файла
//     ФорматОбмена - Строка - название формата из процедуры ПриЗаполненииФорматовОбмена
//     ДанныеВыписки - Структура - возвращаемые данные выписки, содержит поля:
//      * Заголовок - см. ДенежныеСредстваСервер.ЗаголовокВыписки
//      * РасчетныеСчета - Массив из Структура - см. ДенежныеСредстваКлиентСервер.ДанныеРасчетногоСчета;
//      * ДокументыВыписки - Массив из Структура - см. ДенежныеСредстваСервер.ДанныеЗагружаемойОперации;
//      * ОшибкиРазбора - Массив из Строка - ошибки разбора файла выписки
//
//@skip-warning реализуется партнером при необходимости.
Процедура ПрочитатьВыпискуИзФайла(ДвоичныеДанныеФайла, ФорматОбмена, ДанныеВыписки) Экспорт
	
КонецПроцедуры


#КонецОбласти
