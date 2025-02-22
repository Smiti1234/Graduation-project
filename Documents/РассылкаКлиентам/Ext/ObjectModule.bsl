﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если ПредназначенаДляSMS Тогда
		
		ТипТекстаПисьма =  Неопределено;
		ТекстПисьма     = "";
		ТекстПисьмаHTML = ""; 
		
	Иначе
		
		ТекстSMS = "";
		ОтправлятьВТранслите = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	Если ПредназначенаДляЭлектронныхПисем Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("ТекстSMS");
		
		Если ТипТекстаПисьма = Перечисления.СпособыРедактированияЭлектронныхПисем.HTML Тогда
			
			МассивНепроверяемыхРеквизитов.Добавить("ТекстПисьма");
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если ПредназначенаДляSMS Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("ТипТекстаПисьма");
		МассивНепроверяемыхРеквизитов.Добавить("ТекстПисьма");
		
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты,МассивНепроверяемыхРеквизитов);
	
	Если ДатаАктуальности <> Дата(1, 1, 1) 
		И (Статус = Перечисления.СтатусыРассылокКлиентам.Черновик ИЛИ Статус = Перечисления.СтатусыРассылокКлиентам.КОтправке) Тогда
		
		Если ДатаАктуальности < ТекущаяДатаСеанса() Тогда
			
			ТекстСообщения= НСтр("ru = 'Указанная дата актуальности меньше текущей даты, сообщения никогда не будут отправлены.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "ДатаАктуальности",,Отказ);
			
		КонецЕсли;
		
		Если ДатаАктуальности < ДатаРассылки Тогда
			
			ТекстСообщения= НСтр("ru = 'Указанная дата актуальности меньше даты рассылки, сообщения никогда не будут отправлены.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "ДатаАктуальности",,Отказ);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Для каждого ДополнительныйПолучатель Из ДополнительныеПолучатели Цикл
	
		Если ПустаяСтрока(ДополнительныйПолучатель.КонтактнаяИнформация) Тогда
			Продолжить;
		КонецЕсли;
		
		НомерСтроки = ДополнительныйПолучатель.НомерСтроки;
		
		ПутьКТабличнойЧасти = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Объект.ДополнительныеПолучатели",
		                                                                       ДополнительныйПолучатель.НомерСтроки,
		                                                                      "КонтактнаяИнформация");
		
		Если ПредназначенаДляSMS Тогда
		
			Если СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ДополнительныйПолучатель.КонтактнаяИнформация, ";", Истина).Количество() > 1 Тогда
			
				ТекстСообщения = НСтр("ru = 'В строке %1 указан более чем один номер телефона.'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ВставитьПараметрыВСтроку(ТекстСообщения, НомерСтроки);
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				       ТекстСообщения,
				       ,
				      ПутьКТабличнойЧасти,
				      ,
				      Отказ);
				Продолжить;
				
			КонецЕсли;
			
			ТекстСообщения = НСтр("ru = 'Номер телефона в строке %1 должен быть указан в формате ""+xx (xxx) xxxxxxx"".'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, НомерСтроки);
			
			Если Не Взаимодействия.КорректноВведенНомерТелефона(ДополнительныйПолучатель.КонтактнаяИнформация) Тогда
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				      ТекстСообщения,
				      ,
				      ПутьКТабличнойЧасти,
				      ,
				      Отказ);
				
			КонецЕсли;
			
		Иначе
			
			МассивАдресов = ОбщегоНазначенияКлиентСервер.АдресаЭлектроннойПочтыИзСтроки(ДополнительныйПолучатель.КонтактнаяИнформация);
			
			Если МассивАдресов.Количество() > 1 Тогда
				
				ТекстСообщения = НСтр("ru = 'В строке %1 указан более чем один адрес электронной почты.'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, НомерСтроки);
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				       ТекстСообщения,
				       ,
				       ПутьКТабличнойЧасти,
				       ,
				       Отказ);
				Продолжить;
				
			КонецЕсли;
			
			Если МассивАдресов.Количество() = 1 И Не ПустаяСтрока(МассивАдресов[0].ОписаниеОшибки) Тогда
				
				ТекстСообщения = НСтр("ru = 'Ошибка в строке %1. %2'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, НомерСтроки, МассивАдресов[0].ОписаниеОшибки);
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
					ТекстСообщения,
					,
					ПутьКТабличнойЧасти,
					,
					Отказ);
				
			КонецЕсли;
			
		КонецЕсли;
	
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.МаркетинговыеМероприятия") Тогда
		
		Основание = ДанныеЗаполнения;
		
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.НазначениеОпросов") Тогда
		
		Основание = ДанныеЗаполнения;
		
		РеквизитыОпроса = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ДанныеЗаполнения, "Наименование, Дата, ДатаНачала, ДатаОкончания, ТипРеспондентов");
		
		Если РеквизитыОпроса.ТипРеспондентов = Справочники.Пользователи.ПустаяСсылка() Тогда
			ВызватьИсключение НСтр("ru = 'Рассылку клиентам нельзя создать на основании опроса, проводимого среди пользователей.'")
		КонецЕсли;
		
		РеквизитыОпроса = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ДанныеЗаполнения, "Наименование, Дата, ДатаНачала, ДатаОкончания");
		Тема      = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Рассылка по опросу ""%1"" от %2.'"),
		                                                                    РеквизитыОпроса.Наименование, РеквизитыОпроса.Дата);
		
		ДатаРассылки     = ?(ЗначениеЗаполнено(РеквизитыОпроса.ДатаНачала), НачалоДня(РеквизитыОпроса.ДатаНачала), Дата(1, 1, 1));
		ДатаАктуальности = ?(ЗначениеЗаполнено(РеквизитыОпроса.ДатаОкончания), КонецДня(РеквизитыОпроса.ДатаОкончания), Дата(1, 1, 1));
		
	КонецЕсли;
	
	Ответственный = Пользователи.ТекущийПользователь();
	ДатаРассылки  = ?(ДатаРассылки = Дата(1, 1, 1), ТекущаяДатаСеанса(), ДатаРассылки);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Устанавливает статус для объекта документа
//
// Параметры:
//	НовыйСтатус - Строка - Имя статуса, который будет установлен у заказов
//	ДополнительныеПараметры - Структура - Структура дополнительных параметров установки статуса.
//
// Возвращаемое значение:
//	Булево - Истина, в случае успешной установки нового статуса.
//
Функция УстановитьСтатус(НовыйСтатус, ДополнительныеПараметры) Экспорт
	
	Статус = Перечисления.СтатусыРассылокКлиентам[НовыйСтатус];
	
	Возврат ПроверитьЗаполнение();
	
КонецФункции

Процедура ПриКопировании(ОбъектКопирования)
	
	Статус = Перечисления.СтатусыРассылокКлиентам.Черновик;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
