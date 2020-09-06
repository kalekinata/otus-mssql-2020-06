/* 3. � ������� ����� ���� ���� � ����� ������ �������� � ���������
�������� ������� �� ������, ��������, ��� - ����� � ���� ��� ���� �������� ���� ��������� ���
������ ������

CountryId CountryName Code
1 Afghanistan AFG
1 Afghanistan 4
3 Albania ALB
3 Albania 8 */

SELECT *
FROM(
	SELECT    CountryID
			, CountryName
			, IsoAlpha3Code
			,(select CAST(IsoNumericCode as nvarchar(3)) from Application.Countries co where co.CountryID = c.CountryID) as IsoNumericCodes
	FROM Application.Countries c
	) AS Country
UNPIVOT (Code FOR Name IN (IsoAlpha3Code,IsoNumericCodes)) as unpvt

