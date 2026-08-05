# Centralized vs Distributed Databases

> Status: ✅ Built as the architecture and data-placement lesson.

## Overview
A database system can be centralized or distributed depending on where the data is stored and how it is managed.

The choice affects availability, performance, cost, consistency, and fault tolerance.

---

## 1. Centralized database

A centralized database stores data in one main location, usually on a single server or cluster managed by one system.

### Characteristics
- single database server
- easier to administer
- simpler consistency model
- centralized backup and security
- may become a bottleneck as scale grows

### Example
A small business database hosted on one SQL Server instance.

---

## 2. Distributed database

A distributed database stores data across multiple physical locations or systems, often connected through a network.

### Characteristics
- data spread across nodes or regions
- high availability and scalability
- resilient to failures
- more complex coordination
- more difficult to maintain consistency

### Example
A multinational system with data replicated across regional servers.

---

## 3. Key differences

| Feature | Centralized DB | Distributed DB |
|---|---|---|
| Location | One main site/server | Multiple sites/nodes |
| Management | Simpler | More complex |
| Scalability | Limited | Better horizontal growth |
| Fault tolerance | Lower | Higher |
| Consistency | Easier to maintain | More challenging |
| Performance | Good for small/medium loads | Good for large-scale, global systems |

---

## 4. When to use centralized systems

Use centralized databases when:
- the application is small or medium-sized,
- a single team manages the database,
- consistency and simplicity are more important than huge scale,
- operational cost is a concern.

---

## 5. When to use distributed systems

Use distributed databases when:
- the application is global or large-scale,
- high availability is critical,
- data must be near users geographically,
- the system must scale horizontally.

---

## 6. Trade-offs

Centralized systems are easier to secure and govern but may become slower or less flexible at large scale.
Distributed systems are more scalable and resilient, but they require stronger replication, concurrency, and synchronization strategies.

---

## 7. Summary

A centralized database is easier to manage but limited in scale. A distributed database is more resilient and scalable but more complex.

> 💡 **Core idea**
> The architecture decision depends on the business goals: simplicity, consistency, and control versus scalability, resilience, and geographic reach.

---

> 🔗 **See also**
> - [../01_Foundations/02_Database_System_Architecture/theory.md](../01_Foundations/02_Database_System_Architecture/theory.md)
> - [../11_NoSQL/theory.md](../11_NoSQL/theory.md)
