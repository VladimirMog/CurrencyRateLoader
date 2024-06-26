USE [Lotto]
GO
/****** Object:  StoredProcedure [dbo].[ProcessRates]    Script Date: 5/7/2024 6:49:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ProcessRates]
AS

WITH cte 
AS
(  SELECT
   CAST([Date] AS DATE) [Date]
  ,CONVERT(MONEY, NULLIF(USD, 'N/A')) USD
  ,CONVERT(MONEY, NULLIF(JPY, 'N/A')) JPY
  ,CONVERT(MONEY, NULLIF(BGN, 'N/A')) BGN
  ,CONVERT(MONEY, NULLIF(CYP, 'N/A')) CYP
  ,CONVERT(MONEY, NULLIF(CZK, 'N/A')) CZK
  ,CONVERT(MONEY, NULLIF(DKK, 'N/A')) DKK
  ,CONVERT(MONEY, NULLIF(EEK, 'N/A')) EEK
  ,CONVERT(MONEY, NULLIF(GBP, 'N/A')) GBP
  ,CONVERT(MONEY, NULLIF(HUF, 'N/A')) HUF
  ,CONVERT(MONEY, NULLIF(LTL, 'N/A')) LTL
  ,CONVERT(MONEY, NULLIF(LVL, 'N/A')) LVL
  ,CONVERT(MONEY, NULLIF(MTL, 'N/A')) MTL
  ,CONVERT(MONEY, NULLIF(PLN, 'N/A')) PLN
  ,CONVERT(MONEY, NULLIF(ROL, 'N/A')) ROL
  ,CONVERT(MONEY, NULLIF(RON, 'N/A')) RON
  ,CONVERT(MONEY, NULLIF(SEK, 'N/A')) SEK
  ,CONVERT(MONEY, NULLIF(SIT, 'N/A')) SIT
  ,CONVERT(MONEY, NULLIF(SKK, 'N/A')) SKK
  ,CONVERT(MONEY, NULLIF(CHF, 'N/A')) CHF
  ,CONVERT(MONEY, NULLIF(ISK, 'N/A')) ISK
  ,CONVERT(MONEY, NULLIF(NOK, 'N/A')) NOK
  ,CONVERT(MONEY, NULLIF(HRK, 'N/A')) HRK
  ,CONVERT(MONEY, NULLIF(RUB, 'N/A')) RUB
  ,CONVERT(MONEY, NULLIF(TRL, 'N/A')) TRL
  ,CONVERT(MONEY, NULLIF(TRY, 'N/A')) TRY
  ,CONVERT(MONEY, NULLIF(AUD, 'N/A')) AUD
  ,CONVERT(MONEY, NULLIF(BRL, 'N/A')) BRL
  ,CONVERT(MONEY, NULLIF(CAD, 'N/A')) CAD
  ,CONVERT(MONEY, NULLIF(CNY, 'N/A')) CNY
  ,CONVERT(MONEY, NULLIF(HKD, 'N/A')) HKD
  ,CONVERT(MONEY, NULLIF(IDR, 'N/A')) IDR
  ,CONVERT(MONEY, NULLIF(ILS, 'N/A')) ILS
  ,CONVERT(MONEY, NULLIF(INR, 'N/A')) INR
  ,CONVERT(MONEY, NULLIF(KRW, 'N/A')) KRW
  ,CONVERT(MONEY, NULLIF(MXN, 'N/A')) MXN
  ,CONVERT(MONEY, NULLIF(MYR, 'N/A')) MYR
  ,CONVERT(MONEY, NULLIF(NZD, 'N/A')) NZD
  ,CONVERT(MONEY, NULLIF(PHP, 'N/A')) PHP
  ,CONVERT(MONEY, NULLIF(SGD, 'N/A')) SGD
  ,CONVERT(MONEY, NULLIF(THB, 'N/A')) THB
  ,CONVERT(MONEY, NULLIF(ZAR, 'N/A')) ZAR
  ,NULL AS [ScaledPred]
  FROM [dbo].[eurofxref-hist] 
)

MERGE [dbo].[Rates] TRG
USING (
SELECT [Date],[Currency],[Rate],[ScaledPred]
  FROM 
  (SELECT [Date],[ScaledPred]
,[USD]
,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR]
   FROM cte) pvt  
  UNPIVOT (
	[Rate] FOR [Currency] IN ([USD]
,[JPY],[BGN],[CYP],[CZK],[DKK],[EEK],[GBP],[HUF],[LTL],[LVL],[MTL],[PLN],[ROL],[RON],[SEK],[SIT],[SKK],[CHF],[ISK],[NOK]
,[HRK],[RUB],[TRL],[TRY],[AUD],[BRL],[CAD],[CNY],[HKD],[IDR],[ILS],[INR],[KRW],[MXN],[MYR],[NZD],[PHP],[SGD],[THB],[ZAR]
  )
) upv ) SRC
ON SRC.[Date] = TRG.[Date] AND SRC.[Currency] = TRG.[Currency] 
WHEN NOT MATCHED THEN INSERT
VALUES ([Date],[Currency],[Rate],[ScaledPred]);