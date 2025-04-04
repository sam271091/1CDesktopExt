&НаСервере
Процедура Декорация1НажатиеНаСервере(СписокОбъектов)
	СписокСправочники = Метаданные.Справочники;

	СписокДокументы = Метаданные.Документы;

	СписокОбработки = Метаданные.Обработки;

	СписокОчеты = Метаданные.Отчеты;

	Для Каждого Стр Из СписокСправочники Цикл
		Объектдоступен = ПравоДоступа("Просмотр", Стр);

		Если Объектдоступен Тогда
			СтруктураДанных = Новый Структура;
			СтруктураДанных.Вставить("ИмяОбъекта", Стр.Имя);
			СтруктураДанных.Вставить("Видобъекта", "Справочник");
			ЗначениеСписка = Сериализовать(СтруктураДанных);
			СписокОбъектов.Добавить(ЗначениеСписка, Стр.Синоним);
		КонецЕсли;
	КонецЦикла;

	Для Каждого Стр Из СписокДокументы Цикл
		Объектдоступен = ПравоДоступа("Просмотр", Стр);
		Если Объектдоступен Тогда
			СтруктураДанных = Новый Структура;
			СтруктураДанных.Вставить("ИмяОбъекта", Стр.Имя);
			СтруктураДанных.Вставить("Видобъекта", "Документ");
			ЗначениеСписка = Сериализовать(СтруктураДанных);
			СписокОбъектов.Добавить(ЗначениеСписка, Стр.Синоним);
		КонецЕсли;
	КонецЦикла;
	Для Каждого Стр Из СписокОбработки Цикл
		Объектдоступен = ПравоДоступа("Просмотр", Стр);
		Если Объектдоступен Тогда
			СтруктураДанных = Новый Структура;
			СтруктураДанных.Вставить("ИмяОбъекта", Стр.Имя);
			СтруктураДанных.Вставить("Видобъекта", "Обработка");
			ЗначениеСписка = Сериализовать(СтруктураДанных);
			СписокОбъектов.Добавить(ЗначениеСписка, Стр.Синоним);
		КонецЕсли;
	КонецЦикла;

	Для Каждого Стр Из СписокОчеты Цикл
		Объектдоступен = ПравоДоступа("Просмотр", Стр);
		Если Объектдоступен Тогда
			СтруктураДанных = Новый Структура;
			СтруктураДанных.Вставить("ИмяОбъекта", Стр.Имя);
			СтруктураДанных.Вставить("Видобъекта", "Отчет");
			ЗначениеСписка = Сериализовать(СтруктураДанных);
			СписокОбъектов.Добавить(ЗначениеСписка, Стр.Синоним);
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
	Если ВыбранныйЭлемент <> Неопределено Тогда
		ЗначениеСписка = ПолучитьСтруктураДанных(ВыбранныйЭлемент.Значение);
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("ОбъектМетаданных", ЗначениеСписка.ИмяОбъекта);
		МассивСтрок = ТаблицаОбъектов.НайтиСтроки(СтруктураПоиска);
		Если МассивСтрок.Количество() = 0 Тогда

			СтрокаТаблицаОбъектов = ТаблицаОбъектов.Добавить();
			СтрокаТаблицаОбъектов.ОбъектМетаданных = ЗначениеСписка.ИмяОбъекта;
			СтрокаТаблицаОбъектов.ВидОбъекта = ЗначениеСписка.Видобъекта;
			СтрокаТаблицаОбъектов.ПредставлениеОбъекта = ВыбранныйЭлемент.Представление;
			НомерИндекса = ТаблицаОбъектов.Индекс(СтрокаТаблицаОбъектов);
			СоздатьЭлементыФормы(СтрокаТаблицаОбъектов.ОбъектМетаданных, СтрокаТаблицаОбъектов.ПредставлениеОбъекта,
				НомерИндекса + 1);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры
&НаСервере
Функция ПолучитьСтруктураДанных(Значение)
	Возврат Десериализовать(Значение)
КонецФункции

&НаСервере
Процедура УдалитьЭлементФормы(ИмяОбъект) Экспорт
	ИмяРекв = "Декорация_" + ИмяОбъект;
	ИмяГруппы = "гр_" + ИмяОбъект;
    ИмяКартинки = ИмяРекв + "_Иконка";
    
	Группа = Элементы.Найти(ИмяГруппы);

	РодительГруппы = Группа.Родитель;

	Элементы.Удалить(Элементы.Найти(ИмяРекв));
	Элементы.Удалить(Элементы.Найти(ИмяКартинки));
	Элементы.Удалить(Группа);
    
	Если РодительГруппы.ПодчиненныеЭлементы.Количество() = 0 Тогда
		Элементы.Удалить(РодительГруппы);
	КонецЕсли;
	
КонецПроцедуры
&НаСервере
Процедура СоздатьЭлементыФормы(ИмяОбъект, ПредставлениеОбъекта, НомерСтроки)
	ИмяРекв = "Декорация_" + ИмяОбъект;

	ПереноситьСтроки =(НомерСтроки % 4) = 0;

	Если ПереноситьСтроки Тогда

		ИмяГруппы = "группаПанель_" + НомерСтроки;
		Если Элементы.Найти(ИмяГруппы) = Неопределено Тогда
			Группа = Элементы.Добавить(ИмяГруппы, Тип("ГруппаФормы"), ЭтаФорма);
			Группа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
			Группа.ГоризонтальноеПоложениеВГруппе = ГоризонтальноеПоложениеЭлемента.Лево;

			ТекИмяГруппы = ИмяГруппы;
		КонецЕсли;
	КонецЕсли;
	ИмяГруппы = "гр_" + ИмяОбъект;
	Если Элементы.Найти(ИмяГруппы) = Неопределено Тогда
		Группа = Элементы.Добавить(ИмяГруппы, Тип("ГруппаФормы"), Элементы[ТекИмяГруппы]);
		Группа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		Группа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
		Группа.ЦветФона = WebЦвета.Аквамарин;
		Группа.Ширина = 18;
		Группа.Высота = 8;
		Группа.Объединенная = Истина;
		Группа.РастягиватьПоГоризонтали = Ложь;

		СлучайноеЧисло = Новый ГенераторСлучайныхЧисел(ТекущаяУниверсальнаяДатаВМиллисекундах());
		ИндексЦвета = СлучайноеЧисло.СлучайноеЧисло(0, ТаблицаЦветов.Количество() - 1);

		СтрокаЦветов = ТаблицаЦветов.Получить(ИндексЦвета);
		Группа.ЦветФона = СтрокаЦветов.Цвет;
		Картинка = ПолучитьКартинкуОбъекта(ИмяОбъект);

		ЭлементКартинки = Элементы.Добавить(ИмяРекв + "_Иконка", Тип("ДекорацияФормы"), Группа);
		ЭлементКартинки.Вид = ВидДекорацииФормы.Картинка;
		ЭлементКартинки.Картинка = Картинка;
		ЭлементКартинки.ГоризонтальноеПоложениеВГруппе = ГоризонтальноеПоложениеЭлемента.Центр;
		ЭлементКартинки.ВертикальноеПоложениеВГруппе = ВертикальноеПоложениеЭлемента.Центр;
		
		
		нЭлемент = Элементы.Добавить(ИмяРекв, Тип("ДекорацияФормы"), Группа);
		нЭлемент.Вид = ВидДекорацииФормы.Надпись;
		нЭлемент.Заголовок = ПредставлениеОбъекта;
		нЭлемент.Гиперссылка = Истина;
		нЭлемент.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента.Центр;
		нЭлемент.ГоризонтальноеПоложениеВГруппе = ГоризонтальноеПоложениеЭлемента.Центр;
		нЭлемент.ВертикальноеПоложение = ВертикальноеПоложениеЭлемента.Центр;
		нЭлемент.ВертикальноеПоложениеВГруппе = ВертикальноеПоложениеЭлемента.Центр;

		нЭлемент.УстановитьДействие("Нажатие", "ОбработчикНачатияГиперссылки");
	КонецЕсли;
КонецПроцедуры


&НаСервере
Функция ПолучитьКартинкуОбъекта(НаименованиеОбъекта)
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("ОбъектМетаданных", НаименованиеОбъекта);

	МассивСтрок = ТаблицаОбъектов.НайтиСтроки(СтруктураПоиска);

	Если МассивСтрок.Количество() > 0 Тогда
		СтрокаДанных  = МассивСтрок[0];
		Если СтрокаДанных.ВидОбъекта = "Справочник" Тогда
			Возврат БиблиотекаКартинок.Справочник;
		ИначеЕсли СтрокаДанных.ВидОбъекта = "Документ" Тогда
			Возврат БиблиотекаКартинок.Документ;
		ИначеЕсли СтрокаДанных.ВидОбъекта = "Отчет" Тогда
			Возврат БиблиотекаКартинок.Отчет;
		ИначеЕсли СтрокаДанных.ВидОбъекта = "Обработка" Тогда
			Возврат БиблиотекаКартинок.Обработка;
		КонецЕсли;
	КонецЕсли;

КонецФункции
&НаКлиенте
Процедура КомандаВернутьНастройки(Команда)
	Для Каждого Стр Из ТаблицаОбъектов Цикл
		УдалитьЭлементФормы(Стр.ОбъектМетаданных);
	КонецЦикла;

	ТекИмяГруппы = "ГруппаПанель1";

	ЗаполнитьПоНастройке();

	Для Каждого СтрокаТаблицаОбъектов Из ТаблицаОбъектов Цикл
		НомерИндекса = ТаблицаОбъектов.Индекс(СтрокаТаблицаОбъектов);

		СоздатьЭлементыФормы(СтрокаТаблицаОбъектов.ОбъектМетаданных, СтрокаТаблицаОбъектов.ПредставлениеОбъекта,
			НомерИндекса + 1);
	КонецЦикла;
КонецПроцедуры
&НаКлиенте
Процедура ОбработчикНачатияГиперссылки(Элемент)
	НаименованиеОбъекта = СтрЗаменить(Элемент.Имя, "Декорация_", "");
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("ОбъектМетаданных", НаименованиеОбъекта);

	МассивСтрок = ТаблицаОбъектов.НайтиСтроки(СтруктураПоиска);

	Для Каждого Стр Из МассивСтрок Цикл
		Если Стр.ВидОбъекта = "Обработка" Или Стр.ВидОбъекта = "Отчет" Тогда
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
	НастроитьВидимостьЭлементов();
КонецПроцедуры

&НаСервере
Процедура НастроитьВидимостьЭлементов()
	ЭтоАдмин = РольДоступна("РБ_АдминРабочегоСтола1С") Или РольДоступна("ПолныеПрава");
	Элементы.ФормаКомандаСохранитьНастройки.Видимость = ЭтоАдмин;
	Элементы.ФормаОткрытьНастройки.Видимость = ЭтоАдмин;
	Элементы.ГруппаИконка.Видимость = ЭтоАдмин;
	Элементы.ВариантНастройки.Видимость = ЭтоАдмин;
КонецПроцедуры

&НаКлиенте
Процедура КомандаСохранитьНастройки(Команда)
	ОткрытьФорму("Обработка.РабочийСтол.Форма.ФормаСохраненияНастройки",
		Новый Структура("ТекПользователь,АдресНастройки,ВариантНастройки", ТекущийПользователь, АдресНастроек(),ВариантНастройки));
КонецПроцедуры

&НаСервере
Функция АдресНастроек()
	Возврат ПоместитьВоВременноеХранилище(ТаблицаОбъектов.Выгрузить(), УникальныйИдентификатор);
КонецФункции

&НаСервере
Процедура ЗаполнитьПоНастройке()
	ВариантНастройки = РегистрыСведений.РБ_НастройкиРабочегоСтола.ПолучитьНастройкуРабочегоСтола(
		ТекущийПользователь);
	Если ЗначениеЗаполнено(ВариантНастройки) Тогда
		Настройка = ВариантНастройки.Настройка.Получить();
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
		СоздатьЭлементыФормы(СтрокаТаблицаОбъектов.ОбъектМетаданных, СтрокаТаблицаОбъектов.ПредставлениеОбъекта,
			НомерИндекса + 1);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНастройки(Команда)
	Структура = Новый Структура;
	Структура.Вставить("ТаблицаОбъектов", ТаблицаОбъектов);
	ОткрытьФорму("Обработка.РабочийСтол.Форма.ФормаНастройки", Структура);
КонецПроцедуры

&НаСервере
Процедура ОбновитьИнтерфейсФормы(Настройка)
	Для Каждого Стр Из ТаблицаОбъектов Цикл
		УдалитьЭлементФормы(Стр.ОбъектМетаданных);
	КонецЦикла;

	ТекИмяГруппы = "ГруппаПанель1";

	ТаблицаОбъектов.Очистить();
	Если Настройка <> Неопределено Тогда
		Для Каждого СтрокаТаблицаОбъектов Из Настройка Цикл
			СтрокаТаблицы = ТаблицаОбъектов.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТаблицы, СтрокаТаблицаОбъектов);
			НомерИндекса = Настройка.Индекс(СтрокаТаблицаОбъектов);

			СоздатьЭлементыФормы(СтрокаТаблицаОбъектов.ОбъектМетаданных, СтрокаТаблицаОбъектов.ПредставлениеОбъекта,
				НомерИндекса + 1);
		КонецЦикла;
	КонецЕсли;	
КонецПроцедуры	

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "ОбновитьИнтерфейс" Тогда
		ОбновитьИнтерфейсФормы(Параметр);
	ИначеЕсли ИмяСобытия = "ВыборОбъекта" Тогда
		ЗначениеСписка = Параметр;//ПолучитьСтруктураДанных(ВыбранныйЭлемент.Значение);

		ДобавитьЭлементНаформу(ЗначениеСписка);
		
	ИначеЕсли ИмяСобытия = "СохранениеНастроек" Тогда
		СтруктураСохранения = Параметр;
		ВариантНастройки = СтруктураСохранения.ВариантНастройки;
		РезультатСохранения = СтруктураСохранения.РезультатСохранения;
		ОбщегоНазначенияКлиент.СообщитьПользователю(РезультатСохранения);
	КонецЕсли;
КонецПроцедуры



&НаКлиенте
Процедура ВариантНастройкиПриИзменении(Элемент)
	ВариантНастройкиПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ВариантНастройкиПриИзмененииНаСервере()
	ОбновитьИнтерфейсФормы(ВариантНастройки.Настройка.Получить());
КонецПроцедуры





&НаСервере
Процедура ДобавитьЭлементНаформу(ЗначениеСписка)
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("ОбъектМетаданных", ЗначениеСписка.ИмяОбъекта);
	МассивСтрок = ТаблицаОбъектов.НайтиСтроки(СтруктураПоиска);
	Если МассивСтрок.Количество() = 0 Тогда

		СтрокаТаблицаОбъектов = ТаблицаОбъектов.Добавить();
		СтрокаТаблицаОбъектов.ОбъектМетаданных = ЗначениеСписка.ИмяОбъекта;
		СтрокаТаблицаОбъектов.ВидОбъекта = ЗначениеСписка.Видобъекта;
		СтрокаТаблицаОбъектов.ПредставлениеОбъекта = ЗначениеСписка.Представление;
		НомерИндекса = ТаблицаОбъектов.Индекс(СтрокаТаблицаОбъектов);
		СоздатьЭлементыФормы(СтрокаТаблицаОбъектов.ОбъектМетаданных, СтрокаТаблицаОбъектов.ПредставлениеОбъекта,
			НомерИндекса + 1);
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура КомандаЗагрузитьИзИзбранного(Команда)
	КомандаЗагрузитьИзИзбранногоНаСервере();
КонецПроцедуры

&НаСервере
Процедура КомандаЗагрузитьИзИзбранногоНаСервере()
	Избранное = ХранилищеСистемныхНастроек.Загрузить("Общее/ИзбранноеРаботыПользователя");

	Если Избранное = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Для Каждого Элемент Из Избранное Цикл
		Если СтрНайти(Элемент.НавигационнаяСсылка, "?ref=") <> 0 Или СтрНайти(Элемент.НавигационнаяСсылка, "list") = 0 Тогда
			Продолжить;
		КонецЕсли;

		СтруктураДанныхОбъекта = Обработки.РабочийСтол.СтруктураДанныхОбъекта();
		НавСсылка  = Элемент.НавигационнаяСсылка;
		НавСсылка = СтрЗаменить(Элемент.НавигационнаяСсылка, "e1cib/list/", "");

		ЧастиСтроки = СтрРазделить(НавСсылка, ".");

		СтруктураДанныхОбъекта.Видобъекта = ЧастиСтроки[0];
		СтруктураДанныхОбъекта.ИмяОбъекта = ЧастиСтроки[1];
		СтруктураДанныхОбъекта.Представление  = Обработки.РабочийСтол.ПредставлениеОбъекта(
			СтруктураДанныхОбъекта.Видобъекта, СтруктураДанныхОбъекта.ИмяОбъекта);

		ДобавитьЭлементНаформу(СтруктураДанныхОбъекта);
	КонецЦикла;
КонецПроцедуры