## Sample Test Cases

* **Q1:** Verified all 8 system fields (Username, Hostname, etc.) display correctly.


* **Q2:** Tested creating a directory, creating a file within it, and then deleting it with the confirmation prompt.


* **Q3:** Ran against a sample `access.log` to verify unique IP counting and status code frequency.


* **Q4:** Created a `test_backup` directory and successfully generated a `.tar.gz` archive with a timestamp.


* **Q5:** Verified the script correctly identifies UID 0 users and lists regular users with UIDs >= 1000.



## Challenges Faced

* **Parsing /etc/passwd:** Using `awk` with the `:` delimiter was tricky initially when trying to align table columns for the user report.


* **Log Processing:** Implementing the "Top 3 IP addresses" logic required chaining multiple commands (`sort`, `uniq`, `head`) to get the formatting right.


* **Permissions:** Managing file existence checks to prevent script errors when a user tries to delete a non-existent file.


  
