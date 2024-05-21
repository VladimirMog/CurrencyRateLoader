CREATE OR ALTER PROC [dbo].[FillWeights]
	@date DATE = NULL
AS
BEGIN
DECLARE @begin_date DATE
DECLARE @end_date DATE

SET @date = ISNULL(@date, GETDATE()-1);

IF OBJECT_ID('tempdb..#dates') IS NOT NULL
	DROP TABLE #dates

SELECT DISTINCT TOP 10 [Date]
INTO #dates
FROM [dbo].[Rates]
WHERE [Date] <= @date
ORDER BY [Date] DESC

SELECT 
	@begin_date = MIN([Date]),
	@end_date = MAX([Date])
FROM #dates

IF OBJECT_ID('tempdb..#weights') IS NOT NULL
	DROP TABLE #weights

SELECT [Date]
		,c.[Currency]
		,r.[Rate] * c.Scale AS [Rate]
INTO #weights
FROM [Lotto].[dbo].[Rates] r 
		INNER JOIN 
	[dbo].[Currencies] c ON r.Currency = c.Currency
WHERE [Date] BETWEEN @begin_date AND @end_date

IF NOT EXISTS(SELECT 1 FROM [dbo].[Weights] WHERE [Date] = @date)
BEGIN
	INSERT INTO [dbo].[Weights] ([Date]) 
	VALUES (@date)
	--SELECT DISTINCT @date, [Currency] FROM #weights
END

UPDATE [dbo].[Weights]
SET 
 [INP001] = [USD] 
,[INP002] = [JPY] 
,[INP003] = [BGN] 
,[INP004] = [CYP] 
,[INP005] = [CZK] 
,[INP006] = [DKK] 
,[INP007] = [EEK] 
,[INP008] = [GBP] 
,[INP009] = [HUF] 
,[INP010] = [LTL] 
,[INP011] = [LVL] 
,[INP012] = [MTL] 
,[INP013] = [PLN] 
,[INP014] = [ROL] 
,[INP015] = [RON] 
,[INP016] = [SEK] 
,[INP017] = [SIT] 
,[INP018] = [SKK] 
,[INP019] = [CHF] 
,[INP020] = [ISK] 
,[INP021] = [NOK] 
,[INP022] = [HRK] 
,[INP023] = [RUB] 
,[INP024] = [TRL] 
,[INP025] = [TRY] 
,[INP026] = [AUD] 
,[INP027] = [BRL] 
,[INP028] = [CAD] 
,[INP029] = [CNY] 
,[INP030] = [HKD] 
,[INP031] = [IDR] 
,[INP032] = [ILS] 
,[INP033] = [INR] 
,[INP034] = [KRW] 
,[INP035] = [MXN] 
,[INP036] = [MYR] 
,[INP037] = [NZD] 
,[INP038] = [PHP] 
,[INP039] = [SGD] 
,[INP040] = [THB] 
,[INP041] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = @begin_date
) t00
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
----------------------------------------------------
UPDATE [dbo].[Weights]
SET 
 [INP101] = [USD] 
,[INP102] = [JPY] 
,[INP103] = [BGN] 
,[INP104] = [CYP] 
,[INP105] = [CZK] 
,[INP106] = [DKK] 
,[INP107] = [EEK] 
,[INP108] = [GBP] 
,[INP109] = [HUF] 
,[INP110] = [LTL] 
,[INP111] = [LVL] 
,[INP112] = [MTL] 
,[INP113] = [PLN] 
,[INP114] = [ROL] 
,[INP115] = [RON] 
,[INP116] = [SEK] 
,[INP117] = [SIT] 
,[INP118] = [SKK] 
,[INP119] = [CHF] 
,[INP120] = [ISK] 
,[INP121] = [NOK] 
,[INP122] = [HRK] 
,[INP123] = [RUB] 
,[INP124] = [TRL] 
,[INP125] = [TRY] 
,[INP126] = [AUD] 
,[INP127] = [BRL] 
,[INP128] = [CAD] 
,[INP129] = [CNY] 
,[INP130] = [HKD] 
,[INP131] = [IDR] 
,[INP132] = [ILS] 
,[INP133] = [INR] 
,[INP134] = [KRW] 
,[INP135] = [MXN] 
,[INP136] = [MYR] 
,[INP137] = [NZD] 
,[INP138] = [PHP] 
,[INP139] = [SGD] 
,[INP140] = [THB] 
,[INP141] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = (SELECT [Date] FROM #dates ORDER BY [Date] OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY)
) t01
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
----------------------------------------------------
UPDATE [dbo].[Weights]
SET 
 [INP201] = [USD] 
,[INP202] = [JPY] 
,[INP203] = [BGN] 
,[INP204] = [CYP] 
,[INP205] = [CZK] 
,[INP206] = [DKK] 
,[INP207] = [EEK] 
,[INP208] = [GBP] 
,[INP209] = [HUF] 
,[INP210] = [LTL] 
,[INP211] = [LVL] 
,[INP212] = [MTL] 
,[INP213] = [PLN] 
,[INP214] = [ROL] 
,[INP215] = [RON] 
,[INP216] = [SEK] 
,[INP217] = [SIT] 
,[INP218] = [SKK] 
,[INP219] = [CHF] 
,[INP220] = [ISK] 
,[INP221] = [NOK] 
,[INP222] = [HRK] 
,[INP223] = [RUB] 
,[INP224] = [TRL] 
,[INP225] = [TRY] 
,[INP226] = [AUD] 
,[INP227] = [BRL] 
,[INP228] = [CAD] 
,[INP229] = [CNY] 
,[INP230] = [HKD] 
,[INP231] = [IDR] 
,[INP232] = [ILS] 
,[INP233] = [INR] 
,[INP234] = [KRW] 
,[INP235] = [MXN] 
,[INP236] = [MYR] 
,[INP237] = [NZD] 
,[INP238] = [PHP] 
,[INP239] = [SGD] 
,[INP240] = [THB] 
,[INP241] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = (SELECT [Date] FROM #dates ORDER BY [Date] OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY)
) t02
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
----------------------------------------------------
UPDATE [dbo].[Weights]
SET 
 [INP301] = [USD] 
,[INP302] = [JPY] 
,[INP303] = [BGN] 
,[INP304] = [CYP] 
,[INP305] = [CZK] 
,[INP306] = [DKK] 
,[INP307] = [EEK] 
,[INP308] = [GBP] 
,[INP309] = [HUF] 
,[INP310] = [LTL] 
,[INP311] = [LVL] 
,[INP312] = [MTL] 
,[INP313] = [PLN] 
,[INP314] = [ROL] 
,[INP315] = [RON] 
,[INP316] = [SEK] 
,[INP317] = [SIT] 
,[INP318] = [SKK] 
,[INP319] = [CHF] 
,[INP320] = [ISK] 
,[INP321] = [NOK] 
,[INP322] = [HRK] 
,[INP323] = [RUB] 
,[INP324] = [TRL] 
,[INP325] = [TRY] 
,[INP326] = [AUD] 
,[INP327] = [BRL] 
,[INP328] = [CAD] 
,[INP329] = [CNY] 
,[INP330] = [HKD] 
,[INP331] = [IDR] 
,[INP332] = [ILS] 
,[INP333] = [INR] 
,[INP334] = [KRW] 
,[INP335] = [MXN] 
,[INP336] = [MYR] 
,[INP337] = [NZD] 
,[INP338] = [PHP] 
,[INP339] = [SGD] 
,[INP340] = [THB] 
,[INP341] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = (SELECT [Date] FROM #dates ORDER BY [Date] OFFSET 3 ROWS FETCH NEXT 1 ROWS ONLY)
) t03
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
----------------------------------------------------
UPDATE [dbo].[Weights]
SET 
 [INP401] = [USD] 
,[INP402] = [JPY] 
,[INP403] = [BGN] 
,[INP404] = [CYP] 
,[INP405] = [CZK] 
,[INP406] = [DKK] 
,[INP407] = [EEK] 
,[INP408] = [GBP] 
,[INP409] = [HUF] 
,[INP410] = [LTL] 
,[INP411] = [LVL] 
,[INP412] = [MTL] 
,[INP413] = [PLN] 
,[INP414] = [ROL] 
,[INP415] = [RON] 
,[INP416] = [SEK] 
,[INP417] = [SIT] 
,[INP418] = [SKK] 
,[INP419] = [CHF] 
,[INP420] = [ISK] 
,[INP421] = [NOK] 
,[INP422] = [HRK] 
,[INP423] = [RUB] 
,[INP424] = [TRL] 
,[INP425] = [TRY] 
,[INP426] = [AUD] 
,[INP427] = [BRL] 
,[INP428] = [CAD] 
,[INP429] = [CNY] 
,[INP430] = [HKD] 
,[INP431] = [IDR] 
,[INP432] = [ILS] 
,[INP433] = [INR] 
,[INP434] = [KRW] 
,[INP435] = [MXN] 
,[INP436] = [MYR] 
,[INP437] = [NZD] 
,[INP438] = [PHP] 
,[INP439] = [SGD] 
,[INP440] = [THB] 
,[INP441] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = (SELECT [Date] FROM #dates ORDER BY [Date] OFFSET 4 ROWS FETCH NEXT 1 ROWS ONLY)
) t04
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
----------------------------------------------------
UPDATE [dbo].[Weights]
SET 
 [INP501] = [USD] 
,[INP502] = [JPY] 
,[INP503] = [BGN] 
,[INP504] = [CYP] 
,[INP505] = [CZK] 
,[INP506] = [DKK] 
,[INP507] = [EEK] 
,[INP508] = [GBP] 
,[INP509] = [HUF] 
,[INP510] = [LTL] 
,[INP511] = [LVL] 
,[INP512] = [MTL] 
,[INP513] = [PLN] 
,[INP514] = [ROL] 
,[INP515] = [RON] 
,[INP516] = [SEK] 
,[INP517] = [SIT] 
,[INP518] = [SKK] 
,[INP519] = [CHF] 
,[INP520] = [ISK] 
,[INP521] = [NOK] 
,[INP522] = [HRK] 
,[INP523] = [RUB] 
,[INP524] = [TRL] 
,[INP525] = [TRY] 
,[INP526] = [AUD] 
,[INP527] = [BRL] 
,[INP528] = [CAD] 
,[INP529] = [CNY] 
,[INP530] = [HKD] 
,[INP531] = [IDR] 
,[INP532] = [ILS] 
,[INP533] = [INR] 
,[INP534] = [KRW] 
,[INP535] = [MXN] 
,[INP536] = [MYR] 
,[INP537] = [NZD] 
,[INP538] = [PHP] 
,[INP539] = [SGD] 
,[INP540] = [THB] 
,[INP541] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = (SELECT [Date] FROM #dates ORDER BY [Date] OFFSET 5 ROWS FETCH NEXT 1 ROWS ONLY)
) t05
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
----------------------------------------------------
UPDATE [dbo].[Weights]
SET 
 [INP601] = [USD] 
,[INP602] = [JPY] 
,[INP603] = [BGN] 
,[INP604] = [CYP] 
,[INP605] = [CZK] 
,[INP606] = [DKK] 
,[INP607] = [EEK] 
,[INP608] = [GBP] 
,[INP609] = [HUF] 
,[INP610] = [LTL] 
,[INP611] = [LVL] 
,[INP612] = [MTL] 
,[INP613] = [PLN] 
,[INP614] = [ROL] 
,[INP615] = [RON] 
,[INP616] = [SEK] 
,[INP617] = [SIT] 
,[INP618] = [SKK] 
,[INP619] = [CHF] 
,[INP620] = [ISK] 
,[INP621] = [NOK] 
,[INP622] = [HRK] 
,[INP623] = [RUB] 
,[INP624] = [TRL] 
,[INP625] = [TRY] 
,[INP626] = [AUD] 
,[INP627] = [BRL] 
,[INP628] = [CAD] 
,[INP629] = [CNY] 
,[INP630] = [HKD] 
,[INP631] = [IDR] 
,[INP632] = [ILS] 
,[INP633] = [INR] 
,[INP634] = [KRW] 
,[INP635] = [MXN] 
,[INP636] = [MYR] 
,[INP637] = [NZD] 
,[INP638] = [PHP] 
,[INP639] = [SGD] 
,[INP640] = [THB] 
,[INP641] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = (SELECT [Date] FROM #dates ORDER BY [Date] OFFSET 6 ROWS FETCH NEXT 1 ROWS ONLY)
) t06
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
----------------------------------------------------
UPDATE [dbo].[Weights]
SET 
 [INP701] = [USD] 
,[INP702] = [JPY] 
,[INP703] = [BGN] 
,[INP704] = [CYP] 
,[INP705] = [CZK] 
,[INP706] = [DKK] 
,[INP707] = [EEK] 
,[INP708] = [GBP] 
,[INP709] = [HUF] 
,[INP710] = [LTL] 
,[INP711] = [LVL] 
,[INP712] = [MTL] 
,[INP713] = [PLN] 
,[INP714] = [ROL] 
,[INP715] = [RON] 
,[INP716] = [SEK] 
,[INP717] = [SIT] 
,[INP718] = [SKK] 
,[INP719] = [CHF] 
,[INP720] = [ISK] 
,[INP721] = [NOK] 
,[INP722] = [HRK] 
,[INP723] = [RUB] 
,[INP724] = [TRL] 
,[INP725] = [TRY] 
,[INP726] = [AUD] 
,[INP727] = [BRL] 
,[INP728] = [CAD] 
,[INP729] = [CNY] 
,[INP730] = [HKD] 
,[INP731] = [IDR] 
,[INP732] = [ILS] 
,[INP733] = [INR] 
,[INP734] = [KRW] 
,[INP735] = [MXN] 
,[INP736] = [MYR] 
,[INP737] = [NZD] 
,[INP738] = [PHP] 
,[INP739] = [SGD] 
,[INP740] = [THB] 
,[INP741] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = (SELECT [Date] FROM #dates ORDER BY [Date] OFFSET 7 ROWS FETCH NEXT 1 ROWS ONLY)
) t07
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
----------------------------------------------------
UPDATE [dbo].[Weights]
SET 
 [INP801] = [USD] 
,[INP802] = [JPY] 
,[INP803] = [BGN] 
,[INP804] = [CYP] 
,[INP805] = [CZK] 
,[INP806] = [DKK] 
,[INP807] = [EEK] 
,[INP808] = [GBP] 
,[INP809] = [HUF] 
,[INP810] = [LTL] 
,[INP811] = [LVL] 
,[INP812] = [MTL] 
,[INP813] = [PLN] 
,[INP814] = [ROL] 
,[INP815] = [RON] 
,[INP816] = [SEK] 
,[INP817] = [SIT] 
,[INP818] = [SKK] 
,[INP819] = [CHF] 
,[INP820] = [ISK] 
,[INP821] = [NOK] 
,[INP822] = [HRK] 
,[INP823] = [RUB] 
,[INP824] = [TRL] 
,[INP825] = [TRY] 
,[INP826] = [AUD] 
,[INP827] = [BRL] 
,[INP828] = [CAD] 
,[INP829] = [CNY] 
,[INP830] = [HKD] 
,[INP831] = [IDR] 
,[INP832] = [ILS] 
,[INP833] = [INR] 
,[INP834] = [KRW] 
,[INP835] = [MXN] 
,[INP836] = [MYR] 
,[INP837] = [NZD] 
,[INP838] = [PHP] 
,[INP839] = [SGD] 
,[INP840] = [THB] 
,[INP841] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = (SELECT [Date] FROM #dates ORDER BY [Date] OFFSET 8 ROWS FETCH NEXT 1 ROWS ONLY)
) t08
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
----------------------------------------------------
UPDATE [dbo].[Weights]
SET 
 [INP901] = [USD] 
,[INP902] = [JPY] 
,[INP903] = [BGN] 
,[INP904] = [CYP] 
,[INP905] = [CZK] 
,[INP906] = [DKK] 
,[INP907] = [EEK] 
,[INP908] = [GBP] 
,[INP909] = [HUF] 
,[INP910] = [LTL] 
,[INP911] = [LVL] 
,[INP912] = [MTL] 
,[INP913] = [PLN] 
,[INP914] = [ROL] 
,[INP915] = [RON] 
,[INP916] = [SEK] 
,[INP917] = [SIT] 
,[INP918] = [SKK] 
,[INP919] = [CHF] 
,[INP920] = [ISK] 
,[INP921] = [NOK] 
,[INP922] = [HRK] 
,[INP923] = [RUB] 
,[INP924] = [TRL] 
,[INP925] = [TRY] 
,[INP926] = [AUD] 
,[INP927] = [BRL] 
,[INP928] = [CAD] 
,[INP929] = [CNY] 
,[INP930] = [HKD] 
,[INP931] = [IDR] 
,[INP932] = [ILS] 
,[INP933] = [INR] 
,[INP934] = [KRW] 
,[INP935] = [MXN] 
,[INP936] = [MYR] 
,[INP937] = [NZD] 
,[INP938] = [PHP] 
,[INP939] = [SGD] 
,[INP940] = [THB] 
,[INP941] = [ZAR] 
FROM 
(
	SELECT * FROM #weights WHERE [Date] = @end_date
) t08
PIVOT 
(
	MIN([Rate])
	FOR [Currency] IN 
		([USD]
		,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
		,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR])
) AS pvt
WHERE [Weights].[Date] = [dbo].[Weights].[Date] 
END
GO


