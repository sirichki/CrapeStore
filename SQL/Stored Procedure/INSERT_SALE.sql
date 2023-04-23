USE [MyCrape]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_SALE]    Script Date: 5/3/2566 1:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[INSERT_SALE] (
 @STRINGLINE NVARCHAR(MAX)
)
AS 
BEGIN
DECLARE @SID INT = ISNULL((SELECT MAX(SALE_ID) FROM SALE),0) + 1
DECLARE @DID INT = ISNULL((SELECT MAX(DAY_ID) FROM TB_PERIODS),1)
DECLARE @SHIFTID INT =  ISNULL((SELECT MAX(SHIFT_ID) FROM TB_PERIODS WHERE DAY_ID = @DID),1)

INSERT INTO [dbo].[SALE_DETAIL_ITEM]
SELECT @SID AS SALE_ID
		,ROW_NUMBER() OVER(ORDER BY S.[VALUE]) AS ITEM_NO
		,S.[VALUE] AS PROD_ID
		,P.CATEGORY AS CAT_ID
		,P.PRICE AS PRICE
FROM (
SELECT [VALUE] FROM STRING_SPLIT(@STRINGLINE,',')) S
INNER JOIN PRODUCT P
ON S.[VALUE] = P.ID
WHERE P.IS_ACTIVE = 1
ORDER BY P.ID

INSERT INTO [dbo].[SALE_DETAIL]
SELECT @SID AS SALE_ID
		,1 AS ITEM_NO
		,1 AS QTY
		,ISNULL((SELECT SUM(PRICE) FROM [SALE_DETAIL_ITEM] WHERE SALE_ID = @SID),0) AS PRICE
		,0 AS TOTAL
		,0 AS VATABLE
		,0 AS VAT
		,0 AS NETBFVAT
		,0 AS NETTOTAL

UPDATE SALE_DETAIL
SET TOTAL = PRICE * QTY
,VATABLE = PRICE * QTY
,VAT = CONVERT(DECIMAL(13,2),(PRICE * QTY) * 7.0/107)
,NETBFVAT = CONVERT(DECIMAL(13,2),(PRICE * QTY) - ((PRICE * QTY) * 7.0/107))
,NETTOTAL = PRICE * QTY
WHERE SALE_ID = @SID

INSERT INTO SALE
SELECT @SID
		,ISNULL((SELECT SHIFT_ID FROM TB_PERIODS WHERE PERIODTYPE = 1 AND PERIODSTATUS = 0),ISNULL((SELECT MAX(SHIFT_ID) FROM TB_PERIODS WHERE PERIODTYPE = 1 AND DAY_ID = @DID),1))
		,ISNULL((SELECT DAY_ID FROM TB_PERIODS WHERE PERIODTYPE = 1 AND PERIODSTATUS = 0),@DID)
		,ISNULL((SELECT MAX(QUEUEID) FROM SALE WHERE DAY_ID	= @DID AND SHIFT_ID = @SHIFTID),0) + 1
		,ISNULL((SELECT SUM(TOTAL) FROM SALE_DETAIL WHERE SALE_ID = @SID),0)
		,''
		,GETDATE()
		,GETDATE()
		,1
		,'SYSADMIN'
END