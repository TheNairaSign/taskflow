# TaskFlow – Mid-Level Flutter Assessment Project

## Project Name
TaskFlow

## Target
Mobile Developer Skills Assessment (Mid-Level Flutter)

## Objective
Generate a complete Flutter mobile application that demonstrates:
- REST API consumption
- Authentication (mocked)
- Clean architecture
- State management
- CRUD functionality
- Proper loading and error handling

The code must be assessment-ready, readable, and production-structured.

## Tech Stack (Mandatory)
- Flutter (latest stable)
- Dart
- State Management: Provider
- HTTP networking using http
- Local storage: SharedPreferences
- Public REST API: https://jsonplaceholder.typicode.com
- Material 3
- Light and Dark mode support

## App Features & Screens

### 1. Authentication (Mocked)
Login screen with:
- Email input
- Password input
- Validation (non-empty, valid email format)
- Simulate successful login if validation passes
- Persist login state using SharedPreferences
- Redirect authenticated users directly to Dashboard

### 2. Dashboard Screen
AppBar with:
- App title “TaskFlow”
- Profile avatar

Profile summary card:
- Name
- Email
- Avatar (mock image)

Task list fetched from:
- GET /todos

Display:
- Task title
- Status badge (Completed / Pending)
- Date (generated locally)
- Loading, empty, and error states

Floating Action Button to create a new task

### 3. Task Details Screen
Triggered on task tap  
Show:
- Task title
- Completion status
- Task ID
- Assigned user ID

Handle loading and error states  
Button to edit task

### 4. Create / Update Task Screen
Form fields:
- Title
- Description (optional)
- Completed toggle

Validation before submit  
Use:
- POST /todos for create
- PUT /todos/{id} for update

Show success or error feedback via SnackBar  
Update dashboard state immediately

## Architecture & Folder Structure
Enforce strict separation of concerns.
