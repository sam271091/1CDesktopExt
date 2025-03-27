
&НаСервере
Процедура Декорация1НажатиеНаСервере(СписокОбъектов)
	
	
	СписокСправочники = Метаданные.Справочники;
	
	СписокДокументы = Метаданные.Документы;
	
	СписокОбработки = Метаданные.Обработки;
	
	СписокОчеты = Метаданные.Отчеты;
	
	Для Каждого Стр из СписокСправочники Цикл 
		Объектдоступен = ПравоДоступа("Просмотр",Стр);
				
		Если Объектдоступен Тогда 
			СтруктураДанных = Новый Структура;
			СтруктураДанных.Вставить("ИмяОбъекта",Стр.Имя);
			СтруктураДанных.Вставить("Видобъекта","Справочник");
			ЗначениеСписка = Сериализовать(СтруктураДанных);
			СписокОбъектов.Добавить(ЗначениеСписка,Стр.Синоним);
		КонецЕсли;
	КонецЦикла;	
	
	Для Каждого Стр из СписокДокументы Цикл 
		Объектдоступен = ПравоДоступа("Просмотр",Стр);
		Если Объектдоступен Тогда 
			СтруктураДанных = Новый Структура;
			СтруктураДанных.Вставить("ИмяОбъекта",Стр.Имя);
			СтруктураДанных.Вставить("Видобъекта","Документ");
			ЗначениеСписка = Сериализовать(СтруктураДанных);
			СписокОбъектов.Добавить(ЗначениеСписка,Стр.Синоним);
		КонецЕсли;
	КонецЦикла;	
	
	
	Для Каждого Стр из СписокОбработки Цикл 
		Объектдоступен = ПравоДоступа("Просмотр",Стр);
		Если Объектдоступен Тогда 
			СтруктураДанных = Новый Структура;
			СтруктураДанных.Вставить("ИмяОбъекта",Стр.Имя);
			СтруктураДанных.Вставить("Видобъекта","Обработка");
			ЗначениеСписка = Сериализовать(СтруктураДанных);
			СписокОбъектов.Добавить(ЗначениеСписка,Стр.Синоним);
		КонецЕсли;
	КонецЦикла;	
	
	Для Каждого Стр из СписокОчеты Цикл 
		Объектдоступен = ПравоДоступа("Просмотр",Стр);
		Если Объектдоступен Тогда 
			СтруктураДанных = Новый Структура;
			СтруктураДанных.Вставить("ИмяОбъекта",Стр.Имя);
			СтруктураДанных.Вставить("Видобъекта","Отчет");
			ЗначениеСписка = Сериализовать(СтруктураДанных);
			СписокОбъектов.Добавить(ЗначениеСписка,Стр.Синоним);
		КонецЕсли;
	КонецЦикла;	
	
	
КонецПроцедуры


&НаСервере
Функция Сериализовать(ОбъектСериализации) 
	ДеревоВОбъектеXDTO = СериализаторXDTO.ЗаписатьXDTO(ОбъектСериализации);
	МойXML = Новый ЗаписьXML;
	МойXML.УстановитьСтроку();
	ПараметрыЗаписиXML = Новый ПараметрыЗаписиXML("UTF-8", "1.0", Ложь); 
	ФабрикаXDTO.ЗаписатьXML(МойXML, ДеревоВОбъектеXDTO);
	Возврат МойXML.Закрыть();
КонецФункции

&НаСервере
Функция Десериализовать(XMLСтруктураСериализованногоОбъекта) 
	ЧтениеXMLДанных = Новый ЧтениеXML;
	ЧтениеXMLДанных.УстановитьСтроку(XMLСтруктураСериализованногоОбъекта);
	ТЗ = СериализаторXDTO.ПрочитатьXML(ЧтениеXMLДанных);
	ЧтениеXMLДанных.Закрыть();  
	Возврат ТЗ;
КонецФункции




&НаКлиенте
Процедура Декорация1Нажатие(Элемент)
	ОткрытьФорму("Обработка.РабочийСтол.Форма.ФормаВыбораОбъекта");
	Возврат;
	СписокОбъектов = Новый СписокЗначений;
	Декорация1НажатиеНаСервере(СписокОбъектов);
	
	
	Оповещение = Новый ОписаниеОповещения("ПослеВыбораЭлемента", ЭтаФорма);
    СписокОбъектов.ПоказатьВыборЭлемента(Оповещение, "Выберите объект.");

		
КонецПроцедуры


&НаКлиенте
Процедура ПослеВыбораЭлемента(ВыбранныйЭлемент, СписокПараметров) Экспорт
    Если ВыбранныйЭлемент = Неопределено Тогда
		//Сообщить("Объект не выбран.");
    Иначе        		
		ЗначениеСписка = ПолучитьСтруктураДанных(ВыбранныйЭлемент.Значение);

		
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("ОбъектМетаданных",ЗначениеСписка.ИмяОбъекта);
		МассивСтрок = ТаблицаОбъектов.НайтиСтроки(СтруктураПоиска);
		Если МассивСтрок.Количество() = 0 Тогда 
					
		СтрокаТаблицаОбъектов = ТаблицаОбъектов.Добавить();
		СтрокаТаблицаОбъектов.ОбъектМетаданных = ЗначениеСписка.ИмяОбъекта;
		СтрокаТаблицаОбъектов.ВидОбъекта = ЗначениеСписка.Видобъекта;
		СтрокаТаблицаОбъектов.ПредставлениеОбъекта = ВыбранныйЭлемент.Представление;
		НомерИндекса = ТаблицаОбъектов.Индекс(СтрокаТаблицаОбъектов);
		СоздатьЭлементыФормы(СтрокаТаблицаОбъектов.ОбъектМетаданных,СтрокаТаблицаОбъектов.ПредставлениеОбъекта,НомерИндекса+1);
		КонецЕсли;
    КонецЕсли;
КонецПроцедуры


&НаСервере
Функция ПолучитьСтруктураДанных(Значение)
	Возврат  Десериализовать(Значение)
КонецФункции	

&НаСервере
Процедура УдалитьЭлементФормы(ИмяОбъект) Экспорт 
	   ИмяРекв = "Декорация_" + ИмяОбъект;
       ИмяГруппы = "гр_" + ИмяОбъект;
	   
	   Группа = Элементы.Найти(ИмяГруппы);
	   
	   РодительГруппы = Группа.Родитель;
	   
	   Элементы.Удалить(Элементы.Найти(ИмяРекв));
	   Элементы.Удалить(Группа);
	   
	   Если РодительГруппы.ПодчиненныеЭлементы.Количество() = 0 Тогда 
		   Элементы.Удалить(РодительГруппы);
	   КонецЕсли;   
	   
	   
КонецПроцедуры	


&НаСервере
Процедура СоздатьЭлементыФормы(ИмяОбъект,ПредставлениеОбъекта,НомерСтроки)
	ИмяРекв = "Декорация_" + ИмяОбъект;
	
	ПереноситьСтроки =(НомерСтроки%4)=0;
	
	Если ПереноситьСтроки Тогда 
		
		ИмяГруппы = "группаПанель_" + НомерСтроки;
		Если Элементы.Найти(ИмяГруппы) = Неопределено Тогда
			Группа = Элементы.Добавить(ИмяГруппы, Тип("ГруппаФормы"),ЭтаФорма);
			Группа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
			Группа.ГоризонтальноеПоложениеВГруппе = ГоризонтальноеПоложениеЭлемента.Лево;
			
			ТекИмяГруппы = ИмяГруппы;
		КонецЕсли;	
	Иначе 
		//ТекИмяГруппы = "ГруппаПанель1";
	КонецЕсли;
	
	
	ИмяГруппы = "гр_" + ИмяОбъект;
    Если Элементы.Найти(ИмяГруппы) = Неопределено Тогда
        Группа = Элементы.Добавить(ИмяГруппы, Тип("ГруппаФормы"), Элементы[ТекИмяГруппы]);
		Группа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		Группа.ЦветФона = WebЦвета.Аквамарин;
		Группа.Ширина = 18;
		Группа.Высота = 8;
		Группа.Объединенная = Истина;
		Группа.РастягиватьПоГоризонтали = Ложь;
		
		СлучайноеЧисло = Новый ГенераторСлучайныхЧисел(0);
		ИндексЦвета = СлучайноеЧисло.СлучайноеЧисло(0,ТаблицаЦветов.Количество()-1);
		
		СтрокаЦветов = ТаблицаЦветов.Получить(ИндексЦвета);
		Группа.ЦветФона = СтрокаЦветов.Цвет;
		
		
		нЭлемент = Элементы.Добавить(ИмяРекв, Тип("ДекорацияФормы"), Группа); 
		нЭлемент.Вид = ВидДекорацииФормы.Надпись;
		нЭлемент.Заголовок = ПредставлениеОбъекта;
		нЭлемент.Гиперссылка = Истина;
		нЭлемент.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента.Центр;
		нЭлемент.ГоризонтальноеПоложениеВГруппе = ГоризонтальноеПоложениеЭлемента.Центр;
		нЭлемент.ВертикальноеПоложение = ВертикальноеПоложениеЭлемента.Центр;
		нЭлемент.ВертикальноеПоложениеВГруппе = ВертикальноеПоложениеЭлемента.Центр;
		
		нЭлемент.УстановитьДействие("Нажатие","ОбработчикНачатияГиперссылки");
    КонецЕсли;
        
	
КонецПроцедуры	

&НаКлиенте
Процедура ОбработчикНачатияГиперссылки(Элемент)  
    НаименованиеОбъекта = СтрЗаменить(Элемент.Имя,"Декорация_","");
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("ОбъектМетаданных",НаименованиеОбъекта);
	
	МассивСтрок = ТаблицаОбъектов.НайтиСтроки(СтруктураПоиска);
	
	Для Каждого Стр Из МассивСтрок Цикл 
		Если Стр.ВидОбъекта = "Обработка" ИЛИ Стр.ВидОбъекта = "Отчет" Тогда 
		    ОткрытьФорму(Стр.ВидОбъекта + "." + Стр.ОбъектМетаданных + ".Форма");		
		Иначе 
			ОткрытьФорму(Стр.ВидОбъекта + "." + Стр.ОбъектМетаданных + ".ФормаСписка");		
		КонецЕсли;
	КонецЦикла;	
   
КонецПроцедуры 




&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ТекущийПользователь =  Пользователи.ТекущийПользователь();
	ЗаполнитьПоНастройке();
	ТекИмяГруппы = "ГруппаПанель1";
	ЗаполнитьТаблицуЦветов();
КонецПроцедуры



&НаКлиенте
Процедура КомандаСохранитьНастройки(Команда)
	КомандаСохранитьНастройкиНаСервере();
КонецПроцедуры

&НаСервере
Процедура КомандаСохранитьНастройкиНаСервере()
	РегистрыСведений.РБ_НастройкиРабочегоСтола.ЗаписатьНастройкиРабочегоСтола(ТекущийПользователь, Новый ХранилищеЗначения(ТаблицаОбъектов.Выгрузить()));
КонецПроцедуры



&НаСервере
Процедура ЗаполнитьПоНастройке()
	Настройка = РегистрыСведений.РБ_НастройкиРабочегоСтола.ПолучитьНастройкуРабочегоСтола(ТекущийПользователь).Получить();
	Если Настройка <> Неопределено  Тогда
		ТаблицаОбъектов.Загрузить(Настройка);
	КонецЕсли;
	
КонецПроцедуры


&НаСервере
Процедура ЗаполнитьТаблицуЦветов()
	
	МассивЦветов = Новый Массив;
	МассивЦветов.Добавить(WebЦвета.Роса);
	МассивЦветов.Добавить(WebЦвета.ГолубойСКраснымОттенком);
	МассивЦветов.Добавить(WebЦвета.СеребристоСерый);
	МассивЦветов.Добавить(WebЦвета.ТопленоеМолоко);
	МассивЦветов.Добавить(WebЦвета.Лимонный);
	МассивЦветов.Добавить(Новый Цвет(204, 195, 255));
	МассивЦветов.Добавить(Новый Цвет(177, 255, 177));
	МассивЦветов.Добавить(WebЦвета.ЦианСветлый);
	МассивЦветов.Добавить(WebЦвета.ТусклоРозовый);
	МассивЦветов.Добавить(WebЦвета.БледноЛиловый);
	МассивЦветов.Добавить(Новый Цвет(218, 246, 250));
	МассивЦветов.Добавить(Новый Цвет(244, 236, 197));
	
	
	Для Каждого Цвет Из МассивЦветов Цикл 
		СтрокаЦветов = ТаблицаЦветов.Добавить();
		СтрокаЦветов.Цвет = Цвет;		
	КонецЦикла;	
	
КонецПроцедуры	

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Для Каждого СтрокаТаблицаОбъектов Из ТаблицаОбъектов Цикл 
		НомерИндекса = ТаблицаОбъектов.Индекс(СтрокаТаблицаОбъектов);
		СоздатьЭлементыФормы(СтрокаТаблицаОбъектов.ОбъектМетаданных,СтрокаТаблицаОбъектов.ПредставлениеОбъекта,НомерИндекса+1);
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНастройки(Команда)
	Структура = Новый Структура;
	Структура.Вставить("ТаблицаОбъектов",ТаблицаОбъектов);
	ОткрытьФорму("Обработка.РабочийСтол.Форма.ФормаНастройки",Структура);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "ОбновитьИнтерфейс" Тогда 
		Для Каждого Стр Из ТаблицаОбъектов Цикл 
			УдалитьЭлементФормы(Стр.ОбъектМетаданных);
		КонецЦикла;	
		
		ТекИмяГруппы = "ГруппаПанель1";
		
		ТаблицаОбъектов.Очистить();
		Для Каждого СтрокаТаблицаОбъектов Из Параметр Цикл 
			СтрокаТаблицы = ТаблицаОбъектов.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТаблицы,СтрокаТаблицаОбъектов);
			НомерИндекса = Параметр.Индекс(СтрокаТаблицаОбъектов);
			
			СоздатьЭлементыФормы(СтрокаТаблицаОбъектов.ОбъектМетаданных,СтрокаТаблицаОбъектов.ПредставлениеОбъекта,НомерИндекса+1);
		КонецЦикла;	
	ИначеЕсли ИмяСобытия = "ВыборОбъекта" Тогда 
		ЗначениеСписка = Параметр;//ПолучитьСтруктураДанных(ВыбранныйЭлемент.Значение);

		
		
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("ОбъектМетаданных",ЗначениеСписка.ИмяОбъекта);
		МассивСтрок = ТаблицаОбъектов.НайтиСтроки(СтруктураПоиска);
		Если МассивСтрок.Количество() = 0 Тогда 
					
		СтрокаТаблицаОбъектов = ТаблицаОбъектов.Добавить();
		СтрокаТаблицаОбъектов.ОбъектМетаданных = ЗначениеСписка.ИмяОбъекта;
		СтрокаТаблицаОбъектов.ВидОбъекта = ЗначениеСписка.Видобъекта;
		СтрокаТаблицаОбъектов.ПредставлениеОбъекта = ЗначениеСписка.Представление;
		НомерИндекса = ТаблицаОбъектов.Индекс(СтрокаТаблицаОбъектов);
		СоздатьЭлементыФормы(СтрокаТаблицаОбъектов.ОбъектМетаданных,СтрокаТаблицаОбъектов.ПредставлениеОбъекта,НомерИндекса+1);
	КонецЕсли;	
	КонецЕсли;
КонецПроцедуры
