# Animation Enhancement Specification

## Objective
Enhance the existing application by adding subtle, purpose-driven animations while:
- Preserving all existing business logic
- Avoiding architectural changes
- Keeping code readable and review-friendly
- Using only Flutter SDK (no third-party animation libraries)

## Global Rules
- Do not modify API logic
- Do not introduce complex animation controllers unless absolutely necessary
- Prefer implicit animations
- Keep animations short (200–400ms)
- Animations must not interfere with state management or navigation flow

## 1. Screen Transition Animations

### Apply to
- Login → Dashboard
- Dashboard → Task Details
- Dashboard → Create / Update Task

### Implementation Requirements
- Replace default navigation with `PageRouteBuilder`
- Combine:
  - `FadeTransition`
  - `SlideTransition` (bottom → top)
- Duration: 250–300ms
- Extract transition logic into a reusable helper (e.g. `AppPageRoute`)

## 2. Task List Entry Animation

### Apply to
- Task list items on the Dashboard

### Implementation Requirements
- Animate items when first rendered after API fetch
- Use:
  - `TweenAnimationBuilder` or
  - `AnimatedList`
- Effects:
  - Opacity: 0 → 1
  - Vertical translation: +20px → 0px
- Stagger animation slightly based on index (simple delay logic)

## 3. Task Status Badge Animation

### Apply to
- Completed / Pending badge in:
  - Task list
  - Task details screen

### Implementation Requirements
- Use `AnimatedContainer`
- Animate:
  - Background color
  - Border radius (optional)
- Duration: 200–300ms
- Trigger animation when task completion state changes

## 4. Button Feedback Animations

### Apply to
- Login button
- Save Task button

### Implementation Requirements
- Use `AnimatedScale` or `AnimatedOpacity`
- Scale slightly on press or fade during loading
- Disable button interaction during API submission
- Replace button text with loading indicator when submitting

## Code Quality Expectations
- Keep animation code localized within widgets
- Avoid duplicating animation logic
- Add brief inline comments explaining animation purpose
- No unused animation code
- Respect existing theming and color system

Also add hero animations where necessary
