-- =====================================================
-- SGIPC Website - Complete Team Members Setup
-- RUN THIS SINGLE FILE - It does everything!
-- =====================================================

USE ClubProjDB;
GO

-- =====================================================
-- STEP 1: Create TeamMembers table if it doesn't exist
-- =====================================================

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TeamMembers')
BEGIN
    CREATE TABLE TeamMembers (
        TeamMemberId INT PRIMARY KEY IDENTITY(1,1),
        FirstName NVARCHAR(100) NOT NULL,
        LastName NVARCHAR(100) NOT NULL,
        Email NVARCHAR(255) NOT NULL UNIQUE,
        Role NVARCHAR(100),
        Category NVARCHAR(100),
        RollNumber NVARCHAR(20),
        BatchYear NVARCHAR(10),
        PhoneNumber NVARCHAR(15),
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'TeamMembers table created successfully.';
END
ELSE
BEGIN
    PRINT 'TeamMembers table already exists. Adding missing columns...';
    
    -- Add Category column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TeamMembers' AND COLUMN_NAME = 'Category')
    BEGIN
        ALTER TABLE TeamMembers ADD Category NVARCHAR(100);
        PRINT 'Column Category added.';
    END;
    
    -- Add RollNumber column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TeamMembers' AND COLUMN_NAME = 'RollNumber')
    BEGIN
        ALTER TABLE TeamMembers ADD RollNumber NVARCHAR(20);
        PRINT 'Column RollNumber added.';
    END;
    
    -- Add BatchYear column
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TeamMembers' AND COLUMN_NAME = 'BatchYear')
    BEGIN
        ALTER TABLE TeamMembers ADD BatchYear NVARCHAR(10);
        PRINT 'Column BatchYear added.';
    END;
END;

GO

-- =====================================================
-- STEP 2: Delete existing data to avoid duplicates
-- =====================================================

DELETE FROM TeamMembers WHERE Email LIKE '%@stud.kuet.ac.bd%';
PRINT 'Cleared existing team member data.';

GO

-- =====================================================
-- STEP 3: Insert All Team Members Data
-- =====================================================

-- Leadership Team
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Nilay', 'Das', 'nilay@stud.kuet.ac.bd', 'President', 'Club Leadership', '2007086', '2k20', '+8801700000001', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md. Tanjimul', 'Hasan', 'tanjimul@stud.kuet.ac.bd', 'Vice President', 'Club Leadership', '2007081', '2k20', '+8801700000002', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Shah Md', 'Khalil Ullah', 'khalil@stud.kuet.ac.bd', 'Vice President', 'Club Leadership', '2007090', '2k20', '+8801700000003', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Khadimul', 'Islam Mahi', 'mahi@stud.kuet.ac.bd', 'General Secretary', 'Club Leadership', '2107076', '2k21', '+8801700000004', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Mohammad Abu Daud', 'Sharif', 'sharif@stud.kuet.ac.bd', 'Assistant General Secretary', 'Club Leadership', '2107002', '2k21', '+8801700000005', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md', 'Umar Faruk', 'faruk@stud.kuet.ac.bd', 'Treasurer', 'Club Leadership', '2007016', '2k20', '+8801700000006', 1);

-- Core Team Members
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Amit', 'Kairy', 'amit@stud.kuet.ac.bd', 'Organizing Secretary', 'Core Team Members', '2007069', '2k20', '+8801700000007', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md. Ashraful', 'Haque Sifat', 'sifat@stud.kuet.ac.bd', 'Organizing Secretary', 'Core Team Members', '2007082', '2k20', '+8801700000008', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Siam', 'Arif', 'siam@stud.kuet.ac.bd', 'Assistant Organizing Secretary', 'Core Team Members', '2107062', '2k21', '+8801700000009', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Siyam', 'Khan', 'siyam@stud.kuet.ac.bd', 'Assistant Organizing Secretary', 'Core Team Members', '2107120', '2k21', '+8801700000010', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Abdullah Al', 'Saif', 'saif@stud.kuet.ac.bd', 'Assistant Organizing Secretary', 'Core Team Members', '2107017', '2k21', '+8801700000011', 1);

-- Performance Analyzers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Sujoy', 'Sadhu', 'sujoy@stud.kuet.ac.bd', 'Performance Analyzer', 'Performance Analyzers', '2007019', '2k20', '+8801700000012', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md. Asif', 'Rahman', 'asif@stud.kuet.ac.bd', 'Performance Analyzer', 'Performance Analyzers', '2007044', '2k20', '+8801700000013', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md', 'Hafizur Rahman', 'hafizur@stud.kuet.ac.bd', 'Performance Analyzer', 'Performance Analyzers', '2007080', '2k20', '+8801700000014', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Rahul', 'Sheikh', 'rahul@stud.kuet.ac.bd', 'Performance Analyzer', 'Performance Analyzers', '2107063', '2k21', '+8801700000015', 1);

-- Batch Representatives
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Saleque Bin', 'Hossain', 'saleque@stud.kuet.ac.bd', 'Batch Representative (2k21)', 'Batch Representatives', '2107026', '2k21', '+8801700000016', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Alok', 'Baul', 'alok@stud.kuet.ac.bd', 'Batch Representative (2k22)', 'Batch Representatives', '2207098', '2k22', '+8801700000017', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md', 'Farhan Ishraq', 'farhan@stud.kuet.ac.bd', 'Batch Representative (2k23)', 'Batch Representatives', '2307012', '2k23', '+8801700000018', 1);

-- Senior Mentors
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md', 'Babla Islam', 'babla@stud.kuet.ac.bd', 'Senior Mentor for Boys', 'Senior Mentor for Boys', '2007045', '2k20', '+8801700000019', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md', 'Raihan Hossain Rakib', 'raihan@stud.kuet.ac.bd', 'Senior Mentor for Boys', 'Senior Mentor for Boys', '2007005', '2k20', '+8801700000020', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Rauful', 'Islam Tamum', 'rauful@stud.kuet.ac.bd', 'Senior Mentor for Boys', 'Senior Mentor for Boys', '2007009', '2k20', '+8801700000021', 1);

-- Junior Mentors
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Farid', 'Ahmed', 'farid@stud.kuet.ac.bd', 'Junior Mentor For Boys', 'Junior Mentor For Boys', '2107043', '2k21', '+8801700000022', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md', 'Mosaddek Ali', 'mosaddek@stud.kuet.ac.bd', 'Junior Mentor For Boys', 'Junior Mentor For Boys', '2107027', '2k21', '+8801700000023', 1);

-- Contest Managers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Dipra', 'Datta', 'dipra@stud.kuet.ac.bd', 'Contest Manager', 'Contest Manager', '2107070', '2k21', '+8801700000024', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Ankon', 'Roy', 'ankon@stud.kuet.ac.bd', 'Contest Manager', 'Contest Manager', '2107113', '2k21', '+8801700000025', 1);

-- Assistant Contest Managers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Sk.Nazmus', 'Salehin Nirob', 'nazmus@stud.kuet.ac.bd', 'Assistant Contest Manager', 'Assistant Contest Manager', '2207045', '2k22', '+8801700000026', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Nurul', 'Absar Shadik', 'nurul@stud.kuet.ac.bd', 'Assistant Contest Manager', 'Assistant Contest Manager', '2207065', '2k22', '+8801700000027', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Sazzad', 'Ahmed', 'sazzad@stud.kuet.ac.bd', 'Assistant Contest Manager', 'Assistant Contest Manager', '2207026', '2k22', '+8801700000028', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('MD Shahariar', 'Emon Saikat', 'shahariar@stud.kuet.ac.bd', 'Assistant Contest Manager', 'Assistant Contest Manager', '2207002', '2k22', '+8801700000029', 1);

-- Workshop Managers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Raihan', 'Arefin', 'raihanarefin@stud.kuet.ac.bd', 'Workshop Manager', 'Workshop Manager', '2107065', '2k21', '+8801700000030', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Naqibul', 'Haque', 'naqibul@stud.kuet.ac.bd', 'Workshop Manager', 'Workshop Manager', '2107077', '2k21', '+8801700000031', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md', 'Tariful Islam Jony', 'tariful@stud.kuet.ac.bd', 'Workshop Manager', 'Workshop Manager', '2107119', '2k21', '+8801700000032', 1);

-- Assistant Workshop Managers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Shah', 'Makhdum Sharif', 'makhdum@stud.kuet.ac.bd', 'Assistant Workshop Manager', 'Assistant Workshop Manager', '2207089', '2k22', '+8801700000033', 1);

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
VALUES ('Md', 'Taki Tahmid Saad', 'taki@stud.kuet.ac.bd', 'Assistant Workshop Manager', 'Assistant Workshop Manager', '2207022', '2k22', '+8801700000034', 1);

GO

-- =====================================================
-- STEP 4: Verify Data
-- =====================================================

PRINT '';
PRINT '=== Team Members by Category ===';
SELECT DISTINCT Category FROM TeamMembers WHERE IsActive = 1 ORDER BY Category;

PRINT '';
PRINT '=== Total Team Members Inserted ===';
SELECT COUNT(*) as TotalMembers FROM TeamMembers WHERE IsActive = 1;

PRINT '';
PRINT '=== All Team Members ===';
SELECT TeamMemberId, FirstName + ' ' + LastName as FullName, Role, Category, RollNumber, BatchYear 
FROM TeamMembers 
WHERE IsActive = 1 
ORDER BY Category, Role, FirstName;

PRINT '';
PRINT 'Setup completed successfully!';

-- =====================================================
-- STEP 3: Insert All Team Members Data
-- =====================================================

-- Leadership Team
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Nilay', 'Das', 'nilay@stud.kuet.ac.bd', 'President', 'Club Leadership', '2007086', '2k20', '+8801700000001', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'nilay@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md. Tanjimul', 'Hasan', 'tanjimul@stud.kuet.ac.bd', 'Vice President', 'Club Leadership', '2007081', '2k20', '+8801700000002', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'tanjimul@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Shah Md', 'Khalil Ullah', 'khalil@stud.kuet.ac.bd', 'Vice President', 'Club Leadership', '2007090', '2k20', '+8801700000003', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'khalil@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Khadimul', 'Islam Mahi', 'mahi@stud.kuet.ac.bd', 'General Secretary', 'Club Leadership', '2107076', '2k21', '+8801700000004', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'mahi@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Mohammad Abu Daud', 'Sharif', 'sharif@stud.kuet.ac.bd', 'Assistant General Secretary', 'Club Leadership', '2107002', '2k21', '+8801700000005', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'sharif@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md', 'Umar Faruk', 'faruk@stud.kuet.ac.bd', 'Treasurer', 'Club Leadership', '2007016', '2k20', '+8801700000006', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'faruk@stud.kuet.ac.bd');

-- Core Team Members
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Amit', 'Kairy', 'amit@stud.kuet.ac.bd', 'Organizing Secretary', 'Core Team Members', '2007069', '2k20', '+8801700000007', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'amit@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md. Ashraful', 'Haque Sifat', 'sifat@stud.kuet.ac.bd', 'Organizing Secretary', 'Core Team Members', '2007082', '2k20', '+8801700000008', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'sifat@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Siam', 'Arif', 'siam@stud.kuet.ac.bd', 'Assistant Organizing Secretary', 'Core Team Members', '2107062', '2k21', '+8801700000009', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'siam@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Siyam', 'Khan', 'siyam@stud.kuet.ac.bd', 'Assistant Organizing Secretary', 'Core Team Members', '2107120', '2k21', '+8801700000010', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'siyam@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Abdullah Al', 'Saif', 'saif@stud.kuet.ac.bd', 'Assistant Organizing Secretary', 'Core Team Members', '2107017', '2k21', '+8801700000011', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'saif@stud.kuet.ac.bd');

-- Performance Analyzers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Sujoy', 'Sadhu', 'sujoy@stud.kuet.ac.bd', 'Performance Analyzer', 'Performance Analyzers', '2007019', '2k20', '+8801700000012', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'sujoy@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md. Asif', 'Rahman', 'asif@stud.kuet.ac.bd', 'Performance Analyzer', 'Performance Analyzers', '2007044', '2k20', '+8801700000013', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'asif@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md', 'Hafizur Rahman', 'hafizur@stud.kuet.ac.bd', 'Performance Analyzer', 'Performance Analyzers', '2007080', '2k20', '+8801700000014', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'hafizur@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Rahul', 'Sheikh', 'rahul@stud.kuet.ac.bd', 'Performance Analyzer', 'Performance Analyzers', '2107063', '2k21', '+8801700000015', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'rahul@stud.kuet.ac.bd');

-- Batch Representatives
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Saleque Bin', 'Hossain', 'saleque@stud.kuet.ac.bd', 'Batch Representative (2k21)', 'Batch Representatives', '2107026', '2k21', '+8801700000016', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'saleque@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Alok', 'Baul', 'alok@stud.kuet.ac.bd', 'Batch Representative (2k22)', 'Batch Representatives', '2207098', '2k22', '+8801700000017', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'alok@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md', 'Farhan Ishraq', 'farhan@stud.kuet.ac.bd', 'Batch Representative (2k23)', 'Batch Representatives', '2307012', '2k23', '+8801700000018', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'farhan@stud.kuet.ac.bd');

-- Senior Mentors
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md', 'Babla Islam', 'babla@stud.kuet.ac.bd', 'Senior Mentor for Boys', 'Senior Mentor for Boys', '2007045', '2k20', '+8801700000019', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'babla@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md', 'Raihan Hossain Rakib', 'raihan@stud.kuet.ac.bd', 'Senior Mentor for Boys', 'Senior Mentor for Boys', '2007005', '2k20', '+8801700000020', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'raihan@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Rauful', 'Islam Tamum', 'rauful@stud.kuet.ac.bd', 'Senior Mentor for Boys', 'Senior Mentor for Boys', '2007009', '2k20', '+8801700000021', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'rauful@stud.kuet.ac.bd');

-- Junior Mentors
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Farid', 'Ahmed', 'farid@stud.kuet.ac.bd', 'Junior Mentor For Boys', 'Junior Mentor For Boys', '2107043', '2k21', '+8801700000022', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'farid@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md', 'Mosaddek Ali', 'mosaddek@stud.kuet.ac.bd', 'Junior Mentor For Boys', 'Junior Mentor For Boys', '2107027', '2k21', '+8801700000023', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'mosaddek@stud.kuet.ac.bd');

-- Contest Managers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Dipra', 'Datta', 'dipra@stud.kuet.ac.bd', 'Contest Manager', 'Contest Manager', '2107070', '2k21', '+8801700000024', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'dipra@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Ankon', 'Roy', 'ankon@stud.kuet.ac.bd', 'Contest Manager', 'Contest Manager', '2107113', '2k21', '+8801700000025', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'ankon@stud.kuet.ac.bd');

-- Assistant Contest Managers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Sk.Nazmus', 'Salehin Nirob', 'nazmus@stud.kuet.ac.bd', 'Assistant Contest Manager', 'Assistant Contest Manager', '2207045', '2k22', '+8801700000026', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'nazmus@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Nurul', 'Absar Shadik', 'nurul@stud.kuet.ac.bd', 'Assistant Contest Manager', 'Assistant Contest Manager', '2207065', '2k22', '+8801700000027', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'nurul@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Sazzad', 'Ahmed', 'sazzad@stud.kuet.ac.bd', 'Assistant Contest Manager', 'Assistant Contest Manager', '2207026', '2k22', '+8801700000028', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'sazzad@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'MD Shahariar', 'Emon Saikat', 'shahariar@stud.kuet.ac.bd', 'Assistant Contest Manager', 'Assistant Contest Manager', '2207002', '2k22', '+8801700000029', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'shahariar@stud.kuet.ac.bd');

-- Workshop Managers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Raihan', 'Arefin', 'raihanarefin@stud.kuet.ac.bd', 'Workshop Manager', 'Workshop Manager', '2107065', '2k21', '+8801700000030', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'raihanarefin@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Naqibul', 'Haque', 'naqibul@stud.kuet.ac.bd', 'Workshop Manager', 'Workshop Manager', '2107077', '2k21', '+8801700000031', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'naqibul@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md', 'Tariful Islam Jony', 'tariful@stud.kuet.ac.bd', 'Workshop Manager', 'Workshop Manager', '2107119', '2k21', '+8801700000032', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'tariful@stud.kuet.ac.bd');

-- Assistant Workshop Managers
INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Shah', 'Makhdum Sharif', 'makhdum@stud.kuet.ac.bd', 'Assistant Workshop Manager', 'Assistant Workshop Manager', '2207089', '2k22', '+8801700000033', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'makhdum@stud.kuet.ac.bd');

INSERT INTO TeamMembers (FirstName, LastName, Email, Role, Category, RollNumber, BatchYear, PhoneNumber, IsActive)
SELECT 'Md', 'Taki Tahmid Saad', 'taki@stud.kuet.ac.bd', 'Assistant Workshop Manager', 'Assistant Workshop Manager', '2207022', '2k22', '+8801700000034', 1
WHERE NOT EXISTS (SELECT 1 FROM TeamMembers WHERE Email = 'taki@stud.kuet.ac.bd');

-- =====================================================
-- STEP 4: Verify Data
-- =====================================================

PRINT '';
PRINT '=== Team Members by Category ===';
SELECT DISTINCT Category FROM TeamMembers WHERE IsActive = 1 ORDER BY Category;

PRINT '';
PRINT '=== Total Team Members Inserted ===';
SELECT COUNT(*) as TotalMembers FROM TeamMembers WHERE IsActive = 1;

PRINT '';
PRINT '=== All Team Members ===';
SELECT TeamMemberId, FirstName + ' ' + LastName as FullName, Role, Category, RollNumber, BatchYear 
FROM TeamMembers 
WHERE IsActive = 1 
ORDER BY Category, Role, FirstName;

PRINT '';
PRINT 'Setup completed successfully!';
