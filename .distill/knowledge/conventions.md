---
domain: conventions
scope: commits, languages, style
last_validated: 2026-10-15
staleness_threshold: 90
---

# Conventions

- Imperative commit subjects, often prefixed with the area and a colon; body explains why. evidence: history of tomacco/agents-mission-control
  confidence: provisional
  origin: convention
- Swift 5.10 tools, macOS 26+, SwiftUI with an AppKit status item; no Xcode project. evidence: Package.swift
  confidence: hardened
  origin: constraint
- Shell scripts are **zsh** (`#!/bin/zsh`, `${0:A:h}` idioms), never bash. evidence: bin/*, tests/*, build.sh
  confidence: validated
- Comments explain why, one or two lines above the code. evidence: Sources/*.swift
  confidence: provisional
- Menu bar art is pixel grids drawn live in SwiftUI `Canvas` (no PNG templates), so it follows light and dark. evidence: Bar.swift#Art
  confidence: validated
