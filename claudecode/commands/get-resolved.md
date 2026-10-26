---
description: GetResolved helper — manage issues, conversations, releases via the `getresolved` CLI
---

You have access to GetResolved through the `getresolved` CLI. Always prefer the CLI over raw `curl` — it handles auth (from `~/.getresolved/auth.json`), shortcodes, validation, and dedup. Use `--json` whenever you need to extract fields with `jq`.

The active product for this directory is auto-resolved from `.getresolved/config.json`. You don't need to pass `--product` unless overriding it.

## DO NOT send messages to customer conversations unless explicitly asked

`getresolved conversation reply` **delivers a message to a real end user**. Never call it as a side effect of any other workflow.

Hard rules:
- Only run `getresolved conversation reply <id> --body="…"` when the user's prompt **explicitly** asks to send a reply / message / response to a specific conversation (e.g. "reply to conversation abc123 with…", "send this message to the chat thread", "respond to the customer in conv X").
- Generic prompts like "comment", "leave a note", "add a comment", "comment in get resolved", "log this", "mark done and comment" do **NOT** authorize sending a customer message. When working on an issue, "comment" means commenting on the **issue** — see the issue-comment workflow below.
- "Commit and mark done & comment in get resolved" after finishing a feature → `getresolved issue done <id> "<note>"` (writes `resolution_comment`), do not message any conversation.
- The CLI itself refuses to send a reply without `--yes` (or interactive confirmation). Do not bypass this with `--yes` unless the user explicitly authorized it.

## "Comment" while working on an issue → use `getresolved issue done`

When the user says "comment" in the context of an issue (especially after finishing work — "mark done and comment", "comment in get resolved"), they mean leaving a note on the **issue**, not messaging any customer:

```bash
getresolved issue done GET-005 "Shipped in commit abc123 — fixed by …"
```

This writes the note onto the issue's `resolution_comment` and is private to the workspace. Customers linked to the issue are **not** notified — they only hear about the fix later through a release announcement, when the user explicitly creates one.

For a running log while you work (as opposed to the final resolution note), post to the issue's activity thread — also private to the workspace:

```bash
getresolved issue comment GET-005 --body="Root cause: the footer link was hardcoded; fixing in footer.js"
```

## Self-update is automatic

The `getresolved` CLI runs a 24h-cooldown check on every invocation: it silently refreshes this slash command from the server and prints an "Update available" notice to stdout when a newer CLI version is on npm. You don't need to trigger anything.

If `getresolved` isn't on PATH, suggest the user install it: `npm i -g @getresolved/cli` (or `npx @getresolved/cli@latest …`). If the user sees the update notice, they can run `npm i -g @getresolved/cli@latest` to upgrade.

Note: do **not** re-read this file mid-conversation after the silent refresh. The new instructions take effect on the next `/get-resolved` invocation.

## Subcommands

### `update` — refresh this slash command

```bash
getresolved update
```

Re-downloads the latest slash-command content and rewrites `~/.claude/commands/get-resolved.md` if it differs.

## CLI reference

### Identity
```bash
getresolved whoami                   # workspace + member info
getresolved member list              # all members in the workspace
```

When assigning to yourself, pass `me` as the member id:
```bash
getresolved issue assign GET-005 me
getresolved issue update GET-005 --assignee=me
```

### Products
```bash
getresolved product list
getresolved product show current                # the product linked to this directory
getresolved product show <id>
getresolved product create --name="My App" [--prefix=APP]
getresolved product update <id> [--name=…] [--slug=…] [--prefix=…] [--domain=…]
```

Heads up: `prefix` (issue prefix) only affects newly created issues — existing shortcodes (e.g. `APP-007`) are immutable.

### Issues — to-dos extracted from customer conversations

Each issue has a UUID and a human-readable shortcode (e.g. `GET-005`). Single-issue commands accept either.

```bash
# List
getresolved issue list                                      # current product
getresolved issue list --status=pending,in_progress
getresolved issue list --priority=high,urgent
getresolved issue list --mine                               # client-side filter to assignee=me
getresolved issue list --json                               # for jq pipelines

# Show
getresolved issue show GET-005                              # human format with linked conversations
getresolved issue show GET-005 --json

# Update
getresolved issue update GET-005 --status=in_progress
getresolved issue update GET-005 --priority=urgent --assignee=me
getresolved issue update GET-005 --comment="Fixed by reverting commit abc"

# Status shortcuts (preferred — terse + correct semantics)
getresolved issue start    GET-005
getresolved issue review   GET-005 "ready — see commit abc123"   # finished, needs a teammate to check
getresolved issue approve  GET-005                               # reviewed and good → done
getresolved issue done     GET-005 "Shipped in commit abc123"
getresolved issue dismiss  GET-005 "duplicate of GET-002"
getresolved issue reopen   GET-005
getresolved issue assign   GET-005 me

# Activity thread (private notes; never customer-facing)
getresolved issue comment  GET-005 --body="…"
getresolved issue comments GET-005

# Hand off to the autonomous agent worker (Claude Code on the team's dev box)
getresolved issue queue    GET-005                            # default agent, the branch its folder is on
getresolved issue queue    GET-005 --new-branch               # default agent, a new branch for this task
getresolved issue queue    GET-005 --agent=mikael-mac          # a specific agent
getresolved issue queue    GET-005 GET-006 --branch=admin-ui   # several fixes onto one existing branch
getresolved issue unqueue  GET-005                            # cancel
getresolved agent branches                                    # branches the worker knows about
```

Queued issues show `agent_state` (`queued → running → review | failed`) plus `target_branch`, `preview_url` and `pr_url` in `issue show`. The worker posts its progress to the activity thread (`issue comments`).

#### Creating issues — `getresolved issue create` deduplicates by default

Always use `getresolved issue create`. It hits `POST /issues/maybe` under the hood, which runs AI duplicate-detection against pending/in_progress issues for the product (matches across paraphrasing and translation) and either links the request as a new source on the existing issue or creates a new one. This keeps the issue list clean.

```bash
getresolved issue create --title="Fix signup redirect" \
                         --description="Customer reports being bounced to /login" \
                         --priority=high \
                         --json
```

The `--json` response includes `matched_existing` (boolean) and `data.shortcode`. Report the shortcode back to the user, prefixing with "Matched existing" if `matched_existing: true`.

To bypass dedup (debugging only, or when the user explicitly says "skip dedup"):
```bash
getresolved issue create --title="…" --no-dedup
```

Issue statuses: `pending` → `in_progress` → `review` → `done` → `released` | `dismissed` (`released` is applied automatically when the issue is linked to a release). `review` means the work is finished and waiting for a teammate to check it: `getresolved issue review <id>` to hand it over, `getresolved issue approve <id>` (= done) once it's checked, `getresolved issue start <id>` to send it back. Fixes from the agent worker land in `review`.
Priorities: `low`, `normal`, `high`, `urgent`.

### Conversations — tickets, ideas, feedback, chats

```bash
getresolved conversation list                               # current product
getresolved conversation list --type=ticket --status=open
getresolved conversation show <id>                          # full thread with messages
getresolved conversation update <id> --status=in_progress

# ⚠ DELIVERS TO THE CUSTOMER. Only when the user EXPLICITLY asks to reply.
#   The CLI prompts for confirmation interactively. `--yes` skips it.
getresolved conversation reply <id> --body="Your message here" --yes
```

Conversation statuses: `open` → `in_progress` → `resolved` | `dismissed`.
Types: `ticket`, `idea`, `feedback`, `chat`.

### Releases

```bash
getresolved release list
getresolved release show <id>                               # includes linked issues
getresolved release create --title="v1.0" --version=1.0.0 \
                           --description="…" \
                           --issues=GET-1,GET-2,GET-7
```

## Pagination

All `list` commands accept `--limit` (default 50, max 200) and `--offset` (default 0). `--json` responses include `pagination.total`.

## Common workflows

**"Create an issue about X"**:
1. `getresolved issue create --title="…" --description="…" --priority=… --json`
2. Read `matched_existing` from the response. If true, tell the user "Matched existing issue `<shortcode>`"; otherwise "Created `<shortcode>`."

**"Work on issue X"**:
1. `getresolved issue show <id> --json` — see the issue and which conversations raised it.
2. For each linked conversation: `getresolved conversation show <id>` (read-only — do NOT call `reply`).
3. `getresolved issue start <id>` to mark it in_progress.
4. Optionally `getresolved issue comment <id> --body="…"` with a one-line plan, so teammates watching the board know what's happening.

**"Send X to the agent" / "let the agent fix X" / "queue X"** — hand the issue to the autonomous worker instead of fixing it here:
- Default: `getresolved issue queue <id>` — the default agent works on the branch its folder has checked out.
- "…on a new branch" / "branch out": add `--new-branch`. "…on <agent>" / "on Mikael's machine": add `--agent=<name>`.
- "…onto branch Y" / "on the Y branch" / "together with the other fixes on Y": `getresolved issue queue <id> --branch=Y`.
- Never queue onto `main`/`master` or the product's base branch — the agent refuses protected branches. If the user asks for that, explain and suggest a branch to merge from.
Then report the shortcode(s) and the branch. Check progress later with `getresolved issue show <id>` and `getresolved issue comments <id>`.

**"Mark done and comment" / "commit and mark done & comment in get resolved"** — close out an issue after shipping:
```bash
getresolved issue done <id> "<short note about what shipped>"
```
Do not call `getresolved conversation reply`. The "comment" here is the issue's `resolution_comment`, not a customer-facing message.

**"Create a release"**:
1. `getresolved issue list --status=done --json` to find completed issues.
2. `getresolved release create --title="…" --version=… --issues=GET-1,GET-2`.

**"What needs attention?"**:
```bash
getresolved issue list --status=pending --priority=high,urgent
```

## When the CLI isn't installed

If `getresolved --version` errors with "command not found", suggest one of:
- `npm i -g @getresolved/cli` (recommended — works for all subsequent calls)
- `npx @getresolved/cli@latest <command>` (one-off; slower)

If the user is logged out (`Not logged in. Run \`getresolved login\` first…`), point them at `getresolved login`. Don't try to work around it with `--api-key`.
