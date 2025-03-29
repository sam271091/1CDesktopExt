#Область СлужебныеПроцедурыИФункции
// Структура данных объекта.
// 
// Возвращаемое значение:
//  Структура - Структура данных объекта:
// * ИмяОбъекта - Строка - Имя объекта
// * Видобъекта - Строка - Вид объекта
// * Представление - Строка - Представление объекта
Функция СтруктураДанныхОбъекта() Экспорт
	СтруктураДанных = Новый Структура;
	СтруктураДанных.Вставить("ИмяОбъекта", "");
	СтруктураДанных.Вставить("Видобъекта", "");
	СтруктураДанных.Вставить("Представление", "");
	Возврат СтруктураДанных;
КонецФункции


// Представление объекта.
// 
// Параметры:
//  Видобъекта - Строка - Видобъекта
//  ИмяОбъкта  - Строка - Имя объкта
// 
// Возвращаемое значение:
//  Строка - Представление объекта
Функция ПредставлениеОбъекта(Видобъекта,ИмяОбъкта) Экспорт
	Если Видобъекта = "Документ" Тогда
		Возврат Метаданные.Документы[ИмяОбъкта].Синоним;
	ИначеЕсли  Видобъекта = "Справочник" Тогда
		Возврат Метаданные.Справочники[ИмяОбъкта].Синоним;
	ИначеЕсли  Видобъекта = "Отчет" Тогда
		Возврат Метаданные.Отчеты[ИмяОбъкта].Синоним;
	ИначеЕсли  Видобъекта = "Обработка" Тогда	
		Возврат Метаданные.Обработки[ИмяОбъкта].Синоним;	
	Иначе
		Возврат СтрШаблон("%1.%2",Видобъекта,ИмяОбъкта);
	КонецЕсли;
	
КонецФункции


#КонецОбласти