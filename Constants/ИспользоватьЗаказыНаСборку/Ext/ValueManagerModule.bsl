﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыНабора = УправлениеСвойствами.СтруктураПараметровНабораСвойств();
	ПараметрыНабора.Используется = Константы.ИспользоватьЗаказыНаСборку.Получить();
	
	УправлениеСвойствами.УстановитьПараметрыНабораСвойств("Документ_ЗаказНаСборку", ПараметрыНабора);

КонецПроцедуры

#КонецОбласти

#КонецЕсли
