﻿
#Область СлужебныйПрограммныйИнтерфейс

// Добавляет в список поставляемые драйверы в составе конфигурации.
// 
// Параметры:
//  ДрайвераОборудования - см. МенеджерОборудования.НоваяТаблицаПоставляемыхДрайверовОборудования
//
Процедура ОбновитьПоставляемыеДрайвера(ДрайвераОборудования) Экспорт
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверCASЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'CAS:Электронные весы'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "CasCentreSimpleScale"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверCASЭлектронныеВесы2х";
	Драйвер.Наименование = НСтр("ru = 'CAS:Электронные весы 2.х'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "CAS_Scale_nLP"; 
	Драйвер.ВерсияДрайвера = "2.14"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверАТОЛЭлектронныеВесы8X";
	Драйвер.Наименование = НСтр("ru = 'АТОЛ:Электронные весы 8.Х'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "ATOL_Scale_1CInt"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверМассаКЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'Масса-К:Электронные весы'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "MassaKDriverR1C"; 
	Драйвер.ИмяМакетаДрайвера = "ДрайверМассаКЭлектронныеВесыИСПечатьюЭтикеток";
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверШтрихМЭлектронныеВесыPOS2";
	Драйвер.Наименование = НСтр("ru = 'ШТРИХ-М:Электронные весы POS2'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "DrvSM1C"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверСервисПлюсЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'Сервис-Плюс:Электронные весы'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "Cw100Driver"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверМАСЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'МАС:Электронные весы'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "ScaleMAS"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "Драйвер1СЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = '1С:Электронные весы (Native Api)'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "CheckoutScales"; 
	Драйвер.ВерсияДрайвера = "1.2.8.4";     
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверМертехЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'Мертех:Электронные весы'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "ScalePos2M";
	Драйвер.ВерсияДрайвера = "1.1.30001";     
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверНАИСЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'НАИС:Весовые терминалы ВТ'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "naisTerminals";
	Драйвер.ВерсияДрайвера = "1.4";
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверCASВесыСПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'CAS:Весы с печатью этикеток'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "CasCentrePrintingScale"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверCASВесыСПечатьюЭтикеток2х";
	Драйвер.Наименование = НСтр("ru = 'CAS:Весы с печатью этикеток 2.х'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "CAS_ScaleLP"; 
	Драйвер.ВерсияДрайвера = "2.19"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверМассаКВесыСПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'Масса-К:Весы с печатью этикеток'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "MassaKDriverR1C"; 
	Драйвер.ИмяМакетаДрайвера = "ДрайверМассаКЭлектронныеВесыИСПечатьюЭтикеток";
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверАТОЛВесыСПечатьюЭтикеток8X";
	Драйвер.Наименование = НСтр("ru = 'АТОЛ:Весы c печатью этикеток 8.X'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "ATOL_ScaleLP_1CInt"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверРБСВесыCПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'РБС:Весы c печатью этикеток KS'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "Rbs1CDriver";     
	Драйвер.ВерсияДрайвера = "3.0.2";
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверШтрихМВесыСПечатьюЭтикетокШтрихПринт";
	Драйвер.Наименование = НСтр("ru = 'ШТРИХ-М:Весы с печатью этикеток ШТРИХ-ПРИНТ'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "DrvLP1C";     
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверШтрихМВесыСПечатьюЭтикетокШтрихПринтNG";
	Драйвер.Наименование = НСтр("ru = 'ШТРИХ-М:Весы с печатью этикеток ШТРИХ-ПРИНТ NG'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "ShtrihPrint_drv_ng_V1";      
	Драйвер.ВерсияДрайвера = "1.0.0.2";
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверBizerbaВесыСПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'Bizerba:Драйвер весов с печатью этикеток'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "BizerbaNative"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверСервисПлюсВесыСПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'Сервис-Плюс:Весы с печатью этикеток'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "Sm320Driver"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверМертехВесыСПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'Мертех:Весы с печатью этикеток'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "Mertech";      
	Драйвер.ВерсияДрайвера = "1.2.00002";
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверРБСВесыCПечатьюЭтикетокVenus";
	Драйвер.Наименование = НСтр("ru = 'РБС:Весы c печатью этикеток Venus'", ОбщегоНазначения.КодОсновногоЯзыка());
	Драйвер.ИдентификаторОбъекта = "Rbs1cVenusDriver";      
	Драйвер.ВерсияДрайвера = "3.0.2";  

КонецПроцедуры

#КонецОбласти