---
id: decision-1
title: Agent Board becomes its own project
date: 2026-10-15
status: accepted
origin: directive
tasks: []
---

## Context

The menu bar pill (hands off, caffeinate, localhost) and privileged sessions grew in one repository. Privileged sessions must run with no menu bar item, since some companies block unknown apps.

## Options Considered

1) One app with both. 2) Two projects.

## Decision

Two projects: Agent Board for the pill, Agents Mission Control for privileged sessions. Agent Board needs no macOS permissions.

## Evidence

- `README.md`

## Consequences

The hands-off flag moved to ~/.agent-board/hands-off; Agents Mission Control reads it.
