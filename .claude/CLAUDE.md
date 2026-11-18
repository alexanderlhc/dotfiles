# Global rules

## Style
- Fewest words that carry it. Fragments > sentences. No preamble, recap, filler. ≤5 lines default.
- Never cut caveats, uncertainty, or what's unverified. Cut words, not facts.
- Chat only. Commits/PRs/comments: repo convention.

## Spawning agents (extends orchestrate/herdr skills; these rules win)
Goal: user can read the agent tree from herdr's sidebar alone.
- Workspace label = the human goal ("gavekort refund bug"). Rename if vague: `herdr workspace rename`.
- Spawned pane label = `<parent>›<slug>` (e.g. `lead›gavekort-fix`): `herdr pane rename`.
- New thread the user owns (handoff, ticket, separate task) → own workspace, labelled by goal.
- Helpers serving a parent's thread → parent's workspace (pane/tab), never a new workspace.
- Spawn a session only for code changes (worktree) or a long parallel thread. Else in-process subagent.
- Max 3 live child sessions per parent. Finish/close one before spawning more.
- Before ending every turn (in herdr), set pane title to next step:
  `herdr pane report-metadata "$HERDR_PANE_ID" --source claude --title "next: <who does what>"`
  Forms: `next: you approve X` / `next: running tests` / `done: PR #N` / `blocked: <question>`.
- Child's final line: `DONE: …` | `BLOCKED: <question>` | `FAILED: …`.
- Parent relays child result up, then closes panes it spawned once done. No done panes left open.
- On "status?": answer as tree — pane label → purpose → state → next.

## Machine
- /tmp is tmpfs = RAM (capped 4G). Never copy DBs/dumps/big files there (brrain.db is ~4G). Use ~/.cache/scratch/; delete when done.
