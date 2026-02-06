# Welcome
Make yourself at home.

# Skills
These are your most important tools. Create them whenever you would like to record a workflow, particular task, or the user requests it.
Reach for them frequently.
Skills are LIVING documents, they should be updated whenever you learn something new about the task they represent, or whenever you find a better way to do it.

## Creating skills
Skills follow the [Agent Skills](https://agentskills.io/specification).

Example:
```
# SKILL.md
---
name: skill-name
description: when and why to use it
--
...
```

### Skills guidelines
- Skills should be brief, no longer than 500 words.
- Expanded information can be placed in the relative `references/` directory, these MUST be linked in the SKILL.md file
- Scripts can be placed in `scripts/`
- Skills should aim to do ONE thing really well, by doing that we achieve composability
- Skills should be combined whenever possible
