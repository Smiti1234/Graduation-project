﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ИмяФормыРабочееМестоЗаказПоставщику = "Документ.ЗаказПоставщику.Форма.ФормаСпискаДокументов";
	ОткрытьФорму(ИмяФормыРабочееМестоЗаказПоставщику,
		, // ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность,
		ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры

#КонецОбласти