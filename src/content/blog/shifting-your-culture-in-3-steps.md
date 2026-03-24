---
title: "Creating or Shifting a Company Culture In 3 Steps"
description: "How to shift your engineering culture from estimation-driven to flow-driven delivery. A 3-step framework for implementing predictable delivery practices using flow metrics, WIP limits, and data-driven forecasting."
date: 2023-05-19
updated: 2026-03-04
author: jeffrey-nolte
category: culture
---

Shifting engineering culture is one of the hardest things a leader can do. Especially when the shift involves replacing deeply ingrained habits -- like estimation-driven planning -- with something fundamentally different.

I have led this transition multiple times over twenty years. Moving teams from estimation-driven delivery to flow-driven delivery is not a tooling change. It is a cultural transformation. And like any cultural shift, it fails when it is imposed from the top and succeeds when it is built with the team.

Here is the three-step framework I use. It is simple, but do not confuse simple with easy.

## Step 1: Build Shared Understanding of the Problem

Before you can shift to flow-based delivery, your team needs to understand why the current approach is failing. This is not an opportunity for you to lecture about Little's Law. It is a conversation where you surface the pain that everyone already feels but nobody has named.

**Start by sharing the data.** Pull your team's actual delivery metrics. How long do items sit in progress? How many items are in progress simultaneously? What is the gap between estimated completion dates and actual completion dates?

In my experience, this data tells a consistent story across every scaling company I have worked with: estimates are unreliable, WIP is too high, and cycle times are two to three times longer than anyone realizes.

Then ask the team: **Why do we think this is happening?**

The answers will surprise you. Engineers will talk about context switching. They will mention the overhead of estimation sessions. They will describe how sprint commitments create pressure to start things early rather than finish things quickly. They already know the system is broken. They just have not had permission to say it.

### What this looks like in practice

I worked with a Series B healthcare company where the engineering team was spending nearly a full day per sprint on estimation -- planning poker, grooming, re-grooming after scope changes. When I asked the team to calculate how much engineering time they spent on estimation versus building, the room went quiet. It was close to 20%.

That number alone shifted the conversation from "should we change?" to "how fast can we change?"

The key here is transparency. Share the problem, share the data, and let the team participate in diagnosing the root causes. This is not about selling your solution. It is about building genuine shared understanding of [the predictability gap](/blog/the-predictability-gap) -- the distance between what your delivery system promises and what it actually produces.

## Step 2: Individual Alignment and Honest Conversations

Group discussions create awareness. Individual conversations create commitment.

After the team discussion, use your next round of one-on-ones to go deeper. Every person on your team will have a different relationship with the current process, and different concerns about changing it.

Some engineers love estimation because it gives them a sense of control. Others hate it but worry that removing it means removing accountability. Some managers are terrified that without story points they will have no way to report progress to leadership. These are legitimate concerns, and they need to be addressed individually.

### Questions I ask in these conversations

- **"What part of our current process helps you deliver better work?"** This surfaces what to keep.
- **"What part of our current process feels like waste?"** This surfaces what to cut.
- **"If we measured delivery by throughput and cycle time instead of velocity and story points, what would concern you?"** This surfaces fears that need to be addressed.
- **"What would need to be true for you to feel confident in a flow-based approach?"** This turns resistance into requirements.

The cooling-off period between the group conversation and these individual check-ins is important. People need time to process the idea, try it on mentally, and come back with real questions rather than knee-jerk reactions.

### Addressing the leadership concern

The most common objection I hear is from engineering managers worried about reporting upward: "If we do not have velocity and sprint commitments, how do I tell the CEO when something will ship?"

The answer is that flow metrics give you better answers to that question, not worse ones. When you have historical cycle time data, you can run Monte Carlo simulations that produce probabilistic forecasts. Instead of saying "we committed to finishing this in sprint 14," you can say "based on our throughput, there is an 85% probability this will ship by March 15th."

That is a more honest answer. And in regulated industries like regulated and high-stakes industries, honest answers are worth more than optimistic ones.

## Step 3: Build the Accountability Loop Around Flow

Steps one and two create buy-in. Step three is where the cultural shift either takes hold or dies.

You need a feedback loop that reinforces the new behavior. For flow-based delivery, that means making flow metrics visible, reviewing them regularly, and using them to drive decisions.

### The weekly flow review

Replace your sprint review with a weekly flow review. Keep it short -- thirty minutes or less. Cover three things:

1. **Throughput**: How many items did we complete this week? Is the trend stable, improving, or declining?
2. **Cycle time**: What was our average cycle time this week? Are any items aging beyond our normal range?
3. **WIP**: Are we within our limits? If not, why? What needs to finish before we start something new?

This is not a status meeting. Nobody reports what they did. The data speaks for itself. The conversation is about the system, not the individuals.

### Celebrate completions, not starts

This is a subtle but powerful shift. In estimation-driven cultures, teams celebrate kicking off new sprints, assigning new work, and filling boards with tickets. In flow-driven cultures, the only thing worth celebrating is finished work that reached customers.

When someone finishes a feature, acknowledge it. When the team's cycle time drops, call it out. When a forecast turns out to be accurate, make sure leadership knows. Positive reinforcement around the right behaviors is what makes cultural shifts stick.

### Follow up with curiosity, not blame

When cycle times spike or throughput drops, do not look for someone to blame. Ask: "What is blocking flow?" The answer is almost always systemic -- unclear requirements, external dependencies, too much WIP -- not individual performance.

This is where the culture shift really lives. In estimation-driven cultures, missed deadlines mean someone estimated wrong. In flow-driven cultures, anomalous metrics mean the system has a constraint that needs to be addressed. One creates blame. The other creates learning.

## Cultural Shifts Are Never Done

The final thing I will say is that this is not a one-time transformation. Flow-based delivery is an operating system for your engineering organization, and like any system, it requires ongoing attention.

Keep reviewing your flow metrics. Keep having the conversations. Keep iterating on your WIP limits and workflow design. The teams that thrive with this approach are the ones that treat it as a continuous practice, not a migration project with a finish line.

The companies that get this right -- especially in regulated industries where predictability is not optional -- build a genuine competitive advantage. They ship faster, forecast more accurately, and spend their engineering time on work that matters instead of process overhead. And it starts with these three steps.
