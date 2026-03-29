---
title: "Barry's Bootcamp"
client: "Barry's"
description: "A custom instructor payroll and incentive system for one of the world's most recognized fitness brands — connecting class management, HR, and multi-location studio operations across the US."
category: wellness
date: 2020-08-15
order: 5
image: /images/work/barrys/featured.jpg
imageAlt: "Barry's Bootcamp — Instructor payroll and incentive platform"
status: "Live"
partnership: "5+ years"
order: 5
services:
  - Systems Integration
  - Payroll Architecture
  - API Development
  - Cloud Infrastructure
  - Ongoing Maintenance
metrics:
  deliveries: 451
  timeline: "5+ years"
  accuracy: "93%"
  cycleTime: "4.8d"
  onTime: "96%"
testimonial:
  quote: ""
  author: ""
  role: ""
team:
  - name: "Yanna Lopes"
    role: "Product Lead"
  - name: "Dulce Hernandez Cruz"
    role: "Lead Engineer"
  - name: "Jeffrey Nolte"
    role: "Delivery Lead"
platforms:
  - GCP Cloud Run
  - Firestore
  - Cloud Scheduler
phases:
  - name: "Strategy"
    duration: "8 weeks"
  - name: "Launch"
    duration: "6 months"
  - name: "Evolve"
    duration: "5+ years"
---

## The Bet

Barry's is the global fitness brand behind "The Best Workout in the World." With dozens of studios across the US, they needed a system that could accurately calculate instructor pay — including class-based bonuses, attendance incentives, and time entries — and push it directly into their payroll provider. No manual spreadsheets. No room for error.

The challenge: instructor compensation isn't simple. Pay varies by class type, attendance thresholds, studio location, and bonus tiers. The data lives in their class management platform, and payroll runs through their HR system. Nothing talks to each other out of the box.

## The Complexity

This is a systems integration problem wrapped in payroll compliance:

- **Class management data** — schedules, instructor assignments, attendance counts, and booking data across every US studio
- **HR and payroll** — employee records, time entries, and payroll processing through their HR provider
- **Incentive logic** — multi-layered bonus rules tied to attendance thresholds, class types, studio-specific premiums, and special event rates — each with its own edge cases
- **Multi-location** — every studio has different configurations, timezone considerations, and operational rules
- **Payroll accuracy is non-negotiable** — incorrect pay erodes trust with instructors and creates operational overhead

## The Thinking

We didn't build a generic integration. We built a payroll calculation engine that understands Barry's business rules:

**Incentive architecture** — We mapped every bonus type, threshold, and edge case into deterministic business rules with BDD scenarios. Each rule has acceptance criteria written in plain language and automated tests that verify the calculation before payroll runs.

**Pipeline design** — The system runs as a scheduled pipeline: extract class data, transform it through the bonus and timesheet logic, and import the results into payroll. Each stage is independently testable and recoverable.

**Idempotency** — Payroll can't process the same entry twice. We built deduplication and idempotency into every step of the pipeline to prevent duplicate payments.

## The Build

451 deliveries shipped over five years. The system evolved through a major integration migration, continuous studio expansion, and ongoing infrastructure improvements:

**Integration & launch** — Built the extraction pipeline from class management data, designed the bonus calculation engine, and integrated with the payroll API. Shipped the first automated payroll run within six months.

**HR provider migration** — When Barry's switched HR providers, we rebuilt the entire import layer — new API endpoints, new data mapping, new field validation — while keeping the extraction and transformation layers stable. Zero payroll disruptions during the cutover.

**Ongoing evolution** — Continuous expansion as Barry's opens new studios, introduces new class formats, and evolves their compensation model. Infrastructure migrations to modern serverless architecture, error monitoring, and code quality improvements including full TypeScript migration and automated test coverage.

## The Proof

The system processes payroll for every Barry's instructor across all US studios — every pay period, automatically.

- **451 deliveries** shipped and validated in production
- **5+ year** continuous partnership
- **30+ studio locations** supported with location-specific logic
- **Zero payroll disruptions** during a full HR provider migration
- **Automated pipeline** eliminates manual timesheet calculation entirely

## The Partnership

This is what a long-term product partnership looks like. Not a build-and-handoff — a continuous engagement where we maintain the system, respond to production issues, expand to new locations, adapt to new providers, and evolve the business logic as Barry's compensation model changes.

Five years. 451 deliveries. Every payroll cycle runs automatically. That's predictable delivery.
