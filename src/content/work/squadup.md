---
title: "SquadUP"
client: "SquadUP"
description: "A PE-backed event platform with a proven backend trapped behind years of frontend debt. We rebuilt the entire user-facing layer in four months — modernizing the experience without touching what already worked."
category: consumer
date: 2025-09-08
image: /images/work/squadup/featured.jpg
imageAlt: "SquadUP — Modern event management dashboard"
status: "Live"
partnership: "4 months"
services:
  - Product Strategy
  - Design Modernization
  - Responsive Web Architecture
  - Quality Assurance
metrics:
  deliveries: 24
  timeline: "4 months"
  accuracy: "96%"
  cycleTime: "5.1d"
platforms:
  - Web
phases:
  - name: "Strategy"
    duration: "4 weeks"
  - name: "Delivery"
    duration: "12 weeks"
team:
  - name: "Sam Mogil"
    role: "Co-Founder, SquadUP"
  - name: "Dan Urruela"
    role: "Design Lead, Nolte"
---

## The Bet

SquadUP had the backend to prove it. Thousands of events processed, reliable infrastructure, a real business. But the frontend told a different story — years of accumulated technical debt had turned the user experience into a liability. Inconsistent layouts across user roles. Fragmented workflows. Manual, error-prone testing. No reusable component system. Every release felt slow and risky.

Sam Mogil, SquadUP's co-founder and a designer by trade, knew what the product should feel like. He also knew the gap between where it was and where it needed to be was widening with every sprint. The platform needed a complete frontend overhaul — not a redesign that would break what worked, but a rebuild that would make what worked accessible.

The constraint was real: modernize everything the user touches without disrupting the proven backend infrastructure underneath.

## The Complexity

This wasn't a greenfield build. It was surgery on a live system:

- **Legacy debt across every surface** — inconsistent layouts, duplicated logic, and fragmented design patterns that had accumulated over years of feature-by-feature growth. No design system. No shared components.
- **Multi-role complexity** — event organizers, sub-admins, and attendees each interact with different surfaces of the same platform. Every workflow had to be rethought for each role without introducing new inconsistencies.
- **Zero-downtime migration** — the backend was stable and proven. The frontend rebuild couldn't create regressions in transaction processing, check-in flows, or any revenue-critical path.
- **PE-backed timeline** — four months to go from strategy through a fully rebuilt responsive dashboard. Not a prototype. A production system handling real events and real money.

## The Thinking

We started where we always start — understanding whether and how this should be built before writing a line of code.

The first four weeks were strategy. We benchmarked the competitive landscape — Eventbrite, Tixr, TicketSpice — not to copy features, but to understand where SquadUP's product had fallen behind on experience and where it already led on capability. We mapped organizer workflows end to end, profiling what users actually needed versus what the existing UI forced them to do.

The design direction crystallized around four principles: **consistent** visual language, **scalable** component architecture, **clear** information hierarchy, and **efficient** workflows that reduced friction at every step.

Sam and our Design Lead Dan Urruela worked shoulder to shoulder — this wasn't a handoff, it was a partnership. Sam brought deep product knowledge and design instinct. Dan brought systematic thinking about how to turn that instinct into a component library that would scale. Together they focused on fixing behavior, not just changing colors.

![SquadUP project timeline](/images/work/squadup/timeline.png)

By the end of the strategy phase, the team had a validated design system, a prioritized delivery roadmap, and a clear technical architecture: Next.js and TypeScript on the frontend, Tailwind and shadcn/ui for the component layer, Playwright for automated testing, and Sentry plus MixPanel for production monitoring.

## The Build

With the strategic foundation in place, execution moved into three structured monthly delivery cycles — April, May, and June.

**Dashboard & Transactions** — The main organizer dashboard was rebuilt from scratch. Transaction management — the revenue-critical core — was restructured with modern data handling, responsive layouts, and consistent interaction patterns across every device.

**Check-In & Sub-Admin Flows** — The check-in experience that event staff use on-site was redesigned for speed and reliability. Sub-admin management got proper role-based access controls and a clean interface that matched the rest of the platform.

**Reserve Seating, Gift Cards & Reporting** — Complex features that had grown organically were rebuilt with the new component system. Reserve seating, bundle management, gift cards, cashout flows, and reporting — each modernized to be consistent with the design system and maintainable going forward.

**Infrastructure & Quality** — CI/CD workflows and staging environments were established from scratch. Playwright automated testing gave the team confidence in every release. Sentry provided error monitoring, while PostHog and MixPanel enabled visibility into how organizers actually used the rebuilt interfaces.

The team also prepared the groundwork for a RodAuth migration with cross-domain session handling — setting SquadUP up for the next phase of technical evolution.

## The Proof

In four months, SquadUP went from a platform held back by its own UI to one built to evolve. The entire user-facing layer was rebuilt without a single backend disruption. Every release went through automated testing before hitting production. Every deployment followed established CI/CD workflows validated across Cloudflare and Next.js infrastructure.

The rebuild wasn't just a facelift. It introduced modular architecture that reduced component interdependencies, established testing and release environments that didn't exist before, and created deployment workflows that made shipping fast and safe instead of slow and risky.

Close collaboration with SquadUP's internal engineering team ensured every production release was validated and stable. The partnership model worked because both teams shared context — Nolte brought strategic foresight and design modernization, SquadUP brought reliability, scalability, and domain mastery.

The result: a frontend built to evolve, backed by a backend that was never in doubt.
