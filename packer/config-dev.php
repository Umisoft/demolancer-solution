<?php
	return [
		'package' => 'demolancer-dev',
		'destination' => './sys-temp/packer/out/demolancer-dev/',
		'directories' => [
			'./templates/demolancer/',
			'./images/cms/data/',
			'./files/filesToImport/',
		],
		'files' => [
			'./files/pdn.doc'
		],
		'types' => [
			127, // Тип формы обратной связи
			128, // Тип настроек сайта
			129, // Справочник "Социальные сети в футере",
			130, // Тип страницы контента "Главная страница"
		],
		'objects' => [
			628, // Адрес формы обратной связи
			629, // Шаблон письма формы обратной связи
			631, // Объект настроек сайта,
			636, // Объект "Поделиться ВКонтакте"
			637, // Объект "Поделиться в Facebook"
			638, // Объект "Поделиться в LiveJournal"
			639, // Объект "Поделиться в Twitter"
			640, // Объект "Поделиться в Моём мире"
			641, // Объект "Поделиться в Одноклассниках"
		],
		'templates' => [
			1
		],
		'branchesStructure' => [
			1, // Главная страница
			2, // Страница "Обо мне"
			3, // Фотогалерея
			4, // Блог
			5, // Страница с формой обратной связи
			43,// Новости
		],
		'savedRelations' => [
			'fields_relations',
			'files',
			'hierarchy',
			'permissions',
			'guides'
		]
	];
