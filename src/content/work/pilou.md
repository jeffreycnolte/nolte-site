---
title: "Pilou"
client: "Pilou"
description: "Financial services platform built under regulatory and compliance requirements with full audit trail visibility."
category: finance
date: 2024-01-15
image: /images/work/pilou/featured.png
imageAlt: "Pilou financial platform"
status: "Live"
partnership: "2 years"
order: 2
services:
  - Product Strategy
  - Platform Architecture
  - Full-Stack Development
  - Compliance Engineering
metrics:
  deliveries: 85
  timeline: "2 years"
  accuracy: "96%"
  cycleTime: "4.8d"
  onTime: "97%"
testimonial:
  quote: ""
  author: "Andrea de la Garza"
  role: "Co-Founder, Pilou"
team:
  - name: "Andrea de la Garza"
    role: "Co-Founder"
  - name: "Patricia Florencia"
    role: "Co-Founder"
platforms:
  - Web
phases:
  - name: "Strategy"
    duration: "4 weeks"
  - name: "Launch"
    duration: "5 months"
  - name: "Evolve"
    duration: "Ongoing"
---

## The Challenge

Pilou is a Mexico-based fintech platform focused on financial empowerment for underserved populations. When we joined the engagement, the platform had an unclear technology strategy — multiple engineers had contributed over time, leaving confusion around scalability, documentation, code quality, and security. The product needed modernization while maintaining strict compliance with Mexican financial regulations under the CNBV.

The founders had a clear mission but a fragmented technical foundation. Pilou needed a partner who could assess what existed, define a coherent strategy, and rebuild the critical user-facing systems without disrupting live operations.

![Pilou fintech platform hero](/images/work/pilou/hero.png)

## Strategy and Planning

We started with a thorough assessment — technical architecture, product design, and digital product evaluation — to identify every improvement area. Then we moved into discovery.

Discovery meant analyzing the competitive landscape across six direct competitors, running user surveys to gather demographic and qualitative data, and conducting Example Mapping sessions to extract business rules from stakeholders and translate them into development-ready specifications.

![Competitive landscape analysis](/images/work/pilou/competitive-landscape.png)

![Example Mapping methodology for extracting business rules](/images/work/pilou/example-mapping.png)

The output was a detailed release plan and roadmap, with the onboarding and KYC system identified as the critical first priority — the first touchpoint for every new user and the foundation for regulatory compliance.

![Pilou strategy and planning documentation](/images/work/pilou/strategy.jpg)

## What We Built

![Pilou design system components](/images/work/pilou/design-system.png)

**Investor Profile Quiz** — A complete redesign of Pilou's risk assessment questionnaire. We reduced the question count for efficiency, updated the interface to match the new design system, enhanced the backend scoring and risk algorithms, and implemented email-based result delivery to encourage account creation. AML compliance mechanisms were improved throughout.

![Redesigned investor profile quiz interface](/images/work/pilou/quiz.png)

**KYC and Digital Signatures** — We evaluated technical partners based on compliance requirements, cost, scalability, and performance, then integrated identity verification and digital signature infrastructure meeting Mexican financial regulations.

![Onboarding flow redesign](/images/work/pilou/onboarding.png)

![Validation flow for KYC compliance](/images/work/pilou/validation.png)

**SDK Integration with Major Mexican Bank** — A direct integration with GBM's banking SDK that reduced account opening from days to near-instant processing. Replaced manual setup procedures with an automated system. Our team served as primary liaison with the bank's technical staff throughout the integration.

![GBM bank SDK integration](/images/work/pilou/gbm-integration.png)

**Regulatory Compliance Framework** — We conducted an in-depth study of Mexico's CNBV financial regulations and held weekly collaboration sessions with Pilou's compliance team. Every backend mechanism was built with security and regulatory adherence as a baseline requirement, not an afterthought.

![Compliance workflow and regulatory framework](/images/work/pilou/compliance.png)

## The Technical Challenge

The hardest problem wasn't any single feature — it was bridging two distinct technology stacks. Pilou's legacy system ran on Ruby. The new frontend was built in Next.js and Nest.js. Making them work together seamlessly required secure API authentication, CORS protocol management, GraphQL API calls for user profile operations, field mapping and data synchronization across platforms, and seamless post-onboarding redirection from the new system back to the legacy dashboard.

![Pilou system architecture diagram](/images/work/pilou/architecture.png)

We tested extensively in development environments before touching production, ensuring backward compatibility at every step. Users experienced a single coherent product even though two distinct systems powered it behind the scenes.

## Delivery Data

Across 85 deliveries over two years, our forecast accuracy held at 96%. The average cycle time was 4.8 days — reflecting the additional validation that financial services deliveries require compared to less regulated domains.

97% of deliveries shipped on or before their forecasted date. The remaining 3% were delayed by external dependencies — third-party API integrations and regulatory clarifications that required back-and-forth with compliance counsel.

Every delivery was priced before work began. Every invoice matched the agreed price. Pilou's finance team could forecast their own technology spend with the same confidence we forecast delivery dates — because both numbers were committed up front.

## The Outcome

Pilou launched on time with zero compliance gaps. The platform serves thousands of users with full regulatory compliance under Mexican financial law. The onboarding experience went from fragmented and slow to streamlined and conversion-optimized. The banking SDK integration eliminated days of manual account setup.

The engagement gave Pilou something most fintech startups in emerging markets don't have: a coherent technology strategy, a modern user experience, and a delivery model where every feature is scoped, priced, and forecasted before work begins. Two years in, the pattern hasn't changed because the pattern works.
