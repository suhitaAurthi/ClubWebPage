-- =====================================================
-- SGIPC Website - Add Missing Columns to TeamMembers
-- Run this FIRST before SQL_Queries_TeamMembers.sql
-- =====================================================

USE ClubProjDB;
GO

-- Add Category column if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TeamMembers' AND COLUMN_NAME = 'Category')
BEGIN
    ALTER TABLE TeamMembers ADD Category NVARCHAR(100);
    PRINT 'Column Category added successfully.';
END
ELSE
BEGIN
    PRINT 'Column Category already exists.';
END;

-- Add RollNumber column if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TeamMembers' AND COLUMN_NAME = 'RollNumber')
BEGIN
    ALTER TABLE TeamMembers ADD RollNumber NVARCHAR(20);
    PRINT 'Column RollNumber added successfully.';
END
ELSE
BEGIN
    PRINT 'Column RollNumber already exists.';
END;

-- Add BatchYear column if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TeamMembers' AND COLUMN_NAME = 'BatchYear')
BEGIN
    ALTER TABLE TeamMembers ADD BatchYear NVARCHAR(10);
    PRINT 'Column BatchYear added successfully.';
END
ELSE
BEGIN
    PRINT 'Column BatchYear already exists.';
END;

-- Verify the columns exist
SELECT 'TeamMembers Table Structure' as Info, COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'TeamMembers'
ORDER BY ORDINAL_POSITION;
