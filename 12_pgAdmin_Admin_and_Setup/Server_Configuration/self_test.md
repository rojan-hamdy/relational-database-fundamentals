# Self-Test — pgAdmin & PostgreSQL Server Configuration

**Q1. What does server configuration control in PostgreSQL?**

<details>
<summary>Show answer</summary>
It controls instance-level settings such as memory allocation (shared_buffers, work_mem), authentication policies (pg_hba.conf), connection limits, and background server behavior.
</details>

**Q2. Where do you configure client authentication rules in PostgreSQL?**

<details>
<summary>Show answer</summary>
In the `pg_hba.conf` configuration file.
</details>

**Q3. How do you reload configuration changes in PostgreSQL without restarting the server?**

<details>
<summary>Show answer</summary>
By running `SELECT pg_reload_conf();` or using pgAdmin's Reload Configuration option.
</details>

**Q4. What is the difference between a Login Role and a Group Role in PostgreSQL?**

<details>
<summary>Show answer</summary>
A Login Role has the `LOGIN` privilege (can authenticate with a password/credentials), whereas a Group Role is used to bundle permissions and grant them to other roles.
</details>

**Q5. Which SQL statement creates a new login role in PostgreSQL?**

<details>
<summary>Show answer</summary>
CREATE ROLE RoleName WITH LOGIN PASSWORD 'Password';
</details>

**Q6. Why is careful management of server configuration important?**

<details>
<summary>Show answer</summary>
Because instance configuration directly affects security, performance, memory allocation, stability, and connection limits.
</details>

---

## Quick revision

- Server config = instance-level settings (postgresql.conf, pg_hba.conf)
- Authentication = configured in pg_hba.conf (e.g. scram-sha-256)
- Configuration reload = `SELECT pg_reload_conf();`
- Role = unified account in PostgreSQL (login accounts vs group roles)
- Permissions = granted via GRANT and default privileges
