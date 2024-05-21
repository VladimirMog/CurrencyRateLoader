

CREATE OR ALTER  PROC [dbo].[PrepareData]
	@date DATE = NULL,
	@curr NVARCHAR(3) = NULL
AS
BEGIN
DECLARE @begin_date DATE
DECLARE @end_date DATE

SET @date = ISNULL(@date, GETDATE()-1);

IF OBJECT_ID('tempdb..#dates') IS NOT NULL
	DROP TABLE #dates

SELECT DISTINCT TOP 11 [Date]
INTO #dates
FROM [dbo].[Rates]
WHERE [Date] <= @date
ORDER BY [Date] DESC

SELECT 
	@begin_date = MIN([Date]),
	@end_date = MAX([Date])
FROM #dates

SELECT 
	diff.[Date],
	diff.[Currency],
	diff.[LastRate],
	diff.[CurrentRate] AS [TargetRate],
	diff.[CurrentRate] / diff.[LastRate] AS [TargetKoeff],

	diff.[FlattRate],
	IIF(ABS([Diff1]) < 12, 1, 0) AS [N100],
	IIF([Diff1] BETWEEN 12 AND 24, 1, 0) AS [N101],
	IIF([Diff1] BETWEEN 25 AND 49, 1, 0) AS [N102],
	IIF([Diff1] BETWEEN 50 AND 100, 1, 0) AS [N103],
	IIF([Diff1] > 100, 1, 0) AS [N104],
	IIF([Diff1] BETWEEN -24 AND -12, 1, 0) AS [N105],
	IIF([Diff1] BETWEEN -49 AND -25, 1, 0) AS [N106],
	IIF([Diff1] BETWEEN -100 AND -50, 1, 0) AS [N107],
	IIF([Diff1] < -100, 1, 0) AS [N108],

	IIF(ABS([Diff2]) < 12, 1, 0) AS [N200],
	IIF([Diff2] BETWEEN 12 AND 24, 1, 0) AS [N201],
	IIF([Diff2] BETWEEN 25 AND 49, 1, 0) AS [N202],
	IIF([Diff2] BETWEEN 50 AND 100, 1, 0) AS [N203],
	IIF([Diff2] > 100, 1, 0) AS [N204],
	IIF([Diff2] BETWEEN -24 AND -12, 1, 0) AS [N205],
	IIF([Diff2] BETWEEN -49 AND -25, 1, 0) AS [N206],
	IIF([Diff2] BETWEEN -100 AND -50, 1, 0) AS [N207],
	IIF([Diff2] < -100, 1, 0) AS [N208],

	IIF(ABS([Diff3]) < 12, 1, 0) AS [N300],
	IIF([Diff3] BETWEEN 12 AND 24, 1, 0) AS [N301],
	IIF([Diff3] BETWEEN 25 AND 49, 1, 0) AS [N302],
	IIF([Diff3] BETWEEN 50 AND 100, 1, 0) AS [N303],
	IIF([Diff3] > 100, 1, 0) AS [N304],
	IIF([Diff3] BETWEEN -24 AND -12, 1, 0) AS [N305],
	IIF([Diff3] BETWEEN -49 AND -25, 1, 0) AS [N306],
	IIF([Diff3] BETWEEN -100 AND -50, 1, 0) AS [N307],
	IIF([Diff3] < -100, 1, 0) AS [N308],

	IIF(ABS([Diff4]) < 12, 1, 0) AS [N400],
	IIF([Diff4] BETWEEN 12 AND 24, 1, 0) AS [N401],
	IIF([Diff4] BETWEEN 25 AND 49, 1, 0) AS [N402],
	IIF([Diff4] BETWEEN 50 AND 100, 1, 0) AS [N403],
	IIF([Diff4] > 100, 1, 0) AS [N404],
	IIF([Diff4] BETWEEN -24 AND -12, 1, 0) AS [N405],
	IIF([Diff4] BETWEEN -49 AND -25, 1, 0) AS [N406],
	IIF([Diff4] BETWEEN -100 AND -50, 1, 0) AS [N407],
	IIF([Diff4] < -100, 1, 0) AS [N408],

	IIF(ABS([Diff5]) < 12, 1, 0) AS [N500],
	IIF([Diff5] BETWEEN 12 AND 24, 1, 0) AS [N501],
	IIF([Diff5] BETWEEN 25 AND 49, 1, 0) AS [N502],
	IIF([Diff5] BETWEEN 50 AND 100, 1, 0) AS [N503],
	IIF([Diff5] > 100, 1, 0) AS [N504],
	IIF([Diff5] BETWEEN -24 AND -12, 1, 0) AS [N505],
	IIF([Diff5] BETWEEN -49 AND -25, 1, 0) AS [N506],
	IIF([Diff5] BETWEEN -100 AND -50, 1, 0) AS [N507],
	IIF([Diff5] < -100, 1, 0) AS [N508],

	IIF(ABS([Diff6]) < 12, 1, 0) AS [N600],
	IIF([Diff6] BETWEEN 12 AND 24, 1, 0) AS [N601],
	IIF([Diff6] BETWEEN 25 AND 49, 1, 0) AS [N602],
	IIF([Diff6] BETWEEN 50 AND 100, 1, 0) AS [N603],
	IIF([Diff6] > 100, 1, 0) AS [N604],
	IIF([Diff6] BETWEEN -24 AND -12, 1, 0) AS [N605],
	IIF([Diff6] BETWEEN -49 AND -25, 1, 0) AS [N606],
	IIF([Diff6] BETWEEN -100 AND -50, 1, 0) AS [N607],
	IIF([Diff6] < -100, 1, 0) AS [N608],

	IIF(ABS([Diff7]) < 12, 1, 0) AS [N700],
	IIF([Diff7] BETWEEN 12 AND 24, 1, 0) AS [N701],
	IIF([Diff7] BETWEEN 25 AND 49, 1, 0) AS [N702],
	IIF([Diff7] BETWEEN 50 AND 100, 1, 0) AS [N703],
	IIF([Diff7] > 100, 1, 0) AS [N704],
	IIF([Diff7] BETWEEN -24 AND -12, 1, 0) AS [N705],
	IIF([Diff7] BETWEEN -49 AND -25, 1, 0) AS [N706],
	IIF([Diff7] BETWEEN -100 AND -50, 1, 0) AS [N707],
	IIF([Diff7] < -100, 1, 0) AS [N708],

	IIF(ABS([Diff7]) < 12, 1, 0) AS [N800],
	IIF([Diff7] BETWEEN 12 AND 24, 1, 0) AS [N801],
	IIF([Diff7] BETWEEN 25 AND 49, 1, 0) AS [N802],
	IIF([Diff7] BETWEEN 50 AND 100, 1, 0) AS [N803],
	IIF([Diff7] > 100, 1, 0) AS [N804],
	IIF([Diff7] BETWEEN -24 AND -12, 1, 0) AS [N805],
	IIF([Diff7] BETWEEN -49 AND -25, 1, 0) AS [N806],
	IIF([Diff7] BETWEEN -100 AND -50, 1, 0) AS [N807],
	IIF([Diff7] < -100, 1, 0) AS [N808],

	IIF(ABS([Diff8]) < 12, 1, 0) AS [N900],
	IIF([Diff8] BETWEEN 12 AND 24, 1, 0) AS [N901],
	IIF([Diff8] BETWEEN 25 AND 49, 1, 0) AS [N902],
	IIF([Diff8] BETWEEN 50 AND 100, 1, 0) AS [N903],
	IIF([Diff8] > 100, 1, 0) AS [N904],
	IIF([Diff8] BETWEEN -24 AND -12, 1, 0) AS [N905],
	IIF([Diff8] BETWEEN -49 AND -25, 1, 0) AS [N906],
	IIF([Diff8] BETWEEN -100 AND -50, 1, 0) AS [N907],
	IIF([Diff8] < -100, 1, 0) AS [N908],

	IIF(ABS([Diff9]) < 12, 1, 0) AS [NA00],
	IIF([Diff9] BETWEEN 12 AND 24, 1, 0) AS [NA01],
	IIF([Diff9] BETWEEN 25 AND 49, 1, 0) AS [NA02],
	IIF([Diff9] BETWEEN 50 AND 100, 1, 0) AS [NA03],
	IIF([Diff9] > 100, 1, 0) AS [NA04],
	IIF([Diff9] BETWEEN -24 AND -12, 1, 0) AS [NA05],
	IIF([Diff9] BETWEEN -49 AND -25, 1, 0) AS [NA06],
	IIF([Diff9] BETWEEN -100 AND -50, 1, 0) AS [NA07],
	IIF([Diff9] < -100, 1, 0) AS [NA08]

FROM
(
	SELECT 
		rate.[Date],
		rate.[Currency],
		rate.[LastRate],
		rate.[CurrentRate],
		rate.[FlattRate],
		CAST(10000 * ([Rate1] - [Rate0]) / [Rate0] AS INT) AS [Diff1],
		CAST(10000 * ([Rate2] - [Rate1]) / [Rate1] AS INT) AS [Diff2],
		CAST(10000 * ([Rate3] - [Rate2]) / [Rate2] AS INT) AS [Diff3],
		CAST(10000 * ([Rate4] - [Rate3]) / [Rate3] AS INT) AS [Diff4],
		CAST(10000 * ([Rate5] - [Rate4]) / [Rate4] AS INT) AS [Diff5],
		CAST(10000 * ([Rate6] - [Rate5]) / [Rate5] AS INT) AS [Diff6],
		CAST(10000 * ([Rate7] - [Rate6]) / [Rate6] AS INT) AS [Diff7],
		CAST(10000 * ([Rate8] - [Rate7]) / [Rate7] AS INT) AS [Diff8],
		CAST(10000 * ([Rate9] - [Rate8]) / [Rate8] AS INT) AS [Diff9]
	FROM
	(
		SELECT [Date]
				,c.[Currency]
				,r.[Rate] * c.Scale AS [FlattRate]
				,LAG(r.[Rate], 1, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [LastRate]
				,r.[Rate] AS [CurrentRate]
				,LAG(r.[Rate] * c.Scale, 10, 0) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate0]
				,LAG(r.[Rate] * c.Scale, 9, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate1]
				,LAG(r.[Rate] * c.Scale, 8, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate2]
				,LAG(r.[Rate] * c.Scale, 7, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate3]
				,LAG(r.[Rate] * c.Scale, 6, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate4]
				,LAG(r.[Rate] * c.Scale, 5, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate5]
				,LAG(r.[Rate] * c.Scale, 4, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate6]
				,LAG(r.[Rate] * c.Scale, 3, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate7]
				,LAG(r.[Rate] * c.Scale, 2, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate8]
				,LAG(r.[Rate] * c.Scale, 1, 0 ) OVER ( PARTITION BY c.[Currency] ORDER BY [Date] ) AS [Rate9]
		FROM [Lotto].[dbo].[Rates] r 
				INNER JOIN 
			[dbo].[Currencies] c ON r.Currency = c.Currency
		WHERE [Date] BETWEEN @begin_date AND @end_date
			AND c.[Currency] = ISNULL(@curr, c.[Currency])
	) rate
	WHERE rate.[Date] = @end_date
) diff
ORDER BY [Date],[Currency]
END
GO


