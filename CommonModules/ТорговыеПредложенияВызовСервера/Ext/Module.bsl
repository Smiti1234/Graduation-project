﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Торговые предложения".
// ОбщийМодуль.ТорговыеПредложенияВызовСервера.
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

#Область СервисРекомендаций

Функция ОтразитьОткликНаРекомендацию(Организация, УникальныйИдентификатор, АдресРесурса) Экспорт
	
	Результат = ТорговыеПредложенияСлужебный.ОтразитьОткликНаРекомендациюАсинхронно(
		Организация, УникальныйИдентификатор, АдресРесурса);
		
	Возврат Результат;	
	
КонецФункции

Функция ДеактивироватьРекомендацию(Организация, УникальныйИдентификатор, АдресРесурса) Экспорт
	
	Результат = ТорговыеПредложенияСлужебный.ДеактивироватьРекомендациюАсинхронно(
		Организация, УникальныйИдентификатор, АдресРесурса);
		
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область РаботаСКорзиной

// Выполнить действие с товаром корзины в фоне.
// 
// Параметры:
//  ПараметрыМетода - Структура
//  УникальныйИдентификатор - Строка
// 
// Возвращаемое значение:
//  см. ДлительныеОперации.ВыполнитьВФоне
//
Функция ВыполнитьДействиеСТоваромКорзиныВФоне(ПараметрыМетода, УникальныйИдентификатор) Экспорт
	
	ДлительнаяОперация = ТорговыеПредложенияСлужебный.ВыполнитьДействиеСТоваромКорзиныВФоне(ПараметрыМетода, УникальныйИдентификатор);
	
	Возврат ДлительнаяОперация;
	
КонецФункции

Функция УдалитьКорзинуВФоне(ПараметрыМетода, УникальныйИдентификатор) Экспорт
	
	Результат = ТорговыеПредложенияСлужебный.УдалитьКорзинуВФоне(ПараметрыМетода, УникальныйИдентификатор);
	
	Возврат Результат;
	
КонецФункции

// Создать корзину добавить товар в фоне.
// 
// Параметры:
//  Организация - ОпределяемыйТип.Организация
//  ДанныеПредложений - см. ТорговыеПредложенияСлужебныйКлиент.НовыйПараметрыПредложения
//  УникальныйИдентификатор - Строка
// 
// Возвращаемое значение:
//  см. ДлительныеОперации.ВыполнитьВФоне
//
Функция СоздатьКорзинуДобавитьТоварВФоне(Организация, ДанныеПредложений, УникальныйИдентификатор) Экспорт
	
	ДлительнаяОперация = ТорговыеПредложенияСлужебный.СоздатьКорзинуДобавитьТоварВФоне(
		Организация, ДанныеПредложений, УникальныйИдентификатор);
	Возврат ДлительнаяОперация;
	
КонецФункции

#КонецОбласти

#Область РаботаСКатегориями

Функция ПолучитьКатегорииТорговыхПредложенийВФоне(УникальныйИдентификатор) Экспорт
	
	Результат = ТорговыеПредложенияСлужебный.ПолучитьКатегорииТорговыхПредложенийВФоне(УникальныйИдентификатор);
	
	Возврат Результат;
	
КонецФункции

// См. ТорговыеПредложенияСлужебный.ПолучитьХарактеристикиКатегорииВФоне
Функция ПолучитьХарактеристикиКатегорииВФоне(Идентификатор, Контрагенты, УникальныйИдентификатор, ИдентификаторЗадания) Экспорт 
	
	Возврат ТорговыеПредложенияСлужебный.ПолучитьХарактеристикиКатегорииВФоне(
		Идентификатор, Контрагенты, УникальныйИдентификатор, ИдентификаторЗадания);
	
КонецФункции

#КонецОбласти

#Область Синхронизация

Функция ОбновитьСтатистикуСинхронизацииВФоне(УникальныйИдентификатор, ПараметрыПроцедуры) Экспорт
	
	НаименованиеЗадания = НСтр("ru = 'Торговые предложения. Обновление статистики синхронизации.'");
	ИмяПроцедуры        = "ТорговыеПредложенияСлужебный.ОбновитьСтатистикуСинхронизации";
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НаименованиеЗадания;
	ПараметрыВыполнения.ОжидатьЗавершение = 0;
	ПараметрыВыполнения.ЗапуститьВФоне = Истина;
	
	Возврат ДлительныеОперации.ВыполнитьВФоне(ИмяПроцедуры, ПараметрыПроцедуры, ПараметрыВыполнения);
	
КонецФункции

Процедура ВыполнитьСинхронизациюТорговыхПредложенийВФоне(ДлительнаяОперация) Экспорт 
	ТорговыеПредложенияСлужебный.ВыполнитьСинхронизациюТорговыхПредложенийВФоне(ДлительнаяОперация);
КонецПроцедуры

Процедура НайтиДлительнуюОперациюСинхронизацииТорговыхПредложений(ДлительнаяОперация) Экспорт
	ТорговыеПредложенияСлужебный.НайтиДлительнуюОперациюСинхронизацииТорговыхПредложений(ДлительнаяОперация);
КонецПроцедуры

#КонецОбласти

// Отменяет фоновое задание публикации, и записывает сведения в РС СостоянияСинхронизацииТорговыеПредложения.
Процедура ОтменитьФоновоеЗадание(ДлительнаяОперация) Экспорт 
	ТорговыеПредложенияСлужебный.ОтменитьФоновоеЗадание(ДлительнаяОперация);
КонецПроцедуры

// См. РегистрыСведений.ТорговыеПредложенияТорговойПлощадки.ПубликуемаяНоменклатураТорговыхПредложений
//
Процедура ПубликуемаяНоменклатураТорговыхПредложений(Номенклатура) Экспорт
	ТорговыеПредложенияСлужебный.ПубликуемаяНоменклатураТорговыхПредложений(Номенклатура);
КонецПроцедуры

#КонецОбласти