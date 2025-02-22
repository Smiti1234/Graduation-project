﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область Инициализация

Если ПолучитьФункциональнуюОпцию("ИспользоватьПередачуНаОтветственноеХранениеСПравомПродажи") Тогда
	СоздаватьПередачуТоваровХранителю = Истина;
	ПечататьПередачуТоваровХранителю  = Истина;
КонецЕсли;

Если ПолучитьФункциональнуюОпцию("ИспользоватьЗаказыКлиентов") Тогда
	СоздаватьЗаказКлиента = Истина;
	ПечататьЗаказКлиента = Истина;
КонецЕсли;

Если ПолучитьФункциональнуюОпцию("ИспользоватьСчетаНаОплатуКлиентам") Тогда
	СоздаватьСчетНаОплату = Истина;
	ПечататьСчетНаОплату = Истина;
КонецЕсли;

СоздаватьЗаявкуНаВозвратТоваровОтКлиентов = Ложь;
СоздаватьДокументПродажи = Истина;
СтатусЗаказаКлиента = Перечисления.СтатусыЗаказовКлиентов.НеСогласован;
СтатусЗаявкиНаВозвратТоваровОтКлиентов = Перечисления.СтатусыЗаявокНаВозвратТоваровОтКлиентов.КВозврату;
СтатусРеализацииТоваровУслуг = Перечисления.СтатусыРеализацийТоваровУслуг.Отгружено;

ПечататьРеализациюТоваровУслуг = Истина;
ПечататьАктВыполненныхРабот = Истина;
ПечататьЗаявкуНаВозвратТоваровОтКлиентов = Ложь;

СпособДоставки = Перечисления.СпособыДоставки.Самовывоз;
СпособПрогнозированияПродаж = Перечисления.СпособыПрогнозированияПродаж.ПоСтатистикеПродаж;
ЗаполнятьТоварыПоСоглашению = Ложь;
ПериодСбораСтатистики = 30;

Если ПолучитьФункциональнуюОпцию("ИспользоватьРасширенныеВозможностиЗаказаКлиента") Тогда
	ВариантОбеспечения = Перечисления.ВариантыОбеспечения.КОбеспечению;
Иначе
	ВариантОбеспечения = Перечисления.ВариантыОбеспечения.НеТребуется;
КонецЕсли;

Продажи.ПриИнициализацииПомощникаПродаж(ЭтотОбъект);

//++ Локализация
ПечататьСчетФактуру = Истина;
//-- Локализация
#КонецОбласти

#КонецЕсли