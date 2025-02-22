﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	НастройкиУчета = КоммерческиеПредложенияДокументы.НастройкиУчета();
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	Если Не НастройкиУчета.ИспользуютсяПартнеры Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Клиент");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(МассивНепроверяемыхРеквизитов) Тогда
		ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Автор) И ЭтоНовый() Тогда
		Автор = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
