# Events Not Visible - Troubleshooting Guide

## Problem Summary
Created events are not being visible in the events section of the website.

## Root Cause Analysis

### Critical Issue: Database Connection
The most likely cause is that the SQL Server is **not accessible** or the database **does not exist**.

**Connection String (from Web.config):**
```
Server=SUHITA\SQLEXPRESS;Database=ClubProjDB;User Id=sa;Password=sqlpass123;
```

### Verification Checklist

#### 1. **SQL Server Status** ✓
- [ ] SQL Server Express is running on the machine
- [ ] SQL Server instance "SUHITA\SQLEXPRESS" exists
- [ ] If running on a different machine, update the server name in Web.config

#### 2. **Database Exists** ✓
- [ ] Connect to SQL Server using SQL Server Management Studio
- [ ] Verify database "ClubProjDB" exists
- [ ] Run this query to check Events table:
```sql
SELECT TOP 10 * FROM Events;
```

#### 3. **Events Table Structure** ✓
Expected columns in Events table:
```sql
CREATE TABLE Events (
    EventId INT PRIMARY KEY IDENTITY(1,1),
    EventName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    EventType NVARCHAR(50),
    EventDate DATE,
    StartTime TIME,
    EndTime TIME,
    Location NVARCHAR(255),
    RegistrationStatus NVARCHAR(50),
    RegistrationLink NVARCHAR(255),
    ContestLink NVARCHAR(255),
    IsPublished BIT DEFAULT 0,
    CreatedByUserId INT,
    CreatedDate DATETIME DEFAULT GETDATE()
);
```

#### 4. **Users Table Structure** ✓
Expected to have IsTeamMember column:
```sql
SELECT TOP 5 UserId, Username, IsTeamMember FROM Users;
```

#### 5. **Sample Data Test** ✓
Insert a test event as published:
```sql
INSERT INTO Events (EventName, Description, EventType, EventDate, StartTime, EndTime, 
    Location, RegistrationStatus, IsPublished, CreatedByUserId, CreatedDate)
VALUES ('Test Event', 'This is a test event', 'normal', CAST(GETDATE() AS DATE), 
    CAST('10:00:00' AS TIME), CAST('12:00:00' AS TIME), 'Test Location', 'open', 1, 1, GETDATE());
```

Then refresh the events page. If you don't see this event, the database connection is broken.

---

## Error Messages to Look For

### In Browser Console (Press F12)
1. **No error shown** → Events page loads but shows "No events available"
   - Likely: Database is empty or query returned no results
   - Check: Are events published? (IsPublished = 1)

2. **Connection failed** → Shows "Error loading events. Connection failed."
   - Likely: SQL Server not running or not accessible
   - Check: SQL Server instance name and status

3. **Specific error message** → Shows database error
   - Check: Error message in console
   - This is now visible after our code fixes!

---

## Recent Code Improvements

### What Was Fixed:
1. **Added Better Error Logging**
   - All database catch blocks now log errors to Debug output
   - Error messages are now returned to JavaScript

2. **Improved JavaScript Error Handling**
   - JavaScript now detects and displays database errors
   - Connection failures are clearly indicated

3. **Enhanced User Feedback**
   - Events page now shows specific error messages when something fails
   - Better diagnostics for troubleshooting

---

## Step-by-Step Debugging Process

### Step 1: Open Browser Console
- Right-click on the Events page
- Select "Inspect" or press F12
- Go to "Console" tab

### Step 2: Look for Error Messages
- Should see "GetPublishedEvents response: ..." in logs
- If you see an error object, there's a database issue
- If you see empty array [], database is working but has no published events

### Step 3: Check Event Creation
- Login as a team member
- Create a new event and set "Published" to "Published"
- Check if event appears immediately after creation
- If not, check browser console for error messages

### Step 4: Verify Database Directly
Using SQL Server Management Studio:
```sql
-- Check if any published events exist
SELECT COUNT(*) as PublishedEventsCount FROM Events WHERE IsPublished = 1;

-- List all events
SELECT EventId, EventName, EventDate, IsPublished, CreatedByUserId 
FROM Events 
ORDER BY CreatedDate DESC;

-- Check if current user is a team member
SELECT UserId, Username, IsTeamMember FROM Users WHERE UserId = 1;
```

---

## Connection String Troubleshooting

### If SQL Server is on Different Machine
Update Web.config:
```xml
<add name="SGIPCConnection" 
     connectionString="Server=ACTUAL_SERVER_NAME\SQLEXPRESS;Database=ClubProjDB;User Id=sa;Password=sqlpass123;" 
     providerName="System.Data.SqlClient" />
```

### Common Issues:
- Wrong server name
- SQL Server not accessible over network (firewall)
- SQL Server not running
- Invalid credentials
- Database doesn't exist

---

## Quick Fixes

### If Events Still Not Showing After Fixes:

1. **Clear Browser Cache**
   - Press Ctrl+Shift+Delete
   - Clear all browser data
   - Refresh events page

2. **Check Application Logs**
   - Visual Studio Output window
   - Look for Debug messages with connection errors

3. **Restart IIS**
   - Open IIS Manager
   - Right-click Application Pool → Recycle
   - Refresh events page

4. **Test Database Connection Directly**
   ```csharp
   // In Visual Studio, add to events.aspx.cs Page_Load:
   try {
       SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString);
       conn.Open();
       System.Diagnostics.Debug.WriteLine("Database connection successful!");
       conn.Close();
   } catch (Exception ex) {
       System.Diagnostics.Debug.WriteLine("Database connection failed: " + ex.Message);
   }
   ```

---

## Event Visibility Rules

### Published Events (IsPublished = 1):
- Visible to all users (logged in or not)
- Shown via `GetPublishedEvents()` WebMethod

### Unpublished Events (IsPublished = 0):
- **Only visible to team members** (where IsTeamMember = 1)
- Shown via `GetAllEvents()` WebMethod
- Regular users see published events only

### Check if Current User is Team Member:
- User must have `IsTeamMember = 1` in Users table
- Team members can see ALL events (published and unpublished)
- Regular members can only see published events

---

## After Fix Verification

1. ✓ Restart IIS application pool
2. ✓ Clear browser cache
3. ✓ Open events page
4. ✓ Open browser console (F12)
5. ✓ Check for error messages or event data
6. ✓ Create test published event
7. ✓ Verify event appears immediately
8. ✓ Check database directly to confirm saved

---

## Support Information

If events still don't show:
1. Check browser console for specific error messages
2. Verify database connection in Web.config
3. Ensure Events table exists and has data
4. Check user IsTeamMember flag for visibility rules
5. Review SQL Server error logs for connection issues
