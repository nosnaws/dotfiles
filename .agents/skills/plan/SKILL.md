---
name: plan
description: Instructions for building plans for large codebase changes. Use when changes span many files or interface boundaries.
---

# Plan

Create detailed PLAN.md files that clearly lay out goals, changes, tradeoffs, and decisions.

Use when:
- Creating something from scratch such as a webapp or other software project.
- Changes to large codebases that span many files.
- Changes to large codebases that span more than one interface boundary.

## Steps

1. Research
Search the codebase for relevant documentation or code. Trace execution and data flows for a full understanding of current functionality.

2. Clarify
Come up with a list of important questions and/or trade offs that should be clarified with the user. Go through these one by one and get answers. Be exhaustive.

3. Compile
Use the user's ask, research, and input with step 2 to build a plan to implement the changes.

4. Output
Write the plan to a PLAN.md file in the CWD following this format:

```
# Goals

- goal 1
- goal 2
...

## Current state

- current state of things 1
...

## Desired state

- how things should work after these changes

## Steps
### Step 1
Overview of changes in this step. Should be enough information for implementation, but not a full reproduction of code changes. Interface changes and type changes should always be covered.
```
