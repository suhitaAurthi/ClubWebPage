# Event Creation Debug Guide

## Status: ✅ FIXED

The events page now has comprehensive debugging and error handling. Events are displaying correctly.

## What Was Fixed

### 1. **JavaScript Syntax Error** (CRITICAL)
- **Issue**: Duplicate code in the error handler was causing a syntax error that prevented events.js from loading
- **Fix**: Removed duplicate `alert()` statement and extra closing braces
- **Result**: JavaScript file now loads successfully

### 2. **Enhanced Error Logging** (events.js)
Added comprehensive console logging to track:
- Event creation process
- AJAX requests and responses  
- Data loading and rendering
- User authentication status
- Team member verification

### 3. **Improved Error Handling** (events.aspx.cs)
- All database exceptions now logged to Debug output
- Error messages returned to JavaScript
- Specific error details for troubleshooting

## How Event Creation Works Now

### Step 1: Form Submission
When a team member clicks "Save Event":
```javascript
console.log("===== createEvent STARTED =====");
console.log("Event Data:", eventData);
console.log("isApprovedTeamMember:", true/false);
console.log("currentUserId:", userId);
```

### Step 2: AJAX Call to Backend
```javascript
$.ajax({
    url: "events.aspx/CreateEventInDatabase",
    data: { ...event details, isPublished: boolean }
});
```

### Step 3: Backend Processing
Backend validates:
- User is logged in ✓
- User is a team member ✓
- Event data is valid ✓
- Saves to database ✓

### Step 4: Refresh Event List
```javascript
initializeEvents();
// Calls either:
// - loadPublishedEventsFromDatabase() [if not team member]
// - loadAllEventsFromDatabase(userId) [if team member]
```

---

## Testing Event Creation - New Console Logs

### Open Browser Console (F12)

#### Expected logs for successful creation:
```
===== createEvent STARTED =====
Event Data: {title: "...", description: "...", ...}
isApprovedTeamMember: true
currentUserId: 2
Editing existing event? false

===== CreateEventInDatabase SUCCESS =====
Raw Response: {d: "{"success": true, "message": "Event created successfully", "eventId": 2}"}
Parsed Result: {success: true, message: "...", eventId: 2}
✓ Event creation successful!
Waiting 1 second before refreshing events...
NOW calling initializeEvents to refresh the list

===== initializeEvents called =====
currentUserId: 2
isCurrentUserTeamMember: true
isApprovedTeamMember(): true
User logged in as ID: 2 Team member: true

===== loadAllEventsFromDatabase called with userId: 2
===== GetAllEvents AJAX success - Raw response: {d: "[{...event1...}, {...event2...}]"}
Parsed events: [{...}, {...}]
✓ Loaded all events count: 2
renderAllEvents called, events count: 2
```

---

## Troubleshooting Event Creation Issues

### Issue: Event Created But Not Showing

**Step 1: Check Console for Errors**
- Open browser console (F12)
- Look for "FAILED:" or "ERROR:" messages
- Check for red error messages

**Step 2: Verify Team Member Status**
Console should show:
```
isApprovedTeamMember: true
isCurrentUserTeamMember: true
```

If false, user is NOT a team member → can only see published events

**Step 3: Check if Event Was Published**
Look for `isPublished: true` or `isPublished: false` in logs

Published events → visible to everyone
Unpublished events → only visible to team members

**Step 4: Check AJAX Response**
Look for this log:
```
Parsed Result: {success: true, message: "...", eventId: X}
```

If you see `success: false`, check the error message

---

## Common Issues & Solutions

### Issue 1: "Error creating event: 500"
**Cause**: Server error in CreateEventInDatabase
**Solution**: Check Console for error details, check database connectivity

### Issue 2: "You are not authorized to create events"
**Cause**: User IsTeamMember flag is 0 in database
**Solution**: Set user's IsTeamMember = 1 in database

### Issue 3: "You must be logged in"
**Cause**: Session lost or login expired
**Solution**: Re-login to the application

### Issue 4: Event shows in console but not on page
**Cause**: renderAllEvents() not working
**Solution**: Check that DOM element `#eventsContainer` exists

---

## Database Checks

### Verify Event Was Created
```sql
SELECT TOP 5 EventId, EventName, EventDate, IsPublished, CreatedByUserId, CreatedDate
FROM Events
ORDER BY CreatedDate DESC;
```

### Verify User is Team Member
```sql
SELECT UserId, Username, IsTeamMember 
FROM Users 
WHERE UserId = @YourUserId;
```

### Check All Events
```sql
SELECT COUNT(*) as TotalEvents FROM Events;
SELECT COUNT(*) as PublishedEvents FROM Events WHERE IsPublished = 1;
```

---

## Step-by-Step Test Process

### For Team Members:

1. **Login** as a team member account
   - Check console: `isCurrentUserTeamMember: true`

2. **Navigate** to events page
   - Check console: `✓ Loaded all events count: X`

3. **Click** "Create Event" button
   - Form should appear

4. **Fill** in event details:
   - Title: "Test Event X"
   - Description: "Testing event creation"
   - Date: Tomorrow's date
   - Time: 10:00 - 12:00
   - Location: "Test Room"
   - Publish Status: **Published** (for visibility)

5. **Click** "Save Event"
   - Watch console for logs
   - Should see: `✓ Event creation successful!`
   - Wait 1 second for page refresh
   - New event should appear at top of list

6. **Verify** in database:
   ```sql
   SELECT * FROM Events WHERE EventName LIKE '%Test Event%' ORDER BY CreatedDate DESC;
   ```

---

## Console Log Reference

### Debug Output Format
Each major operation logs:
- Operation start: `===== functionName called =====`
- Input data: `Data: {...}`
- AJAX response: `Raw Response: {...}`
- Parsed result: `Parsed Result: {...}`  
- Success: `✓ Operation completed`
- Errors: `✗ Error: [message]`

### Filtering Logs
In Browser Console:
```javascript
// Filter to see only event creation logs
console.log(...);  // Type "createEvent" in filter box

// See only errors
console.error(...);  // Type "error" in filter box

// See only initializeEvents logs
console.log("===== initializeEvents");  // Type "====" to see all operations
```

---

## Performance Notes

- Event creation has 1-second delay before refresh (for database synchronization)
- AJAX calls use JSON serialization (standard format)
- Event list refreshes completely after each creation/edit

---

## Next Steps if Still Having Issues

1. **Check Server Logs**
   - IIS Express console should show request details
   - SQL Server errors (if any)

2. **Check Database Connection**
   - Test: `sqlcmd -S "SUHITA\SQLEXPRESS" -d "ClubProjDB" -U "sa" -P "sqlpass123" -Q "SELECT @@VERSION;"`

3. **Check User Permissions**
   - Verify Users table has correct IsTeamMember values
   - Verify EventId table exists and is accessible

4. **Restart Application**
   - Restart IIS Express
   - Clear browser cache (Ctrl+Shift+Del)
   - Re-login

5. **Report Issue**
   - Share console logs (F12 > Console tab > Copy all)
   - Include error messages
   - Include database state at time of issue
