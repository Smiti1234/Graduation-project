﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает список реквизитов, которые разрешается редактировать
// с помощью обработки группового изменения объектов.
//
// Возвращаемое значение:
//  Массив - список имен реквизитов объекта.
//
Функция РеквизитыРедактируемыеВГрупповойОбработке() Экспорт
	
	Возврат РаботаСФайлами.РеквизитыРедактируемыеВГрупповойОбработке();
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает краткое описание последнего сообщения обмена указанного типа (Передано, ВОчереди, СОшибкой, Любое)
//   по документу. Если такого сообщения нет, возвращает Неопределено.
//
// Параметры:
//   ДокументСсылка         - ОпределяемыйТип.ДокументыИСМП - документ для получения описания
//   ТипПоследнегоСообщения - Строка                        - тип сообщения из фиксированного списка
// Возвращаемое значение:
//   Структура - реквизиты сообщения:
//   * ВладелецФайла - ОпределяемыйТип.ДокументыИСМП            - владелец файла
//   * Операция      - ПеречислениеСсылка.ВидыОперацийИСМП      - операция обмена
//   * ТипСообщения  - ПеречислениеСсылка.ТипыЗапросовИС        - тип сообщения (исходящий, входящий)
//   * Сообщение     - СправочникСсылка.ИСМППрисоединенныеФайлы - ссылка на сообщение
//                   - Неопределено - сообщение не найдено
//
Функция ПоследнееСообщение(ДокументСсылка, ТипПоследнегоСообщения = "Передано") Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИСМППрисоединенныеФайлы.Ссылка               КАК Сообщение,
	|	ИСМППрисоединенныеФайлы.ТипСообщения         КАК ТипСообщения,
	|	ИСМППрисоединенныеФайлы.Документ.Организация КАК Организация,
	|	ИСМППрисоединенныеФайлы.СтатусОбработки      КАК СтатусОбработки,
	|	ИСМППрисоединенныеФайлы.ВладелецФайла        КАК ВладелецФайла,
	|	ИСМППрисоединенныеФайлы.Операция             КАК Операция
	|ПОМЕСТИТЬ ИСМППрисоединенныеФайлы
	|ИЗ
	|	Справочник.ИСМППрисоединенныеФайлы КАК ИСМППрисоединенныеФайлы
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОчередьСообщенийИСМП КАК ОчередьСообщенийИСМП
	|		ПО ОчередьСообщенийИСМП.Сообщение = ИСМППрисоединенныеФайлы.Ссылка
	|ГДЕ
	|	ИСМППрисоединенныеФайлы.Документ = &Документ
	|	И &Условие1
	|УПОРЯДОЧИТЬ ПО
	|	ИСМППрисоединенныеФайлы.ДатаСоздания УБЫВ,
	|	ВЫБОР
	|		КОГДА ИСМППрисоединенныеФайлы.ТипСообщения = ЗНАЧЕНИЕ(Перечисление.ТипыЗапросовИС.Исходящий) ТОГДА
	|			0
	|		ИНАЧЕ
	|			1
	|	КОНЕЦ УБЫВ
	|;
	|
	|//////////////////////////////////////////////////
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	ОчередьСообщенийИСМП.Сообщение                  КАК Сообщение,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗапросовИС.Исходящий) КАК ТипСообщения,
	|	ОчередьСообщенийИСМП.Организация                КАК Организация,
	|	НЕОПРЕДЕЛЕНО                                    КАК СтатусОбработки,
	|	ОчередьСообщенийИСМП.Документ                   КАК ВладелецФайла,
	|	ОчередьСообщенийИСМП.Операция                   КАК Операция
	|ПОМЕСТИТЬ ОчередьСообщенийИСМП
	|ИЗ
	|	РегистрСведений.ОчередьСообщенийИСМП КАК ОчередьСообщенийИСМП
	|ГДЕ
	|	ОчередьСообщенийИСМП.Документ = &Документ
	|	И ОчередьСообщенийИСМП.СообщениеОснование = """"
	|	И &Условие2
	|УПОРЯДОЧИТЬ ПО
	|	ОчередьСообщенийИСМП.ДатаСоздания УБЫВ
	|;
	|
	|//////////////////////////////////
	|ВЫБРАТЬ
	|	Т.Сообщение       КАК Сообщение,
	|	Т.ТипСообщения    КАК ТипСообщения,
	|	Т.Организация     КАК Организация,
	|	Т.СтатусОбработки КАК СтатусОбработки,
	|	Т.ВладелецФайла   КАК ВладелецФайла,
	|	Т.Операция        КАК Операция,
	|	1                 КАК Приоритет
	|ПОМЕСТИТЬ Итог
	|ИЗ
	|	ИСМППрисоединенныеФайлы КАК Т
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Т.Сообщение       КАК Сообщение,
	|	Т.ТипСообщения    КАК ТипСообщения,
	|	Т.Организация     КАК Организация,
	|	Т.СтатусОбработки КАК СтатусОбработки,
	|	Т.ВладелецФайла   КАК ВладелецФайла,
	|	Т.Операция        КАК Операция,
	|	2                 КАК Приоритет
	|ИЗ
	|	ОчередьСообщенийИСМП КАК Т
	|;
	|
	|//////////////////////////
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	Т.Сообщение       КАК Сообщение,
	|	Т.ТипСообщения    КАК ТипСообщения,
	|	Т.Организация     КАК Организация,
	|	Т.СтатусОбработки КАК СтатусОбработки,
	|	Т.ВладелецФайла   КАК ВладелецФайла,
	|	Т.Операция        КАК Операция,
	|	Т.Приоритет       КАК Приоритет
	|ИЗ
	|	Итог КАК Т
	|УПОРЯДОЧИТЬ ПО
	|	Т.Приоритет УБЫВ
	|");
	
	Запрос.УстановитьПараметр("Документ", ДокументСсылка);
	
	Если ТипПоследнегоСообщения = "Передано" Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Условие1", "ИСТИНА");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Условие2", "ЛОЖЬ");
	ИначеЕсли ТипПоследнегоСообщения = "ВОчереди" Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Условие1", "ЛОЖЬ");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Условие2", "ИСТИНА");
	ИначеЕсли ТипПоследнегоСообщения = "СОшибкой" Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Условие1",
			"
			|ВЫБОР
			|	КОГДА ВЫРАЗИТЬ(ИСМППрисоединенныеФайлы.Описание КАК Строка(255)) = """"
			|		ТОГДА ЛОЖЬ
			|	ИНАЧЕ ИСТИНА
			|КОНЕЦ
			|");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Условие2", "ЛОЖЬ");
	ИначеЕсли ТипПоследнегоСообщения = "Любое" Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Условие1", "ИСТИНА");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Условие2", "ИСТИНА");
	КонецЕсли;
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Не Выборка.Следующий() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ВозвращаемоеЗначение = Новый Структура;
	ВозвращаемоеЗначение.Вставить("Организация");
	ВозвращаемоеЗначение.Вставить("Сообщение");
	ВозвращаемоеЗначение.Вставить("ТипСообщения");
	ВозвращаемоеЗначение.Вставить("ВладелецФайла");
	ВозвращаемоеЗначение.Вставить("Операция");
	ВозвращаемоеЗначение.Вставить("СтатусОбработки");
	
	ЗаполнитьЗначенияСвойств(ВозвращаемоеЗначение, Выборка);
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Возвращает выборку последних сообщений протокола обмена, обработанных с ошибкой,
//   по документу. Если такого сообщения нет, возвращает Неопределено.
//
// Параметры:
//   ДокументСсылка         - ОпределяемыйТип.ДокументыИСМП - документ для получения описания
//   ТипПоследнегоСообщения - Строка                        - тип сообщения из фиксированного списка
// Возвращаемое значение:
//   ВыборкаИзРезультатаЗапроса - элементы коллекции:
//   * ВладелецФайла - ОпределяемыйТип.ДокументыИСМП            - владелец файла
//   * Операция      - ПеречислениеСсылка.ВидыОперацийИСМП      - операция обмена
//   * ТипСообщения  - ПеречислениеСсылка.ТипыЗапросовИС        - тип сообщения (исходящий, входящий)
//   * Сообщение     - СправочникСсылка.ИСМППрисоединенныеФайлы - ссылка на сообщение
//                   - Неопределено - сообщение не найдено
//
Функция ПоследниеСообщенияСОшибкой(ДокументСсылка, ТипПоследнегоСообщения = "Передано") Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИСМППрисоединенныеФайлы.Версия   КАК Версия,
	|	ИСМППрисоединенныеФайлы.Документ КАК Документ,
	|	ИСМППрисоединенныеФайлы.Операция КАК Операция
	|ПОМЕСТИТЬ ИСМППрисоединенныеФайлыВерсии
	|ИЗ
	|	Справочник.ИСМППрисоединенныеФайлы КАК ИСМППрисоединенныеФайлы
	|ГДЕ
	|	ИСМППрисоединенныеФайлы.Документ = &Документ
	|	И ВЫБОР
	|	КОГДА ВЫРАЗИТЬ(ИСМППрисоединенныеФайлы.Описание КАК Строка(255)) = """"
	|		ТОГДА ЛОЖЬ
	|	ИНАЧЕ ИСТИНА
	|	КОНЕЦ
	|УПОРЯДОЧИТЬ ПО
	|	ИСМППрисоединенныеФайлы.ДатаСоздания УБЫВ,
	|	ВЫБОР
	|		КОГДА ИСМППрисоединенныеФайлы.ТипСообщения = ЗНАЧЕНИЕ(Перечисление.ТипыЗапросовИС.Исходящий) ТОГДА
	|			0
	|		ИНАЧЕ
	|			1
	|	КОНЕЦ УБЫВ
	|;
	|
	|//////////////////////////////////
	|ВЫБРАТЬ
	|	ИСМППрисоединенныеФайлы.Ссылка               КАК Сообщение,
	|	ИСМППрисоединенныеФайлы.ТипСообщения         КАК ТипСообщения,
	|	ИСМППрисоединенныеФайлы.Документ.Организация КАК Организация,
	|	ИСМППрисоединенныеФайлы.СтатусОбработки      КАК СтатусОбработки,
	|	ИСМППрисоединенныеФайлы.ВладелецФайла        КАК ВладелецФайла,
	|	ИСМППрисоединенныеФайлы.Операция             КАК Операция
	|ИЗ
	|	ИСМППрисоединенныеФайлыВерсии КАК ИСМППрисоединенныеФайлыВерсии
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ИСМППрисоединенныеФайлы КАК ИСМППрисоединенныеФайлы
	|		ПО ИСМППрисоединенныеФайлыВерсии.Документ = ИСМППрисоединенныеФайлы.Документ
	|		И ИСМППрисоединенныеФайлыВерсии.Операция = ИСМППрисоединенныеФайлы.Операция
	|		И ИСМППрисоединенныеФайлыВерсии.Версия = ИСМППрисоединенныеФайлы.Версия
	|ГДЕ
	|	ВЫБОР
	|	КОГДА ВЫРАЗИТЬ(ИСМППрисоединенныеФайлы.Описание КАК Строка(255)) = """"
	|		ТОГДА ЛОЖЬ
	|	ИНАЧЕ ИСТИНА
	|	КОНЕЦ
	|УПОРЯДОЧИТЬ ПО
	|	ИСМППрисоединенныеФайлы.ДатаСоздания УБЫВ,
	|	ВЫБОР
	|		КОГДА ИСМППрисоединенныеФайлы.ТипСообщения = ЗНАЧЕНИЕ(Перечисление.ТипыЗапросовИС.Исходящий) ТОГДА
	|			0
	|		ИНАЧЕ
	|			1
	|	КОНЕЦ УБЫВ
	|");
	
	Запрос.УстановитьПараметр("Документ", ДокументСсылка);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат Результат.Выбрать();
	
КонецФункции

// Возвращает текст последней ошибки из протокола обмена
//
// Параметры:
//  ДокументСсылка - ДокументСсылка - документ, по которому требуется показать ошибку обмена
//
// Возвращаемое значение:
//  Строка - текст ошибки обмена.
//
Функция ТекстОшибкиИзПротокола(ДокументСсылка) Экспорт
	
	ДанныеПоследнегоСообщения = ПоследниеСообщенияСОшибкой(ДокументСсылка);
	Если ДанныеПоследнегоСообщения = Неопределено Тогда
		Возврат "";
	КонецЕсли;
	
	МассивОшибок = Новый Массив;
	Пока ДанныеПоследнегоСообщения.Следующий() Цикл
		МассивОшибок.Добавить(ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДанныеПоследнегоСообщения.Сообщение, "Описание"));
	КонецЦикла;
	
	Возврат СтрСоединить(МассивОшибок, Символы.ПС);
	
КонецФункции

#КонецОбласти

#КонецЕсли
