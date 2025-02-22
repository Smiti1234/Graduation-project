﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	РазрешитьРедактированиеКалендарь   = Истина;
	РазрешитьРедактированиеФормаОплаты = Истина;
	РазрешитьРедактированиеЭтапов      = Истина;

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура РазрешитьРедактирование(Команда)

	Результат = Новый Массив;
	
	Если РазрешитьРедактированиеКалендарь Тогда
		Результат.Добавить("Календарь");
	КонецЕсли;
	
	Если РазрешитьРедактированиеФормаОплаты Тогда
		Результат.Добавить("ФормаОплаты");
	КонецЕсли;
	
	Если РазрешитьРедактированиеЭтапов Тогда
		Результат.Добавить("Этапы");
	КонецЕсли;
	
	Закрыть(Результат);

КонецПроцедуры

&НаКлиенте
Процедура УстановитьВсеОтметки(Команда)
	
	РазрешитьРедактированиеКалендарь   = Истина;
	РазрешитьРедактированиеФормаОплаты = Истина;
	РазрешитьРедактированиеЭтапов      = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьВсеОтметки(Команда)
	
	РазрешитьРедактированиеКалендарь   = Ложь;
	РазрешитьРедактированиеФормаОплаты = Ложь;
	РазрешитьРедактированиеЭтапов      = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти
