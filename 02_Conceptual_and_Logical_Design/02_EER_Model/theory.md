# EER Model

## Overview
The Enhanced Entity-Relationship (EER) model extends the basic ER model by adding more powerful modeling features. It is used when the data has inheritance, specialization, generalization, categories, or more complex relationships.

This model is especially useful in real-world systems where different kinds of entities share common characteristics.

---

## 1. Why EER is Needed

The standard ER model is very effective for basic entities and relationships. However, many real systems have:

- employees and customers both being persons,
- managers and regular employees sharing common attributes,
- different subtypes of products,
- overlapping entity categories,
- inheritance between entity types.

EER adds the concept of specialization/generalization to represent these patterns cleanly.

---

## 2. Superclass and Subclass

### Superclass
A general entity that contains common attributes.

Example:
- Person

### Subclass
A specialized entity that inherits from a superclass.

Examples:
- Employee
- Customer
- Student

```mermaid
classDiagram
    class Person {
        +PersonID
        +Name
        +DOB
    }

    class Employee {
        +EmployeeID
        +Salary
        +HireDate
    }

    class Customer {
        +CustomerID
        +MembershipNumber
    }

    Person <|-- Employee
    Person <|-- Customer
```

---

## 3. Generalization and Specialization

### Generalization
Combining multiple similar entities into one higher-level entity.

Example:
- Car, Truck, Van -> Vehicle

### Specialization
Breaking one general entity into multiple more specific ones.

Example:
- Person -> Employee, Student, Customer

This is often described as an IS-A relationship.

---

## 4. Disjoint vs Overlapping

### Disjoint specialization
An instance belongs to only one subclass.

Example:
- A person is either an Employee or a Student, but not both.

### Overlapping specialization
An instance may belong to more than one subclass.

Example:
- A person may be both Employee and Customer.

---

## 5. Total vs Partial Specialization

### Total specialization
Every superclass instance must belong to at least one subclass.

Example:
- Every person is either a student or a staff member.

### Partial specialization
Some superclass instances may not belong to any subclass.

Example:
- Some people are not students and not employees.

---

## 6. Categories and Union Types

A category is a subclass formed from multiple unrelated entity types.

Example:
- A `VehicleOwner` may be either a Person or a Company.

This is useful when groups share the same role but do not belong to the same superclass.

---

## 7. Aggregation in EER

Aggregation models a relationship where one entity is composed of or structured around another relationship.

This is useful when we need to represent higher-level business objects like:

- project team membership,
- shipment containing multiple items,
- order includes product lines.

---

## 8. EER Notation and Visual Representation

EER modeling uses the ER notation and adds inheritance-based symbols.

### 8.1 Superclass and subclass
A superclass is the general type, while a subclass is the specialized type.

```mermaid
flowchart TD
    P[Person]
    E[Employee]
    C[Customer]
    P -->|is-a| E
    P -->|is-a| C
```

### 8.2 Generalization and specialization
Generalization combines similar entities into a higher-level entity. Specialization splits one entity into more specific ones.

```mermaid
flowchart TB
    V[Vehicle]
    C[Car]
    T[Truck]
    V -->|generalization| C
    V -->|generalization| T
```

```mermaid
flowchart TB
    P[Person]
    E[Employee]
    S[Student]
    P -->|specialization| E
    P -->|specialization| S
```

### 8.3 Disjoint vs overlapping specialization
- Disjoint: an instance belongs to only one subclass.
- Overlapping: an instance may belong to more than one subclass.

```mermaid
flowchart LR
    P[Person]
    E[Employee]
    S[Student]
    P --> E
    P --> S
```

```mermaid
flowchart LR
    P[Person]
    E[Employee]
    C[Customer]
    P --> E
    P --> C
```

### 8.4 Total vs partial specialization
- Total specialization: every superclass instance must belong to at least one subclass.
- Partial specialization: some superclass instances may not belong to any subclass.

```mermaid
flowchart LR
    P[Person] -->|must be one of| E[Employee]
    P -->|must be one of| S[Student]
```

```mermaid
flowchart LR
    P[Person] -->|optional| E[Employee]
    P -->|optional| S[Student]
```

### 8.5 Categories and union types
A category is a subclass formed from multiple unrelated entity types.

```mermaid
flowchart LR
    O[VehicleOwner]
    P[Person]
    C[Company]
    P --> O
    C --> O
```

### 8.6 Cardinality and participation in EER
The same cardinality and participation ideas from ER are reused in EER diagrams.

```mermaid
flowchart LR
   D[Department] -->|"||"| S[Student]
```

```mermaid
flowchart LR
    A[Employee] -->|"1"| B[Project]
```

### 8.7 Primary key and inherited attributes
In EER, a subtype usually inherits the superclass primary key.

```mermaid
erDiagram
    PERSON {
        int PersonID PK
    }
    EMPLOYEE {
        int PersonID PK,FK
        decimal Salary
    }
    PERSON ||--o{ EMPLOYEE : "inherits"
```

### 8.8 Derived and multivalued attributes in EER
Specialized entities can also carry derived or multivalued properties.

```mermaid
flowchart TD
    P[Person]
    A[Age = derived]
    M[PhoneNumbers = multivalued]
    P --> A
    P --> M
```

> 💡 **EER visual rule**
> Use inheritance arrows for specialization/generalization and keep the same ER-style cardinality and participation rules for relationships between entities.

---

## 9. Diagram Illustration

![EER model diagram](images/eer%20diagram.jpg)

This image is stored beside the lesson and helps visualize specialization, generalization, and inheritance patterns in the EER model.

---

## 10. pgAdmin and SQL Mapping

EER concepts are usually designed before implementation. In pgAdmin, the equivalent implementation often looks like:

1. Create a general parent table, like `Person`
2. Add subtype tables like `Employee`, `Customer`, `Student`
3. Add primary and foreign keys from subtype tables back to the parent table
4. Define constraints to enforce specialization rules

---

## 11. Equivalent PostgreSQL Example

```sql
CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE
);

CREATE TABLE Employee (
    PersonID INT PRIMARY KEY,
    Salary NUMERIC(10,2),
    HireDate DATE,
    CONSTRAINT FK_Employee_Person
        FOREIGN KEY (PersonID)
        REFERENCES Person(PersonID)
);

CREATE TABLE Customer (
    PersonID INT PRIMARY KEY,
    MembershipNumber VARCHAR(50),
    CONSTRAINT FK_Customer_Person
        FOREIGN KEY (PersonID)
        REFERENCES Person(PersonID)
);
```

---

## 12. Exam-Friendly Summary

- EER model extends ER with inheritance and specialization
- Superclass = general type
- Subclass = specialized type
- Specialization and generalization model IS-A relationships
- Disjoint vs overlapping and total vs partial are important modeling choices
- EER helps represent realistic business hierarchies cleanly

> 💡 **Core idea**
> EER modeling lets us represent real-world inheritance and classification patterns that basic ER models cannot express well.

---

> 🔗 **See also**
> - [../01_ER_Model/theory.md](../01_ER_Model/theory.md)
> - [../04_EER_to_Relational_Mapping/theory.md](../04_EER_to_Relational_Mapping/theory.md)

