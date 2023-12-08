/******************************************************************************************************
************ KWADWO APPIAH | 1713858 | CIS622 DATA ARCHITECTURE | ART ANALYSIS PROJECT*****************
To define groups, assign permissions, and create users in PostgreSQL for the Art Analysis database, We will assume three distinct user groups with specific reasons to access the data:
1.	Curators:
Curators require full access to the database to effectively manage and update information related to artists, artworks, and museums. This access includes read and write permissions, allowing them to keep the database up-to-date with the most accurate and relevant information.
2.	Researchers:
For academic or research purposes, researchers may need to access the data solely for analysis. Ensuring they do not have permission to modify the database in any way is imperative. Therefore, read-only access is the appropriate level of access required for such tasks.
3.	Guests:
As an organization, we have identified that guests require enhanced read access to view basic information about artworks. Additionally, we understand that there is a need for them to access sensitive or detailed data. Therefore, we are working towards providing guests with the necessary permissions to view the required information while ensuring the safety and security of our data.
Now, let's create these groups and users with the corresponding permissions using SQL code:*/

-- Connect to Art Analysis Database
\c art_analysis

-- Create Curators group with full access
CREATE ROLE curators;
-- Grant necessary permissions to the role
GRANT USAGE ON SCHEMA public TO curators;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO curators;

-- Create Researchers group with read-only access
CREATE ROLE researchers;
-- Grant necessary permissions to the role
GRANT USAGE ON SCHEMA public TO researchers;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO researchers;

-- Create a role for guest users
CREATE ROLE guests;
-- Grant necessary permissions to the role
GRANT USAGE ON SCHEMA public TO guests;

-- Grant SELECT permissions on specific columns for the guest users
GRANT SELECT (name, style) ON TABLE artwork TO guests;
GRANT SELECT (full_name, birth, death) ON TABLE artist TO guests;
GRANT SELECT (name) ON TABLE museum TO guests;

-- Create individual users and assign them to groups
CREATE USER curator_user1 WITH PASSWORD 'password1';
ALTER USER curator_user1 SET ROLE curators;

CREATE USER researcher_user1 WITH PASSWORD 'password2';
ALTER USER researcher_user1 SET ROLE researchers;

CREATE USER guest_user1 WITH PASSWORD 'password3';
ALTER USER guest_user1 SET ROLE guests;

-- View all groups and users
SELECT rolname AS role_name, rolsuper AS superuser, rolcreatedb AS createdb, rolcreaterole AS createrole
FROM pg_roles;

/*Explanation:
• CREATE ROLE is used to define each group.
• GRANT USAGE ON SCHEMA public TO group_name allows the group to use the public schema.
• GRANT statements specify the permissions on tables within the public schema.
• CREATE USER is used to create individual users.
• ALTER USER ... SET ROLE assigns users to the appropriate group.*/