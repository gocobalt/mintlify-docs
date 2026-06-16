# Sentence-level style

The line-level rules that make Claude docs read cleanly. Each rule has the *why*
so you can apply it to cases not listed here. Examples marked ✅ are verbatim or
close paraphrases of platform.claude.com prose.

## 1. Second person, present tense, active voice

Address the reader as "you" and describe what happens now, not what could
hypothetically happen. It reads as a person helping you, and it forces a clear
subject.

✅ "When you create additional workspaces, you can assign API keys, members, and
resource limits to each one."
🚫 "API keys, members, and resource limits may be assigned to workspaces upon
their creation."

## 2. One idea per sentence

Long sentences hide the action. The Claude docs average short, declarative
sentences. If you have two `and`s plus a `which`, split into two sentences.

✅ "API keys are scoped to a specific workspace. When you create an API key in a
workspace, it can only access resources within that workspace."

## 3. Lead with the verb in instructions

Procedures and recommendations start with the imperative verb. The reader is
scanning for the action.

✅ "Create and manage workspaces in the Claude Console."
✅ "Name workspaces clearly to indicate their purpose."

## 4. Bold the lead term in defining lists

When a bulleted list defines or enumerates things, bold the first
term/identifier. This converts a wall of bullets into a scannable index.

✅
```
Key characteristics:
- **Workspace identifiers** use the `wrkspc_` prefix
- **Maximum 100 workspaces** per organization (archived workspaces don't count)
- **Default Workspace** has no ID and doesn't appear in list endpoints
```

## 5. Show real values inline

Abstract docs feel untrustworthy. Drop in a real ID, token, or path in
parentheses.

✅ "Workspace identifiers use the `wrkspc_` prefix (for example,
`wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ`)."
✅ "an Admin API key (starting with `sk-ant-admin...`)"

## 6. State the constraint, then the consequence

When something has a limit or rule, say the rule and what happens if you hit it,
plainly. Move the hard exceptions into a callout (see `mintlify-design`).

✅ "Workspace limits can be set lower than (but not higher than) your
organization's limits."
✅ "Archiving a workspace immediately revokes all API keys in that workspace.
This action cannot be undone." (this one belongs in a `<Warning>`)

## 7. Use tables for any matrix or comparison

Roles × permissions, mode × use-case, environment × purpose — anything with two
dimensions is a table, never prose.

✅
```
| Mode | How it works | Best for |
|------|-------------|----------|
| Direct | Each app action becomes its own tool | Simple setups |
| Agent | Two meta-tools resolve then execute | Many actions across apps |
```

## 8. Name the surface in the heading

When the same task can be done two ways, split by surface and say so in the
heading: "Using the Console" / "Using the Admin API". The reader picks their lane
immediately.

## 9. Celebrate then route (tutorials)

End a tutorial step sequence by acknowledging the result and pointing forward.

✅ "You made your first API call. Next, learn the Messages API patterns you'll
use in every Claude integration."

## 10. Cut these words

`in order to` → `to`. `utilize` → `use`. `simply` / `just` → delete. `please` →
delete. `note that` → delete (use a `<Note>` if it matters). `there is/are` →
rewrite with a real subject. `allows you to` → `lets you` or just say what it
does.

## Read-aloud test

Read the paragraph aloud. Wherever you run out of breath or stumble, the sentence
is too long or mispunctuated — split it. Wherever you sound like a brochure
("powerful, seamless, robust"), cut the adjective and state the capability.
