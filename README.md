XNL Banking App

Overview
XNL Banking App is a prototype mobile banking application built using Flutter. It provides users with a simple interface to manage transactions, view their balance, and perform basic banking operations. This project was developed as part of an assessment task within a constrained 24-hour deadline.

Features Implemented
- Dashboard Screen: Displays the user's balance and a list of transactions.
- Transaction Details Screen: Allows users to view transaction history.
- Payment Screen:** Provides an interface for entering recipient details and amount.
- State Management: Implemented using Riverpod for better scalability.
- Basic Validation: Ensures user inputs are valid before processing transactions.
- Logger Integration: Used for debugging and error tracking.

 Current Limitations
- Payment Gateway Not Implemented: The app currently simulates payment processing using placeholder logic. No actual transactions are processed.
- Backend Integration Missing: The app does not connect to a real backend or database.
- Authentication Not Implemented: No user authentication or security measures are in place.

Future Improvements
- Integrate a Payment Gateway: Implement a real transaction system using APIs like Razorpay, Stripe, or PayU.
- Backend Integration: Store transaction data securely in a backend database.
- User Authentication: Implement secure login and user management.
- UI Enhancements: Improve the design and add animations for a better user experience.

How to Run the App
1. Ensure you have Flutter installed (`flutter --version` should return a valid version).
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Start the application using `flutter run` on an emulator or physical device.

Notes
- The project was developed under a strict time constraint, resulting in incomplete features.
- Code improvements and additional functionality can be implemented in future iterations.

Author
Developed by Siddhi Rai as part of an assessment task.

