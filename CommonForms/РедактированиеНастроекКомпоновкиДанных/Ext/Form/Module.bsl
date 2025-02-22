﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если ЭтоАдресВременногоХранилища(Параметры.АдресНастроек) Тогда
		НастройкиКомпоновкиПеременная = ПолучитьИзВременногоХранилища(Параметры.АдресНастроек);
		УдалитьИзВременногоХранилища(Параметры.АдресНастроек);
	Иначе
		НастройкиКомпоновкиПеременная = Параметры.АдресНастроек;
	КонецЕсли;
	
	Если ЭтоАдресВременногоХранилища(Параметры.ИмяАдресМакета) Тогда
		URLСхемы = Параметры.ИмяАдресМакета;
	Иначе
		СхемаКомпоновкиДанных = ОбщегоНазначенияУТ.МакетПоИмени(Параметры.ИмяАдресМакета);
		URLСхемы = ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, Новый УникальныйИдентификатор());
	КонецЕсли;
	
	ИсточникНастроек = Новый ИсточникДоступныхНастроекКомпоновкиДанных(URLСхемы);
	НастройкиКомпоновки.Инициализировать(ИсточникНастроек);
	НастройкиКомпоновки.ЗагрузитьНастройки(НастройкиКомпоновкиПеременная);
	НастройкиКомпоновки.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КнопкаОК(Команда)
	
	Закрыть(ПоместитьНастройкиОтборНоменклатурыВоВременноеХранилище());
	
КонецПроцедуры

&НаКлиенте
Процедура КнопкаОтмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПоместитьНастройкиОтборНоменклатурыВоВременноеХранилище()
	НастройкиКомпоновкиПеременная = НастройкиКомпоновки.ПолучитьНастройки();
	Возврат ПоместитьВоВременноеХранилище(НастройкиКомпоновкиПеременная);
КонецФункции

#КонецОбласти





