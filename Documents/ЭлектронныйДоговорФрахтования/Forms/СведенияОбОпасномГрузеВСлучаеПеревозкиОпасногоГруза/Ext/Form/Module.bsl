﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	                                                           
	ОбменСГИСЭПД.ПриСозданииНаСервереПодчиненнойФормы(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
	Если Параметры.Свойство("ФормаБезОбработки") = Ложь И ЭтотОбъект.ЗапретитьИзменение = Ложь Тогда
		Элементы.СсылкаДОПОГ.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.КлассификаторДОПОГЭПД");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
		
	ОбменСГИСЭПДКлиент.СохранитьПараметрыПодчиненнойФормы(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбменСГИСЭПДКлиент.ПриОткрытииПодчиненнойФормы(ЭтотОбъект);
																		
КонецПроцедуры
			
&НаКлиенте
Функция ОписаниеРеквизитовФормы() Экспорт
	
	Возврат ОписаниеРеквизитовФормыСервер();
	
КонецФункции

&НаСервере
Функция ОписаниеРеквизитовФормыСервер()
	
	Возврат ОбменСГИСЭПД.ОписаниеРеквизитовФормы(ЭтаФорма);
		
КонецФункции

//@skip-check module-unused-method
&НаКлиенте
Процедура Подключаемый_ДобавлениеПоляВвода(Команда)
	
	ИмяТаблицыИПоля = СтрЗаменить(Команда.Имя, "ДобавлениеПоляВвода", "");
	МассивЧастей = ОбменСГИСЭПДКлиентСервер.РазделитьСтрокуСоСложнымРазделителем(ИмяТаблицыИПоля, "__");
	
	ДобавлениеПоляВводаСервер(МассивЧастей[0], МассивЧастей[1]);
	
КонецПроцедуры

&НаСервере
Процедура ДобавлениеПоляВводаСервер(ИмяТаблицы, ИмяПоля)
	
	ОбменСГИСЭПД.СоздатьЭлементыВводаЗначенийСписка(ЭтотОбъект, ИмяТаблицы, ИмяПоля, Истина);
	
КонецПроцедуры

//@skip-check module-unused-method
&НаКлиенте
Процедура Подключаемый_ПолеЗначенияСпискаИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;	
	МассивЧастей = ОбменСГИСЭПДКлиентСервер.РазделитьСтрокуСоСложнымРазделителем(Элемент.Имя, "__");	
	УстановитьФорматированноеЗначениеПоляВвода(МассивЧастей[0], МассивЧастей[1], Число(МассивЧастей[2]), Текст);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьФорматированноеЗначениеПоляВвода(ИмяТаблицы, ИмяПоля, НомерСтроки, Текст)
	
	ТекущиеДанные = ЭтотОбъект[ИмяТаблицы][НомерСтроки];	 
	ОбменСГИСЭПД.УстановитьФорматированноеЗначениеПоляВвода(ЭтотОбъект, ТекущиеДанные, ИмяПоля, Текст);
	
КонецПроцедуры

&НаКлиенте
Процедура СсылкаДОПОГПриИзменении(Элемент)


	ОбменСГИСЭПДКлиентСервер.ЗаполнитьРеквизитыПоСсылке(Элемент, ЭтотОбъект);
	
КонецПроцедуры