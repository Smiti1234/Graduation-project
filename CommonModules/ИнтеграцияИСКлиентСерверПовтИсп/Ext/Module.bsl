﻿#Область СлужебныйПрограммныйИнтерфейс

#Область УпаковкиЕдиницыИзмерения

// Возвращает единицу измерения, указанную в константе ЕдиницаИзмеренияКилограммИС.
//
// Возвращаемое значение:
// 	ОпределяемыйТип.Упаковка
// 
Функция ЕдиницаИзмеренияКилограмм() Экспорт
	
	ЕдиницаИзмеренияКилограмм = ИнтеграцияИСВызовСервера.ЕдиницаИзмеренияКилограмм();
	Если Не ЗначениеЗаполнено(ЕдиницаИзмеренияКилограмм) Тогда
		ВызватьИсключение НСтр("ru = 'Не указана единица измерения для учета ""Килограмм"".
			|Перейдите в панель администрирования и укажите единицу измерения ""Килограмм"".'");
	КонецЕсли;
	
	Возврат ЕдиницаИзмеренияКилограмм;
	
КонецФункции

// Возвращает единицу измерения, указанную в константе ЕдиницаИзмеренияЛитрИС.
//
// Возвращаемое значение:
// 	ОпределяемыйТип.Упаковка
// 
Функция ЕдиницаИзмеренияЛитр() Экспорт
	
	ЕдиницаИзмеренияЛитр = ИнтеграцияИСВызовСервера.ЕдиницаИзмеренияЛитр();
	Если Не ЗначениеЗаполнено(ЕдиницаИзмеренияЛитр) Тогда
		ВызватьИсключение НСтр("ru = 'Не указана единица измерения для учета ""Литр"".
			|Перейдите в панель администрирования и укажите единицу измерения ""Литр"".'");
	КонецЕсли;
	
	Возврат ЕдиницаИзмеренияЛитр;
	
КонецФункции

Функция ПустоеЗначениеУпаковки() Экспорт
	
	Возврат ИнтеграцияИСВызовСервера.ПустоеЗначениеУпаковки();
	
КонецФункции

#КонецОбласти

#Область ЧастичноеВыбытие

// Возвращает признак возможности для вида продукции участвовать в частичном выбытии.
// 
// Параметры:
//  ВидПродукции    - ПеречислениеСсылка.ВидыПродукцииИС                - вид маркируемой продукции.
//  ВидОперацииИСМП - ПеречислениеСсылка.ВидыОперацийИСМП, Неопределено - вид операции ИСМП.
// Возвращаемое значение:
//  Булево - Вид продукци может выбывать частично.
Функция ПоддерживаетсяЧастичноеВыбытие(ВидПродукции, ВидОперацииИСМП = Неопределено) Экспорт
	
	Возврат ИнтеграцияИСВызовСервера.ПоддерживаетсяЧастичноеВыбытие(ВидПродукции, ВидОперацииИСМП);
	
КонецФункции

#КонецОбласти

// Классифицирует текущий сеанс, как сеанс, запущенный в фоновом задании в клиент-серверном варианте, в остальных
// случаях, сеанс имеет ту же файловую систему на стороне сервера, что и основной сеанс.
//	
// Возвращаемое значение:
// 	Булево - Описание
Функция ЭтоФоновоеЗаданиеНаСервере() Экспорт
	Возврат ИнтеграцияИСВызовСервера.ЭтоФоновоеЗаданиеНаСервере();
КонецФункции

// Возвращает признак принадлежности переданного в параметре вида продукции к наборам или групповым упаковкам.
// 
// Параметры:
// 	ВидПродукции - ПеречислениеСсылка.ВидыПродукцииИС - Вид продукции для анализа.
// Возвращаемое значение:
// 	Булево - Принадлежность к виду продукции ИСМП
//
Функция ВидПродукцииИспользуетНаборыИлиГрупповыеУпаковки(ВидПродукции, ВидУпаковки = Неопределено) Экспорт
	
	Если ВидУпаковки = Неопределено Тогда
		Если ИнтеграцияИСКлиентСервер.ВидПродукцииИспользуетНаборы(ВидПродукции) Тогда
			Возврат Истина;
		ИначеЕсли ИнтеграцияИСКлиентСервер.ВидПродукцииИспользуетГрупповыеУпаковки(ВидПродукции) Тогда
			Возврат Истина;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	Иначе
		Если ВидУпаковки = ПредопределенноеЗначение("Перечисление.ВидыУпаковокИС.Групповая")
			И ИнтеграцияИСКлиентСервер.ВидПродукцииИспользуетГрупповыеУпаковки(ВидПродукции) Тогда
			Возврат Истина;
		ИначеЕсли ВидУпаковки = ПредопределенноеЗначение("Перечисление.ВидыУпаковокИС.Набор")
			И ИнтеграцияИСКлиентСервер.ВидПродукцииИспользуетНаборы(ВидПродукции) Тогда
			Возврат Истина;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;
	
КонецФункции

Функция ИменаПараметровРаботыКлиентаВыборТипаПодписиБСП() Экспорт
	
	ВозвращаемоеЗначение = Новый Структура();
	
	ВозвращаемоеЗначение.Вставить("ИмяПараметраПриложения", "ГОСИС_ВыборТипаПодписиБСП");
	ВозвращаемоеЗначение.Вставить(
		"ЗначениеПараметраВыборТипаПодписиНеПоддерживается",
		"ИнтеграцияГОСИС.ВыборТипаПодписиБСП.ВыборТипаПодписиНеПоддерживается");
	ВозвращаемоеЗначение.Вставить(
		"ЗначениеПараметраВыборТипаПодписиИспользуетКонструктор",
		"ИнтеграцияГОСИС.ВыборТипаПодписиБСП.ВыборТипаПодписиИспользуетКонструктор");
	ВозвращаемоеЗначение.Вставить(
		"ЗначениеПараметраВыборТипаПодписиЗадаетсяПеречислением",
		"ИнтеграцияГОСИС.ВыборТипаПодписиБСП.ВыборТипаПодписиЗадаетсяПеречислением");
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

Функция ЗемельныйУчастокИСПереопределен() Экспорт
	
	Возврат ИнтеграцияИСВызовСервера.ЗемельныйУчастокИСПереопределен();
	
КонецФункции

#КонецОбласти