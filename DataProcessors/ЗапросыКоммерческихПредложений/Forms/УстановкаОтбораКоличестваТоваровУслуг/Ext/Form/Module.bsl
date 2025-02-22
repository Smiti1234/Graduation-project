﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИмяФормыСпискаЕдиницыИзмерения = Метаданные.НайтиПоТипу(ТипВидаНоменклатуры()).ПолноеИмя() + ".ФормаВыбора";
	
	ЕдиницаИзмерения   = Параметры.ЕдиницаИзмерения;
	КоличествоОт       = Параметры.ИнтервалОт;
	КоличествоДо       = Параметры.ИнтервалДо;
	
	СформироватьПредставлениеЕдиницыИзмерения(ЕдиницаИзмерения, Элементы.ДекорацияЕдиницаИзмерения);
	
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияЕдиницаИзмеренияНажатие(Элемент)
	
	СтандартнаяОбработка = Ложь;
	
	Описание = Новый ОписаниеОповещения("ПослеВыбораЕдиницыИзмерения", ЭтотОбъект);
	ОткрытьФорму(ИмяФормыСпискаЕдиницыИзмерения, , , , , , Описание);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	Если НЕ ЗначениеЗаполнено(ЕдиницаИзмерения)
		И (ЗначениеЗаполнено(КоличествоОт)
		ИЛИ ЗначениеЗаполнено(КоличествоДо)) Тогда
		
		ПоказатьПредупреждение(Неопределено, НСтр("ru = 'Не выбрана единица измерения отбора.'"), 60);
		Возврат;
	КонецЕсли;
	
	СтруктураВозврата = Новый Структура("ИнтервалОт, ИнтервалДо, ЕдиницаИзмерения");
	СтруктураВозврата.ИнтервалОт       = КоличествоОт;
	СтруктураВозврата.ИнтервалДо       = КоличествоДо;
	СтруктураВозврата.ЕдиницаИзмерения = ЕдиницаИзмерения;
	
	НеверныйИнтервал = ЗначениеЗаполнено(КоличествоОт)
		И ЗначениеЗаполнено(КоличествоДо)
		И КоличествоОт > КоличествоДо;
	
	Если НеверныйИнтервал Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru = 'Указан неверный диапазон значений.'"), 60);
		Возврат;
	КонецЕсли;
	
	Закрыть(СтруктураВозврата);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура СформироватьПредставлениеЕдиницыИзмерения(Знач ЕдиницаИзмерения, ЭлементНадписиЕдиницаИзмерения)
	
	Если ЗначениеЗаполнено(ЕдиницаИзмерения) Тогда
		ЭлементНадписиЕдиницаИзмерения.Заголовок  = Строка(ЕдиницаИзмерения);
		ЭлементНадписиЕдиницаИзмерения.ЦветТекста = Новый Цвет;
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ТипВидаНоменклатуры()
	
	Возврат Метаданные.ОпределяемыеТипы.УпаковкаНоменклатурыБЭД.Тип.Типы()[0];
	
КонецФункции

&НаКлиенте
Процедура ПослеВыбораЕдиницыИзмерения(Результат, ДополнительныеПараметры) Экспорт

	Если НЕ ЗначениеЗаполнено(Результат) Тогда
		Возврат;
	КонецЕсли;
	
	ЕдиницаИзмерения = Результат;
	
	СформироватьПредставлениеЕдиницыИзмерения(ЕдиницаИзмерения, Элементы.ДекорацияЕдиницаИзмерения);
	
КонецПроцедуры

#КонецОбласти


