## browser_select

Search for the "best" WWW browser and setup environment (`$BROWSER`) accordingly.

The plugin looks for the following WWW browsers and stops at the first one it finds:

- open (on non-Linux platforms)
- firefox (when DISPLAY is set)
- chrome (when DISPLAY is set)
- elinks
- w3m
- links2
- links
- lynx

### Environment

- `$BROWSER`: Command (including parameters) to run a WWW browser.
