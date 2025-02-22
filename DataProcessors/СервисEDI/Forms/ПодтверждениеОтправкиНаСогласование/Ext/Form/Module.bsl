﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	КлючСохраненияПоложенияОкна = Новый УникальныйИдентификатор;
	
	ПрочитатьПараметрыФормы();
	УстановитьНачальноеОтображениеФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	КлючСохраненияПоложенияОкна = ""
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДекорацияОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ПоказатьИзменения" Тогда
		
		СтандартнаяОбработка = Ложь;
		
		СформироватьОтчет();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОтправитьНаСогласование(Команда)
	
	Если БольшеНеПоказыватьФорму Тогда
		ДокументыEDIИнтеграцияВызовСервера.УстановитьПодтверждениеПриОтправкеИзменений(Ложь);
		ПоказатьОповещениеПользователя(
			НСтр("ru = 'Настройка подтверждения изменений при отправке изменена.'"), 
			"e1cib/app/Обработка.НастройкиПользователей", 
			НСтр("ru = 'Очистить значение настройки можно в форме работы с настройками пользователя.'"), ,
			СтатусОповещенияПользователя.Информация);
	КонецЕсли;
	
	Закрыть(Истина);
	
КонецПроцедуры

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

#Область РаботаСФормой

&НаСервере
Процедура ПрочитатьПараметрыФормы()
	
	Параметры.Свойство("Документ", Документ);
	
	БольшеНеПоказыватьФорму = Не ДокументыEDIИнтеграцияВызовСервера.ПоказыватьФормуПодтвержденияПриОтправкеИзменений();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьНачальноеОтображениеФормы()
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаСтраницы", 
		"Видимость", Ложь);
	
КонецПроцедуры

#КонецОбласти

#Область ФормированиеОтчета

&НаСервереБезКонтекста
Функция ЗапуститьФормированиеОтчета(Документ, ИдентификаторФормы)
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияФункции(ИдентификаторФормы);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Формирование отчета сравнения версий'");
	
	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения, "РаботаСВерсиямиEDIСервер.СформироватьТекущиеОтличияДокумента", Документ);
	
КонецФункции

&НаКлиенте
Процедура СформироватьОтчет()
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаСтраницы", 
		"Видимость", Истина);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаСтраницы", 
		"ТекущаяСтраница", Элементы.ГруппаДлительнаяОперация);
	
	ДлительнаяОперацияОтчетСравнениеВерсий = ЗапуститьФормированиеОтчета(Документ, УникальныйИдентификатор);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеФормированияОтчета", ЭтотОбъект);
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперацияОтчетСравнениеВерсий, ОписаниеОповещения, ПараметрыОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеФормированияОтчета(РезультатВыполнения, ДополнительныеПараметры) Экспорт
	
	Если РезультатВыполнения = Неопределено Или Не РезультатВыполнения.Статус = "Выполнено" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаСтраницы", 
			"ТекущаяСтраница", Элементы.ГруппаОшибкаФормированияОтчета);
		Возврат;
	КонецЕсли;
	
	ОтчетСравнениеВерсий = ПолучитьИзВременногоХранилища(РезультатВыполнения.АдресРезультата);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаСтраницы", 
		"ТекущаяСтраница", Элементы.ГруппаСравнениеВерсий);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
