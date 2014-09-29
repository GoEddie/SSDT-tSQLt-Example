﻿---Build+
CREATE PROCEDURE tSQLt.AssertNotEquals
    @Expected SQL_VARIANT,
    @Actual SQL_VARIANT,
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
  IF (@Expected = @Actual)
  OR (@Expected IS NULL AND @Actual IS NULL)
  BEGIN
    DECLARE @msg NVARCHAR(MAX);
    SET @msg = 'Expected actual value to not ' + 
               COALESCE('equal <' + tSQLt.Private_SqlVariantFormatter(@Expected)+'>', 'be NULL') + 
               '.';
    EXEC tSQLt.Fail @msg, @Message;
  END;
  RETURN 0;
END;
---Build-