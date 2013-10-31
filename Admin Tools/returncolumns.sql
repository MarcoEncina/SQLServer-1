/* 

Return non-default, non-identity columns

*/


CREATE PROCEDURE stp_ReturnColumns
@table VARCHAR(250)
AS
BEGIN

	SELECT STUFF((SELECT ', ' + ii.COLUMN_NAME AS [text()]
		FROM INFORMATION_SCHEMA.COLUMNS ii
		WHERE i.TABLE_NAME = ii.TABLE_NAME
			AND COLUMN_DEFAULT IS NULL
			AND COLUMNPROPERTY(object_id(TABLE_NAME),COLUMN_NAME,'IsIdentity') = 0
		ORDER BY ii.COLUMN_NAME
		FOR XML PATH('')),1,1,'') AS TableColumns
	FROM INFORMATION_SCHEMA.COLUMNS i
	WHERE TABLE_NAME = @table
	GROUP BY TABLE_NAME

END
