# ElectronicStore

A full-stack Java web application for an online electronics shopping platform, built with **Jakarta Servlet/JSP (MVC)**, **MySQL**, and **Maven WAR packaging**.

This project includes complete e-commerce flows such as authentication, product discovery, cart operations, checkout, order placement/cancellation, profile management, and address management.

---

## Project Overview

ElectronicStore is a monolithic web application designed for learning and demonstrating core web development architecture using:

- Java 21
- Jakarta Servlet 6.0 + JSP
- JSTL
- JDBC
- MySQL
- Maven
- Tomcat 10+ compatible runtime

It follows a layered architecture:

- **Presentation Layer**: JSP pages, static CSS/JS assets
- **Controller Layer**: Servlet controllers
- **Service Layer**: Business logic
- **DAO Layer**: Data access via JDBC
- **Model Layer**: Domain entities
- **Database Layer**: MySQL schema with seeded data

---

## Key Features

### User & Session
- User registration with duplicate username/email checks
- Login/logout flow
- Session-based authentication (`sessionScope.user`)
- Password hashing using SHA-256 + Base64
- Protected routes via authentication filter
- Session lifecycle logging via listener

### Product Catalog
- Product listing page
- Category-based filtering
- Price range filtering
- Sorting (low-to-high / high-to-low)
- Search by name/brand/description
- Product details page
- AJAX-based product specifications modal

### Cart
- Add item to cart
- Quantity increment/decrement
- Remove single item
- Clear full cart
- Auto-create cart per user if absent
- Cart access protection for unauthenticated users

### Checkout
- Checkout page with order summary
- Default address prefill
- Shipping method simulation (standard/express)
- COD (simulated payment)
- Place order flow
- Cart cleared after successful order

### Orders
- List user orders (latest first)
- View order details with items
- Cancel only `PLACED` orders
- Automatic stock restoration on cancellation
- Tracks `stock_restored` flag in DB

### Profile & Security
- Edit profile details
- Manage addresses (add/update/delete/default)
- Separate security page for:
  - name update
  - email update
  - phone update
  - password change with current-password validation

---

## System Architecture

## 1) High-Level Architecture

- **Client (Browser)**  
  Sends HTTP requests, renders JSP-generated HTML, executes JS for dynamic actions (cart updates, modal specs, etc).

- **Web Layer (Servlet Controllers + JSP Views)**  
  Controllers map routes, process request params, invoke services, and forward to JSP pages.

- **Business Layer (Services)**  
  Encapsulates business rules (cart lifecycle, order placement, cancellation logic, address default handling).

- **Persistence Layer (DAO + JDBC)**  
  Performs SQL operations using prepared statements and shared DB connection utility.

- **Database (MySQL)**  
  Stores users, products, categories, specifications, cart, orders, and addresses.

---

## 2) Request Flow (MVC Pattern)

1. User hits a route (e.g., `/products`, `/cart`, `/checkout`)
2. Servlet controller receives request
3. Controller reads inputs (query params/form params)
4. Controller delegates to service class
5. Service uses DAO interfaces/implementations
6. DAO executes SQL via `DBConnection`
7. Data returns back up the chain
8. Controller sets request attributes
9. JSP renders response (or redirect is issued)

---

## 3) Security/Access Architecture

- **Auth Filter** protects route patterns:
  - `/cart`
  - `/checkout`
  - `/orders`
  - `/profile`
  - `/order-details`
- **Cart Access Filter** ensures only logged-in users can manage cart actions
- Session utility centralizes:
  - set logged-in user
  - read logged-in user
  - check login status
  - logout/session invalidation

---

## 4) Data & Transactional Logic Architecture

### Order Placement
- Reads cart items for user
- Creates `Orders` row
- Creates `Order_Items` rows
- Decrements product stock
- Clears cart

### Order Cancellation
- Allowed only when status is `PLACED`
- Reads order items
- Restores stock per item
- Sets `stock_restored = true`
- Updates order status to `CANCELLED`

> Note: The current implementation performs sequential DB calls but not explicit JDBC transaction demarcation across all operations.

---

## Technology Stack

- **Language**: Java 21
- **Backend**: Jakarta Servlet API 6.0
- **View**: JSP + JSTL
- **Data Access**: JDBC
- **Database**: MySQL 8.x
- **Build Tool**: Maven
- **Packaging**: WAR
- **Server**: Apache Tomcat 10+

---

## Project Structure

```text
ElectronicStore/
├─ pom.xml
├─ schema.sql
├─ src/main/java/com/electronicstore/
│  ├─ controller/        # Servlet controllers
│  ├─ service/           # Business services
│  ├─ dao/
│  │  ├─ interfaces/     # DAO contracts
│  │  └─ implementations/# JDBC DAO implementations
│  ├─ model/             # Domain models (User, Product, Order, etc.)
│  ├─ util/              # DB connection, session, password util
│  ├─ filter/            # Auth/cart access filters
│  └─ listener/          # App/session lifecycle listener
├─ src/main/resources/
│  └─ db.properties      # DB URL, username, password, driver
└─ src/main/webapp/
   ├─ WEB-INF/web.xml
   ├─ auth/              # login/register views
   ├─ pages/             # products/cart/checkout/profile/orders/etc.
   ├─ partials/          # reusable JSP fragments (header/navbar/footer)
   └─ assets/            # css/js/images
```

---

## Database Design

The SQL schema includes these core tables:

- `Users`
- `Address`
- `Categories`
- `Products`
- `Product_Specifications`
- `Cart`
- `Cart_Items`
- `Orders`
- `Order_Items`

### Relationships (Conceptual ER)

- One `User` → many `Address`
- One `User` → one `Cart`
- One `Cart` → many `Cart_Items`
- One `Product` → many `Cart_Items`
- One `User` → many `Orders`
- One `Order` → many `Order_Items`
- One `Product` → many `Order_Items`
- One `Category` → many `Products`
- One `Product` → many `Product_Specifications`

### Seed Data Included

`schema.sql` preloads:
- 12 categories
- 50+ products
- rich product specifications
- INR-based pricing

---

## URL Endpoints (Controller Routes)

- `/home` (also root via HomeController mapping)
- `/products`
- `/product-details`
- `/auth` (POST for login/register)
- `/logout`
- `/cart`
- `/checkout`
- `/orders`
- `/profile`
- `/addresses`
- `/security`

---

## Configuration

### `pom.xml`
- WAR packaging
- Java source/target 21
- Dependencies:
  - `jakarta.servlet-api`
  - `jakarta.servlet.jsp-api`
  - `jakarta.el-api`
  - `jakarta.servlet.jsp.jstl-api`
  - `org.glassfish.web:jakarta.servlet.jsp.jstl`
  - `mysql-connector-j`

### `web.xml`
- Welcome file: `index.jsp`
- Session timeout: 30 minutes
- 404 redirected to `/home`

### `db.properties`
Contains:
- JDBC URL
- DB username
- DB password
- JDBC driver class

---

## Setup & Run Instructions

## Prerequisites
- JDK 21
- Maven 3.8+
- MySQL 8.x
- Apache Tomcat 10.x

## 1) Clone repository
```bash
git clone https://github.com/Vikas-Karthik-S/ElectronicStore.git
cd ElectronicStore
```

## 2) Create and seed database
Run `schema.sql` in MySQL client/workbench.

This will:
- create database `electronic_store`
- create all tables
- insert categories/products/specifications seed data

## 3) Configure DB credentials
Edit:
`src/main/resources/db.properties`

Set:
- `db.url`
- `db.username`
- `db.password`
- `db.driver`

## 4) Build project
```bash
mvn clean package
```

WAR generated at:
`target/ElectronicStore.war`

## 5) Deploy to Tomcat
- Copy `ElectronicStore.war` to `tomcat/webapps/`
- Start Tomcat
- Open:
`http://localhost:8080/ElectronicStore/`

> In this project, `AppSessionListener` also attempts to auto-open browser to app URL on startup.

---

## Default User Data

No fixed default login is hardcoded in the application logic.  
Create a new account from Register page and then login.

---

## Important Notes

- Passwords are hashed before storage (SHA-256 + Base64)
- `db.properties` currently stores DB credentials in plain text (development-friendly, not production-grade)
- Address ownership checks are present in controller logic during update/delete
- Order cancel is restricted to orders in `PLACED` status
- Product stock is adjusted on place/cancel flows

---

## Known Limitations / Improvement Areas

- No role-based admin panel although `role` exists in `Users`
- No payment gateway integration (COD simulation only)
- No explicit DB transaction management for multi-step checkout
- No REST API layer (server-side rendered JSP app)
- Basic validation only (server + minimal client-side)
- No automated tests included currently

---

## Suggested Future Enhancements

- Add admin dashboard for inventory/category/order management
- Add robust input validation and centralized error handling
- Add transaction boundaries for checkout/cancel consistency
- Add password salting/strong adaptive hashing (e.g., BCrypt/Argon2)
- Add pagination for products/orders
- Add advanced search + filters (brand list, stock, price slider)
- Add unit/integration tests
- Externalize secrets via environment variables

---

## Files Excluded from GitHub Upload

As per your note, these are intentionally excluded:

- `Internship_Report_Source.md`
- `Internship_Report.docx`
- `Review 2 ppt content.docx`
- `Vikas Karthik S_Internship_Report_Review_1.pptx`
- `.settings/`
- `.vscode/`

---

## License

This project currently has no explicit license file.  
If needed, add a `LICENSE` file (e.g., MIT/Apache-2.0) before public distribution.

---

## Author

**Vikas Karthik S**  
ElectronicStore Internship Project
