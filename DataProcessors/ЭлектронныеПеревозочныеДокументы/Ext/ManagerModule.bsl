﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Запрос по документу основания.
// 
// Возвращаемое значение:
//  Строка - Запрос по документу основания
Функция ЗапросПоДокументуОснования() Экспорт
	
	ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ЭлектроннаяСопроводительнаяВедомостьДокументыОснования.Ссылка КАК Ссылка
		|ПОМЕСТИТЬ ВТОснования
		|ИЗ
		|	Документ.ЭлектроннаяСопроводительнаяВедомость.ДокументыОснования КАК
		|		ЭлектроннаяСопроводительнаяВедомостьДокументыОснования
		|ГДЕ
		|	ЭлектроннаяСопроводительнаяВедомостьДокументыОснования.ДокументОснование В (&ДокументОснование)
		|СГРУППИРОВАТЬ ПО
		|	ЭлектроннаяСопроводительнаяВедомостьДокументыОснования.Ссылка
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ЭлектроннаяТранспортнаяНакладнаяДокументыОснования.Ссылка
		|ИЗ
		|	Документ.ЭлектроннаяТранспортнаяНакладная.ДокументыОснования КАК ЭлектроннаяТранспортнаяНакладнаяДокументыОснования
		|ГДЕ
		|	ЭлектроннаяТранспортнаяНакладнаяДокументыОснования.ДокументОснование В (&ДокументОснование)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ЭлектронныйЗаказНарядДокументыОснования.Ссылка
		|ИЗ
		|	Документ.ЭлектронныйЗаказНаряд.ДокументыОснования КАК ЭлектронныйЗаказНарядДокументыОснования
		|ГДЕ
		|	ЭлектронныйЗаказНарядДокументыОснования.ДокументОснование В (&ДокументОснование)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ТИПЗНАЧЕНИЯ(РеестрЭПДПереопределяемый.Ссылка) КАК ТипСсылки,
		|	РеестрЭПДПереопределяемый.НомерДокументаИБ КАК НомерДокументаИБ,
		|	РеестрЭПДПереопределяемый.ДатаЭПД КАК ДатаЭПД,
		|	РеестрЭПДПереопределяемый.ДатаДокументаИБ КАК ДатаСоздания,
		|	РеестрЭПДПереопределяемый.Организация КАК Организация,
		|	РеестрЭПДПереопределяемый.Грузоотправитель КАК Грузоотправитель,
		|	РеестрЭПДПереопределяемый.Грузополучатель КАК Грузополучатель,
		|	РеестрЭПДПереопределяемый.Перевозчик КАК Перевозчик,
		|	РеестрЭПДПереопределяемый.ТекущийШаг КАК ТекущийШаг,
		|	РеестрЭПДПереопределяемый.ТекущийШагВыполнен КАК ТекущийШагВыполнен,
		|	РеестрЭПДПереопределяемый.Комментарий КАК Комментарий,
		|	РеестрЭПДПереопределяемый.Ссылка КАК Ссылка,
		|	СостоянияЭДПереопределяемый.СостояниеЭДО,
		|	СостоянияЭДПереопределяемый.ПредставлениеСостояния,
		|	РеестрЭПДПереопределяемый.Проведен,
		|	РеестрЭПДПереопределяемый.ПометкаУдаления,
		|	ВЫБОР
		|		КОГДА РеестрЭПДПереопределяемый.ПометкаУдаления
		|			ТОГДА 1
		|		ИНАЧЕ 0
		|	КОНЕЦ КАК НестандартнаяКартинка,
		|	ВЫРАЗИТЬ("""" КАК СТРОКА(500)) КАК ДокументОснование
		|ИЗ
		|	ВТОснования КАК ВТОснования
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.РеестрЭПД КАК РеестрЭПДПереопределяемый
		|		ПО ВТОснования.Ссылка = РеестрЭПДПереопределяемый.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СостоянияПоОбъектамУчетаЭДО КАК СостоянияЭДПереопределяемый
		|		ПО (СостоянияЭДПереопределяемый.СсылкаНаОбъект = РеестрЭПДПереопределяемый.Ссылка)
		|{ГДЕ
		|	(РеестрЭПДПереопределяемый.ДатаЭПД >= &НачалоПериода
		|	ИЛИ &НачалоПериода = ДАТАВРЕМЯ(1, 1, 1))
		|	И (РеестрЭПДПереопределяемый.ДатаЭПД <= &КонецПериода
		|	ИЛИ &КонецПериода = ДАТАВРЕМЯ(1, 1, 1))}";

	Возврат ТекстЗапроса;

КонецФункции

#КонецОбласти

#КонецЕсли
