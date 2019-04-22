AX-ZSH: Alex' Modular ZSH Configuration - Plugin Documentation
==============================================================

Plugin Exit Codes
-----------------

- 0: OK
- 1: Error
- 91: Ignore
- 92: Optional


Detecting "Plugin Check" Run
----------------------------

When `axzshctl check-plugins` is doing a _plugin check_ run, the enviromnet
variable `AXZSH_PLUGIN_CHECK` is "non-zero"; this can be tested like this:

```
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92
```
