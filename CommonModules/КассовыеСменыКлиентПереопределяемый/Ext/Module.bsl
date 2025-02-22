﻿#Область ПрограммныйИнтерфейс

// Обработчик события переопределяет произвольную команду формы списка Кассовая смена.
//
// Параметры:
//  Команда - КомандаФормы - команда формы.
//
Процедура ФормаСпискаВыполнитьПереопределяемуюКоманду(Команда) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Обработчик события переопределяет произвольную команду формы документа Кассовая смена.
//
// Параметры:
//  Команда - КомандаФормы - команда формы.
//
Процедура ФормаДокументаВыполнитьПереопределяемуюКоманду(Команда) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Обработчик события вызывается при получении имени кассира.
//
// Параметры:
//  ФискальноеУстройство - СправочникСсылка.ПодключаемоеОборудование.
//  ДополнительныеПараметры - Структура.
//
Процедура УправлениеФУЗаполнитьДополнительныеПараметрыПередОткрытиемСмены(ФискальноеУстройство, ДополнительныеПараметры) Экспорт
	
	КассаККМ = РозничныеПродажиВызовСервера.КассаККМПоПодключаемомуОборудованияДляРМК(ФискальноеУстройство);
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("КассаККМ", КассаККМ);
	
КонецПроцедуры

#КонецОбласти
