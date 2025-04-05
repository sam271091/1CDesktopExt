// Вариант настройки.
// 
// Параметры:
//  СсылкаВарианта - СправочникСсылка.РБ_ВариантыНастроекРабочегоСтола - Ссылка варианта
//  НаименованиеНастройки - Строка - Наименование настройки
//  ХранилищеНастроек - ХранилищеЗначения - Хранилище настроек
//  Автор - СправочникСсылка.Пользователи - Автор
// 
// Возвращаемое значение:
//  СправочникСсылка.РБ_ВариантыНастроекРабочегоСтола - Вариант настройки
Функция ВариантНастройки(СсылкаВарианта,НаименованиеНастройки,ХранилищеНастроек,Автор) Экспорт
	
	Если Не ЗначениеЗаполнено(СсылкаВарианта) Тогда
		ОбъектВарианта = Справочники.РБ_ВариантыНастроекРабочегоСтола.СоздатьЭлемент();
	Иначе
		ОбъектВарианта = СсылкаВарианта.ПолучитьОбъект();
	КонецЕсли;
	
	ОбъектВарианта.Наименование = НаименованиеНастройки;
	ОбъектВарианта.Настройка    = ХранилищеНастроек;
	ОбъектВарианта.Автор        = Автор;
	ОбъектВарианта.Записать();
	Возврат ОбъектВарианта.Ссылка;
КонецФункции