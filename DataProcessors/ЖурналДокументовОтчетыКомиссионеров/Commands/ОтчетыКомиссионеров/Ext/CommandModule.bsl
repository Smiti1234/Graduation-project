﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыФормы = Новый Структура("", );
	ОткрытьФорму("Обработка.ЖурналДокументовОтчетыКомиссионеров.Форма.СписокДокументов", 
		ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник, 
		ПараметрыВыполненияКоманды.Уникальность, 
		ПараметрыВыполненияКоманды.Окно,
		ПараметрыВыполненияКоманды.НавигационнаяСсылка);
КонецПроцедуры

#КонецОбласти