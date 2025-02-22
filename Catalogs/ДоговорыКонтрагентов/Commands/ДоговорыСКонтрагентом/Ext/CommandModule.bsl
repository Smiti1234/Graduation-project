﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрТекстЗаголовка = НСтр("ru='Договоры с контрагентом'");
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отбор", Новый Структура("Контрагент", ПараметрКоманды));
	ПараметрыФормы.Вставить("Заголовок", ПараметрТекстЗаголовка);
	
	ОткрытьФорму("Справочник.ДоговорыКонтрагентов.ФормаСписка",
				 ПараметрыФормы,
				 ПараметрыВыполненияКоманды.Источник,
				 ПараметрыВыполненияКоманды.Уникальность,
				 ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры
