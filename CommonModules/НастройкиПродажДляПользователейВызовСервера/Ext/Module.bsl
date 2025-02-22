﻿
#Область ПрограммныйИнтерфейс

// Получить настройку ограничений по пользователю
//
// Параметры:
//  Ссылка - СправочникСсылка.Пользователи - Пользователь.
// 
// Возвращаемое значение:
//  СправочникСсылка.НастройкиПродажДляПользователей, Неопределено - Настройка ограничений пользователя.
//
Функция НастройкаОграниченийПоОбъекту(Ссылка) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	НастройкиПродажДляПользователей.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.НастройкиПродажДляПользователей КАК НастройкиПродажДляПользователей
	|ГДЕ
	|	НастройкиПродажДляПользователей.Владелец = &Владелец";
	
	Запрос.УстановитьПараметр("Владелец", Ссылка);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		
		Возврат Выборка.Ссылка;
		
	Иначе
		
		Возврат Неопределено;
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти