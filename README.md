# internetBanking

A simple internet banking web application built using Java Servlets, JSP, and JavaScript. This project demonstrates core banking functionalities including user login, account creation, fund transfer, bill payment, and user profile updates.

---

## Features

- **User Authentication:** Login functionality with session management.
- **Account Management:** Open new bank accounts.
- **Fund Transfer:** Transfer money between accounts.
- **Bill Payment:** Pay bills securely.
- **Profile Updates:** Change user details like name, password, and mobile number.
- **Session Handling:** User-specific session data storage for secure transactions.

---

## Technology Stack

- **Backend:** Java Servlets (Java EE)
- **Frontend:** JSP, HTML, JavaScript
- **Database:** JDBC with ODBC bridge (configured for MS Access or similar)
- **Server:** Apache Tomcat or any Servlet container

---

## Project Structure

- **Controller.java:** Central servlet handling all user actions (login, transfer, payment, updates).
- **DAO Classes (`PDAO`, `PDAOU`):** Data access objects for interacting with the database.
- **JSP Pages:** Views for registration, login, transaction confirmation, and user interaction.
- **JavaScript:** Client-side validation and interactivity.

---

## How to Run

1. Configure your database connection in DAO classes (`PDAO`, `PDAOU`).
2. Deploy the project on a servlet container (e.g., Apache Tomcat).
3. Access the application via browser, starting with the `main.jsp` or login page.
4. Use the provided forms to interact with banking features.

---

## Notes

- Ensure the JDBC-ODBC bridge or appropriate database driver is configured.
- Proper session handling is implemented to maintain user state.
- Basic validation is included both on client-side (JavaScript) and server-side (Java).

