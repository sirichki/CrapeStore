CREATE DATABASE [MyCrape]

USE [MyCrape]
GO

/****** Object:  Table [dbo].[CATEGORY]    Script Date: 19/2/2566 2:09:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [dbo].[PRODUCT](
	[ID] [smallint] NOT NULL,
	[PROD_NAME] [nvarchar](155) NULL,
	[CATEGORY] [tinyint] NULL,
	[PRICE] [decimal](13, 2) NULL,
	[IS_ACTIVE] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[CATEGORY](
	[ID] [tinyint] NOT NULL,
	[CAT_NAME] [nvarchar](155) NULL,
	[IS_ACTIVE] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SALE](
	[SALE_ID] [int] NOT NULL,
	[SHIFT_ID] [tinyint] NULL,
	[DAY_ID] [smallint] NULL,
	[QUEUEID] [int] NULL,
	[GRANDTOTAL] [decimal](13, 2) NULL,
	[REMARK] [nvarchar](255) NULL,
	[CREATEDATE] [datetime] NULL,
	[MODDATE] [datetime] NULL,
	[IS_ACTIVE] [bit] NULL,
	[MODBY] [nvarchar](35) NULL,
PRIMARY KEY CLUSTERED 
(
	[SALE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SALE_DETAIL](
	[SALE_ID] [int] NOT NULL,
	[ITEM_NO] [smallint] NOT NULL,
	[QTY] [smallint] NULL,
	[PRICE] [decimal](13, 2) NULL,
	[TOTAL] [decimal](13, 2) NULL,
	[VATABLE] [decimal](13, 2) NULL,
	[VAT] [decimal](13, 2) NULL,
	[NETBFVAT] [decimal](13, 2) NULL,
	[NETTOTAL] [decimal](13, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[SALE_ID] ASC,
	[ITEM_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SALE_DETAIL_ITEM](
	[SALE_ID] [int] NOT NULL,
	[ITEM_NO] [smallint] NOT NULL,
	[PROD_ID] [smallint] NULL,
	[CAT_ID] [tinyint] NULL,
	[PRICE] [decimal](13, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[SALE_ID] ASC,
	[ITEM_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TB_PERIODS](
	[PERIOD_ID] [int] NOT NULL,
	[DAY_ID] [int] NULL,
	[SHIFT_ID] [tinyint] NULL,
	[BUS_DATE] [date] NULL,
	[PERIODTYPE] [bit] NULL,
	[PERIODSTATUS] [bit] NULL,
	[OPENTIME] [datetime] NULL,
	[CLOSETIME] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PERIOD_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE VIEW [dbo].[V_PRODUCT] 
AS
SELECT ROW_NUMBER() OVER( ORDER BY ID) AS VID
		,*
FROM PRODUCT
GO

INSERT INTO [dbo].[CATEGORY] VALUES
(0,'��',1)
,(1,'�����',1)
,(2,'�����ҹ',1)
,(3,'��ʿ��',1)
,(4,'��ʾ����',1)


INSERT INTO PRODUCT VALUES
(1,'�ҹ����',0,20.00,1)
,(1001,'����͡��',1,10.00,1)
,(1002,'����',1,10.00,1)
,(1003,'�ٹ��',1,10.00,1)
,(1004,'���Ѵ',1,10.00,1)
,(1005,'�����ͧ',1,10.00,1)
,(1006,'຤͹',1,10.00,1)
,(1007,'������',1,10.00,1)
,(1008,'�����ԡ��',1,10.00,1)
,(1009,'઴��Ҫ��',1,10.00,1)
,(1010,'��ʫ�������',1,10.00,1)
,(2001,'ʵ��������',2,10.00,1)
,(2002,'���������',2,10.00,1)
,(2003,'������',2,10.00,1)
,(2004,'�����ҹ����',2,10.00,1)
,(2005,'��͡��ŵ',2,10.00,1)
,(2006,'���������',2,10.00,1)
,(2007,'������',2,10.00,1)
,(2008,'��������',2,10.00,1)
,(2009,'�������',2,10.00,1)
,(2010,'�����鹪�',2,10.00,1)
,(2011,'������ŵԹ',2,10.00,1)
,(2012,'�������',2,10.00,1)
,(2013,'�ù���',2,10.00,1)
,(2014,'����͹��',2,10.00,1)
,(2015,'�������ǧ',2,10.00,1)
,(2016,'��·ͧ',2,10.00,1)
,(2017,'�������',2,10.00,1)
,(2018,'�¶���ʤԻ���',2,10.00,1)
,(3001,'������',3,0.00,1)
,(3002,'��ԡ��',3,0.00,1)
,(3003,'���ͧ��',3,0.00,1)
,(3004,'�������',3,0.00,1)
,(3005,'��ʾ�ԡ',3,0.00,1)
,(3006,'������ҹ',3,0.00,1)
,(3007,'��͡��ŵ',3,0.00,1)
,(4001,'��ʾԫ���',4,5.00,1)
,(4002,'��ʪ��',4,5.00,1)
,(4003,'ʵ���������',4,5.00,1)
,(4004,'��ʤ������',4,5.00,1)
