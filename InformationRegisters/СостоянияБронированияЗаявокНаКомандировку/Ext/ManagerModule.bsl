﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Устанавливает состояние для заявки
//
// Параметры:
//    ЗаявкаНаКомандировку - ДокументСсылка.ЗаявкаНаКомандировку - Заявка на командировку
//    СостояниеЗаявки - ПеречислениеСсылка.СостоянияБронированияЗаявокНаКомандировку - Состояние заявки
//    ИнформацияОбОшибке - Строка - Дополнительная информация
//
Процедура УстановитьСостояние(ЗаявкаНаКомандировку, СостояниеЗаявки, ИнформацияОбОшибке = Неопределено) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Период = ТекущаяДатаСеанса();
	МенеджерЗаписи.ЗаявкаНаКомандировку = ЗаявкаНаКомандировку;
	МенеджерЗаписи.Состояние = СостояниеЗаявки;
	
	Если ИнформацияОбОшибке <> Неопределено Тогда
		МенеджерЗаписи.Комментарий = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
	КонецЕсли;
	
	МенеджерЗаписи.Записать();
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

// Определяет заявки для обновления статуса в сервисе бронирования
// 
// Возвращаемое значение:
//    Массив из ДокументСсылка.ЗаявкаНаКомандировку
//
Функция ЗаявкиВСтатусеОтправлена() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст ="
	|ВЫБРАТЬ
	|	ДанныеРегистра.ЗаявкаНаКомандировку КАК Ссылка
	|ИЗ
	|	РегистрСведений.СостоянияБронированияЗаявокНаКомандировку.СрезПоследних КАК ДанныеРегистра
	|ГДЕ
	|	ДанныеРегистра.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияБронированияЗаявокНаКомандировку.Отправлена)
	|";
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции

#КонецОбласти

#КонецЕсли
