﻿
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗамерыПроизводительности(Команда)
	
	АдресФайла = ПолучитьАдресФайлаНаСервере();
	Заголовок = НСтр("ru = 'Сохранение файла'");
		
	ИмяФайла = НСтр("ru = 'Замеры производительности.zip'", ОбщегоНазначенияКлиент.КодОсновногоЯзыка());
		
	ПараметрыДиалога = Новый ПараметрыДиалогаПолученияФайлов(Заголовок, Истина);
	НачатьПолучениеФайлаССервера(АдресФайла, ИмяФайла, ПараметрыДиалога);

КонецПроцедуры

&НаСервере
Функция ПолучитьАдресФайлаНаСервере()
	
	ДвоичныеДанные = РеквизитФормыВЗначение("Объект").ЗамерыПроизводительности.Получить();	
	Адрес = ПоместитьВоВременноеХранилище(ДвоичныеДанные);
	
	Возврат Адрес;
	
КонецФункции

#КонецОбласти
