﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ТолькоПросмотр = Истина;	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Данный регистр является служебным, поэтому доступ к его данным запрещен.'"));
КонецПроцедуры

#КонецОбласти
