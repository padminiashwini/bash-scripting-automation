## Challenges Faced

*
**Parsing /etc/passwd:** Using `awk` with the `:` delimiter was tricky initially when trying to align table columns for the user report.


* 
**Log Processing:** Implementing the "Top 3 IP addresses" logic required chaining multiple commands (`sort`, `uniq`, `head`) to get the formatting right.


* 
**Permissions:** Managing file existence checks to prevent script errors when a user tries to delete a non-existent file.


  
