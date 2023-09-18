- Modules
  - Avoid dynamic imports
  - Use `import "module"` instead of `module = require("module")`
  - Use `export` instead of returning a table
- Functions
  - For no-argument function expressions, do NOT omit the paranthesis
  - Always call functions with paranthesis, do NOT use `func!`
- Always declare variables explicitly
  - Prefer using `const` over `local` when possible
- Do NOT use parathesis-less functions
  - Exceptions:
    - Using a plain `require "module"` that isn't supposed to be bound to a variable or which doesn't return a module object
    - Functions that take a single table
- Do NOT use bracket-less tables
  - Exceptions:
    - When a function uses a table as named arguments after at least one positional parameter, you should omit the brackets
      - The declarative widget system (`wibox.widget`) does NOT qualify for that!
      - If the table may contain fields with numerical indecies, it does NOT qualify for that, either!
- Don't write comments.
  - Wait, WHAT? The idea is that, if you feel the need to use human language to explain what your code does, then
    this is often a sign that you should instead refactor the code. See: https://www.youtube.com/watch?v=Bf7vDBBOBUA

    Things like blocks or comments that are tied in to how your code behaves tends to just become a maintainance hassle more than anything