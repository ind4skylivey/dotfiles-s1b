# Eco-Workflow: Livey Sib Gr0up — Decisions & Evolution

This is not a traditional changelog of "what was added." This is a **decision log** — explaining the **why** behind each choice, and how the system evolves with intention.

---

## v1.0 — The Birth of Eco-Workflow (2025-12-17)

### Core Philosophy Locked In

**Decision: "Orchestration layer, not rewrite"**

Why: Your dotfiles already work. Forcing a rewrite would:
- Break muscle memory with existing keybindings
- Risk losing subtle config tuning accumulated over months
- Create friction for adoption

Result: All existing configs stay untouched. Workflow layer is 100% additive.

---

### Tool Roles Formalized

**Decision: Five explicit roles, no overlap**

```
tmux      → Remote backbone (persistence, SSH, infrastructure)
zellij    → Local visual workspaces (ephemeral, layout-driven)
neovim    → Fast editing (daily coding, LSP, terminal-first)
emacs     → Deep work (org-mode, Magit, large projects)
helix     → Optional minimal (instant, zero-config)
```

Why: Previous ambiguity (should I use tmux or zellij locally?) → decision paralysis. Formalizing roles removes cognitive load. Each tool answers one question:
- **Local work?** → zellij
- **Remote work?** → tmux
- **Writing docs?** → emacs
- **Quick edit?** → nvim or helix

Result: Clear mental model. No tool wars.

---

### Four Profiles, Not Nine

**Decision: Only four profiles (local, remote, write, redteam)**

Why: Could have created 9+ niche profiles (data analysis, streaming, etc.). But:
- More profiles = more confusion
- Users should customize based on these four archetypes
- Four is a psychological magic number (manageable, memorable)

Result: Four clear entry points. Users fork these as templates for their own variations.

---

### Environment Variable Exports

**Decision: Each `ws-*` script exports `LIVEY_WORKFLOW`**

Why: Scripts were "just tools." But with state (the workflow variable):
- Prompt can show which profile is active → awareness
- Tmux statusline can change colors per profile → visual feedback
- Logging becomes profile-aware → better organization
- Parent shell inherits the state → other tools can react

Result: Workflow becomes a **first-class state**, not just a command.

---

### Semantic Session Naming

**Decision: `remote-hostname`, `local-project`, `redteam-target`**

Why: Before:
```bash
tmux ls
# ws_prod_5834
# ws_local_9203
# rt-5823-472
# 🤔 Which is which?
```

After:
```bash
tmux ls
# local-dotfiles-5834
# remote-prod
# redteam-htb
# ✅ Instant clarity
```

Result: Terminal gives you clarity without explanation.

---

### Zellij Layouts as Templates

**Decision: Four simple KDL layouts, not "perfect" configurations**

Why: Could have made elaborate layouts with nested splits and plugins. But:
- Zellij layouts are user-editable (KDL is readable)
- Offering "expert configs" discourages customization
- Templates teach structure; users adapt to their needs

Result: Simple, learnable layouts that spawn infinite variations.

---

### Minimal Helix Config

**Decision: Settings only, no plugins or complex keybindings**

Why: Helix is designed for zero-config speed. Adding layers defeats the purpose:
- If you want Helix, you want instant startup
- LSP and syntax work out of box
- Users who need more will know to add it

Result: Helix stays true to its philosophy: work immediately.

---

### Documentation as Philosophy, Not Manual

**Decision: Each profile explains "when" and "when not," not just "how"**

Why: Manuals tell you what buttons to press. This system tells you:
- When to use each tool
- What problem each profile solves
- Why you might NOT want a profile
- How to customize it for your brain

Result: Documentation becomes a teaching tool, not a reference.

---

## Evolution Principles (Future Versions)

### We Will NOT:
- Rewrite existing configs (always additive)
- Add tools "just because they exist"
- Create profiles for micro-niches (users adapt base four)
- Bloat layouts with plugins or complex chrome
- Break backward compatibility

### We WILL:
- Add profiles only when a fourth major workflow emerges (not before)
- Improve documentation based on real usage patterns
- Refine semantic naming if a better pattern emerges
- Listen to how users customize and incorporate learnings
- Maintain Catppuccin aesthetic and terminal-first philosophy

---

## Version History

### v1.0 (2025-12-17)
- ✅ Four profiles (local, remote, write, redteam)
- ✅ Four entrypoint scripts with LIVEY_WORKFLOW export
- ✅ Semantic session naming
- ✅ Four Zellij layouts (templates, not final configs)
- ✅ Minimal Helix config
- ✅ ~2,100 lines of documentation
- ✅ Updated README with workflow section
- **Status**: First stable release. Ready for daily use.

---

## Decision Template (For Future Entries)

When evolving this system, use this structure:

```markdown
### [Version] — [Title of Decision]

**Decision: [What we chose]**

Why: [Why we chose it over alternatives]

Result: [Outcome or impact]
```

This keeps decisions explicit and reasoned, not accidental.

---

## Lessons Learned Building This System

### 1. **Tool Clarity Reduces Friction**
Humans choose faster when options are explicit:
- "Use tmux for remote" beats "use one of these five multiplexers"
- Decision paralysis disappears when path is clear

### 2. **State Matters More Than Commands**
`ws-local` is just a script. But `LIVEY_WORKFLOW=local` is identity:
- Prompts can react to state
- Logging can organize by state
- Parent tools can inherit state
- System becomes aware of context

### 3. **Documentation as Design**
Writing clear documentation forces you to think clearly about design:
- If you can't explain "when to use this," the design is fuzzy
- Good docs reveal design flaws
- Docs become the interface, not the tool

### 4. **Semantic Naming is Free Clarity**
`local-dotfiles` vs `ws_1092` takes 0 extra CPU but 1000x more clarity:
- Users read output, not configs
- Semantic names speak for themselves
- Terminal becomes a communication medium

### 5. **Additive Always Beats Rewrite**
Your muscle memory is worth gold:
- Existing key-bindings work as expected
- Configs stay where they are
- New layer fits on top without friction
- Adoption is frictionless

---

## Design Debt (Intentional Choices to Revisit Later)

### Helix Config Could Grow
Right now it's minimal. If users heavily adopt Helix, we might want:
- LSP configuration templates
- Custom keybindings (but keep defaults as fallback)
- Theme integration with other tools

Decision: Not now. Revisit after seeing usage patterns.

### Tmux Layouts Could Be Richer
Remote session layout is functional but basic. We could add:
- Status bar integration
- Plugin recommendations
- Advanced split arrangements

Decision: Not yet. Let users customize first, then see patterns.

### Profile Proliferation
We're at 4 profiles. Temptation: add "data science," "devops," "streaming," etc.

Decision: Resist. If a fifth emerges from real usage, then add it with intent. Otherwise, users adapt the four we have.

---

## The Intent Behind This System

This system exists to answer one question:

**"What should I do right now?"**

Each profile is the answer to a specific context:
- Local project? → `ws-local`
- Remote server? → `ws-remote`
- Documentation? → `ws-write`
- Security work? → `ws-redteam`

The system reduces decision-making noise so you can focus on **work**, not **tool selection**.

That's the design intent. Every choice serves that goal.

---

## How to Use This Changelog

- Read it once to understand design thinking
- Reference it when considering new features
- Add new decisions following the template
- Resist feature creep by re-reading the "Will NOT" section

This is a **decision log**, not a changelog. It's about **why**, not **what**.

---

*Last updated: 2025-12-17 — System v1.0 stable*

