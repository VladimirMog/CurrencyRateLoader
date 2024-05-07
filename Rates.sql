CREATE OR ALTER TABLE [dbo].[Rates](
	[Date] [date] NOT NULL,
	[Currency] [nvarchar](3) NOT NULL,
	[Rate] [money] NULL,
	[ScaledRate]  AS ([Rate]*case when [Rate]<(1) then (10) when [Rate]>(100000) then (0.00001) when [Rate]>(10000) then (0.0001) when [Rate]>(1000) then (0.001) when [Rate]>(100) then (0.01) when [Rate]>(10) then (0.1) else (1) end) PERSISTED,
	[ScaledPred] [money] NULL,
 CONSTRAINT [PK_Rates] PRIMARY KEY CLUSTERED 
(
	[Date] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO