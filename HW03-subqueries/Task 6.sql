/*6. В материалах к вебинару есть файл HT_reviewBigCTE.sql - прочтите этот запрос и напишите, что он должен вернуть и в чем его смысл. Если есть идеи по улучшению запроса, то напишите их.
WITH cteDeletedDF as
(
	SELECT top (@DFBatchSize)
		df.UserFileId,
		@vfId as VirtualFolderId,
		@vfOwnerId as OwnerId,
		df.UserFileVersionId,
		df.FileId,
		df.[Length],
		df.EffectiveDateRemovedUtc as lastDeleteDate,
		@vfFolderId as FolderId
	FROM dbo.vwUserFileInActive df with(nolock)
	WHERE df.[FolderId] = @vfFolderId
	AND df.EffectiveDateRemovedUtc < @maxDFKeepDate
),
cteDeletedDFMatchedRules
as
(
	SELECT ROW_NUMBER() over(partition by DF.UserFileId order by T.Priority) rn,
		DATEADD(YEAR, -t.DeletedFileYears,
				DATEADD(MONTH, -t.DeletedFileMonths,
						DATEADD(DAY, -t.DeletedFileDays , @keepDeletedFromDate))) customRuleKeepDate,
		T.DeletedFileDays as customDeletedDays,
		T.DeletedFileMonths as customDeletedMonths,
		T.DeletedFileYears as customDeletedYears,
		T.CustomRuleId,
		dDf.UserFileId,
		dDF.FolderId as FolderId
	FROM cteDeletedDF dDF
	INNER JOIN dbo.UserFile DF with(nolock) on dDF.FolderId = df.FolderId and dDF.UserFileId = Df.UserFileId
	LEFT JOIN dbo.UserFileExtension dfe with(nolock) on df.[ExtensionId] = dfe.[ExtensionId]
	CROSS JOIN #companyCustomRules T
	WHERE
	(
		EXISTS
		(
			SELECT TOP 1
					1 as id
			where T.RuleType = 0
				and T.RuleCondition = 0
				and T.RuleItemFileType = dfe.[FileTypeId]

			union all

			SELECT TOP 1
					1
			where T.RuleType = 0
				and T.RuleCondition = 1
				and T.RuleItemFileType <> dfe.[FileTypeId]

			union all

			SELECT TOP 1
					1
			 where T.RuleType = 1
				and T.RuleCondition = 0
				and DF.Name = T.RuleItemFileMask

			union all

			SELECT TOP 1
					1
			 where T.RuleType = 1
				and T.RuleCondition = 4
				and DF.Name like  case T.RuleCondition
								  when 4
								  then '%' + T.RuleItemFileMask + '%' --never will be indexed
								  when 3
								  then '%' + T.RuleItemFileMask --never will be indexed
								  when 2
								  then T.RuleItemFileMask + '%' --may be indexed
								 end

			union all

			SELECT TOP 1
					1
			 where T.RuleType = 1
				and T.RuleCondition = 5
				and dbo.RegExMatch(DF.Name, T.RuleItemFileMask) = 1 --never will be indexed

			union all

			SELECT TOP 1
					1
			 where T.RuleType = 2
				and T.RuleCondition = 6
				and DF.[Length] > T.RuleItemFileSize

			union all

			SELECT TOP 1
					1
			 where T.RuleType = 2
				and T.RuleCondition = 7
				and DF.[Length] < T.RuleItemFileSize

			union all

			SELECT TOP 1
					1
			 where T.RuleType = 3
				and T.RuleCondition = 0
				and dDF.VirtualFolderId = T.RuleItemVirtualFolderId

			union all

			SELECT TOP 1
					1
			 where T.RuleType = 3
				and T.RuleCondition = 8
				and T.RuleItemVirtualFolderOwnerId = dDf.OwnerId
		)
	)
)
*/

Временное значение, которое вычисляется во время выполнения запроса и содержит в себе id пользовательского файла, отсортированное по возрастанию значения приоритета; дата с изменениями значений года, месяца и дня удаления файла; пользовательское правило хранения дат; день, когда был удалён файл; месяц, когда был удалён файл; год, когда был удалён файл; id пользовательского правила; id пользовательского файла; id папки. Когда истино, при условиях, что 1) выводится id, когда тип правила = 0, условия правила = 0, тип элемента правила = id тип файла; 2)выводится 1, когда тип правила = 0, условия правила = 1, тип элемента правила не = id тип файла; 3)выводится 1, когда тип правила = 1, условия правила = 4 и имя со значениями '%' + RuleItemFileMask + '%' или '%' + T.RuleItemFileMask, или T.RuleItemFileMask + '%'; 4) выводится 1, когда тип правила = 1, условия правила = 5 и имя со значением 1 и маска файла элемента правил = 1; 5) выводится 1, когда тип правила = 2, условия правила = 6 и длина больше размера файла элемента правил; 6) выводится 1, когда тип правила = 2, условия правила = 7 и длина меньше размера файла элемента правил; 7) выводится 1, когда тип правила = 3, условия правила = 0 и id виртуальной папки равно id элементу правил виртуальной папки; 8) выводится 1, когда тип правила = 3, условия правила = 8 и id владельца элемента правил виртуальной папки равно id владельца.
Запрос возвращает информацию об удалённом файле.
