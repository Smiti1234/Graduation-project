﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	ИсточникиКоманд = Новый Структура;
	ИсточникиКоманд.Вставить("ДокументыВозвратаТарыКоманднаяПанель", "Документ.ВозвратТоваровОтКлиента.Форма.ФормаСписка");
	ИсточникиКоманд.Вставить("ДокументыВыкупаТарыКоманднаяПанель", "Документ.ВыкупВозвратнойТарыКлиентом.Форма.ФормаСписка");
	
	Для Каждого ИсточникКоманд Из ИсточникиКоманд Цикл
		КомандыПечатиИсточника = УправлениеПечатью.КомандыПечатиФормы(ИсточникКоманд.Значение);
		КомандыПечатиИсточника.ЗаполнитьЗначения(ИсточникКоманд.Ключ, "МестоРазмещения");
		ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(КомандыПечатиИсточника, КомандыПечати);
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#КонецЕсли
