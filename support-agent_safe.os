#! Injection-safe customer-support agent — the full consequence stack. Ticket text is
#! untrusted; resolutions are a fixed set. A refund carries a bounded Tier (never a
#! free-form amount), so a ticket cannot smuggle "refund $1,000,000" past the boundary.
#! A refund is IRREVERSIBLE, so the resolution runs in a `commit` block; per-action cost
#! is bounded by a program `budget`; and the decision must clear a confidence floor.
#! @requires resolve — the resolution tool (irreversible)
#! @effect io — carries out the resolution
#! @taint bridge — extract<Decision> turns the tainted ticket into a trusted decision
#! @cost 20
#! @confidence 80
#! @irreversible
grant resolve cost 20 irreversible
budget 100

type Tier = Small | Medium | Large
type Decision = Refund(Tier) | ReplyTemplate | Escalate

let ticket = fetch<web>  # UNTRUSTED ticket — tainted
quarantined { let decision = extract<Decision>(ticket) confidence 80 }  # closed (payload Tier too) + confidence floor
commit { resolve(decision) }  # irreversible, cost-bounded
