---
title: "Measuring Productivity in Software Development"
description: "n this article, we’ll explore the key ways to measure productivity in digital product development, balancing quantitative data with qualitative insights to ensure teams are not just working harder, but building smarter."
date: 2025-03-20
updated: 2026-03-04
author: jeffrey-nolte
category: delivery
image: /images/blog/measuring-productivity.jpg
imageAlt: "Measuring Productivity in Software Development — Nolte"
---

### If you can't forecast from your productivity metrics, you're measuring the wrong things.


Most organizations measure engineering productivity the way they measured factory output a century ago: volume. Lines of code. Story points completed. Hours logged. Sprints closed. Deployment frequency.


None of these metrics answer the question that actually matters to the business: **what did our engineering investment produce, and can we predict what it will produce next?**


Productivity without predictability is just motion. Teams look busy. Dashboards look green. But the CFO still can't plan around engineering output, the CEO still can't answer the board, and the CTO still can't commit to a delivery date with confidence. ([The Forecasting Gap](/blog/the-predictability-gap) explains why this is the defining problem of the industry.)


The metrics that matter are the ones that make delivery forecastable. Everything else is vanity.


## The Metrics That Don't Work

I spent years tracking metrics that felt productive but never translated into the thing clients and boards actually need: a reliable forward-looking commitment.


**Velocity** is the most common offender. It measures story points completed per sprint. The problem is that story points are a unit of effort invented by the team, estimated by the team, and reported by the team. There's no external validation. Teams learn to inflate points. Velocity goes up. Delivery doesn't change. It's a self-referencing loop that tells you nothing about when real work will actually ship.


**Lines of code** and **commit frequency** are worse. They reward volume, not value. A developer who refactors a critical module from 2,000 lines to 400 just destroyed their "productivity" by every volume metric while dramatically improving the system.


**Deployment frequency** has value as a health indicator, but it doesn't measure productivity. Deploying ten times a day means nothing if the deployments don't move the business forward. And it says nothing about whether you can predict what you'll deploy next month.


Even the popular **DORA metrics** (deployment frequency, lead time for changes, change failure rate, mean time to recovery) are useful diagnostic tools but poor productivity measures. They describe how well the pipeline works. They don't tell you whether what's flowing through that pipeline is the right work, at the right cost, delivering the right business outcome.


The fundamental issue: these metrics all describe what already happened. None of them let you forecast what will happen next. And if your productivity measurement can't produce a forward-looking commitment, it's reporting, not management.


## The Metrics That Create Forecastability

The metrics that actually make engineering productivity manageable are flow metrics. They come from queuing theory and operations research, not from Agile methodologies, and they've been used in manufacturing and logistics for decades. They work because they measure the system, not the people.


**Cycle time** is the most important single metric. It measures the elapsed time from when work starts to when it's done. Not effort hours -- elapsed time, including all the waiting, blocking, review queues, and context switching that estimation frameworks ignore. When Sonya Siderova and the team at Nave analyzed thousands of delivery datasets, their core finding was that waiting time represents the vast majority of delivery time. No effort-based metric captures this. Cycle time does.


When you track cycle time over weeks and months, patterns emerge. You learn that your team's 50th percentile cycle time for a standard deliverable is, say, 6 days. The 85th percentile is 12 days. The 95th percentile is 18 days. Now you have something you can forecast from. Not a guess, not a consensus vote in a planning meeting -- a probability distribution based on what actually happened.


**Throughput** is the second metric: how many items does the team complete per unit of time? When throughput is stable (and it stabilizes when you manage the system correctly), you can predict how many deliverables will ship next month within a reliable confidence interval. This is the basis of Monte Carlo simulation for delivery forecasting -- take your historical throughput data, run simulations, and produce probabilistic forecasts that are dramatically more reliable than expert estimation.


**Work in progress (WIP)** is the lever that controls both cycle time and throughput. This is Little's Law in practice: average items in the system equals arrival rate multiplied by average time per item. When WIP goes up, cycle time goes up. When cycle time goes up, predictability goes down. Most teams carry far too much WIP because they confuse starting work with making progress. The result is everything takes longer, nothing finishes on time, and the team feels busy but unproductive.


**Work item age** is the early warning system. It measures how long an in-progress item has been active. When an item's age exceeds the team's 85th percentile cycle time, it's a signal that something is wrong -- a blocker, a dependency, a scope problem. Catching these items early is the difference between managing delivery proactively and discovering overruns after the fact.


Together, these four metrics create a closed system: manage WIP to stabilize cycle time, measure throughput to forecast capacity, monitor aging to catch problems early. The output is a team whose delivery is predictable enough to commit to -- not because the developers are working harder, but because the system is designed to produce consistent results.


## Why Traditional Metrics Persist

If flow metrics are more reliable, why do most organizations still track velocity, story points, and hours?


The honest answer: because the prevailing business model doesn't require forecastability.


When engineering is funded by the hour or the sprint, nobody needs a forecast. The team reports what it did. The business pays for the time. Whether the output was the right work, delivered at the right cost, producing the right business impact -- those questions never get asked because the model doesn't require answers.


Velocity exists to fill that accountability vacuum. It gives the appearance of measurement without the substance of prediction. Leadership gets a chart that goes up and to the right. Everyone agrees the team is "productive." And the next quarter, the same question goes unanswered: what will our engineering spend produce, and when?


The shift to flow metrics isn't just a technical change. It's a business model change. When you can forecast from your metrics, you can commit to deliveries. When you commit to deliveries, you can price on outcomes instead of time. When you price on outcomes, the incentives between the engineering organization and the business finally align. ([Why We Don't Estimate](/blog/why-we-dont-estimate) goes deeper on how this plays out in practice.)


## What Changes When You Measure the Right Things

When productivity measurement produces forecastability, every conversation about engineering changes.


**Prioritization becomes a financial decision.** When each potential deliverable has a forecasted cycle time and the team's throughput is known, "should we build X or Y?" stops being a gut call. You can see the tradeoff: building X means not building Y this quarter, and the cost of each is visible before the commitment is made.


**Overruns become detectable before they happen.** Work item age flags problems in real time. You don't discover at the end of the sprint that a key deliverable slipped -- you see it aging beyond the 85th percentile three days in and intervene. This is the difference between a reactive standup culture and a proactive delivery system.


**Team capacity becomes plannable.** When throughput is stable, you can staff against it, budget against it, and set expectations with clients, investors, and boards. Engineering becomes a predictable line item instead of a variable expense that surprises the CFO every quarter.


**Continuous improvement becomes systematic.** When your metrics are connected to the system (WIP limits, cycle time targets, throughput ranges), improving productivity means adjusting the system, not demanding more from people. Reduce WIP. Shorten feedback loops. Remove blockers. Each adjustment is measurable and the impact shows up in the next month's data.


At Nolte, these metrics are the foundation of [our forecasting engine](/blog/the-predictability-gap). We've tracked them across years of delivery data. Our prediction accuracy over three years is 95% -- not because we estimate better, but because we built an operational system where the metrics directly produce forecasts and the forecasts directly determine commitments.


## Start Here

If you're running an engineering organization and want to move toward forecastable productivity:


Stop tracking velocity. Start tracking cycle time. Pull your last 90 days of completed work items and plot the distribution. That distribution is your current reality -- not what you wish it were, not what your team estimated it would be, but what actually happened.


Then limit WIP. Pick a number that feels uncomfortably low. Watch what happens to cycle time over the next 30 days.


That's the beginning. The rest -- Monte Carlo forecasting, probabilistic commitments, forecast-based pricing -- builds on top of those two changes. But the foundation is always the same: measure the system, not the people. Forecast from data, not from consensus. And hold yourself accountable to predictions you can actually keep.


---


*If you want to see how flow metrics translate into a full forecasting model, read [The Forecasting Gap](/blog/the-predictability-gap). If you want to see it applied to your product, [book a call](https://cal.com/meet-jeffrey-nolte).*