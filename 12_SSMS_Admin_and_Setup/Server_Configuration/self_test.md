# Self-Test — SSMS Server Configuration

> Status: ✅ Ready for practice.

**Q1. What does server configuration control?**

<details>
<summary>Show answer</summary>
It controls the instance-level settings such as security, authentication, connections, and memory.
</details>

**Q2. What is the main place to change SQL Server authentication mode in SSMS?**

<details>
<summary>Show answer</summary>
Server Properties → Security.
</details>

**Q3. Why is a service restart required after changing authentication mode?**

<details>
<summary>Show answer</summary>
Because the instance must reload the security configuration before accepting the new mode.
</details>

**Q4. What is the difference between Windows authentication and SQL authentication?**

<details>
<summary>Show answer</summary>
Windows authentication uses the Windows identity; SQL authentication uses a SQL login and password.
</details>

**Q5. Which T-SQL command creates a SQL login?**

<details>
<summary>Show answer</summary>
CREATE LOGIN LoginName WITH PASSWORD = 'Password';
</details>

**Q6. Why is careful management of server configuration important?**

<details>
<summary>Show answer</summary>
Because the instance configuration directly affects security, performance, stability, and access control.
</details>

---

## Quick revision

- Server config = instance-level settings
- Authentication mode = important security decision
- Restart = required after changing mode
- Login = server-level principal
- User = database-level principal
