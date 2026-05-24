-- =====================================================
-- SGIPC Website - Alter Tables for Event Management
-- =====================================================

USE ClubProjDB;
GO

-- =====================================================
-- ADD IsTeamMember COLUMN TO Users TABLE
-- =====================================================

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'IsTeamMember')
    ALTER TABLE Users ADD IsTeamMember BIT DEFAULT 0;

-- Update team members (set IsTeamMember = 1 for these users)
UPDATE Users SET IsTeamMember = 1 WHERE Email IN (
    'nilay@stud.kuet.ac.bd',
    'tanjimul@stud.kuet.ac.bd',
    'khalil@stud.kuet.ac.bd',
    'mahi@stud.kuet.ac.bd',
    'sharif@stud.kuet.ac.bd',
    'faruk@stud.kuet.ac.bd',
    'amit@stud.kuet.ac.bd',
    'sifat@stud.kuet.ac.bd',
    'siam@stud.kuet.ac.bd',
    'siyam@stud.kuet.ac.bd'
);

-- =====================================================
-- ADD COLUMNS TO Events TABLE FOR EVENT MANAGEMENT
-- =====================================================

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Events' AND COLUMN_NAME = 'StartTime')
    ALTER TABLE Events ADD StartTime TIME;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Events' AND COLUMN_NAME = 'EndTime')
    ALTER TABLE Events ADD EndTime TIME;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Events' AND COLUMN_NAME = 'RegistrationStatus')
    ALTER TABLE Events ADD RegistrationStatus NVARCHAR(50);  -- 'open', 'closed', 'coming-soon'

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Events' AND COLUMN_NAME = 'RegistrationLink')
    ALTER TABLE Events ADD RegistrationLink NVARCHAR(500);

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Events' AND COLUMN_NAME = 'ContestLink')
    ALTER TABLE Events ADD ContestLink NVARCHAR(500);

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Events' AND COLUMN_NAME = 'IsPublished')
    ALTER TABLE Events ADD IsPublished BIT DEFAULT 0;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Events' AND COLUMN_NAME = 'CreatedByUserId')
    ALTER TABLE Events ADD CreatedByUserId INT;

-- Verify the updated tables structure
SELECT 'Users Table' as TableName, COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users'
UNION ALL
SELECT 'Events Table' as TableName, COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Events';

-- =====================================================
-- ALTER EventRegistrations TABLE
-- =====================================================

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EventRegistrations')
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'EventRegistrations' AND COLUMN_NAME = 'Status')
        ALTER TABLE EventRegistrations ADD Status NVARCHAR(50);
END;

-- =====================================================
-- VERIFY TEAM MEMBERS SETUP
-- =====================================================

-- View all team members (IsTeamMember = 1)
SELECT UserId, Email, Username, Roll, IsTeamMember FROM Users WHERE IsTeamMember = 1;

-- =====================================================
-- USEFUL QUERIES
-- =====================================================

-- Get all team members
-- SELECT UserId, Email, Username, Roll FROM Users WHERE IsTeamMember = 1;

-- Get all events
-- SELECT * FROM Events ORDER BY EventDate DESC;

-- Get published events only
-- SELECT * FROM Events WHERE IsPublished = 1 ORDER BY EventDate DESC;

-- Get events created by specific user
-- SELECT * FROM Events WHERE CreatedByUserId = @UserId ORDER BY EventDate DESC;

-- Get all registrations for specific event
-- SELECT u.Username, u.Email, r.RegistrationDate, r.Status
-- FROM EventRegistrations r
-- INNER JOIN Users u ON r.UserId = u.UserId
-- WHERE r.EventId = @EventId
-- ORDER BY r.RegistrationDate DESC;

