﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Добавляет объекты ИС в очередь на обновление печатных форм в связанных объектах ДО.
//
// Параметры:
//   Объект - ОпределяемыйТип.ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый - ссылка на объект ИС.
//   Правило - СправочникСсылка.ПравилаИнтеграцииС1СДокументооборотом
//           - СправочникСсылка.ПравилаИнтеграцииС1СДокументооборотом3 - правило интеграции,
//     соответствующее объекту ИС.
//
Процедура Добавить(Объект, Правило) Экспорт
	
	ПоддерживаетсяОбновлениеФайлов =
		ИнтеграцияС1СДокументооборотБазоваяФункциональностьПовтИсп.ДоступенФункционалВерсииСервиса("2.1.9.1.CORP");
		
	Если Не ПоддерживаетсяОбновлениеФайлов Тогда
		Возврат;
	КонецЕсли;
	
	Менеджер = РегистрыСведений.ОбъектыКОбновлениюПечатныхФорм.СоздатьМенеджерЗаписи();
	
	Менеджер.Объект = Объект;
	Менеджер.Правило = Правило;
	
	Менеджер.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли