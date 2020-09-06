/*5. Code review (опционально). Запрос приложен в материалы Hometask_code_review.sql.
Что делает запрос?
Чем можно заменить CROSS APPLY - можно ли использовать другую стратегию выборки\запроса?*/

SELECT T.FolderId (id папки),
		   T.FileVersionId(id версии папки),
		   T.FileId	(id файла)	
	FROM dbo.vwFolderHistoryRemove FHR
	CROSS APPLY (SELECT TOP 1 FileVersionId, FileId, FolderId, DirId
			FROM #FileVersions V
			WHERE RowNum = 1
				AND DirVersionId <= FHR.DirVersionId
			ORDER BY V.DirVersionId DESC) T 
	WHERE FHR.[FolderId] = T.FolderId
	AND FHR.DirId = T.DirId
	AND EXISTS (SELECT 1 FROM #FileVersions V WHERE V.DirVersionId <= FHR.DirVersionId)
	AND NOT EXISTS (
			SELECT 1
			FROM dbo.vwFileHistoryRemove DFHR
			WHERE DFHR.FileId = T.FileId
				AND DFHR.[FolderId] = T.FolderId
				AND DFHR.DirVersionId = FHR.DirVersionId
				AND NOT EXISTS (
					SELECT 1
					FROM dbo.vwFileHistoryRestore DFHRes
					WHERE DFHRes.[FolderId] = T.FolderId
						AND DFHRes.FileId = T.FileId
						AND DFHRes.PreviousFileVersionId = DFHR.FileVersionId
					)
			)

/*В результате выполнения запроса выводятся по одному id папки, id версии файла и id файла для каждой папке, у которой RowNum = 1 и больший DirVersionId <= FHR.DirVersionId. В соответствии с условиями, при которых FolderId и DirId должны совпадать с данными из таблицы, версия файла должна существовать и совпадать с данными из таблицы, и необходимо, чтобы не существовало значений с FileId, FolderId, DirVersionId из сторонней таблицы при том, что вместе с этим не должно существовать значения с совпадающими FolderId, FileId, FileVersionId из таблицы файловой истории с имеющимися на первом этапе таблицами.*/