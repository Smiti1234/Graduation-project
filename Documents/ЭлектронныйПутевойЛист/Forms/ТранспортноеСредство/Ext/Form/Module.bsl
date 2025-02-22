﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	                                                           
	ОбменСГИСЭПД.ПриСозданииНаСервереПодчиненнойФормы(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
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
Процедура ТитулОформлениеПрицепыПередУдалением(Элемент, Отказ)
	
	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ИдентификаторСтроки = Неопределено;
		ТекущиеДанные.Свойство("ИдентификаторСтроки", ИдентификаторСтроки);
		ОбменСГИСЭПДКлиент.ОчиститьПодчиненныеТаблицы(ЭтотОбъект, Элемент.Имя, ИдентификаторСтроки, Отказ);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ХранимыеДанныеПрицепНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбменСГИСЭПДКлиент.ВывестиФормуВводаДанных(ЭтотОбъект, Элемент.Имя, Элементы.Прицепы.ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ХранимыеДанныеПрицепОткрытие(Элемент, СтандартнаяОбработка)

	Если ТипЗнч(Элементы.Прицепы.ТекущиеДанные.ХранимыеДанныеПрицеп) <> Тип("СправочникСсылка.ХранимыеДанныеЭПД") Тогда
		СтандартнаяОбработка = Ложь;
		ОбменСГИСЭПДКлиент.ВывестиФормуВводаДанных(ЭтотОбъект, Элемент.Имя, Элементы.Прицепы.ТекущиеДанные, Ложь);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ХранимыеДанныеПрицепПриИзменении(Элемент)
	
	ЗначениеРеквизита = Элементы.Прицепы.ТекущиеДанные.ХранимыеДанныеПрицеп;
	ГруппаДанных = СтрЗаменить(Элемент.Имя, "ХранимыеДанные", "");
	Если ЗначениеЗаполнено(ЗначениеРеквизита) Тогда
		ВходящийКонтекст = Новый Структура;
		ВходящийКонтекст.Вставить("ЗапретитьИзменение", Ложь);
		ВходящийКонтекст.Вставить("Форма", ЭтотОбъект);
		ВходящийКонтекст.Вставить("ГруппаДанных", ГруппаДанных);
		ВходящийКонтекст.Вставить("ТекущиеДанные", Элементы.Прицепы.ТекущиеДанные);
		ОбменСГИСЭПДКлиент.ОткрытиеФормыПоГиперссылке_Завершение(ЗначениеРеквизита, ВходящийКонтекст);	
	Иначе
		ОбменСГИСЭПДКлиентСервер.УдалитьРеквизитыПоГруппеДанных(ЭтотОбъект, ГруппаДанных);
		ОбменСГИСЭПДКлиентСервер.ИзменитьОформлениеЭлементовФормы(ЭтотОбъект, ГруппаДанных);	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ХранимыеДанныеПрицепАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	ГруппаДанных = СтрЗаменить(Элемент.Имя, "ХранимыеДанные", "");
	ПараметрыПолученияДанных.Отбор = ОбменСГИСЭПДКлиент.ПолучитьОтборХранимыхДанных(ЭтотОбъект, ЭтотОбъект, ГруппаДанных);
	ПараметрыПолученияДанных.СпособПоискаСтроки = ПредопределенноеЗначение("СпособПоискаСтрокиПриВводеПоСтроке.ЛюбаяЧасть");
	
КонецПроцедуры

&НаКлиенте
Процедура ТитулОформлениеПрицепыПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)

	ОбменСГИСЭПДКлиент.ТаблицаПриНачалеРедактирования(Элемент, ЭтотОбъект, НоваяСтрока, Копирование);


КонецПроцедуры