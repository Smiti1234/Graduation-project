﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СхемаКомпоновки = Обработки.ЗапросыКоммерческихПредложений.ПолучитьМакет("СхемаКомпоновщика");
	АдресСхемы = ПоместитьВоВременноеХранилище(СхемаКомпоновки, УникальныйИдентификатор);
	
	АдресВоВременномХранилище = Неопределено;
	КоммерческиеПредложенияПереопределяемый.ПолучитьАдресМакетаПодбораНоменклатуры(УникальныйИдентификатор, АдресВоВременномХранилище);
	
	Если ЭтоАдресВременногоХранилища(АдресВоВременномХранилище) Тогда 
		АдресСхемы = АдресВоВременномХранилище;
	КонецЕсли;
	
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемы)); 
	
	Настройки = Неопределено;
	Если Параметры.Свойство("Настройки", Настройки) Тогда
		КомпоновщикНастроек.ЗагрузитьНастройки(Настройки);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПодключитьОбработчикОжидания("ВыгрузитьНоменклатуруПоОтбору", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыКомпоновщикНастроек

&НаКлиенте
Процедура КомпоновщикНастроекКомпоновкиДанныхНастройкиОтборПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	ОтключитьОбработчикОжидания("ВыгрузитьНоменклатуруПоОтбору");
	
КонецПроцедуры

&НаКлиенте
Процедура КомпоновщикНастроекКомпоновкиДанныхНастройкиОтборПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ПодключитьОбработчикОжидания("ВыгрузитьНоменклатуруПоОтбору", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура КомпоновщикНастроекКомпоновкиДанныхНастройкиОтборПослеУдаления(Элемент)
	
	ПодключитьОбработчикОжидания("ВыгрузитьНоменклатуруПоОтбору", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Ок(Команда)
	
	ПодключитьОбработчикОжидания("СохранитьИВыйти", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура СохранитьИВыйти()
	
	Результат = Новый Структура;
	Результат.Вставить("НастройкиКомпоновки", КомпоновщикНастроек.Настройки);
	Результат.Вставить("МассивСтрок"        , ПолучитьСтрокиНоменклатуры(ВыбраннаяНоменклатура));
	
	Закрыть(Результат);
	
КонецПроцедуры


&НаСервере
Процедура ВыгрузитьНоменклатуруПоОтборуНаСервере()
	
	ВыбраннаяНоменклатура.Очистить();
	
	ТаблицаДанныеПакетаПредложений = Новый ТаблицаЗначений;
	КомпоновщикМакета              = Новый КомпоновщикМакетаКомпоновкиДанных;
	СхемаКомпоновкиДанных          = Новый СхемаКомпоновкиДанных;
	
	СхемаКомпоновки = ПолучитьИзВременногоХранилища(АдресСхемы);
	
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновки, КомпоновщикНастроек.Настройки,,,
		Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"), Ложь);
	
	Запрос = Новый Запрос;
	Запрос.Текст = МакетКомпоновки.НаборыДанных.НаборДанных1.Запрос;
	
	Для Каждого ЗначениеПараметра Из МакетКомпоновки.ЗначенияПараметров Цикл
		
		Запрос.УстановитьПараметр(ЗначениеПараметра.Имя,ЗначениеПараметра.Значение);
		
	КонецЦикла;
	
	Выборка = Запрос.Выполнить().Выбрать();
	Счетчик = 0;
	
	Пока Выборка.Следующий() Цикл
		
		Счетчик = Счетчик + 1;
		ЗаполнитьЗначенияСвойств(ВыбраннаяНоменклатура.Добавить(), Выборка);
		
		Если Счетчик = 5 Тогда
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	КоличествоЭлементов = СтрШаблон(НСтр("ru = '%1 из 5'"), Счетчик);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьНоменклатуруПоОтбору()

	ВыгрузитьНоменклатуруПоОтборуНаСервере();

КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьСтрокиНоменклатуры(Знач ВыбраннаяНоменклатура)
	
	Возврат ВыбраннаяНоменклатура.Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции

#КонецОбласти



